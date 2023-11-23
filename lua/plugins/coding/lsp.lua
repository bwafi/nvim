return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "b0o/schemastore.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
    },
    config = function()
      local on_attach = function(client, bufnr)
        -- disable semantic token
        client.server_capabilities.semanticTokensProvider = nil

        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

        nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
        nmap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
        nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
        nmap("<leader>ss", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

        -- See `:help K` for why this keymap
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

      -- vim.diagnostic.config({
      --   signs = true,
      --   severity_sort = false,
      -- })

      require("mason").setup()
      require("mason-lspconfig").setup()

      require("neodev").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true,
      -- }
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
      })
    end,
  },
}
