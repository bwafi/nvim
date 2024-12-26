return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = false,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  -- version = "3.5.4", -- v3.6.0 is broken
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
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
      },
    },
  },
  main = "ibl",
}
