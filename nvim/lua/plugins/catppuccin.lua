return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      float = {
        transparent = false,
        solid = false,
      },
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      lsp_styles = {
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      color_overrides = {
        mocha = {
          base = "#181825", -- mantle: between default base (#1e1e2e) and crust (#11111b)
        },
      },
      default_integrations = true,
      auto_integrations = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        neo_tree = true,
        notify = false,
        telescope = { enabled = true },
        which_key = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
      custom_highlights = function(colors)
        return {
          -- NeoTree: transparent panels
          NeoTreeNormal = { fg = colors.text, bg = "NONE" },
          NeoTreeNormalNC = { bg = "NONE" },
          NeoTreeEndOfBuffer = { bg = "NONE" },
          NeoTreeWinSeparator = { bg = "NONE" },
          NeoTreeTabActive = { bg = "NONE" },
          NeoTreeTabInactive = { bg = "NONE" },
          NeoTreeTabSeparatorActive = { bg = "NONE" },
          NeoTreeTabSeparatorInactive = { bg = "NONE" },
          -- Gutter / line numbers
          LineNr = { bg = "NONE" },
          CursorLineNr = { fg = colors.peach, bold = true, bg = "NONE" },
          SignColumn = { bg = "NONE" },
          -- Floating windows and Telescope
          NormalFloat = { bg = "NONE" },
          FloatBorder = { fg = colors.blue, bg = "NONE" },
          TelescopeNormal = { bg = "NONE" },
          TelescopeBorder = { fg = colors.blue, bg = "NONE" },
          -- WinBar
          WinBar = { bg = "NONE" },
          WinBarNC = { bg = "NONE" },
          -- MiniIcons using catppuccin palette
          MiniIconsBlue = { fg = colors.blue },
          MiniIconsAzure = { fg = colors.sapphire },
          MiniIconsCyan = { fg = colors.teal },
          MiniIconsGreen = { fg = colors.green },
          MiniIconsYellow = { fg = colors.yellow },
          MiniIconsOrange = { fg = colors.peach },
          MiniIconsRed = { fg = colors.red },
          MiniIconsPurple = { fg = colors.mauve },
          MiniIconsGrey = { fg = colors.overlay1 },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
