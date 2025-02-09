return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "shfmt",
      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "css-lsp",
      "html-lsp",
      "emmet-language-server",
      -- "typescript-language-server",
      "vtsls",
      "prettierd",
      "shfmt",
      "tailwindcss-language-server",
      "jq",
      "eslint-lsp",
      -- "eslint_d",
      "prisma-language-server",
      "json-lsp",
      "js-debug-adapter",
      "vue-language-server",

      -- PHP
      -- "intelephense",
      "phpactor",
      "blade-formatter",
      "phpcs",
      "php-cs-fixer",

      -- sql
      -- "sqlls",
      -- "sql-formatter",

      -- go
      "gopls",
      "delve",
      "goimports",
      "gotests",
      "iferr",
      "gofumpt",
      "gomodifytags",
      "impl",
      -- "golangci-lint",
      "golines",

      -- Docker
      "dockerfile-language-server",
      "docker-compose-language-service",

      "yaml-language-server",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
