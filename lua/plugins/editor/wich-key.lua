return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").add({
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "More git" },
        { "<leader>r", group = "Rename" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Test" },
        { "<leader>u", group = "Toggle" },
        { "<leader>w", group = "Workspace" },
        { "<leader>x", group = "Diagnostics/quickfix" },
      })
    end,
  },
}
