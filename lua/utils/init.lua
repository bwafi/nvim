local LazyUtil = require("lazy.core.util")

---@class lazyvim.util: LazyUtilCore
---@field lsp utils.lsp
---@field mini utils.mini
---@field lualine utils.lualine
---@field root utils.root
---@field ui utils.ui
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    if k == "lazygit" or k == "toggle" then -- HACK: special case for lazygit
      return M.deprecated[k]()
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("utils." .. k)
    M.deprecated.decorate(k, t[k])
    return t[k]
  end,
})

function M.deprecate(old, new)
  M.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), {
    title = "LazyVim",
    once = true,
    stacktrace = true,
    stacklevel = 6,
  })
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

return M
