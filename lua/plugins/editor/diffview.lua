return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-web-devicons" },
    event = "VeryLazy",
    config = true,
    -- stylua: ignore
    keys = {
      { "<leader>gv", mode = { "n", }, "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
      { "<leader>gc", mode = { "n", }, "<cmd>tabclose<cr>", desc = "close diff view" },
      },
  },
}
