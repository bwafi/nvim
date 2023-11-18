return {

  "echasnovski/mini.cursorword",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  init = function()
    require("mini.cursorword").setup({})
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "NvimTree",
      },
      callback = function()
        vim.b.minicursorword_disable = true
      end,
    })
  end,
}
