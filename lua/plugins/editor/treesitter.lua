return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  -- lazy = false,
  event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "lua",
        "html",
        "php",
        "css",
        "scss",
        "sql",
        "json",
        "typescript",
        "javascript",
        "tsx",
        "vue",
        "http",
        "go",
        "prisma",
        "php",
        "markdown",
        "markdown_inline",
        "regex",
      },

      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      autotag = {
        enable = true,
        enable_close_on_slash = false,
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
      },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      --     keymaps = {
      --       -- You can use the capture groups defined in textobjects.scm
      --       ["aa"] = "@parameter.outer",
      --       ["ia"] = "@parameter.inner",
      --       ["af"] = "@function.outer",
      --       ["if"] = "@function.inner",
      --       ["ac"] = "@class.outer",
      --       ["ic"] = "@class.inner",
      --     },
      --   },
      --   move = {
      --     enable = true,
      --     set_jumps = true, -- whether to set jumps in the jumplist
      --     goto_next_start = {
      --       ["]m"] = "@function.outer",
      --       ["]]"] = "@class.outer",
      --     },
      --     goto_next_end = {
      --       ["]M"] = "@function.outer",
      --       ["]["] = "@class.outer",
      --     },
      --     goto_previous_start = {
      --       ["[m"] = "@function.outer",
      --       ["[["] = "@class.outer",
      --     },
      --     goto_previous_end = {
      --       ["[M"] = "@function.outer",
      --       ["[]"] = "@class.outer",
      --     },
      --   },
      -- },
    })
  end,
}
