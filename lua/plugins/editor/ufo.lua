return {
  {
    "kevinhwang91/nvim-ufo",
    -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
      "luukvbaal/statuscol.nvim",
    },
    config = function()
      -- https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1514537245
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = ("   %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx = math.max(width - 5 - curWidth - sufWidth, 0)
        suffix = " ⋯  " .. (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      -- ufo opts
      require("ufo").setup({
        -- fold tesxt custom
        close_fold_kinds_for_ft = { "imports" },
        fold_virt_text_handler = handler,

        -- if use Tressiter
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  {
    "luukvbaal/statuscol.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        bt_ignore = {
          "nofile",
          "prompt",
          "terminal",
          "lazy",
          "nvdash",
        },
        ft_ignore = {
          "Empty",
          "NvimTree",
          "nvcheatsheet",
          "dapui_watches",
          "dap-repl",
          "dapui_console",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "help",
          "vim",
          "alpha",
          "nvdash",
          "Nvdash",
          "dashboard",
          "neo-tree",
          "Trouble",
          "noice",
          "lazy",
          "toggleterm",
        },
        relculright = true,

        segments = {
          -- {
          --   sign = {
          --     name = { ".*" },
          --     maxwidth = 1,
          --     auto = false,
          --     wrap = false,
          --     fillchar = " ",
          --   },
          --   click = "v:lua.ScSa",
          -- },
          {
            sign = { namespace = { "diagnostic" }, maxwidth = 1, colwidth = 2, auto = false },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = {
              namespace = { "gitsigns" },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
              wrap = false,
              fillchar = " ",
            },
            click = "v:lua.ScSa",
          },
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        },
      })
    end,
  },
}
