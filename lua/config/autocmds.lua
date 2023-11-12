-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- disabled semantic Token LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- formatter
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format { bufnr = args.buf }
  end,
})

-- highlight
vim.api.nvim_set_hl(0, 'FoldColumn', { fg = '#5c6370' })
vim.api.nvim_set_hl(0, 'CursorLineFold', { fg = '#abb2bf' })
vim.api.nvim_set_hl(0, 'UfoFoldedBg', { bg = '#1f2336' })
vim.api.nvim_set_hl(0, 'Folded', { link = 'CursorLine' })
