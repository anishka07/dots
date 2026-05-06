-- Node.js / Next.js: linting and auto-formatting (no keymaps)
return {
  -- TypeScript/JavaScript LSP + ESLint LSP for inline linting
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {},
        eslint = {
          -- Only activate when a project-level eslint config is present
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              ".eslintrc.json",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs"
            )(fname)
          end,
          settings = {
            -- Resolve eslint from the project root, not the LSP server location
            workingDirectory = { mode = "auto" },
          },
        },
      },
    },
  },

  -- Auto-formatting with prettier
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        json            = { "prettier" },
        jsonc           = { "prettier" },
        css             = { "prettier" },
        html            = { "prettier" },
      },
    },
  },

  -- Mason: auto-install all required tools
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
      },
    },
  },
}
