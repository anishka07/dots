return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-wave",
    },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          theme = {
            all = {
              ui = {
                -- removes the dark background from sign/gutter column
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- NeoTree: fully transparent, no dark panels
            NeoTreeNormal = { bg = "NONE" },
            NeoTreeNormalNC = { bg = "NONE" },
            NeoTreeEndOfBuffer = { fg = theme.ui.bg_p2, bg = "NONE" },
            NeoTreeWinSeparator = { fg = theme.ui.bg_p2, bg = "NONE" },
            NeoTreeTabActive = { bg = "NONE" },
            NeoTreeTabInactive = { bg = "NONE" },
            NeoTreeTabSeparatorActive = { bg = "NONE" },
            NeoTreeTabSeparatorInactive = { bg = "NONE" },

            -- Line numbers: no dark background behind relative numbers
            LineNr = { bg = "NONE" },
            CursorLineNr = { bg = "NONE" },
            SignColumn = { bg = "NONE" },

            -- Floating windows and Telescope: transparent
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE", fg = theme.syn.fun },
            TelescopeNormal = { bg = "NONE" },
            TelescopeBorder = { bg = "NONE", fg = theme.syn.fun },
          }
        end,
      })

      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },

  -- Accurate file-type icon colors (overrides mini.icons defaults)
  {
    "nvim-mini/mini.icons",
    opts = {
      extension = {
        -- Python canonical color is blue, not yellow
        py = { hl = "MiniIconsBlue" },
        -- Keep other common ones accurate
        rs = { hl = "MiniIconsOrange" }, -- Rust
        go = { hl = "MiniIconsCyan" }, -- Go
        rb = { hl = "MiniIconsRed" }, -- Ruby
        java = { hl = "MiniIconsOrange" }, -- Java
        kt = { hl = "MiniIconsPurple" }, -- Kotlin
        swift = { hl = "MiniIconsOrange" }, -- Swift
        ts = { hl = "MiniIconsBlue" }, -- TypeScript
        tsx = { hl = "MiniIconsBlue" }, -- TypeScript JSX
        lua = { hl = "MiniIconsBlue" }, -- Lua
        css = { hl = "MiniIconsBlue" }, -- CSS
        html = { hl = "MiniIconsOrange" }, -- HTML
      },
      file = {
        [".py"] = { hl = "MiniIconsBlue" },
      },
    },
  },
}
