return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason for managing LSP servers, formatters, linters
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Existing tools
        "pyright",
        "ruff",
        "ruff-lsp",
        "stylua",
        "html-lsp",
        "css-lsp",

        -- Go tools
        "gopls", -- Go language server
        "goimports", -- Go formatter
        "golines", -- Go line formatter
        "delve", -- Go debugger

        -- Add more language tools here as needed
        -- "rust-analyzer", -- Rust
        -- "tsserver",      -- TypeScript
        -- "jdtls",         -- Java
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Existing languages
        "python",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "yaml",
        "toml",

        -- Go language
        "go",

        -- Add more languages here as needed
        -- "rust",          -- Rust
        -- "java",          -- Java
      },
    },
  },
}
