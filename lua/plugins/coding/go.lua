return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  config = function()
    require("go").setup({
      disable_defaults = false, -- true|false when true set false to all boolean settings and replace all table
      -- settings with {}
      go = "go", -- go command, can be go[default] or go1.18beta1
      goimport = "gopls", -- goimport command, can be gopls[default] or either goimport or golines if need to split long lines
      fillstruct = "gopls", -- default, can also use fillstruct
      gofmt = "gofumpt", --gofmt cmd,
      max_line_len = 128, -- max line length in golines format, Target maximum line length for golines
      tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
      tag_options = "json=omitempty", -- sets options sent to gomodifytags, i.e., json=omitempty
      gotests_template = "", -- sets gotests -template parameter (check gotests for details)
      gotests_template_dir = "", -- sets gotests -template_dir parameter (check gotests for details)
      comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. 󰟓       
      icons = { breakpoint = "🧘", currentpos = "🏃" }, -- setup to `false` to disable icons setup
      verbose = false, -- output loginf in messages

      lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
      lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
      lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
      lsp_keymaps = true, -- set to false to disable gopls/lsp keymap
      lsp_document_formatting = false,
      lsp_inlay_hints = {
        enable = true,
        -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
        -- inlay only avalible for 0.10.x
        style = "inlay",
        -- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show variable name before type hints with the inlay hints or not
        -- default: false
        show_variable_name = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "󰊕 ",
        show_parameter_hints = true,
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the lenght of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 6,
        -- The color of the hints
        highlight = "Comment",
      },

      gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
      gopls_remote_auto = true, -- add -remote=auto to gopls
      gocoverage_sign = "█",
      sign_priority = 5, -- change to a higher number to override other signs
      dap_debug = false, -- set to false to disable dap
      build_tags = "tag1,tag2", -- set default build tags
      textobjects = true, -- enable default text jobects through treesittter-text-objects
      test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
      verbose_tests = true, -- set to add verbose flag to tests deprecated, see '-v' option
      trouble = true, -- true: use trouble to open quickfix
      test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
      luasnip = false, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
      iferr_vertical_shift = 4, -- defines where the cursor will end up vertically from the begining of if err statement
    })
  end,
}
