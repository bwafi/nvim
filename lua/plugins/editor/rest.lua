return {
  "rest-nvim/rest.nvim",
  ft = "http",
  commit = "8b62563",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    formatters = {
      json = "jq",
      html = function(body)
        return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
      end,
    },
  },
  config = function()
    vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim", { desc = "execute request" })
    vim.keymap.set("n", "<leader>rp", "<Plug>RestNvimPreview", { desc = "preview curl" })
    vim.keymap.set("n", "<leader>rl", "<Plug>RestNvimLast", { desc = "repeat last request" })
  end,
}
