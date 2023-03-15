---@mod ansible

local api = vim.api
local M = {}


local function has_become(lines)
  for _, line in pairs(lines) do
    if line:find('become: true') then
      return true
    end
  end
  return false
end


local function launch_term(cmd)
  vim.cmd('belowright new')
  vim.fn.termopen(cmd, vim.empty_dict())
end


---@param mode "v"|"V"
local function get_selected_lines(mode)
  -- [bufnr, lnum, col, off]; 1-indexed
  local start = vim.fn.getpos('v')
  local end_ = vim.fn.getpos('.')
  local start_row = start[2]
  local start_col = start[3]
  local end_row = end_[2]
  local end_col = end_[3]
  if start_row == end_row and end_col < start_col then
    end_col, start_col = start_col, end_col
  elseif end_row < start_row then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end
  if mode == "V" then
    start_col = 1
    local lines = api.nvim_buf_get_lines(0, end_row - 1, end_row, true)
    end_col = #(lines[1])
  end
  return api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
end


--- Run the current file using `ansible-playbook` or `ansible localhost -m import_role`
--- Which one is used depends on if the current file is in a /roles/ or in a /playbooks folder
---
--- Can also be used to run only a selected portion (in visual mode) of a role.
--- It will create a `tmptask` folder in the roles directly for that.
function M.run()
  local bufnr = api.nvim_get_current_buf()
  local fname = api.nvim_buf_get_name(bufnr)
  local path = vim.fn.fnamemodify(fname, ':p')
  local role_pattern = '/roles/([%w-]+)/'
  local role_match = path:match(role_pattern)
  if role_match then
    local mode = api.nvim_get_mode().mode
    local become
    if mode == 'v' or mode == 'V' then
      local lines = get_selected_lines(mode)
      local tmptask = path:gsub(role_pattern, '/roles/tmptask/')
      become = has_become(lines)
      tmptask = vim.fn.fnamemodify(tmptask, ':h') .. '/main.yml'
      vim.fn.mkdir(vim.fn.fnamemodify(tmptask, ':h'), 'p')
      local f = io.open(tmptask, "w")
      assert(f, "Must be able to open tmpfile in write mode")
      f:write(table.concat(lines, '\n'))
      f:flush()
      f:close()
      role_match = 'tmptask'
    else
      local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
      become = has_become(lines)
    end
    local _, end_ = path:find('/playbooks/')
    local playbook_dir = nil
    if end_ then
      playbook_dir = path:sub(1, end_)
    end
    local cmd = {
      'ansible',
      'localhost',
      '--playbook-dir', playbook_dir,
      '-m', 'import_role',
      '-a', 'name=' .. role_match
    }
    if become then
      table.insert(cmd, '-K')
    end
    launch_term(cmd)
  elseif path:match('/playbooks/') then
    local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
    local cmd = {'ansible-playbook', path}
    if has_become(lines) then
      table.insert(cmd, '-K')
    end
    launch_term(cmd)
  end
end

return M
