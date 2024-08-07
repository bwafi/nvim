return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path", -- source for file system paths
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "hrsh7th/cmp-cmdline",
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = {
          completeopt = "menu,menuone,preview",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        experimental = {
          ghost_text = true,
          hl_group = "CmpGhostText",
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.complete(),
          ["<C-c>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          {
            name = "lazydev",
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }),

        -- formatting = {
        --   format = function(_, item)
        --     if icon_kinds[item.kind] then
        --       item.kind = icon_kinds[item.kind] .. item.kind
        --     end
        --     return item
        --   end,
        -- },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        completion = {
          completeopt = "menu,preview,menuone,noselect",
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
          },
        }),
      })

      -- '?' cmpline setup
      cmp.setup.cmdline("?", {
        completion = {
          completeopt = "menu,preview,menuone,noselect",
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- '/' cmpline setup
      cmp.setup.cmdline("/", {
        completion = {
          completeopt = "menu,preview,menuone,noselect",
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows")) and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp" or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        local luasnip = require("luasnip")

        luasnip.filetype_extend("javascript", { "javascriptreact" })
        luasnip.filetype_extend("typescript", { "typescriptreact" })
        luasnip.filetype_extend("javascriptreact", { "html" })
        luasnip.filetype_extend("typescriptreact", { "html" })

        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  -- {
  --   "garymjr/nvim-snippets",
  --   event = "InsertEnter",
  --   dependencies = { "rafamadriz/friendly-snippets" },
  --
  --   opts = {
  --     friendly_snippets = true,
  --     extended_filetypes = {
  --       typescript = { "javascript", "tsdoc" },
  --       javascript = { "jsdoc" },
  --       html = { "css", "javascript" },
  --       lua = { "luadoc" },
  --       python = { "python-docstring" },
  --       java = { "javadoc", "java-testing" },
  --       sh = { "shelldoc" },
  --       php = { "phpdoc" },
  --       ruby = { "rdoc" },
  --       quarto = { "markdown" },
  --       rmarkdown = { "markdown" },
  --     },
  --   },
  --   keys = {
  --     {
  --       "<Tab>",
  --       function()
  --         if vim.snippet.active({ direction = 1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(1)
  --           end)
  --           return
  --         end
  --         return "<Tab>"
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "i",
  --     },
  --     {
  --       "<Tab>",
  --       function()
  --         vim.schedule(function()
  --           vim.snippet.jump(1)
  --         end)
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "s",
  --     },
  --     {
  --       "<S-Tab>",
  --       function()
  --         if vim.snippet.active({ direction = -1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(-1)
  --           end)
  --           return
  --         end
  --         return "<S-Tab>"
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = { "i", "s" },
  --     },
  --   },
  -- },
}
