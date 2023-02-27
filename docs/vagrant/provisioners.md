# Overview

Provisioners in Vagrant allow you to automatically install software, alter configurations, and more on the guest machine
as part of the vagrant up process.

# Available provisioners

Vagrant supports powerful automation tools like:

- Chef
- Puppet
- Ansible
- Local Ansible
- Salt
- Docker
- Cloud Init

For simple tasks, you might as well use the:

- File
- Shell

The provisioners can also be **used together** - its quite common to have the shell provisioner along with an automation tool, for instance for setting some environment variables or performing simple tasks before a more complex provision starts.

# Running the provisioner

By default the provisioner only **runs once** - right when you create your environment (first *vagrant up* since the last *destroy*). This saves a lot of time in daily basis, when you normally will be reusing your a virtual machine previously provisioned. But you can also force the execution of the provisioner, even when the machine is already turned on:

```console
vagrant provision --provision-with <name>
```

In brief, you can interact with the provisioners under the following **virtual machine states**:

- If the environment is not yet created, you just need to run ``vagrant up``.
- If the environment was already provisioned before, and the machine is turned down, you need to use ``vagrant up --provision`` in order to force the provisioner execution.
- If the machine is already already turned on, you will use either ``vagrant provision`` or ``vagrant provision --provision-with x,y,z`` which enable only certain provisioners.

# Supported provisioners

## Shell provisioner

This is the most simple virtual machine provisioner. Customization of the shell provisioners can be made through the ``vagrant.yaml`` configuration file. Under the hood, shell provisioners are the execution of an series of *shell/bash* scripts.

Multiple shell type provisioners can be added under the ``:shell:`` yaml key.

```yaml
:provisioners:
        :shell:
            - :name: 'timesyncd'
              :options:
                  :type: 'shell'
                  :path: [*provisioners, *shell, 'timesyncd.sh']
                  :binary: true
                  :args: ['Europe/Athens']
                  :privileged: true
                  :run: null
            - :name: 'locale'
              :options:
                  :type: *shell
                  :path: [*provisioners, *shell, 'locale.sh']
                  :binary: *true
                  :args: ["en_US"]
                  :run: *run_once
```

Supported options are:

- ``:name:`` The name of the shell provisioner.
    - If for example we want to re-execute the provisioner:<br>
        ``vagrant provision --provision-with <name>``.
- ``:options:`` The provisioner parameters.
    - ``:path:`` Relative path to the provisioner shell/bash script.
    - ``:type:`` Type of the provisioner, in this case it must be: **shell**.
    - ``:binary:`` Automatically replaces Windows line endings with Unix line endings.
    - ``:args:``  Arguments to pass to the shell script when executing it as a single string.
    - ``:privileged:`` Enable or disable **elevated privileges** when executed the script.
    - ``:run:`` **null** (run once), **always** (run always) or **never** (run manually).

