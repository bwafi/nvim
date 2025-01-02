local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      example = "advanced",
    },

    --     dashboard = {
    --       preset = {
    --         header = [[
    -- ██████╗  █████╗ ██╗    ██╗ █████╗ ███████╗██╗          Z
    -- ██╔══██╗██╔══██╗██║    ██║██╔══██╗██╔════╝██║      Z
    -- ██████╔╝███████║██║ █╗ ██║███████║█████╗  ██║   z
    -- ██╔══██╗██╔══██║██║███╗██║██╔══██║██╔══╝  ██║ z
    -- ██████╔╝██║  ██║╚███╔███╔╝██║  ██║██║     ██║
    -- ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚═╝
    --       ]],
    --         -- stylua: ignore
    --         ---@type snacks.dashboard.Item[]
    --         keys = {
    --           { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
    --           { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
    --           { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
    --           { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
    --           { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
    --           { icon = " ", key = "s", desc = "Restore Session", section = "session" },
    --           { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
    --           { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
    --           { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    --         },
    --       },
    --     },

    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
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
