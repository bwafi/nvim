return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  version = "*",
  opts = {
    open_mapping = [[<c-_>]],
    shade_terminals = false,
    persist_size = false,
    direction = "horizontal",
    float_opts = {
      border = "rounded",
      width = math.floor(vim.fn.winwidth(0) * 0.8),
      height = math.floor(vim.fn.winheight(0) * 0.8),
      winblend = 3,
      -- zindex = 10,
    },
    winbar = {
      enabled = true,
      name_formatter = function(term)
        local term_number = string.match(term.name, "#(%d+)")
        return term_number and " Terminal: " .. term_number or term.name
      end,
    },
  },
}
