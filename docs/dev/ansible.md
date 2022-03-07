# Basic concepts

Ansible is an open-source [IaC](https://en.wikipedia.org/wiki/Infrastructure_as_code) tool, provides configuration management and application deployment. It runs on many Unix-like systems, and can configure both Unix-like systems as well as Microsoft Windows. Ansible is **agentless**, temporarily connecting remotely via SSH (*distributed mode*) or Windows Remote Management (allowing remote PowerShell execution) to do its tasks on the [managed nodes](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html).

Despite the default behaviour (connecting remotely), ansible supports an connection type known as **[local](https://docs.ansible.com/ansible/latest/inventory/implicit_localhost.html)** connection (*centralized mode*). In such case Ansible will execute any tasks on the [control node](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html). Ansibe (control or managed) nodes are organized in an file known as the [inventory]() file. Sometimes called a *hostfile*. Your inventory can specify information like IP address, credentials and variables for each node.

!!! note
    Vagrant [ansible_local](../vagrant/provisioners.md) provisioner type uses the *local* connection and not the *remote* (SSH) to execute any guest machine tasks. In such case the guest machine is acting as a *control node*.

Ansible task is a unit of action, an group of tasks is organized in an file known as the playbook file. Playbooks are written in YAML and are easy to read, write, share and understand. To learn more about playbooks, see [Intro to playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#about-playbooks).

# Installation process

Ansible requires the following software to be installed on the hosts:

- Python interpreter (control & managed nodes)
    - supported out-of-the-box by most of the Unix-like systems.
- OpenSSH server (only on managed nodes).

Depending on the ``:install_mode:`` (defaults: **pip_args_only**) vagrant will try to automatically install the ansible on the control node.

In our case (**pip_args_only** is the default mode) vagrant will perform the following actions:

- Update the system through the system package manager.
```bash
apt-get update -y -qq
```
- Install the python interpreter (*defaults to python2.7*).
```bash
apt-get install -y -qq build-essential curl git libssl-dev libffi-dev python-dev
```
- Install the pip via *:pip_install_cmd* option value:
```bash
curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py |sudo python
```
- Install the specified ansible version as defined in *:pip_args* or *:version* option value:
```bash
pip install --upgrade ansible(==2.10.5)
```

!!! info "Default python version"
    Ansible local provisioner pre-installs the python2.7 interpreter (even if python2 is **EOL**) as default system python,
    this step cannot be overriden when the selected ``:install_mode`` is **pip** or **pip_args_only**. If the ``:install_mode``
    option value is set to **default** then ansible will be installed via system package manager but the ansible installed version
    is tied coupled on the distribution repositories.

!!! note "Proxy settings"
    If you are behind an proxy you need to setup the (system-wide at least) proxy environment variables on the guest machine,
    by default proxy is always enabled in the ``vagrant.yaml`` configuration file.

# Directory layout

Local ansible provisioner **can be easily extended** with new tasks, an sigle *point of entrace* (the ``playbook.yml``) is being used
to import all the required automated tasks for the guest machine provisioning.

All the required ansible files and directories resides under: ``provisioners/ansible`` subfolder.

```console
.
├── ansible.cfg -> main ansible configuration file
├── files
│   └── vimrc -> regular files
├── handlers.yaml -> ansible handlers
├── inventory.ini -> inventory file
├── playbook.yaml -> the ansible playbook, aggregates all task files into an single file
├── tasks
│   └── vim.yaml -> task files
├── templates
│   └── timezone.j2 -> ansible Jinja2 template files
└── vars
    └── vim.yaml -> ansible variable files
```

Ansible operations are [idempotent](https://en.wikipedia.org/wiki/Idempotence), performing the necessary changes only if it is required.<br>
You can manually repeat all tasks or an subset of tasks (using [tags](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html)) without affecting the guest machine:

```bash
ansible-playbook -i inventory playbook.yml # execute all provisioning tasks
ansible-playbook -i inventory playbook --tags vim # repeat only the vim related tasks
```

!!! info "Provisioning path"
    The Ansible Local provisioner requires that all the Ansible playbook files are available on the guest machine,
    at the location referred by the ``:provisioning_path:`` option. Those files are present on the host machine (as part of your Vagrant project) but
    in the case of local ansible provisioner those files **must be shared** on the guest machine also. This can be achieved by the [synced folders](../vagrant/shared.md) functionality of vagrant. Vagrant will then change directory to the value provided by ``:provisioning_path:`` option and then will execute the playbook.

!!! note "[Ansible Galaxy/Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)"
    Currently are not supported, will be supported in the upcoming releases.

# Linting your playbook tasks

[ansible-lint](https://github.com/ansible-community/ansible-lint) is the tool of choice for [linting](https://en.wikipedia.org/wiki/Lint_(software)) the ansible playbooks, giving you an high level of confidence that after an update of an existing task or adding an new task in your playbook everything will work as expected without having to run them manually.

In brief, ansible-lint offers:

- Syntax checking
- Compliance with ansible best practices
- Custom rules in case the predefined are not enough.

Ansible-lint will automatically installed through [Tox](./tox.md) automation tool and the [pre-commit](./hooks.md) *ansible-lint hook* will be triggered to lint any ansible ``*.yml``.

In your development environment you can trigger the linting process (including ansible-lint):
```bash
tox -e lint
```

Under the hood the ansible-linter is being triggered through the *local* pre-commit hook:

```yaml
    - repo: local
      hooks:
          - id: ansible-lint
            name: Ansible Linter
            entry: ansible-lint
            description: Linter for Ansible roles and playbooks
            language: python
            args: ['--force-color']
            pass_filenames: false
```

As you many other linting tools, ansible-lint supports local configuration via a [.ansible-lint](https://ansible-lint.readthedocs.io/en/latest/configuring.html#configuration-file) configuration file. Ansible-lint checks the working directory for the presence of this file and applies any configuration found there.

```yaml
# Exclude folders from linting
exclude_paths:
    - '.tox/'
    - '.git/'
    - 'logs/'

# This makes linter to fully ignore rules/tags listed below
skip_list:
    - '403'
    - '305'
```

Despite the ansible-lint, ansible-playbook command has an built-in syntax checker and dry run mode but it may not catch everything:

- ``--syntax-check`` - Syntax checking
    - Performs an syntax check on the playbook, but do not execute it.
- ``--check`` - dryrun mode
    - Playbook tasks are executed without making any modification on the target hosts

# References

- [ansible-lint](https://github.com/ansible-community/ansible-lint)
- [ansible](https://docs.ansible.com/)
