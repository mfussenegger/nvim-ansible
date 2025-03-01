local api = vim.api
if vim.fn.executable('ansible-doc') then
  vim.bo.keywordprg = ':sp term://ansible-doc'
end
local fname = api.nvim_buf_get_name(0)
if fname:find('tasks/') then
  local paths = {
    vim.bo.path,
    vim.fs.dirname(fname:gsub("tasks/", "files/")),
    vim.fs.dirname(fname:gsub("tasks/", "templates/")),
    vim.fs.dirname(fname)
  }
  vim.bo.path = table.concat(paths, ",")
end
