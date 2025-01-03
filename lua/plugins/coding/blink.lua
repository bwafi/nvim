return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {

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
          selection = function(ctx)
            return ctx.mode == "cmdline" and "auto_insert" or "preselect"
          end,
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
          },
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "dadbod" },
        -- Disable cmdline completions
        -- cmdline = {},
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },

        per_filetype = {
          -- lua = { 'lsp', 'path' },
          sql = { "dadbod" },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
