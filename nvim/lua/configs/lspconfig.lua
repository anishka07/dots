local lspconfig = require("lspconfig")
local defaults = require("nvchad.configs.lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enhanced on_attach function for Python
local on_attach = function(client, bufnr)
  defaults.on_attach(client, bufnr)
  
  -- Additional Python-specific keymaps
  if client.name == "pyright" then
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "<leader>oi", "<cmd>PyrightOrganizeImports<cr>", vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
  end
end

-- Configure LSP servers
local servers = {
  html = {},
  cssls = {},
  
  -- Pyright configuration with enhanced settings
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "basic", -- Can be "off", "basic", or "strict"
        },
      },
    },
    on_attach = on_attach,
  },

  -- Ruff LSP for fast linting and formatting
  ruff = {
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      }
    },
    on_attach = function(client, bufnr)
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
      defaults.on_attach(client, bufnr)
    end,
  },
}

-- Setup all servers
for server, config in pairs(servers) do
  local server_config = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = config.on_attach or defaults.on_attach,
  }, config)
  
  lspconfig[server].setup(server_config)
end

-- Additional Python environment setup
vim.g.python3_host_prog = vim.fn.exepath("python3")
