return {
  'stevearc/conform.nvim',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  cmd = 'ConformInfo',
  opts = {
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },

    format_after_save = {
      lsp_fallback = true,
    },
    formatters_by_ft = {
      ['markdown'] = { { 'prettierd' } },
      ['markdown.mdx'] = { { 'prettierd' } },
      ['javascript'] = { 'prettierd' },
      ['javascriptreact'] = { 'prettierd' },
      ['typescript'] = { 'prettierd' },
      ['typescriptreact'] = { 'prettierd' },
      ['lua'] = { 'stylua' },
    },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2', '-ci' },
      },
    },
  },
}
