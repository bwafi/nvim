return {
  {
    "saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    event = "InsertEnter",
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },

      keymap = {
        preset = "enter",
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },

        list = {
          selection = {
            -- preselect = true,
            auto_insert = true,
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
          },
        },

        ghost_text = {
          enabled = true,
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          },
        },

        menu = {
          border = "rounded",
          draw = {
            gap = 2,
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon" }, { "kind" } },
          },
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
      },

      sources = {
        -- default = { "lsp", "path", "snippets", "buffer", "dadbod" },
        default = { "lsp", "path", "snippets", "buffer" },
        -- Disable cmdline completions
        -- cmdline = {},
        providers = {
          -- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },

        per_filetype = {
          -- lua = { 'lsp', 'path' },
          -- sql = { "dadbod" },
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
}
