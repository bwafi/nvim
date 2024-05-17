return {
  "akinsho/bufferline.nvim",
  -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  event = "VeryLazy",
  -- version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      sort_by = "insert_at_end",
      numbers = "none",
      -- diagnostics_indicator = function(_, _, diag)
      --   local icons = {
      --     Error = " ",
      --     Warn = " ",
      --     Hint = " ",
      --     Info = " ",
      --   }
      --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
      --     .. (diag.warning and icons.Warn .. diag.warning or "")
      --   return vim.trim(ret)
      -- end,
      offsets = {
        {
          filetype = "NvimTree",
          text = function()
            return vim.fn.getcwd()
          end,
          -- text = 'File Explorer',
          highlight = "Directory",
          separator = true, -- use a "true" to enable the default, or set your own character
          text_align = "left",
        },
      },
    },
  },
}