!!! info
    More details on shell provisioner parameters can be found [here](https://www.vagrantup.com/docs/provisioning/shell)

## File provisioner

The File provisioner allows you to upload a file or directory from the host machine to the guest machine. The file uploads by the file provisioner are done as the *SSH or PowerShell* user. This is important since these users generally do not have **elevated privileges** on their own. Customization of the file provisioners can be made through the ``vagrant.yaml`` configuration file.

Multiple file type provisioners can be added under the ``:file:`` yaml key.

```yaml
:provisioners:
    :file:
        - :name: 'vimrc'
          :options:
              :type: &file 'file'
              :source: ['templates', vimrc.tmpl']
              :destination: '.vimrc'
              :run: &always 'always'
        - :name: 'gitconfig'
          :options:
              :type: *file
              :source: ['templates', 'gitconfig.tmpl']
              :destination: '.gitconfig'
              :run: *always
```

Supported options are:

- ``:name:`` The name of the file provisioner.
    - If for example we want to re-execute the provisioner:<br>
        ``vagrant provision --provision-with <name>``.
- ``:options:`` The provisioner parameters.
    - ``:type:`` The type of the provisioner, in this case it must be: **file**.
    - ``:source:`` Absolute or relative path of the file or directory to be uploaded.
    - ``:destination:`` Absolute path on the guest machine where the source will be uploaded.
    - ``:run:`` **null** (run once), **always** (run always) or **never** (run manually).

!!! info
    More details on file provisioner parameters can be found [here](https://www.vagrantup.com/docs/provisioning/file)

## Local Ansible provisioner

This is the **default vagrant provisioner**, provisioning of the guest machine is performed through the [ansible](https://www.ansible.com/) configuration management tool.

Vagrant supports two modes of ansible provisioners:

- [ansible](https://www.vagrantup.com/docs/provisioning/ansible_intro) - where Ansible tool is executed on the *host machine*.
- [ansible_local](https://www.vagrantup.com/docs/provisioning/ansible_intro) - where Ansible tool is executed on the *guest machine*.

Due to the fact that ansible installation is not supported on [Windows operating systems](https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html), ``ansible_local`` is selected as the defacto guest machine provisioner.

Provisioner is customisable through ``:ansible:`` section in ``vagrant.yaml``, the default settings are sufficient and should cover most of the [supported boxes](./system.md).

```yaml
:provisioners:
    :ansible:
        :name: *hostname
        :options:
            :type: 'ansible_local'
            :install: true
            :install_mode: 'pip_args_only'
            :pip_install_cmd: 'curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py |sudo python'
            :version: 'ansible==4.3.0'
            :verbose: false
            :compatibility_mode: '2.0'
            :limit: 'all'
            :playbook: [*shared, *ansible_provisioner, 'playbook.yml']
            :inventory_path: [*shared, *ansible_provisioner, 'inventory.yml']
            :provisioning_path: [*shared, *ansible_provisioner]
            :extra_vars: 'extra_vars.yml'
            :tags:
                - 'bash_aliases'
                - 'bash_profile'
```

Supported options are:

- ``name``: The name of the ansible provisioner, defaults to: *VM hostname*.
    - If for example we want to re-execute the provisioner:<br>
        ``vagrant provision --provision-with <name>``.
- ``options``:
    - ``:type:`` The type of the provisioner, in this case it must be: **ansible_local**.
    - ``:install:`` Try to automatically install Ansible on the guest system.
        - If sets to ``false`` then ansible will not be installed on the guest system.
    - ``:install_mode:`` Select the way to automatically install Ansible on the guest system.
        - **pip_args_only** mode is the **default** selected.
              - Gives you more flexibility on the *pip* command line options.
              - Provisioner will install ansible using the **:pip_args** option value:
                ```bash
                pip install -r requirements.txt
                or
                pip install ansible==4.3.0
                ```
        - **pip** mode
              - Provisioner will install ansible using the **:version** option value:
                ```bash
                pip install --upgrade ansible==4.3.0
                ```
        - **default** mode, installation of ansible through the system package manager.
              ```bash
              apt-get install ansible
              ```
    - ``:pip_install_cmd:`` Indicates the installation process of the python *pip* command tool.
        - Only applicable for **pip_args_only** and **pip** modes.
    - ``:pip_args:`` Overrides the default *pip* command line arguments.
        - By default this is the place to indicate the desired ansible version to be installed.
        - Only applicable for *pip_args_only* mode.
    - ``:version:`` Install a specific Ansible release.
        - Applicable only for **pip** install mode.
        - This option **does not work** as expected, [check issues](./issues.md)
    - ``:verbose:`` Set Ansible's verbosity to obtain detailed logging.
    - ``:compatibility:`` Set the minimal version of Ansible to be supported.
    - ``:limit:`` Used to make Ansible connect to all machines from the inventory file.
    - ``:playbook:`` The playbook file (include roles) on the guest machine.
    - ``:inventory_path:`` Absolute path to inventory file on the guest machine.
    - ``:provisioning_path:`` Absolute path on the guest machine where the Ansible files are stored.
    - ``:extra_vars:`` Pass additional variables (with highest priority) to the playbook.
        - Same as ``ansible-playbook --extra-vars`` command line option.
        - This parameter can be a path to *a JSON or YAML file*, or a hash.
    - ``:tags:`` Only plays, roles and tasks tagged with this value will be executed:
        - This parameter can be *string or list* of tags.
        - The following tasks are automatically triggered during the guest machine build process:

            - [bash_aliases](https://www.cyberciti.biz/faq/create-permanent-bash-alias-linux-unix/) - Tasks to setup user workspace ```.bash_aliases```.
            - [bash_profile](https://linuxize.com/post/bashrc-vs-bash-profile/) - Tasks to setup the user ```.bash_profile```.
            - [lsyncd](https://axkibe.github.io/lsyncd) -  Lsyncd daemon tasks. Synchronizes local directories with remote targets.
            - [gitconfig](https://git-scm.com/docs/git-config) - Configuration tasks related to gitconfig.
            - [tox](https://tox.readthedocs.io/en/latest) - Tasks for installation of the python ``Tox`` automation tool.
            - [vim](https://vimconfig.com) - Configuration tasks related to VIM editor.
            - [docker](https://www.docker.com) - Docker container runtime provisioning.
            - [tshark](https://www.wireshark.org/docs/wsug_html_chunked/ChBuildInstallUnixBuild.html) - Tshark command line tool installation from the source code.
            - [ruby](https://www.ruby-lang.org/en/) - Ruby programming language.
            - [vagrant](https://www.vagrantup.com/) - The Hashicorp Vagrant command line tool.
            - [hvault](https://www.vaultproject.io/docs/what-is-vault) - The Hashicorp Vault client, secrets management tool.
            - [terraform](https://www.terraform.io/) - The Hashicorp IaC command line tool
            - [go](https://go.dev/) - Go programming language.
            - [kind](https://kind.sigs.k8s.io/) - Running local Kubernetes clusters inside Docker container "nodes".
            - [kubectl](https://kubernetes.io/docs/tasks/tools/) - The Kubernetes command line tool.
            - [helm](https://helm.sh/) - The package manager for Kubernetes.
            - [helm-dashboard](https://github.com/komodorio/helm-dashboard) - UI-driven way to view the installed Helm charts.
            - [hadolint](https://github.com/hadolint/hadolint) - Haskell Dockerfile linter.
            - [groovy](https://groovy-lang.org/) - The optional-typed Apache Groovy language.
            - [k9s](https://github.com/derailed/k9s) - Kubernetes CLI to manager your clusters.
            - [kubectx](https://github.com/ahmetb/kubectx) - Tool to switch between kubernetes contexts (clusters).
            - [kubefwd](https://github.com/txn2/kubefwd) - Kubernetes port forwarding for local development.
            - [kubeshell](https://github.com/cloudnativelabs/kube-shell) - An integrated shell for working with Kubernetes CLI.
            - [kubeps1](https://github.com/jonmosco/kube-ps1) - Kubernetes prompt for bash and zsh.
            - [kubecolor](https://github.com/hidetatz/kubecolor) - Colorize your kubectl output.
            - [kubeshark](https://kubeshark.co/pcap-or-it-didnt-happen) - API Traffic Viewer for Kubernetes.
            - [fzf](https://github.com/junegunn/fzf) - Command line fuzzy finder.
            - [yq](https://github.com/mikefarah/yq) - A lightweight and portable command-line YAML, JSON and XML processor.
            - [terragrunt](https://terragrunt.gruntwork.io/) - A thin wrapper around terraform (*orchestrator for terraform modules*).
            - [awscli](https://pypi.org/project/awscli) - Universal command line environment for AWS.

    - ``:skip_tags:`` Only plays, roles and tasks that *do not match* these values will be executed.
        - This parameter can be *string or list* of tags.

!!! info "More details on local ansible provisioner can be found at:"
      - [Ansible on Sandbox](../dev/ansible.md)
      - [Local Ansible Options](https://www.vagrantup.com/docs/provisioning/ansible_local)
      - [Asible Common Options](https://www.vagrantup.com/docs/provisioning/ansible_common)
