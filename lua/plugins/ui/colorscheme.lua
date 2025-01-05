return {
  -- {
  --   "maxmx03/solarized.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("solarized").setup({
  --       highlights = function(colors)
  --         return {
  --           SignColumn = { bg = colors.base03 },
  --           ColorColumn = { bg = colors.base03 },
  --           FoldColumn = { fg = "#546263", bg = colors.base03 },
  --           Folded = { bg = colors.base03 },
  --           CursorLineFold = { fg = colors.base0, bg = colors.base03 },
  --           LineNr = { fg = "#546263", bg = colors.base03 },
  --           CursorLineNr = { fg = colors.base0, bg = colors.base03 },
  --           GitSignsAdd = { bg = colors.base03 },
  --           GitSignsChange = { bg = colors.base03 },
  --           GitSignsDelete = { bg = colors.base03 },
  --           WhichKeyDesc = { fg = colors.base0 },
  --           DiagnosticSignError = { bg = colors.base03 },
  --           DiagnosticSignWarn = { bg = colors.base03 },
  --           DiagnosticSignInfo = { bg = colors.base03 },
  --           DiagnosticSignHint = { bg = colors.base03 },
  --           DiagnosticSignOk = { bg = colors.base03 },
  --           IblIndent = { fg = "#4c5859" },
  --           MiniIndentscopeSymbol = { fg = colors.magenta },
  --           NvimTreeNormal = { bg = "#002631" },
  --           NvimTreeWinSeparator = { bg = "#002631" },
  --           DashBoardFooter = { fg = colors.blue },
  --           DashBoardHeader = { fg = colors.blue },
  --         }
  --       end,
  --     })
  --     vim.o.background = "dark" -- or 'light'
  --     vim.cmd.colorscheme("solarized")
  --   end,
  -- },

  -- {
  --   "neanias/everforest-nvim",
  --   version = false,
  --   lazy = false,
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   -- Optional; default configuration will be used if setup isn't called.
  --   config = function()
  --     vim.cmd([[colorscheme everforest]])
  --   end,
  -- },
  -- {
  --   'bluz71/vim-nightfly-guicolors',
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd [[colorscheme nightfly]]
  --   end,
  -- },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.cmd([[colorscheme kanagawa-dragon]])
  --   end,
  -- },

  -- {
  --   "shaunsingh/nord.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.cmd([[colorscheme nord]])
  --   end,
  -- },

  -- {
  --   "EdenEast/nightfox.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require("nightfox").setup({
  --       options = {
  --         styles = {
  --           comments = "italic",
  --           keywords = "bold",
  --           types = "italic,bold",
  --         },
  --       },
  --     })
  --     vim.cmd([[colorscheme nightfox]])
  --   end,
  -- },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         nvimtree = true,
  --         treesitter = true,
  --         notify = true,
  --         mini = {
  --           enabled = true,
  --           indentscope_color = "",
  --         },
  --         dap = {
  --           enabled = true,
  --           enable_ui = true,
  --         },
  --         rainbow_delimiters = true,
  --         which_key = true,
  --         mason = true,
  --       },
  --     })
  --   end,
  -- },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = false,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          -- functions = {},
          -- variables = {},
          sidebars = "transparent",
          floats = "dark",
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "moon",
  --       dark_variant = "moon",
  --     })
  --     vim.cmd([[colorscheme rose-pine]])
  --   end,
  -- },
}
