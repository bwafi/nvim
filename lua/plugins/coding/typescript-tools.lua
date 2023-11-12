return {
  "pmizio/typescript-tools.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    settings = {
      tsserver_path = vim.env.HOME .. "/.volta/tools/shared/typescript/lib/tsserver.js",
      complete_function_calls = true,
    },
  },
}
