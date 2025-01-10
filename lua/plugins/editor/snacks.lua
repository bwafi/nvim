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
      example = "advanced",
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
