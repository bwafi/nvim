return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").register({
        ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "Debug", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "Rename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "Search", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "Workspace", _ = "which_key_ignore" },
        ["<leader>t"] = { name = "Test", _ = "which_key_ignore" },
        ["<leader>u"] = { name = "Toggle", _ = "which_key_ignore" },
        ["<leader>x"] = { name = "Diagnostics/quickfix", _ = "which_key_ignore" },
      })
    end,
  },
}
