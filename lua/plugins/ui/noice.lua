return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        -- render = "wrapped-compact",
        -- top_down = false,
        max_width = 55,
        minimum_width = 20,
        level = vim.log.levels.TRACE, -- minimum severity level
        timeout = 3000,
        stages = "slide", -- slide|fade
      },
    },
  },
  opts = {
    cmdline = {
      view = "cmdline",
    },
    views = {
      cmdline_popup = {
        position = {
          row = 10,
          col = "50%",
        },
      },
    },
    redirect = {
      view = "popup",
      filter = { event = "msg_show" },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
        silent = true,
      },
      signature = {
        enabled = true,
        silent = true,
        -- auto_open = {
        --   enabled = true,
        --   trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
        --   luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
        --   throttle = 50, -- Debounce lsp signature help request by 50ms
        -- },
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
  },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
}
