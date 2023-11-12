return {
  'mg979/vim-visual-multi',
  branch = 'master',
  event = 'InsertEnter',
  init = function()
    -- theme : codedark, iceblue, purplegray, spacegray, ocean, nord, neon, papper
    vim.g.VM_theme = 'iceblue'
  end,
}
