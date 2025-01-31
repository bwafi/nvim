local LazyUtil = require("lazy.core.util")

---@class lazyvim.util: LazyUtilCore
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

return M
