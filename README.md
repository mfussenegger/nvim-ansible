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

Best used together with [ansible-language-server](https://github.com/ansible/ansible-language-server)
