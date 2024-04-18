if vim.filetype then
  vim.filetype.add({
    pattern = {
      [".*/playbooks/.*%.yml"] = "yaml.ansible",
      [".*/playbooks/.*%.yaml"] = "yaml.ansible",
      [".*/roles/.*/tasks/.*%.yml"] = "yaml.ansible",
      [".*/roles/.*/tasks/.*%.yaml"] = "yaml.ansible",
      [".*/roles/.*/handlers/.*%.yml"] = "yaml.ansible",
      [".*/roles/.*/handlers/.*%.yaml"] = "yaml.ansible",
    }
  })
else
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {
      "*/playbooks/*.yml",
      "*/playbooks/*.yaml",
      "*/roles/*/tasks/*.yml",
      "*/roles/*/tasks/*.yaml",
      "*/roles/*/handlers/*.yml",
      "*/roles/*/handlers/*.yaml"
    },
    callback = function()
      vim.bo.filetype = "yaml.ansible"
    end,
  })
end
