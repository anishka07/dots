-- Configures code linting (finding potential errors in your code)
--
local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  go = { "golangci_lint" }, -- Add Go linter

  -- Add more languages here
  javascript = { "eslint_d" },
  -- typescript = { "eslint_d" },
}

-- Create autocommand to lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
