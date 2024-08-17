return {
  "mfussenegger/nvim-lint",
  -- enabled = true, -- TODO: linting handler with mason-lspconfig
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.events = { "BufWritePost", "BufReadPost", "InsertLeave" }

    lint.linters_by_ft = {
      -- javascript = { "eslint" },
      -- typescript = { "eslint" },
      -- javascriptreact = { "eslint" },
      -- typescriptreact = { "eslint" },
      go = { "golangcilint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "BufReadPost" }, {
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
}
