return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n" },
      desc = "Format buffer",
    },
    {
      "<leader>uf",
      "<cmd>FormatToggle<cr>",
      mode = { "x", "n", "s" },
      desc = "Toggle Format",
    },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,

      -- format_after_save = {
      --   lsp_fallback = true,
      -- },
      formatters_by_ft = {
        ["markdown"] = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["html"] = { "prettierd" },
        ["lua"] = { "stylua" },
        ["json"] = { "jq" },
        ["go"] = { "goimports", "gofumpt" },
        -- ["go"] = { "goimports", "gofumpt", "golines" },
        ["blade"] = { "blade-formatter" },
        ["php"] = { "php_cs_fixer" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        prettierd = {
          prepend_args = { "--bracket-same-line", "--print-width 300" },
        },
      },
    })
  end,

  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if vim.b.disable_autoformat then
        vim.b.disable_autoformat = false
        vim.notify("Format on save enable", "info", { title = "conform.nvim" })
      else
        vim.b.disable_autoformat = true
        vim.notify("Format on save disable", "warn", { title = "conform.nvim" })
      end
    end, {
      desc = "Disable Format on save",
    })
  end,
}
