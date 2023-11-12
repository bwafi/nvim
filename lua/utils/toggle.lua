local M = {}

-- Function to toggle word wrap for the current window
function M.ToggleWordWrap()
  local current_wrap = vim.wo.wrap
  vim.wo.wrap = not current_wrap
  print('Word wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
end

-- Key mapping to toggle word wrap
vim.api.nvim_set_keymap('n', '<leader>ww', '<cmd>lua ToggleWordWrap()<cr>', { noremap = true, silent = true })

-- Fungsi untuk menoggle opsi number di tingkat buffer
function M.ToggleLineNumbers()
  local current_number = vim.bo.number
  vim.bo.number = not current_number
  print('Line numbers ' .. (vim.bo.number and 'enabled' or 'disabled'))
end

return M
