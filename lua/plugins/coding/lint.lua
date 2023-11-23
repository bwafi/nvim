return {
  "mfussenegger/nvim-lint",
  -- enable = true, -- TODO: linting handler with mason-lspconfig
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters = {
      eslint_d = {
        args = {
          "--no-warn-ignored", -- <-- this is the key argument
          "--format",
          "json",
          "--stdin",
          "--stdin-filename",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
      },
    },
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      -- javascript = { "eslint_d" },
      -- typescript = { "eslint_d" },
      -- javascriptreact = { "eslint_d" },
      -- typescriptreact = { "eslint_d" },
      go = { "golangcilint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
}
