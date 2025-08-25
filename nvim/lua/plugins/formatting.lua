return {
  -- Core formatting
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- Extra linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },
}
