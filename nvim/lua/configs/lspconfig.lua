-- Language Support Setup
--
-- Configures LSP (Language Server Protocol) which gives you:
--
-- Code completion
--
-- Error checking
--
-- Suggestions as you type
--
-- Sets up support for different programming languages

-- Language Support Setup
local lspconfig = require "lspconfig"
local defaults = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enhanced on_attach function
local on_attach = function(client, bufnr)
  defaults.on_attach(client, bufnr)

  -- Python-specific keymaps
  if client.name == "pyright" then
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set(
      "n",
      "<leader>oi",
      "<cmd>PyrightOrganizeImports<cr>",
      vim.tbl_extend("force", opts, { desc = "Organize Imports" })
    )
  end

  -- Go-specific keymaps
  if client.name == "gopls" then
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", vim.tbl_extend("force", opts, { desc = "Go Test" }))
    vim.keymap.set("n", "<leader>gi", "<cmd>GoImport<cr>", vim.tbl_extend("force", opts, { desc = "Go Import" }))
  end
end

-- Configure diagnostics for VS Code-like inline error display
vim.diagnostic.config {
  virtual_text = {
    enabled = true,
    source = "if_many",
    prefix = "●",
    format = function(diagnostic)
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
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
}

-- Diagnostic keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- If you're using nvim-cmp, make sure to configure it for better integration
local cmp = require "cmp"
cmp.setup {
  -- ... your other cmp config
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
}

-- SIMPLE LANGUAGE CONFIGURATION SYSTEM
-- Add new languages here with just one line each!
local servers = {
  -- Existing languages
  html = {},
  cssls = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "basic",
        },
      },
    },
    on_attach = on_attach,
  },
  ruff = {
    init_options = {
      settings = {
        args = {},
      },
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
      defaults.on_attach(client, bufnr)
    end,
  },

  -- NEW LANGUAGES GO HERE - JUST ADD ONE LINE!
  -- ==========================================

  -- Go Language (add this line)
  gopls = {
    on_attach = on_attach,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },

  -- Rust (example for future)
  rust_analyzer = {},

  -- Java (example for future)
  jdtls = {},
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
