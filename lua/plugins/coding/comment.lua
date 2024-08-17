return {
  -- {
  --   "echasnovski/mini.comment",
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       custom_commentstring = function()
  --         return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
  --       end,
  --     },
  --   },
  -- },
  --
  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   event = "VeryLazy",
  --   -- lazy = true,
  --   opts = {
  --     enable_autocmd = false,
  --   },
  --
  -- },
  --
  --
  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
