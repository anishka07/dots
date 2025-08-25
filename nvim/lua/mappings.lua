require "nvchad.mappings"

local map = vim.keymap.set

-- Basic mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Python-specific mappings (using uv.nvim plugin)
-- Note: uv.nvim uses <leader>U prefix, adding convenience shortcuts
map("n", "<leader>py", "", { desc = "Python" })
map("n", "<leader>pyr", "<leader>Ur", { desc = "Run Python file with uv", remap = true })
map("n", "<leader>pya", "<leader>Ua", { desc = "Add package with uv", remap = true })
map("n", "<leader>pyv", "<leader>Uv", { desc = "Select virtual environment", remap = true })
map("n", "<leader>pyi", "<leader>Ui", { desc = "Initialize uv project", remap = true })
map("n", "<leader>pys", "<leader>Us", { desc = "Run selected code with uv", remap = true })
map("n", "<leader>pyc", "<leader>Uc", { desc = "Sync uv packages", remap = true })

-- Formatting mappings
map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format file" })

-- Linting mappings
map("n", "<leader>li", "<cmd>Lint<cr>", { desc = "Run linter" })

-- Flash mappings (buffer search) - these are defined in plugins/init.lua
-- but adding descriptions here for clarity:
-- "s" - Flash jump (search and jump to any visible text)
-- "S" - Flash treesitter (jump to treesitter nodes)
-- "r" - Remote flash (for operator mode)
-- "R" - Treesitter search (for operator and visual mode)
-- "<C-s>" - Toggle flash search in command mode

-- Additional useful Python development mappings
map("n", "<leader>db", "", { desc = "Debug" })
map("n", "<leader>dbt", function()
  -- Add a breakpoint at current line
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local breakpoint = "import pdb; pdb.set_trace()"
  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { breakpoint })
end, { desc = "Add Python breakpoint" })

-- Virtual environment mappings (using uv.nvim plugin)
map("n", "<leader>vs", "<leader>Uv", { desc = "Select Python Virtual Environment", remap = true })
map("n", "<leader>ve", "<leader>U", { desc = "Show uv commands menu", remap = true })

-- LSP mappings (these extend the default NvChad LSP mappings)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- Diagnostic mappings
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- Add these mappings to your mappings.lua file

-- Ruff linting shortcuts
map("n", "<leader>lr", function()
  require("lint").try_lint()
end, { desc = "Run Ruff linting" })

map("n", "<leader>lR", function()
  -- Run ruff directly on current file
  local file = vim.fn.expand "%"
  if file ~= "" then
    vim.fn.jobstart("ruff check " .. file, {
      on_stdout = function(_, data)
        if data and #data > 0 then
          for _, line in ipairs(data) do
            if line ~= "" then
              vim.notify(line, vim.log.levels.WARN)
            end
          end
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 then
          for _, line in ipairs(data) do
            if line ~= "" then
              vim.notify(line, vim.log.levels.ERROR)
            end
          end
        end
      end,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("✓ Ruff: No issues found", vim.log.levels.INFO)
        end
      end,
    })
  end
end, { desc = "Run Ruff check directly" })

-- Ruff fix shortcuts
map("n", "<leader>lf", function()
  local file = vim.fn.expand "%"
  if file ~= "" then
    vim.fn.jobstart("ruff check --fix " .. file, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("✓ Ruff: Auto-fixed issues", vim.log.levels.INFO)
          vim.cmd "checktime" -- Reload file if changed
        else
          vim.notify("✗ Ruff: Could not fix all issues", vim.log.levels.WARN)
        end
      end,
    })
  end
end, { desc = "Ruff auto-fix issues" })

-- Ruff format shortcut (alternative to conform)
map("n", "<leader>lF", function()
  local file = vim.fn.expand "%"
  if file ~= "" then
    vim.fn.jobstart("ruff format " .. file, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("✓ Ruff: File formatted", vim.log.levels.INFO)
          vim.cmd "checktime" -- Reload file if changed
        else
          vim.notify("✗ Ruff: Format failed", vim.log.levels.ERROR)
        end
      end,
    })
  end
end, { desc = "Ruff format file" })

-- Show ruff rules/config
map("n", "<leader>lc", function()
  vim.fn.jobstart("ruff check --show-settings", {
    on_stdout = function(_, data)
      if data and #data > 0 then
        local content = table.concat(data, "\n")
        -- Create a new buffer to show the settings
        vim.cmd "new"
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
        vim.bo.filetype = "json"
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
      end
    end,
  })
end, { desc = "Show Ruff configuration" })

-- Quick ruff check with floating window
map("n", "<leader>ll", function()
  local file = vim.fn.expand "%"
  if file == "" then
    return
  end

  local output = {}
  vim.fn.jobstart("ruff check " .. file .. " --output-format=text", {
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(output, line)
        end
      end
    end,
    on_exit = function(_, code)
      if #output == 0 then
        vim.notify("✓ Ruff: No issues found", vim.log.levels.INFO)
      else
        -- Show results in floating window
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

        local width = math.min(80, vim.o.columns - 4)
        local height = math.min(20, #output)

        vim.api.nvim_open_win(buf, true, {
          relative = "cursor",
          width = width,
          height = height,
          col = 0,
          row = 1,
          border = "rounded",
          style = "minimal",
          title = " Ruff Issues ",
        })

        -- Make it easier to close
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
        vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf })
      end
    end,
  })
end, { desc = "Ruff check with floating results" })

-- Python-specific linting shortcuts (add to the Python section)
map("n", "<leader>pyl", "<leader>lr", { desc = "Python lint with Ruff", remap = true })
map("n", "<leader>pyf", "<leader>lf", { desc = "Python fix with Ruff", remap = true })
map("n", "<leader>pyF", "<leader>lF", { desc = "Python format with Ruff", remap = true })
