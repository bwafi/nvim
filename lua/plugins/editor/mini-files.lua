return {
  "echasnovski/mini.files",
  event = "VeryLazy",
  version = "*",
  init = function()
    require("mini.files").setup({
      content = {
        filter = nil,
        prefix = nil,
        sort = nil,
      },

      mappings = {
        close = "q",
        go_in = "l",
        go_in_plus = "L",
        go_out = "h",
        go_out_plus = "H",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },

      options = {
        permanent_delete = true,
        use_as_default_explorer = false,
      },

      windows = {
        max_number = math.huge,
        preview = false,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
      },
    })

    vim.keymap.set({ "n" }, "-", "<cmd>lua MiniFiles.open()<cr>", { silent = true, desc = "Open Mini Files" })
  end,
}
