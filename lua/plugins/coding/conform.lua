return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  -- stylua: ignore start
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n" }, desc = "Format buffer", },
    { "<leader>uf", "<cmd>FormatToggle!<cr>", mode = { "x", "n", "s" }, desc = "Toggle Format (buffer)", },
    { "<leader>uF", "<cmd>FormatToggle<cr>", mode = { "x", "n", "s" }, desc = "Toggle Format (global)", },
  },
  -- stylua: ignore end

  config = function()
    local conform = require("conform")

    conform.setup({
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,

      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },

      formatters_by_ft = {
        ["markdown"] = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["yaml"] = { "prettierd" },
        -- ["yml"] = { "prettierd" },
        ["html"] = { "prettierd" },
        ["lua"] = { "stylua" },
        ["json"] = { "jq" },
        ["go"] = { "goimports", "gofumpt" },
        -- ["go"] = { "goimports", "gofumpt", "golines" },
        ["blade"] = { "blade-formatter" },
        ["php"] = { "php_cs_fixer" },
        -- ["sql"] = { "sqlfluff" },
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
      if args.bang then
        -- Toggle autoformat will disable formatting just for this buffer
        if vim.b.disable_autoformat then
          vim.b.disable_autoformat = false
          vim.notify("Format on save enabled for this buffer", vim.log.levels.INFO, { title = "Conform.nvim" })
        else
          vim.b.disable_autoformat = true
          vim.notify("Format on save disabled for this buffer", vim.log.levels.WARN, { title = "Conform.nvim" })
        end
      else
        -- Toggle autoformat global
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          vim.notify("Format on save enabled globally", vim.log.levels.INFO, { title = "Conform.nvim" })
        else
          vim.g.disable_autoformat = true
          vim.notify("Format on save disabled globally", vim.log.levels.WARN, { title = "Conform.nvim" })
        end
      end
    end, {
      desc = "Toggle autoformat-on-save (use ! for buffer only)",
      bang = true,
    })
  end,
}
