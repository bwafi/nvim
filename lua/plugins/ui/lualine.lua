-- local Util = require("utils.lualine")
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  config = function()
    -- local wpm = require("wpm")
    require("lualine").setup({
      options = {
        -- theme = "NeoSolarized",
        icons_enabled = true,
        -- theme = "onedark",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = '', right = ''},
        disabled_filetypes = { "dashboard" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode", "tab" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          -- {
          --   Util.pretty_path({ path = 1 }),
          -- },
          -- {
          --   "filename",
          --   file_status = true,
          --   path = 1,
          --   symbols = {
          --     modified = "[+]", -- Text to show when the file is modified.
          --     readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
          --     unnamed = "[No Name]", -- Text to show for unnamed buffers.
          --     newfile = "[New]", -- Text to show for newly created file before first write
          --   },
          -- },
        },
        lualine_x = {
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = { fg = "#ff9e64" },
          },
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " " },
          },
          "filetype",
          "fileformat",
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "nvim-tree" },
    })
  end,
}
