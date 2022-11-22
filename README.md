# nvim-ansible

## Installation

```bash
git clone \
    https://github.com/mfussenegger/nvim-ansible.git \
    ~/.config/nvim/pack/plugins/start/nvim-ansible
```

## Usage

Small plugin to make working with Ansible playbooks or roles more convenient:

- Adds `ftdetect` pattern to recognize playbooks/roles and set `filetype` to `yaml.ansible`.
- Sets `keywordprg` to `ansible-doc` if available
- Sets `path` to be able to jump to files using `gf` which are `files/` next to a `tasks/` role file.
- Provides a `run()` function to execute playbooks or roles using `ansible-playbook` or `ansible localhost -m import_role`. See `:help ansible`


You may want to setup keymaps for the `run()` function, for example in `ftplugin/ansible.lua` add:

```lua
vim.keymap.set('v', '<leader>te', function() require('ansible').run() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>te', ":w<CR> :lua require('ansible').run()<CR>", { buffer = true, silent = true })
```


Best used together with [ansible-language-server](https://github.com/ansible/ansible-language-server)
