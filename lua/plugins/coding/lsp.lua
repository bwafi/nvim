return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "b0o/schemastore.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true },
    },

    opts = {
      codelens = {
        enabled = false,
      },
    },
    config = function(_, opts)
      local on_attach = function(client, bufnr)
        -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        --   border = "single",
        -- })
        -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        --   border = "single",
        --   focusable = false,
        --   relative = "cursor",
        -- })

        -- disable semantic token
        -- client.server_capabilities.semanticTokensProvider = nil

        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>ca", '<CMD>lua vim.lsp.buf.code_action({ context = { only = { "source", "refactor", "quickfix" } } }) <CR>', "Code Action")
        -- nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

        nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
        nmap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
        nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
        nmap("<leader>ss", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

        -- See `:help K` for why this keymaplsp
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "Workspace List Folders")
      end

      -- if opts.codelens.enabled and vim.lsp.codelens then
      --   vim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
      --     vim.lsp.codelens.refresh()
      --     vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      --       buffer = buffer,
      --       callback = vim.lsp.codelens.refresh,
      --     })
      --   end)
      -- end

      -- diagnostics
      local signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- diagnostic configirution
      vim.diagnostic.config({
        signs = { severity = { min = vim.diagnostic.severity.WARN } },
        -- irtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
        -- signs = true,
        virtual_text = false,
        underline = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
        update_in_insert = false, -- Tidak memperbarui diagnostik di mode insert
        severity_sort = false, -- Tidak mengurutkan diagnostik berdasarkan tingkat keparahan
      })

      require("mason").setup()
      require("mason-lspconfig").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local mason_lspconfig = require("mason-lspconfig")

      local lspconfig = require("lspconfig")

      local excluded_servers = { "eslint", "prettierd", "eslint_d" } -- exclude server because server handling with other plugin

      mason_lspconfig.setup_handlers({
        function(server_name)
          -- exclude server because server handling with other plugin
          if not vim.tbl_contains(excluded_servers, server_name) then
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end
        end,

        -- setting server
        ["emmet_language_server"] = function()
          lspconfig.emmet_language_server.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "blade" },
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            seetings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                  },
                  checkThirdParty = false,
                  maxPreload = 100000,
                  preloadFileSize = 10000,
                },
                -- telemetry = { enable = false },
              },
            },
          })
        end,

        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end,

        ["gopls"] = function()
          lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = false,
              },
            },
          })
        end,
      })
    end,
  },
}
