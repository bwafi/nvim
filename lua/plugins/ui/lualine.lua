local Util = require("utils.lualine")

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
    local colors = require("tokyonight.colors").setup({ transform = true })
    -- local config = require("tokyonight.config").options
    local tokyonight = {}

    tokyonight.normal = {
      a = { bg = colors.blue, fg = colors.black },
      b = { bg = colors.fg_gutter, fg = colors.blue },
      c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
    }

    tokyonight.insert = {
      a = { bg = colors.green1, fg = colors.black },
      b = { bg = colors.fg_gutter, fg = colors.green1 },
    }

    tokyonight.command = {
      a = { bg = colors.yellow, fg = colors.black },
      b = { bg = colors.fg_gutter, fg = colors.yellow },
    }

    tokyonight.visual = {
      a = { bg = colors.magenta, fg = colors.black },
      b = { bg = colors.fg_gutter, fg = colors.magenta },
    }

    tokyonight.replace = {
      a = { bg = colors.red, fg = colors.black },
      b = { bg = colors.fg_gutter, fg = colors.red },
    }

    tokyonight.terminal = {
      a = { bg = colors.green, fg = colors.black },
      b = { bg = colors.fg_gutter, fg = colors.green },
    }

    tokyonight.inactive = {
      a = { bg = colors.bg_statusline, fg = colors.blue },
      b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
      c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
    }
    require("lualine").setup({
      options = {
        theme = tokyonight,
        -- theme = "onedark",
        -- component_separators = { left = "", right = "" },
        icons_enabled = true,
        section_separators = { left = "", right = "" },
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

          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          Util.pretty_path(),
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
