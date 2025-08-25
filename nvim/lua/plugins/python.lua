return {
  -- Python virtualenv manager
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    config = function()
      require("venv-selector").setup {
        settings = { options = { notify_user_on_venv_activation = true } },
      }
    end,
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Virtual Environment" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached Python Virtual Environment" },
    },
  },
  {
    "benomahony/uv.nvim",
    lazy = false,
    config = function()
      require("uv").setup {
        auto_activate_venv = true,
        auto_commands = true,
        picker_integration = true,
        keymaps = { prefix = "<leader>U", commands = true, run_file = true, venv = true },
        execution = { run_command = "uv run python", notify_output = true, notification_timeout = 5000 },
      }
      vim.api.nvim_create_user_command("UvDebug", function()
        local cwd = vim.fn.getcwd()
        local venv_paths = { cwd .. "/.venv", cwd .. "/venv", cwd .. "/env" }
        for _, path in ipairs(venv_paths) do
          if vim.fn.isdirectory(path) == 1 then
            return
          end
        end
      end, { desc = "Debug uv virtual environment detection" })
    end,
  },
}
