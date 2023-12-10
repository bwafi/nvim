return {
  "stevearc/overseer.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>co", "<cmd>OverseerToggle<CR>", mode = "n" },
    { "<leader>cr", "<cmd>OverseerRun<CR>", mode = "n" },
    { "<leader>cc", "<cmd>OverseerRunCmd<CR>", mode = "n" },
    { "<leader>cl", "<cmd>OverseerLoadBundle<CR>", mode = "n" },
    { "<leader>cb", "<cmd>OverseerToggle! bottom<CR>", mode = "n" },
    { "<leader>cd", "<cmd>OverseerQuickAction<CR>", mode = "n" },
    { "<leader>cs", "<cmd>OverseerTaskAction<CR>", mode = "n" },
  },
  config = function()
    local overseer = require("overseer")

    overseer.setup({
      templates = { "builtin" },
      strategy = "jobstart",
      dap = false,
      component_aliases = {
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          "on_complete_dispose",
          { "on_output_quickfix", open = true },
        },

        -- Tasks from tasks.json use these components
        default_vscode = {
          "default",
          "on_result_diagnostics",
          "on_result_diagnostics_quickfix",
        },
      },
    })

    overseer.register_template({
      name = "go run",
      builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "go", "run" },
          args = { file },
          components = {
            "default",
          },
        }
      end,
      condition = {
        filetype = { "go" },
      },
    })

    overseer.register_template({
      name = "js/ts run",
      builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "node" },
          args = { file },
          components = {
            "default",
          },
        }
      end,
      condition = {
        filetype = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      },
    })
  end,
}
