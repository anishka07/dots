local options = {
  filters = {
    dotfiles = false,  -- Set to false to show dotfiles like .env, .venv
    git_ignored = false,  -- Set to false to show git ignored files
    custom = {
      -- Remove common hidden files from custom filters
      -- You can add specific files you want to hide here
      "node_modules",
      "__pycache__",
      ".pytest_cache",
    },
  },
  git = {
    enable = true,
    ignore = false,  -- Set to false to show git ignored files
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
}

return options
