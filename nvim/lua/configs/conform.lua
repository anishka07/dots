local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff_organize_imports" },
    -- Uncomment these if you want to format other filetypes
    -- css = { "prettier" },
    -- html = { "prettier" },
    -- javascript = { "prettier" },
    -- typescript = { "prettier" },
    -- json = { "prettier" },
    -- yaml = { "prettier" },
  },

  -- Custom formatters
  formatters = {
    ruff_format = {
      command = "ruff",
      args = { "format", "--stdin-filename", "$FILENAME", "-" },
      stdin = true,
    },
    ruff_organize_imports = {
      command = "ruff",
      args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
      stdin = true,
    },
  },

  -- Auto format on save
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },

  -- Format after paste
  format_after_paste = true,
  
  -- Notify on format
  notify_on_error = true,
}

return options
