return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    lazy = vim.fn.argc(-1) == 0,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-lua/plenary.nvim",
    },
    init = function(plugin) -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts = {
      ensure_installed = {
        "vimdoc",
        "bash",
        "lua",
        "html",
        "php",
        "php_only",
        "css",
        "scss",
        "blade",
        "sql",
        "json",
        "typescript",
        "javascript",
        "tsx",
        "vue",
        "go",
        "markdown",
        "markdown_inline",
        "regex",
        "http",
        "prisma",
      },
      auto_install = true,
      -- sync_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { "ruby" } },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "vv",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      -- PERF: install tree-sitter-cli "npm install -g tree-sitter-cli"
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
          generate_requires_npm = true,
          requires_generate_from_grammar = true,
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    config = function()
      -- PERF: If treesitter is already loaded, we need to run config again for textobjects

      -- if LazyVim.is_loaded("nvim-treesitter") then
      --   local opts = LazyVim.opts("nvim-treesitter")
      --   require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
      -- end

      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
      local configs = require("nvim-treesitter.configs")
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },
}
