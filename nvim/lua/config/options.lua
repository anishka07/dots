-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable line wrapping
vim.opt.wrap = true -- Enable line wrapping
vim.opt.linebreak = true -- Break lines at word boundaries
vim.opt.breakindent = true -- Preserve indentation in wrapped lines
vim.opt.showbreak = "↪ " -- Show symbol at the start of wrapped lines

-- Optional: Set a reasonable text width if you want hard wraps
-- vim.opt.textwidth = 120

-- Ensure proper display of long lines
vim.opt.display = "lastline" -- Show as much as possible of the last line
