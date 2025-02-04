if vim.filetype then
  vim.filetype.add({
    pattern = {
      [".*/defaults/.*%.ya?ml"] = "yaml.ansible",
      [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
      [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
      [".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
      [".*/playbook.*%.ya?ml"] = "yaml.ansible",
      [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
      [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
      [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
      [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
      [".*/molecule/.*%.ya?ml"] = "yaml.ansible",
    },
  })
else
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
      "*/defaults/*.yml",
      "*/defaults/*.yaml",
      "*/host_vars/*.yml",
      "*/host_vars/*.yaml",
      "*/group_vars/*.yml",
      "*/group_vars/*.yaml",
      "*/group_vars/*/*.yml",
      "*/group_vars/*/*.yaml",
      "*/playbook*.yml",
      "*/playbook*.yaml",
      "*/playbooks/*.yml",
      "*/playbooks/*.yaml",
      "*/roles/*/tasks/*.yml",
      "*/roles/*/tasks/*.yaml",
      "*/roles/*/handlers/*.yml",
      "*/roles/*/handlers/*.yaml",
      "*/tasks/*.yml",
      "*/tasks/*.yaml",
      "*/molecule/*.yml",
      "*/molecule/*.yaml",
    },
    callback = function()
      vim.bo.filetype = "yaml.ansible"
    end,
  })
end
