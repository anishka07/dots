-- File Explorer Settings
--
-- Configures the file tree sidebar (like VSCode's file explorer)
--
-- Sets how files are displayed, which icons to use, etc.

local options = {
  filters = {
    dotfiles = true,  -- Set to false to show dotfiles like .env, .venv
    git_ignored = true,  -- Set to false to show git ignored files
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
    -- Hide the full path display
    root_folder_label = ":t",  -- This hides the full path at the top
    
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
  -- Additional settings to clean up display
  update_focused_file = {
    enable = true,
    update_root = false,  -- Don't change root when focusing files
  },
}
return options
