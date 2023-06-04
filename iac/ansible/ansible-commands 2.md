## Ansible Inventory

- ansible-inventory --list
- ansible-inventory --graph
- ansible-inventory --host <hostname>
- ansible-inventory --playbook-dir <playbook-directory>
- ansible-inventory --yaml --host <hostname>

## Ad-Hoc Commands

- ansible <inventory> -m ping
- ansible <inventory> -m <module>
- ansible <inventory> -m <module> -a "<module_arguments>"
- ansible <inventory> -b -m <module> -a "<module_arguments>"

## Playbooks

- ansible-playbook <playbook.yml>
- ansible-playbook <playbook.yml> -i <inventory>
- ansible-playbook <playbook.yml> --tags <tag_name>
- ansible-playbook <playbook.yml> --skip-tags <tag_name>
- ansible-playbook <playbook.yml> --list-hosts
- ansible-playbook <playbook.yml> --limit <group_or_host>
- ansible-playbook <playbook.yml> --start-at-task='<task_name>'
- ansible-playbook <playbook.yml> --check

## Roles

- ansible-galaxy init <role_name>
- ansible-galaxy install <author_name>.<role_name>
- ansible-galaxy install <author_name>.<role_name> --version=<version_number>
- ansible-galaxy remove <author_name>.<role_name>

## Modules

- copy
- file
- fetch
- get_url
- template
- lineinfile
- replace
- command
- shell
- script
- yum
- apt
- service
- systemd
- user
- group
- authorized_key
- file
- mount
- wait_for
- assert
- blockinfile
- acl
- command
- debug
- fail
- pause
- set_fact
- set_stats
- stat
- fail
- debug
- async_status
- async_poll
- archive
- assert
- assertthat
- async_status
- async_poll
- blockinfile
- copy
- command
- community.docker.docker_compose
- community.general.firewalld
- community.kubernetes.k8s
- community.kubernetes.k8s_info
- cron
- debug
- docker_container
- docker_image
- docker_login
- docker_service
- docker_swarm
- file
- get_url
- git
- influxdb_write
- iptables
- lineinfile
- mount
- package
- pip
- rabbitmq_plugin
- rabbitmq_queue
- replace
- s3
- script
- seboolean
- selinux
- set_fact
- slack
- slurp
- stat
- systemd
- sysctl
- template
- uri
- user
- wait_for
- zfs
- zfs_dataset
- zfs_facts
- zfs_snapshot
- zfs_volume

