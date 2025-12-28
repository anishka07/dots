-- Python development setup for LazyVim
-- The extras import is now in lazy.lua to maintain correct order

return {
  -- Configure Python LSP (pyright)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
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
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Configure Linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },

  -- Mason: ensure Python tools are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "ty",
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

  -- Venv-selector - Manual virtual environment selection
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    config = function()
      require("venv-selector").setup({
        settings = {
          options = {
            notify_user_on_venv_activation = true,
          },
        },
      })
    end,
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Virtual Environment" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached Python Virtual Environment" },
    },
  },
}
