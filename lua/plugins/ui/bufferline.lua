return {
  "akinsho/bufferline.nvim",
  -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  event = "VeryLazy",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      sort_by = "insert_at_end",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = ""
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or " ")
          s = s .. sym .. n .. " "
        end
        return s
      end,
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
