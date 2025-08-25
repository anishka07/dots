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
        "pyright",
        "ruff",
        "ruff-lsp",
        "stylua",
        "html-lsp",
        "css-lsp",
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "yaml",
        "toml",
        "go",
      },
    },
  },
}
