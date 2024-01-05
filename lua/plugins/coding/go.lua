return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    event = "CmdlineEnter",
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
