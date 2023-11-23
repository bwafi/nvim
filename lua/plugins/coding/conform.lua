return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  cmd = "ConformInfo",
  config = function()
    local conform = require("conform")

    conform.setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },

      format_after_save = {
        lsp_fallback = true,
      },
      formatters_by_ft = {
        ["markdown"] = { { "prettierd" } },
        ["markdown.mdx"] = { { "prettierd" } },
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["html"] = { "prettierd" },
        ["lua"] = { "stylua" },
        ["json"] = { "jq" },
        ["go"] = { "goimports", "gofumpt" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    })
  end,
}
