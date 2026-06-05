return {
  -- Disable pyright in favour of ruff LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = { enabled = false },
        ruff = {},
      },
    },
  },

  -- Configure Formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },

  -- Restore <leader>co (Organize Imports) via ruff LSP
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.py",
        callback = function(args)
          vim.keymap.set("n", "<leader>co", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.organizeImports" } },
            })
          end, { buffer = args.buf, desc = "Organize Imports" })
        end,
      })
    end,
  },

  -- Mason: ensure Python tools are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "ruff",
        "debugpy",
      },
    },
  },
  {
    "benomahony/uv.nvim",
    lazy = false,
    config = function()
      require("uv").setup({
        auto_activate_venv = true,
        auto_commands = true,
        picker_integration = true,
        keymaps = {
          prefix = "<leader>U",
          commands = true,
          run_file = true,
          venv = true,
        },
        execution = {
          run_command = "uv run python",
          notify_output = true,
          notification_timeout = 5000,
        },
      })

      -- Debug command for troubleshooting venv detection
      vim.api.nvim_create_user_command("UvDebug", function()
        local cwd = vim.fn.getcwd()
        local venv_paths = { cwd .. "/.venv", cwd .. "/venv", cwd .. "/env" }
        for _, path in ipairs(venv_paths) do
          if vim.fn.isdirectory(path) == 1 then
            vim.notify("Found venv at: " .. path, vim.log.levels.INFO)
            return
          end
        end
        vim.notify("No venv found in: " .. cwd, vim.log.levels.WARN)
      end, { desc = "Debug uv virtual environment detection" })
    end,
  },

  -- venv-selector removed: uv.nvim handles venv activation automatically
  { "linux-cultist/venv-selector.nvim", enabled = false },
}
