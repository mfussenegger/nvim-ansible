local api = vim.api
if vim.fn.executable('ansible-doc') then
  vim.bo.keywordprg = ':sp term://ansible-doc'
end
local fname = api.nvim_buf_get_name(0)
if fname:find('tasks/') then
  vim.bo.path = vim.bo.path .. ',' .. vim.fs.dirname(fname:gsub("tasks/", "files/"))
end
