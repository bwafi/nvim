return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>a", "<cmd>AerialToggle<CR>", desc = "Aerial Toggle" },
    { "<leader>A", "<cmd>AerialNavToggle<CR>", desc = "[A]erial nav toggle" },
    { "[s", "<cmd>AerialPrev<CR>", mode = { "n", "v" }, desc = "Previous aerial symbol" },
    { "]s", "<cmd>AerialNext<CR>", mode = { "n", "v" }, desc = "Next aerial symbol" },
  },
  opts = {
    highlight_on_hover = true,
    link_folds_to_tree = true,
    link_tree_to_folds = true,
    manage_folds = {
      ["_"] = true,
    },
  },
}
