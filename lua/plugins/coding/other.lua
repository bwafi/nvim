return {

  -- highlight under cursor
  {
    "echasnovski/mini.cursorword",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    init = function()
      require("mini.cursorword").setup({})
    end,
  },
}
