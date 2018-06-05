sbog/desktop_common
===================

Role to install common desktop stuff like dotfiles and X apps.

#### Requirements

Ansible 2.4

#### Role Variables

```yaml
# Username to become
username: user

git_username: user
git_email: user@user.org
# Dict with ssh configs
ssh_config_hosts: {}

backups_encryption_key: ""
```

#### Dependencies

None

#### Example Playbook

```yaml
- name: Install common desktop stuff
  hosts: localhost
  remote_user: root
  roles:
    - desktop_common
```

#### License

Apache 2.0

#### Author Information

Stanislaw Bogatkin (https://sbog.ru)
