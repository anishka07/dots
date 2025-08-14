local lint = require("lint")

-- Configure linters by filetype
lint.linters_by_ft = {
  python = { "ruff" },
  -- Add other linters if needed
  -- javascript = { "eslint" },
  -- typescript = { "eslint" },
}

-- Customize ruff linter if needed
lint.linters.ruff = {
  cmd = "ruff",
  stdin = true,
  args = { "check", "--output-format", "json", "--stdin-filename", function()
    return vim.api.nvim_buf_get_name(0)
  end, "-" },
  stream = "stdout",
  ignore_exitcode = true,
  parser = function(output, bufnr)
    local diagnostics = {}
    local decoded = vim.json.decode(output)
    
    if decoded and type(decoded) == "table" then
      for _, item in ipairs(decoded) do
        if item.location then
          table.insert(diagnostics, {
            bufnr = bufnr,
            lnum = item.location.row - 1,
            col = item.location.column - 1,
            end_lnum = item.end_location and item.end_location.row - 1 or item.location.row - 1,
            end_col = item.end_location and item.end_location.column - 1 or item.location.column - 1,
            severity = vim.diagnostic.severity.WARN,
            message = item.message,
            source = "ruff",
            code = item.code,
          })
        end
      end
    end
    
    return diagnostics
  end,
}

-- Auto-lint on these events
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- Manual lint command
vim.api.nvim_create_user_command("Lint", function()
  lint.try_lint()
end, { desc = "Run linter on current buffer" })
