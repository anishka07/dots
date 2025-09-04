-- Code Formatter
--
-- Sets up automatic code formatting
--
-- Makes sure your code follows style guidelines
return {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort", "ruff" },
    go = { "goimports", "golines" }, -- Add Go formatters

    -- Add more languages here
    javascript = { "prettier" },
    typescript = { "prettier" },
    rust = { "rustfmt" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}
