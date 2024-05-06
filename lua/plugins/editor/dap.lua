return {
  -- debugging
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      {
        "mfussenegger/nvim-dap",
      },
      {
        "theHamsta/nvim-dap-virtual-text",
      },
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- dap ui setup
      dapui.setup({})

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
     -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = 8123,
        executable = {
          command = "js-debug-adapter",
        },
      }
      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
          },
        }
      end

      local icons = {
        dap = {
          Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
          Breakpoint = " ",
          BreakpointCondition = " ",
          BreakpointRejected = { " ", "DiagnosticError" },
          LogPoint = ".>",
        },
      }

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] })
      end
    end,

      -- stylua: ignore
     keys = {
       { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
       { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
       { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
       { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
       { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
       { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
       { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
       { "<leader>dj", function() require("dap").down() end, desc = "Down" },
       { "<leader>dk", function() require("dap").up() end, desc = "Up" },
       { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
       { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
       { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
       { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
       { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
       { "<leader>ds", function() require("dap").session() end, desc = "Session" },
       { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
       { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
     },
  },

  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
}
