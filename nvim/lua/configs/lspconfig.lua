local lspconfig = require "lspconfig"
local defaults = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enhanced on_attach function for Python
local on_attach = function(client, bufnr)
  defaults.on_attach(client, bufnr)

  -- Additional Python-specific keymaps
  if client.name == "pyright" then
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set(
      "n",
      "<leader>oi",
      "<cmd>PyrightOrganizeImports<cr>",
      vim.tbl_extend("force", opts, { desc = "Organize Imports" })
    )
  end
end

-- Add this to your lspconfig.lua or wherever you configure LSP

-- Configure diagnostics for VS Code-like inline error display
vim.diagnostic.config {
  virtual_text = {
    enabled = true,
    source = "if_many", -- Show source if multiple LSPs are active
    prefix = "●", -- Could also use "■" or "▎"
    format = function(diagnostic)
      -- Show error code if available
      if diagnostic.code then
        return string.format("%s [%s]", diagnostic.message, diagnostic.code)
      end
      return diagnostic.message
    end,
  },
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    },
  },
  underline = true,
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many", -- Show which LSP provided the diagnostic
    header = "",
    prefix = "",
  },
}

-- Optional: Set up keymaps for diagnostics
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- If you're using nvim-cmp, make sure to configure it for better integration
-- This should be in your completion configuration
local cmp = require "cmp"
cmp.setup {
  -- ... your other cmp config
  formatting = {
    format = function(entry, vim_item)
      -- Show source in completion menu
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
}

-- Python-specific LSP setup (add to your Python LSP configuration)
require("lspconfig").pyright.setup {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict", -- Can be "off", "basic", or "strict"
        diagnosticMode = "workspace", -- Analyze entire workspace
        useLibraryCodeForTypes = true,
        autoSearchPaths = true,
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = "error",
          reportOptionalMemberAccess = "error",
          reportOptionalSubscript = "error",
          reportPrivateImportUsage = "warning",
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Your on_attach function here
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end,
}

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
          typeCheckingMode = "strict", -- Can be "off", "basic", or "strict"
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
      },
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
vim.g.python3_host_prog = vim.fn.exepath "python3"
