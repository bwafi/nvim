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

---@param component any
---@param text string
---@param hl_group? string
---@return string
function M.format(component, text, hl_group)
  if not hl_group then
    return text
  end
  ---@type table<string, string>
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    lualine_hl_group = component:create_hl({ fg = utils.extract_highlight_colors(hl_group, "fg") }, "LV_" .. hl_group)
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. " " .. component:get_default_hl()
end

---@param opts? {relative: "cwd"|"root", modified_hl: string?, max_width: number}
function M.pretty_path(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "Constant",
    max_width = 120,
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end

    local cwd = M.cwd()

    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")
    local filename = parts[#parts]

    if #parts > 3 then
      parts = { parts[1], "…", parts[#parts - 1], filename }
    end

    if opts.modified_hl and vim.bo.modified then
      filename = M.format(self, filename, opts.modified_hl)
    end

    local formatted_path = table.concat(parts, sep)

    if vim.fn.winwidth(0) > opts.max_width then
      return formatted_path
    else
      return filename
    end
  end
end

-- TODO: lsp progress dont work for nvim 0.10.xx
function M.lsp_progress()
  local lsp = vim.lsp.util.get_progress_messages()[1]

  if lsp then
    local name = lsp.name or ""
    local percentage = lsp.percentage or 0

    -- List of spinner symbols
    local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }

    -- Calculate spinner frame based on time
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners
    local spinner = spinners[frame + 1]

    return string.format(" %%<%s %s %s ﴾%s%%%%﴿ ", spinner, name, percentage)
  end

  return ""
end

return M
