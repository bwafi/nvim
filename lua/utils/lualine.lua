local M = {}

function M.cwd()
  return M.realpath(vim.loop.cwd()) or ""
end

function M.realpath(path)
  if path == "" or path == nil then
    return nil
  end
  return vim.loop.fs_realpath(path) or path
end

function M.get_root()
  local root_patterns = { ".git", "init.lua", "Makefile", "README.md" }
  local path = vim.fn.expand("%:p:h")

  for _, pattern in ipairs(root_patterns) do
    local found = vim.fn.finddir(pattern, path .. ";")
    if found and found ~= "" then
      return vim.fn.fnamemodify(found, ":p:h")
    end
  end

  return M.cwd()
end

---@param component any
---@param text string
---@param hl_group? string
---@return string
function M.format(component, text, hl_group)
  text = text:gsub("%%", "%%%%")
  if not hl_group or hl_group == "" then
    return text
  end
  ---@type table<string, string>
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    ---@type string[]
    local gui = vim.tbl_filter(function(x)
      return x
    end, {
      utils.extract_highlight_colors(hl_group, "bold") and "bold",
      utils.extract_highlight_colors(hl_group, "italic") and "italic",
    })

    lualine_hl_group = component:create_hl({
      fg = utils.extract_highlight_colors(hl_group, "fg"),
      gui = #gui > 0 and table.concat(gui, ",") or nil,
    }, "LV_" .. hl_group) --[[@as string]]
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

---@param opts? {relative: "cwd"|"root", modified_hl: string?, directory_hl: string?, filename_hl: string?, modified_sign: string?, readonly_icon: string?, length: number?}
function M.pretty_path(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "MatchParen",
    directory_hl = "",
    filename_hl = "Bold",
    modified_sign = " ",
    readonly_icon = " 󰌾 ",
    length = 3,
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end

    local cwd = M.cwd()
    local root = M.get_root()

    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    else
      path = path:sub(#root + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")

    if opts.length == 0 then
      parts = parts
    elseif #parts > opts.length then
      parts = { parts[1], "…", table.concat({ unpack(parts, #parts - opts.length + 2, #parts) }, sep) }
    end

    if opts.modified_hl and vim.bo.modified then
      parts[#parts] = parts[#parts] .. opts.modified_sign
      parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
    else
      parts[#parts] = M.format(self, parts[#parts], opts.filename_hl)
    end

    local dir = ""
    if #parts > 1 then
      dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
      dir = M.format(self, dir .. sep, opts.directory_hl)
    end

    local readonly = ""
    if vim.bo.readonly then
      readonly = M.format(self, opts.readonly_icon, opts.modified_hl)
    end
    return dir .. parts[#parts] .. readonly
  end
end

-- TODO: lsp progress dont work for nvim 0.10.xx
-- function M.lsp_progress()
--   local lsp = vim.lsp.util.get_progress_messages()[1]
--
--   if lsp then
--     local name = lsp.name or ""
--     local percentage = lsp.percentage or 0
--
--     -- List of spinner symbols
--     local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
--
--     -- Calculate spinner frame based on time
--     local ms = vim.loop.hrtime() / 1000000
--     local frame = math.floor(ms / 120) % #spinners
--     local spinner = spinners[frame + 1]
--
--     return string.format(" %%<%s %s %s ﴾%s%%%%﴿ ", spinner, name, percentage)
--   end
--
--   return ""
-- end

return M
