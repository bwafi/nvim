return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
  },
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        -- signs = { severity = { min = vim.diagnostic.severity.WARN } },
        underline = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
        virtual_text = false,
        -- virtual_text = {
        --   spacing = 4,
        --   source = "if_many",
        --   -- prefix = "●",
        --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        --   prefix = "icons",
        -- },
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      inlay_hints = {
        enabled = true,
        -- exclude = { "vue", "typescriptreact" },
        exclude = { "vue", "go" },
      },
      codelens = {
        enabled = false,
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
    }
    return ret
  end,
  config = function(_, opts)
    utils.lsp.setup()
    utils.lsp.on_attach(function(client, buffer)
      require("plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    utils.lsp.on_dynamic_capability(require("plugins.lsp.keymaps").on_attach)

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("syro-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- stylua: ignore start
        -- LSP keyemap Snacks.picker
        map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
        map("gr", function() Snacks.picker.lsp_references() end, "References")
        map("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
        map("gy", function() Snacks.picker.lsp_type_definitions() end, "Goto T[y]pe Definition")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        -- map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("<leader>ca", '<CMD>lua vim.lsp.buf.code_action({ context = { only = { "source", "refactor", "quickfix" } } }) <CR>', "Code Action")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
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
      end,
    })

    if vim.fn.has("nvim-0.10") == 1 then
      -- inlay hints
      if opts.inlay_hints.enabled then
        utils.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype) then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        utils.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end
    end

    -- diagnostics settings
    if type(opts.diagnostics.signs) ~= "boolean" then
      for severity, icon in pairs(opts.diagnostics.signs.text) do
        local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end

    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
        or function(diagnostic)
          local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
    end
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities for completion
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

    -- load server
    local servers = require("plugins.lsp.servers")

    ---@diagnostic disable-next-line: missing-fields
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
