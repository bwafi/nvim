return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'

    npairs.setup {
      map_bs = false,
      fast_wrap = {
        map = '<A-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    }

    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())

    -- fix map_bs conflict with vim-visual-multi
    vim.api.nvim_set_keymap('i', '<Plug>autopairs_bs', 'v:lua.MPairs.autopairs_bs()', {
      expr = true,
      noremap = true,
    })

    vim.keymap.set('i', '<bs>', function()
      if vim.fn.foldclosed '.' > -1 then
        return '<C-o>zo'
      end

      local colnr = vim.fn.col '.'
      local line = vim.fn.getline '.'
      if vim.tbl_contains({ '(  )', '[  ]', '{  }', '>  <' }, line:sub(colnr - 2, colnr + 1)) then
        return '<Plug>autopairs_bs'
      end
      if line:sub(colnr - 1, colnr) == '  ' then
        return '<bs>'
      end

      return '<Plug>autopairs_bs'
    end, { expr = true, silent = true, noremap = true })
  end,
}
