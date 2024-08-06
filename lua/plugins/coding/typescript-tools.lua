return {
  "pmizio/typescript-tools.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    on_attach = function(client)
      client.server_capabilities.semanticTokensProvider = nil
    end,
    settings = {
      tsserver_path = vim.env.HOME .. "/.volta/tools/shared/typescript/lib/tsserver.js",
      complete_function_calls = true,
    },
  },
}
