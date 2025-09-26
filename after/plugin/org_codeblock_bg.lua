-- Shade entire org src block background using extmarks (full line width).

-- Highlight group (background only so inner code colors are preserved).
local function set_hl()
  vim.api.nvim_set_hl(0, "OrgCodeBlock", { bg = "#242221" })
end

set_hl()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("OrgCodeBlockHL", { clear = true }),
  callback = set_hl,
})

-- Config
local SHADE_CONTENT_ONLY = false -- true: only shade the block contents (exclude begin/end)
local SUPPORTED_FTS = { org = true } -- restrict to org buffers only

-- Helpers
local ns = vim.api.nvim_create_namespace "org_codeblock_bg"

local function is_supported_buf(buf)
  local ft = vim.bo[buf].filetype
  return SUPPORTED_FTS[ft] == true
end

local query_cache = {}

local function get_query_for_org()
  if query_cache.org then
    return query_cache.org
  end
  local qstr = [[
    (block
      name: (expr) @_name
      (#match? @_name "^(src|SRC)$")
    ) @whole
  ]]
  local ok, q = pcall(vim.treesitter.query.parse, "org", qstr)
  if ok then
    query_cache.org = q
  end
  return query_cache.org
end

local function first_field(node, names)
  for _, n in ipairs(names) do
    local f = node:field(n)
    if f and f[1] then
      return f[1]
    end
  end
  return nil
end

local function collect_ranges(buf)
  if not is_supported_buf(buf) then
    return {}
  end

  local ok, parser = pcall(vim.treesitter.get_parser, buf, "org")
  if not ok or not parser then
    return {}
  end

  local q = get_query_for_org()
  if not q then
    return {}
  end

  local trees = parser:parse()
  if not trees or not trees[1] then
    return {}
  end
  local root = trees[1]:root()

  local ranges = {}
  for id, node in q:iter_captures(root, buf, 0, -1) do
    if q.captures[id] == "whole" then
      local target = node
      if SHADE_CONTENT_ONLY then
        target = first_field(node, { "contents" }) or node
      end
      local sr, _, er, _ = target:range() -- er is exclusive
      table.insert(ranges, { sr, er })
    end
  end
  return ranges
end

local function apply(buf)
  if not vim.api.nvim_buf_is_loaded(buf) then
    return
  end
  if not is_supported_buf(buf) then
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    return
  end
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  local ranges = collect_ranges(buf)
  for _, r in ipairs(ranges) do
    local sr, er_excl = r[1], r[2]
    local last = math.max(sr, er_excl - 1)
    for line = sr, last do
      vim.api.nvim_buf_set_extmark(buf, ns, line, 0, { line_hl_group = "OrgCodeBlock" })
    end
  end
end

-- Throttle updates slightly
local pending = {}
local function schedule_apply(buf)
  if pending[buf] then
    return
  end
  pending[buf] = true
  vim.defer_fn(function()
    pending[buf] = nil
    apply(buf)
  end, 40)
end

-- Autocmds
local aug = vim.api.nvim_create_augroup("OrgCodeBlockBG", { clear = true })

local function maybe_apply(args)
  local buf = args and args.buf or vim.api.nvim_get_current_buf()
  if not is_supported_buf(buf) then
    return
  end
  schedule_apply(buf)
end

vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "org" },
  callback = maybe_apply,
})

vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWinEnter", "BufReadPost", "TextChanged", "TextChangedI", "InsertLeave", "BufWritePost" },
  {
    group = aug,
    callback = maybe_apply,
  }
)

vim.api.nvim_create_autocmd("User", {
  group = aug,
  pattern = "TSUpdatePost",
  callback = maybe_apply,
})

-- Manual refresh command
vim.api.nvim_create_user_command("OrgCodeblockBgRefresh", function()
  apply(vim.api.nvim_get_current_buf())
end, {})
