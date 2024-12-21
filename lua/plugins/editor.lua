return {
  {
    "blink.cmp", -- overide blink cmp
    opts = {
      completion = {
        menu = {
          winblend = vim.o.pumblend,
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
        documentation = {
          window = {
            winblend = vim.o.pumblend,
            border = "rounded",
            winhighlight = "Normal:BlinkCmpMenu,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          },
        },
      },
      signature = {
        window = {
          winblend = vim.o.pumblend,
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
      },
    },
  },
}
