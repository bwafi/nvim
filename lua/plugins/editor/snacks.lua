return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      preset = {
        header = [[
  ██████╗  █████╗ ██╗    ██╗ █████╗ ███████╗██╗          Z
  ██╔══██╗██╔══██╗██║    ██║██╔══██╗██╔════╝██║      Z    
  ██████╔╝███████║██║ █╗ ██║███████║█████╗  ██║   z       
  ██╔══██╗██╔══██║██║███╗██║██╔══██║██╔══╝  ██║ z         
  ██████╔╝██║  ██║╚███╔███╔╝██║  ██║██║     ██║           
  ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚═╝           
           ]],
      },
      sections = {
        { section = "header" },
        {
          pane = 2,
          ttl = 2 * 60,
          icon = " ",
          title = "Todo",
          enabled = true,
          action = function()
            Snacks.terminal.open("nb; fish", {
              win = {
                position = "float",
                width = 0.6,
                height = 0.6,
              },
            })
          end,
          indent = 3,
          section = "terminal",
          cmd = "nb",
          key = "t",
          height = 5,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },

    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = {
      win = {
        position = "bottom",
      },
    },
    styles = {
      input = {
        relative = "cursor",
        -- row = -3,
        col = 0,
      },
    },
  },

-- stylua: ignore
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
  },
}
