return {
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
  --     vim.cmd([[colorscheme catppuccin-mocha]])
  --   end,
  -- },

  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd([[colorscheme rose-pine-moon]])
  --   end,
  -- },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
