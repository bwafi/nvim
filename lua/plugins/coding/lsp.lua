return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    "b0o/schemastore.nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("syro-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc, has })
        end

        map("gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>", "Goto Definition")
        map("gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>", "Goto References")
        map("gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", "Goto Implementation")
        map("gy", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>", "Type Definition")

        map("<leader>rn", vim.lsp.buf.rename, "Rename")

        -- map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("<leader>ca", '<CMD>lua vim.lsp.buf.code_action({ context = { only = { "source", "refactor", "quickfix" } } }) <CR>', "Code Action")

        map("gD", vim.lsp.buf.declaration, "Goto Declaration")


        -- stylua: ignore start
        -- See `:help K` for why this keymaplsp
        map("K", function() return vim.lsp.buf.hover() end, "Hover")
        map("gK", function() return vim.lsp.buf.signature_help() end, "Signature Help")
        map("<c-k>", function() return vim.lsp.buf.signature_help() end, "Signature Help", "i")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
        map("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace List Folders")
        map( "<leader>cR", function() Snacks.rename.rename_file() end, "Rename File", "n")
        -- stylua: ignore end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- formatter for defult yamlls
        if client.name == "yamlls" then
          client.server_capabilities.documentFormattingProvider = true
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("syro-lsp-highlight", { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("syro-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "syro-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle Inlay Hints")
        end
      end,
    })

    -- Change diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      emmet_language_server = {
        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "blade" },
      },

      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },

      gopls = {
        settings = {
          gopls = {
            -- Tambahkan buildFlags untuk mendukung build tag wireinject
            buildFlags = { "-tags=wireinject" },
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
      },

      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
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
      },

      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = true,
            },
            schemaStore = {
              enable = true,
            },
          },
        },
      },
    }

    require("mason").setup()

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
