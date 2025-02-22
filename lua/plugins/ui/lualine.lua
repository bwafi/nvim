return {
  "nvim-lualine/lualine.nvim",
  dependencies = "echasnovski/mini.icons",
  event = "VeryLazy",
  -- enabled = false,
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  config = function()
    local lualine = require("lualine")

    -- Color table for highlights
    local colors = {
      bg = "#1e2030",
      fg = "#bbc2cf",
      yellow = "#ECBE7B",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#98be65",
      green2 = "41a6b5",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#51afef",
      red = "#ec5f67",
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 120
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
        disabled_filetypes = { "snacks_dashboard" },
        always_divide_middle = true,
        globalstatus = true,
      },
      extensions = { "nvim-tree" },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left({
      function()
        return "▊"
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.blue,
          v = colors.green,
          [""] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 0, right = 1 }, -- We don't need space before this
    })

    ins_left({
      -- mode component
      function()
        return ""
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.blue,
          v = colors.green,
          [""] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    })

    ins_left({
      -- filesize component
      "filesize",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta },
    })

    ins_left({
      utils.lualine.pretty_path(),
    })

    ins_left({
      "filetype",
      colored = true,
      icon_only = true,
      icon = { align = "right" },
      padding = { right = 0, left = 0 },
    })

    ins_left({ [[%l:%c]], color = { fg = colors.violet } })

    ins_left({
      [[%p%%]],
      color = { fg = colors.green2 },
    })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })

    -- ins_left({
    --   Util.lsp_progress,
    -- })

    ins_right({
      function()
        return require("noice").api.status.command.get()
      end,
      cond = require("noice").api.status.command.has,
      color = { fg = colors.blue },
      padding = { right = 0 },
    })

    ins_right({
      "searchcount",
    })

    ins_right({
      "fileformat",
      icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
      symbols = {
        unix = "",
      },
      color = { fg = colors.green },
    })

    ins_right({
      -- Lsp server name .
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = "",
      color = { fg = colors.magenta },
    })

    -- Add components to right sections
    -- ins_right({
    --   "o:encoding", -- option component same as &encoding in viml
    --   fmt = string.upper, -- I'm not sure why it's upper case either ;)
    --   cond = conditions.hide_in_width,
    --   color = { fg = colors.green, gui = "bold" },
    -- })

    ins_right({
      "diff",
      -- Is it me or the symbol for modified us really weird
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
      -- diff_color = {
      --   added = { fg = colors.green },
      --   modified = { fg = colors.orange },
      --   removed = { fg = colors.red },
      -- },
      cond = conditions.hide_in_width,
    })

    ins_right({
      "branch",
      icon = "",
      color = { fg = colors.violet },
      padding = { right = 0 },
    })

    ins_right({
      function()
        return "▊"
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.blue,
          v = colors.green,
          [""] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 1 },
    })

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
