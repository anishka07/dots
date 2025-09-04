return {
  "kdheepak/lazygit.nvim",
  lazy = true, -- Recommended for lazy loading
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- Optional, for floating window border decoration
  },
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
  },
}
