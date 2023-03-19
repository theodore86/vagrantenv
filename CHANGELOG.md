## [2.32.0] - 2023-03-19

### Changed

- Update README.md.
- Update project documentation.
- Update project dependencies.
  - Update ``rubocop==1.48.1``.
  - Update ``pre-commit==3.2.0``.
  - Update ``pytest==7.2.2``.
  - Update ``pylint==2.17.0``.
  - Update ``ansible==7.3.0``.
  - Update ``typing-extensions==4.5.0``.
  - Update ``yamllint==1.29.0``.
  - Update ``shellcheck==0.9.0.2``.
  - Update ``mkdocs==1.4.2``.
- Update ``provision.bat`` windows script.
  - Add ``goto`` error handling.
- Update ``vagrant.yaml``
  - Add support of ``npm`` package manager proxy.
  - Update vagrant plugins version.
    - ``vagrant-vbguest==0.31.0``.
    - ``vagrant-goodhosts==1.1.5``.
  - Update image version to ``bento/22.04`` (Jammy).
  - Update ansible tags.
  - Add config to add extra disks to VM.
- Update ``Dockerfile``
  - Update vagrant to version ``2.3.4``.
  - Update tox to version ``4.2.6``.
- Update ``linux/provision.sh``
  - Update vagrant to version ``2.3.4``.
- Update ansible roles.
  - Update vagrant role version to ``2.3.4``.
  - Update docker role.
    - Add image GC support.
  - Update gitconfig role.
    - Add support of ``credentials.helper=store``.
    - Move role under git super role.
  - Update vim role (*refactor*), add Jenkinsfile vim plugin.
  - Update kubeps1 role.
    - Update git repository url.
  - Update ruby role.
    - Change ruby dependency ``ruby-full`` to ``ruby-dev``.
    - Ruby handler version to ``2.3.23``.
- Update ``tox.ini``
  - Update ``whitelist`` to ``allowlist_externals`` options.
- Update ``Vagrantfile``
  - Update file to include disks method.
- Update ``lib/vagrant-host.rb``
  - Add new extra methods for extra disk management.
- Update ``chocolatey.config``.
  - Add ``vscode/1.72.2``.
  - Update python to ``3.11.0``.
- Update ``docker/lint.sh`` script.
  - Add support of automaticalyl detection of platform architecture and OS.

### Added

- Ansible provisioner roles.
  - ``kubernetes/helm-dashboard`` role.
  - ``kubernetes/kubeshark`` role.
  - ``system/disks`` role.
    - Resize the partition when PV is resized using fdisk.
- Add support for primary disk resizing.

### Removed

- Delete ``sublimetext3`` from ``chocolatey.cfg``.
- Delete ``python/ipython`` role from ansible roles.
- Delete ``midori`` browser from ``common/system`` role packages.

### Fixed

- Ansible provisioner roles.
  - Fix mvn and groovy role handler names to be unique to avoid collisions.
  - Fix groovy handler when absolute path to binary is not defined.
  - Fix ``become`` option from ``no`` to ``yes`` for ruby bundler.
  - Fix ``user_install`` option from ``yes`` to ``no`` to avoid issues with *Gem* path.
- ``pacapt.sh`` helper script.
  - Raise error when ``curl`` is not available on the target host.
- ``vagrant.yaml`` networking
  - Fix instantiation error when ip address range for the *host-network* only adapter is not in ``192.168.56.0/21`` range.

## [2.22.1] - 2022-10-19

### Changed

- Update README.md.
- Update project documentation.
  - Update access.md (network connectivity).
- Update project dependencies.
  - Update ``pylint==2.15.4``.
  - Update ``yamllint==1.28.0``.
  - Update ``ansible==6.5.0``.
  - Update ``mkdocs==1.4.1``.
- Update ``Dockerfile`` dependencies.
- Update ``circleCI`` ``config.yml``.
- Update ``dockerize.yml`` ``Github action``.
- Update ``ansible`` filter plugin unittests.
  - Update unittests to be python3 compatible.
- Update ``ansible`` vagrant role.
  - Add support fo older binary versions.
- Update ``ansible`` GO role.
  - Update GO to version ``1.19.2``.
  - Update GO modules.
    - Add *gopls* module.
    - Add *dlv* (delve) module.
    - Add *staticcheck* module.

### Added

- Ansible provisioner roles.
  - ``kubernetes/kubeshell`` role.
  - ``kubernetes/kubeps1`` role.
  - ``kubernetes/kubecolor`` role.

## [2.19.1] - 2022-09-05

### Changed

- Update README.md.
- Update project documentation.
  - Update ansible.md.
- Update project dependencies.
  - Update ``pylint==2.15.0``.
- Update ``Gemfile/Gemfile.lock``.
  - Update ``rubocop==1.36.0``.
- Update ansible roles.
  - Update ``hashicorp/vagrant`` role.
    - Change *ansbile_machine* with *ansible_architecture* fact variable.
  - Update ``ansible`` role.
    - Update ``paramiko==2.11.0`` and ``jmespath==1.0.1``.
  - Update ``ruby`` role.
    - Update *gem:* ansible module parameters, add ``norc`` option.
- Update ``Vagrantfile``.
  - Update *local_ansible* provisioner to be executed after *shell and file* provisioner.
- Update ``ansible.cfg``
  - Update ``callback_whitelist`` to ``callback_enabled``.
- Update ``vagrant.yaml``
  - Add ``:shell:`` provisioner to invoke the ``ansible.sh`` bootstrap script.

### Added

- Ansible as project requirements.
  - Add ``ansible.txt`` in *requirements.d* with version: *6.3.0*.
- Ansible shell provisioner.
  - Add ``ansible.sh`` shell script for bootstraping the ansible (*CM*) tool.

### Removed

- Delete obsolete service rules from vpn network *port_forward map* in ``vagrant.yaml``.
- Delete ``python2``, and ``cmder`` references from windows ``chocolatey.config``.
- Delete ``python-*`` (*python2*) and ``python3.8-dev`` system packages from ansible ``common/system`` role.

### Fixed

- Ansible provisioner.
  - Change ``kubernetes/k9s`` github repository address.

## [2.18.2] - 2022-08-20

### Changed

- Update project dependencies.
  - Update ``mkdocs==1.3.1``.
  - Update ``pylint==2.14.5``.
  - Update ``pre-commit==2.20.0``.
  - Update ``yamllint==1.27.1``.
- Update ansible-provisioner.
  - Update docker role ``docker-compose==1.29.1``.
  - Update docker role the ``docker==5.0.3`` SDK.
  - Update common system role.
    - Add *midori* lightweight web-browser.
    - Add *xdg-utils* - desktop integration utilities.
- Update ``ansible.cfg``.
  - Update python interpreter to python3.
- Update ``Gemfile/Gemfile.lock``.
  - Update ``rubocop==1.35.0``.

### Added

- Hashicorp ansible role.
  - Terraform IaC binary.
- Terragrunt (IaC) ansible role.
- AWS CLI ansible roles.
  - ``awscliv2``.
  - ``awscli (version 1)``.
- Github action ``release.yml`` workflow.
  - Add Github release on git tag push events.

### Fixed

- Ansible provisioner.
  - Docker-compose (display) version output.
  - Docker SDK (display) version output.

## [2.14.0] - 2022-06-20

### Changed

- Update README.md.
- Update CONTRIBUTING.md.
- Update LICENSE.
- Update project dependencies
  - Update ``mkdocs==1.2.3``.
  - Update ``shellcheck==0.8.04``.
  - Update ``yamllint==1.26.3``.
  - Update ``paygments==2.11.2``.
  - Update ``pre-commit==2.19.0``.
  - Update ``rubocop==1.30.1``.
  - Update ``pydown-extensions==9.3``.
  - Update ``jinja2==3.0.3``.
  - Update ``pylint==2.14.2``.
- Update ansible provisioner.
  - Add filewatcher task in ``system.yml`` task file.
  - Add support for ansible roles.
  - Add support of *buildkit* for docker role.
- Update ``vagrant.yaml``.
  - Update vagrant-goodhosts plugin to version *1.1.4*.
  - Update local ansible provisioner ``:extra_vars:``.
    - Add ``:skip_tags:`` to exclude ansible roles.
  - Update *testvm* name to *sandbox* in configuration file.
  - Update vbguest plugin configuration.
    - Update ``:no_install`` from *true* to *false*.
- Update ``chocolatey.config``.
  - Update vagrant to *2.2.19*.
  - Add under ``tools/windows`` subfolder.
- Update ``rubocop`` shell wrapper.
  - Add check for *bundle* installation.
- Update ``mkdocs.yml``.
  - Add markdown extensions.
- Update ``tox.ini``.
  - Add environment variables:
    - ``BUNDLE_PATH``.
    - ``SKIP``.
    - ``PRE_COMMIT_HOME``.
- Update ``provision.bat`` script.
  - Add under ``tools/windows`` subfolder.

### Added

- Add ``Dockerfile`` for project CI purposes.
- Add ``hadolint`` linter ansible role.
- Add ``helm`` package manager ansible role.
- Add ``jvm`` related ansible roles.
  - ``maven``.
  - ``groovy``.
  - ``openjdk``.
- Add ``kubernetes`` ansible roles.
  - ``k9s``.
  - ``kubectx``.
  - ``kubefwd``.
- Add ``fzf`` tool ansible role.
- Add ``GO`` programing language ansible role.
- Add ``yq`` tool ansible role.
- Add support of local docker linter.
  - Add shell script ``lint.sh`` under ``tools/docker``.
- Add support of local docker builder.
  - Add shell script ``build.sh`` under ``tools/docker``.

### Removed

- Gitlab templates (*moved project to Github*).
- Ansible provisioner.
  - Delete ``test_repos.yaml`` task file.
- Ansible tasks and variable files.

## [2.0.4] - 2022-03-04

### Changed

- Update README.md.
- Update project documentation.
  - Update ``provisioners.md``.
  - Update ``network.md``.
- Update ansible provisioner
  - Update ansible command module to shell.
  - Update ansible.cfg, set *callback_enabled* option.
  - Update ``handlers.yaml``
    - Add *kind* handlers.
    - Add *kubectl* handlers.
  - Update ``playbook.yaml``.
    - Add *vagrant* task file.
    - Add *hvault* task file.
    - Add *go* task file.
    - Add *kind* task file.
    - Add *kubectl* task file.
  - Update ``system.yaml`` task file.
    - Remove *python-pip* package.
    - Add *jq* package.
  - Update ``bash_profile.yaml`` task file.
    - Add vault bash completion.
  - Update ``test_repos.yaml`` task file.
    - Change SCM hostname from repository URLs.
  - Update ``docker.yaml`` task file.
    - Add support for *docker-compose* python package.
- Update ``.pre-commit-config.yaml``.
  - Update *vagrantlint* manual hook.
- Update ``vagrant.yaml``.
  - Update ``ansible`` provisioner name, set to VM hostname.
  - Update ``ansible`` option tags.
    - Add *vagrant* tag.
    - Add *hvault* tag.
    - Add *go* tag.
    - Add *kind* tag.
    - Add *kubectl* tag.
  - Change ``:box_url:`` option value to ``null``.
  - Update ansible local provisioner package to version *4.8.0*.
  - Change ``:allow_downgrade:`` to *true* for vbguest plugin.
  - Update proxy address.
- Update *ruby* libraries.
  - Change ``root_path`` utilities function to ``project_root_path`` in vagrant-utils.rb
  - Add function ``expand_host_path`` in ``vagrant-utils.rb``.
  - Update ``vagrant-host.rb``, reuse ``expand_host_path`` to file and shell provision functions.
- Update ``chocolatey.config``.
  - Update virtualbox to *6.1.16*.
- Update ``ansible.cfg``
  - Change *callback_enabled* to *callback_whitelist* plugins in default settings section.
- Update ``tox.ini``
  - Remove *LC_ALL*, *LC_LANG* env variables.
  - Change *testenv:lint* to *testenv:linters*.
  - Add *http_proxy*, *https_proxy* as *passenv* options.
  - Remove *NO_PROXY* variable from *setenv* option.
  - Update *ansible-lint==5.3.2*.

### Fixed

- Ansible provisioner
  - ``system.yaml``, update locales task file, requires superuser privileges.
  - ``tshark.yaml``, set *when* condition if tshark source code does not exist.

### Added

- Ansible provisioner variable and task files.
  - Add *vagrant* task and variable files.
  - Add *hvault* task and variable files.
  - Add *go* task and variable files.
  - Add *kind* task and variable files.
  - Add *kubectl* task and variable files.
- Gitlab issue templates.

## [2.0.3] - 2021-07-27
### Changed

- Update README.md.
- Update project documentation.
  - Update ``network.md``.
  - Update ``issues.md``.
  - Update ``plugins.md``.
- Update ``.pre-commit-config.yaml``.
  - Change *ansible_lint* hook, explicit set the master playbook path.
  - Add ``pass_filenames: False`` to vagrantlint hook.
  - Change *yamllint* hook, add ansible-lint and yamllint configuration files.
  - Change language option value from *python* to *system*.
  - Consolidate local hooks into an single YAML list.
  - Update *pre-commit* hooks to version *3.4.0*.
  - Update *forbid-tabs* hook to version *1.1.9*.
  - Update *forbid-binary* hook, exclude images.
- Update ``tox.ini``.
  - Change *basepython* to python3.
  - Change *ansible-lint[community]* to version *5.0.6*.
  - Update *passenv* option, add *USER* environment variable.
- Update ``Vagrantfile``.
  - Change library *relative_import* of vagrant-hostupdater with vagrant-goodhosts.
  - Change vagrant-hostupdater configuration block with vagrant-goodhosts.
- Update ruby libraries.
  - Rename plugin ``vagrant-hostupdater.rb`` to ``vagrant-goodhosts.rb``.
- Update ``vagrant.yaml``.
  - Change key ``:hostupdater`` to ``:goodhosts``.
  - Change *local_ansible* provisioner ``:inventory_path`` option to correct file format.
  - Change *local_ansible* provisioner ``:pip_mode`` to ``:pip_args_only``.
  - Update vagrant-vbguest plugin to version *0.30.0*.
  - Update vagrant-goodhosts plugin to version *1.0.15*.
  - Update *local_ansible* provisioner, add ruby tag.
- Update ansible provisioner.
  - Change inventory file format from *INI* to *YAML*.
  - Update system variable file:
    - *python-dev*.
    - *python3-dev*.
    - *python-pip*.
    - *git-crypt*.
    - *bridge-utils*.
  - Update ``pip.conf.j2`` template file, remove *log_file* and *download_cache*.
  - Update ``ansible_extras.yaml`` task file to include all extra ansible dependencies.
  - Update ``tox.yaml`` variable file, set version to *3.23.1*.
  - Update ``tshark.yaml`` variable file
    - Update tshark version to *3.4.2*.
    - Add default tshark group.
    - Add *libcap2-bin* to tshark dependencies.
  - Update ``docker.yaml`` variable file, set version to *4.4.4*.
  - Update ``tshark.yaml`` task file, set non-privilege users to capture with tshark.
  - Update ``bash_profile.yaml`` to include ruby gems into the *PATH* environment variable.
  - Update ``tox.yaml`` task and variable files to include package versions and state as optional directives.
- Update ``.gitattributes``.
  - Add *.cache* ansible-lint folder.
- Update ``.ansible-lint``.
  - Remove *exclude_paths* configuration option.
  - Change *skip_list* configuration option with lint rules.
- Update ``.pip.conf``.
  - Remove *log_file* and *download_cache* configuration options.
- Update ``chocolatey.config``.
  - Update vagrant version to *2.2.16*.
  - Update virtualbox version to *6.1.22*.
- Update ``.gitignore``.
  - Add *.cache* ansible-lint folder.
- Update ``.yamllint``, set configuration to override the default.

### Fixed

- Ansible provisioner.
  - Fix ``docker.yml`` task failures.
  - Fix ``tshark.yaml`` task, handler, requires superuser privileges.
- Fix ``.pre-commit-config.yaml`` *yamllint* hook errors.
- Fix *rubocop* ruby linter recommendations.
- Fix lan network options, replace ``:hostupdate`` with ``:goodhosts`` plugin.

### Added

- Add ``vagrant-goodhosts`` plugin version ``1.0.13``.
- Add ``yamllint==1.26.0`` to ``tox.ini`` dependencies.
- Add git ``.mailmap`` to project.
- Add ``check-mailmap`` hook to ``.pre-commit-config.yaml``.
- Add ``[testenv:rubocoplint]`` for ruby lint virtualenv.
- Add script wrapper *rubocop* for bundler and rubocop linter.
- Add ``GemFile`` and ``GemFile.lock`` to handle ruby dependencies.
- Add *rubocop* hook in ``.pre-commit-config.yaml``.
- Add ``ruby.yaml`` variable file and task file for ruby ansible provisioning.

### Removed

- Remove ``vagrant-hostupdater`` plugin.
- Remove ``gitlint`` hook from ``.pre-commit-config.yaml`` hooks.
- Remove python2 project dependencies in ``tox.ini``.

## [2.0.2] - 2021-03-18

### Changed

- Update README.md.
- Update ``vagrant.yaml``
  - Update local_ansible version to ``2.10.7``.
  - Add local_ansible ``ansible_extras`` tag in tag list.
- Update ansible provisioner ``playbook.yaml``
  - Add ansible extras variable and task files.
- Update ansible provisioner task files.
  - Remove system update task, called once in play ``pre_tasks``.

### Fixed

- Docker SDK ansible task ``PIP_CONFIG_FILE`` variable value.

### Added

- Add ansible provisioner connection plugin dependencies.
  - ``ansible_extras.yaml`` variable file.
  - ``ansible_extras.yaml`` task file.

## [2.0.1] - 2021-03-15

### Changed

- Update README.md.
- Update ``ansible.cfg``
  - Remove ``[ssh_connection]`` section.
  - Add callback debug plugin in ``[defaults]`` section.
- Update ansible provisioner.
  - Pinned virtualenv version in tox variable file.
  - Rename task file ``test-repos.yaml`` to ``test_repos.yaml``.
  - Update main ``playbook.yaml`` - rename task filename to ``test_repos.yaml``.

### Added

- Add ansible provisioner VIM task.
  - Add ``Jinja2-vim-plugin`` syntax xhighlighting.

### Fixed

- Fix local_ansible provisioner failure in ``vagrant.yaml``.
  - Change ``:pip_install_cmd:`` (url) option value.

## [2.0.0] - 2021-02-26

### Changed

- Update README.md.
- Update ``.gitattributes``.
- Update project documentation.
  - Update ``network.md``.
  - Update ``provisioners.md``.
  - Update ``overview.md``.
  - Update ``vagrantfile.md``.
  - Update ``plugins.md``.
- Update ``.pre-commit-config.yaml``.
  - Add ``ansible-lint`` hook.
  - Add ``mkdocs-lint`` hook.
- Update ``.yamllint``.
  - Set maximum lines to 145.
- Update ``Vagrantfile``.
  - Add ``ansible_provision`` method to support ansible provisioner.
- Update ``vagrant-host.rb``.
  - Add ``ansible_provision`` method.
  - Update ``networking`` method.
- Update ``vagrant-proxy.rb``
  - Refactor ``system_wide`` method.
- Update ``mkdocs.yml``.
  - Update ``site_name``, ``site_author``, ``site_description``, ``repo_url``, ``edit_uri`` options.
  - Add ansible, mkdocs sections - list values.
  - Update ``hljs_langueages``, ``hljs_style`` options.
  - Add ``makrdown_extensions`` option.
- Update ``vagrant.yaml``.
  - Add ``:ansible`` provisioner options.
  - Add new ``:forwarded_port`` rule for mkdocs in ``:networks``.
  - Remove ``:file`` and ``:shell`` options for file,shell provisioners.
  - Set anchor for ``/shared`` mounted point.
  - Set ``:no_proxy`` option to list value type.
  - Replace ``:provisioners``, ``:templates`` with ``:shell_provisioner`` and ``:ansible_provisioner`` options.
- Update ``tox.ini``.
  - Add ``ansible-lint[community]`` dependency.
  - Add ``pymdown-extensions`` dependency.
  - Add ``Pygments`` dependency.
  - Remove ``Jinja2`` dependency.
  - Update command option value for ``[testenv:docs]``.

### Added

- Add `.ansiblie-lint` configuration file.
- Add ansible provisioner, set it as main provisioner.
- Add in project documentation.
  - Add ``issues.md`` common issues section.
  - Add ``mkdocs.md`` Mkdocs section.
  - Add ``ansible.md`` Ansible section.
  - Add ``access.md`` intranet access section.

### Removed

 - Delete all shell provisioner scripts.
 - Delete templates subfolder.

## [1.1.9] - 2021-01-14

### Changed

- Update README.md
- Update vagrant provision documentation.
- Update ``vimrc.tml``.
  - Set ruler, laststatus=2, esckeys options.
- Update ``.gitignore``.
  - Add ``install_ps1`` chocolatey install file.
- Update ``gitconfig.tmpl``.
  - Add alias for git clean command.
- Update ``vagrant.yaml``.
  - Set ``:path``, ``:mount_point``, ``upload_path`` to default values in vbguest.
  - Enable ``:auto_update`` in vbguest.
  - Disable ``:docker`` proxy settings.
  - Disable ``:apt`` proxy settings.
  - Disable ``:git`` proxy settings.
  - Add ``_helpers`` file provisioner.
  - Add ``:boot_timeout`` to 60 secs as option.
  - Add ``:plugins`` list with pinned version to be automatically installed.
  - Move vagrant ``:ssh`` dictionary outside of the actual guest config.
  - Add ``:vagrant min_required_version``, the minimum accepted vagrant version.
  - Add extra guest custom command: ``['--ioapic', 'on']``.
  - Add ansible shell provisioner.
  - Add ``:args`` for versioning of tox provisioner.
  - Add anchor *run_once* for ``null`` for shell provisioners.
  - Add anchor *always* for file provisioners.
- Update ``chocolatey.config``.
  - vagrant to ``2.2.14`` version.
  - virtualbox to ``6.1.16`` version.
  - python3 to ``3.9.0`` version.
  - cmder to ``1.3.16`` version.
- Update ``.pre-commit-config.yaml``.
  - pre-commit hooks to version ``3.3.0``.
  - gitlint to version ``0.14.0``.
  - yamllint to version ``1.25.0``.
- Update ``tox.ini``.
  - pre-commit to ``2.8.2`` version for *py3* factor.
  - pre-commit to ``1.21.0`` version for *py2* factor.
  - shellcheck to ``0.7.1.1`` version.
- Update ``docker.sh`` shell provisioner.
  - Add installation verification.
  - Add private docker registries in ``daemon.json``.
- Update ``Vagrantfile``.
  - Move file before shell provisioners.
  - Add boot timeout for VM settings.
  - Add the ``load_config`` helper function to wrap YAML parsing.
  - Rename *CONFIG* to *VCONFIG* constant variable.
  - Add check for vagrant binary minimum version.
  - Move vagrant ssh settings outside of the VM definition.
  - Add ``post_up_message`` method call right after guest instantiation.
- Update ``.pre-commit-config.yaml``.
  - Add -x command line option to shellcheck hook.
- Update ``vagrant-host.rb``.
  - Move ssh method to ``vagrant-ssh.rb`` module.
  - Add ``post_up_message`` method.
- Update ``locale.sh`` shell provisioner.
  - Enclose positional arguments in double quotes.
- Update ``timesynd.sh`` shell provisioner.
  - Enclose positional arguments in double quotes.
- Update ``tox.sh`` shell provisioner.
  - Add error handling if pip installation fails.
- Update ``mkdocs.yml``.
  - Add section in documentation to track vagrant known issues.
- Update ``ipython.tmpl``.
  - Remove ``c.TerminalIPythonApp.ignore_old_config = False`` config option.

### Fixed

- Fix ``compile-tshark.sh`` shell provisioner.
  - Remove double quotes when expanding ``SOURCE_CODE`` variable with wildcard.

### Added

- Add ``provision.bat`` auto install script for required Windows OS packages.
- Add ``_helpers.sh`` shell provisioner.
- Add ruby module ``vagrant-utils.rb`` for helper functions.
  - Add ``load_config`` method.
  - Add ``raise_msg`` method.
  - Add ``ensure_plugins`` method.
- Add ruby module ``vagrant-ssh.rb`` for vagrant ssh settings.
- Add ``ansible.sh`` shell provisioner.
- Add ansible provisioner folder for plays, tasks, vars, inventory.
  - Add ``ansible.cfg`` configuration file.
  - Add ``playbook.yaml`` with ansible play/tasks.
  - Add ``rfvim.yaml`` and ``test-repos.yaml`` variable files.
  - Add *localhost* inventory file.
  - Add ``rfvim.yaml`` and ``test-repos.yaml`` tasks.
- Add ``issues.md`` to track vagrant known issues in documentation.

### Removed

- Delete ``common.rb`` module.
- Delete ``VAGRANT_API_VERSION`` constant variable in ``Vagrantfile``.
- Delete ``.vagrantplugins``.
- Delete ``sys.rb`` module.
- Delete ``rfvim.sh`` shell provisioner.

## [1.1.8] - 2020-09-11

### Changed

- Update README.
- Update ``.gitattributes``.
  - Add ``*.xml`` files as text files.
- Update project documentation.
- Update ``tox.ini``.
  - Exclude extra domain names to ``NO_PROXY`` env variable.
  - ``shellcheck-py==0.7.0.1``.
  - ``pre-commit==1.18.0``.
  - ``mkdocs==1.1.2``.
  - ``jinja2==2.11.0``.
  - Add *jenkins* conditional factor for ``shellsheck-py`` in testenv.
- Update ``.pre-commit-config.yaml``.
  - shellcheck hook from remote to local.
- Update gitconfig template.
  - Add ``autocrlf = input`` option.
  - Add ``eof = native`` option.
- Update ``manage-pkgs.sh``
  - Add *socat*.
  - Add *git-lfs*.
- Update ``vagrant.yaml``
  - Exclude domain names from ``NO_PROXY`` env variable.
  - Add explicit *sync_folders* type in shared folders.
  - Add extra mandatory argument in ctshark/dtshark shell provisioner.

### Fixed

- Fix ``shellcheck`` linter.
  - Correct warnings in ``compile-tshark.sh`` shell provisioner.
- Fix ``compile-tshark.sh`` shell provisioner.
  - Remove ``-gzip/-z`` command line option when compression is not gz.
  - Correct tshark source code checking routine.

### Added

- Add draw.io xml files - documentation images.
- Add support for *tshark-3.x* version in ``compile-tshark.sh`` shell provisioner.

## [1.1.7] - 2020-02-25
### Changed
- Update README.
- Update ``.pip.conf`` index urls.
- Update ``manage-pkgs.sh``.
  - Add *python3-pip*.
  - Add *sshpass*.
  - Remove *git-lfs*.
- Update ``.pre-commit-config.yaml``.
  - *yamllint - v1.20.0*.
  - *gitlint - v0.12.0*.
  - *shellcheck - SC2086*.
- Update ``tox.ini``.
  - *pre-commit>=1.18.0*.
  - *Jinja2==2.11.0*.
  - *LC_ALL, LAG* environment variables to ``en_US.utf8``.
  - *HTTP/HTTPS_PROXY* proxy environment variables.
- Update ``vagrant.yaml``
  - Proxy ip address.
  - Files folder to templates anchor.
  - pip shell provisioner.
- Update ``chocolatey.config``.
  - virtualbox version to *6.1.2*.
  - vagrant version to *2.2.7*.
- Update project documentation.
- Rename *files* foler name to *templates*.
- Remove ``install-tox.sh`` shell provisioner.
- Remove ``chocolatey.config`` from *templates* folder.

### Fixed

- Fix ``shellcheck`` linter.
  - Correct warnings in shell provisioners.
  - Ignore shellcheck *SC2086* warnings.

### Added

- Add *tools* folder in project.
  - Add ``chocolatey.config``.
- Add ``pip-install.sh`` shell provisioner.

## [1.1.6] - 2019-12-18

### Changed

- Update README.
- Update Cmder guide.
- Update lsyncd template.
  - Add macmini5.
  - Add macmini4.
- Update chocolatey package versions.
- Update vagrant provision documentation.
- Update ``Vagrantfile``.
  - Vagrant-vbguest settings.
- Update ``vagrant.yaml``.
  - Vbguest map.
  - RF VIM plugin provisioner.
- Update ``vagrant-proxy.rb`` method parameters.
  - Mandatory to optional.
- Remove host-shell vagrant plugin.
- Update ``tox.ini``.
  - ``LANG`` to ``LC_ALL`` env variable.
- Update compile-tshark.sh shell script description.
- Update vagrant plugins version.
  - vbguest.
  - proxyconf.
- Update ``.gitconfig``.
  - Add ``sshverify = False`` option.

### Fixed

- Fix apt-get autoremove autoconfiguration.
- Fix lsyncd username.

### Added

- Add ``lib/plugins/vagrant-vbguest``.
- Add shell script provisioner for rfvim plugin.
- Add git-lfs package in manage-pkgs.sh.

## [1.1.5] - 2019-09-16
### Changed
- Update README.
- Update project documentation.
  - Cmder guide.
  - Pre-commit hooks.
  - Vagrant Workflow.
- Update ``vagrant.yaml``.
  - Exclude intra domains from guest proxy configuration.
  - Proxy settings.
  - SSH settings.
  - Introduce new key: ``is_supported`` for HTTPs proxy handling.
  - Provisioning of docker package.
- Update ``Vagrantfile``.
  - SSH handling.
  - Conditional execution of ``vagrant-hostupdater`` plugin.
- Update ``vagrant-proxyconf`` plugin version to ``2.0.6``.
- Update ``vagrant-vbguest`` plugin version to ``0.19.0``.
- Update ``vagrant-proxy.rb``.
  - HTTPs scheme for proxy settings.
- Update ``tox.ini``.
  - ``recreate = true`` option for ``[Jenkins]`` section.
  - ``more-itertools==5.0.0`` for ``[py2]`` section.
  - ``recreate = true`` option for ``[py2]`` and ``[py3]`` sections.
- Update ``install-docker.sh``.
  - Add vagrant user to docker group.
- Update ``.pre-commit-config.yaml``.
  - Add ``shell-lint`` hook.
- Update ``chocolatey.config``.
  - Add ``shellcheck`` package.

### Fixed
- Fix relative path for ``sys.rb`` in ``vagrant-vb.rb`` module.
- Fix shell linter issues.

### Added
- Add ``lib/plugins`` subfolder for vagrant plugins.
- Add ``lib/providers`` subfolder for vagrant providers.
- Add ``vagrant-hostupdater.rb`` module.
- Add shell script provisioner for docker installation.

## [1.1.4] - 2019-07-12

### Changed

- Update README.
- Update ``vagrant.yaml``.
  - Remove wireshark tarball hardcoded name to glob.
- Update ``.gitattributes``.
  - Add ``*.tmpl`` files as text files.
  - Force ``eof=lf`` for ``*.tmpl`` files.
- Update ``.gitignore``.
  - Ignore ``logs`` folder.

### Fixed

- Fix ``vagrant.yaml``.
  - Restore LAN as default network.
- Fix ``tox.ini`` issues with python2/3.
  - tornado==5.1.1 in case of py2.
  - jinja2==2.8.1 in case of py3.

### Added

- Add python3 as basepython in ``tox.ini``.
- Add ``log-file`` option in ``.pip.conf``.
- Add ``[testenv:jenkins]`` section in ``tox.ini``.
- Add ``lsyncd`` (rsync) tool.
  - Update ``vagrant.yaml`` - Add lsyncd file provisioner.
  - Add ``lsyncd`` lua configuration file.
  - Update ``manage-pkgs.sh``- Add lsyncd package.
- Add Mkdocs - project documentation.
  - Add ``mkdocs.yml``.
  - Add ``*.md`` documentation files.
  - Add mkdocs>=1.0.4 in deps in ``tox.ini``.
  - Add ``[testenv:docs]`` section in ``tox.ini``.

## [1.1.3] - 2019-06-11
### Changed

- Update ``vagrant.yaml``.
  - Rename files to have .tmpl extension.
- Rename templates folder to files.
- Rename docs static folder to img.
- Update ``.pre-commit-config.yaml``.
  - Add ``--fix-auto`` when mixed-ending-lines.
- Update README.md.
- Update CONTRIBUTING.md.

### Added

- Add project LICENSE.

### Fixed

- Fix ``.pre-commit-config.yaml`` for README.md.
  - Improve regexp to exclude the README.md file.
- Fix ``.vagrantplugins`` regexp.
  - Improve regexp when scanning locally for vagrant plugins.
- Fix ``vagrant.yaml`` networks
  - Mistypo in vpn and lan key values.

## [1.1.2] - 2019-05-29

### Changed

- Update vagrant.yaml
  - Rename vagrant VM host name
- Update project README.md

### Added

- Update manage-pkgs shell provisioner
  - Add ``dos2unix`` system package

## [1.1.1] - 2019-05-02

### Changed

- Update gitconfig.tpl
  - Add option ``autostash = true`` when rebase.
- Rename ``ipython_config.tpl`` to ``ipython.tpl``.
- Update vagrant.yaml.
  - Replace ipython template name.

## [1.1.0] - 2019-04-21

### Added

- Integrate pre-commit framework.
  - ``.pre-commit-config.yaml`` hooks configuration file.
- Integrate Tox automation tool.
  - New tox.ini configuration file.
  - Add PIP ``.pip.conf`` global configuration file.
- Add ``.yamllint`` linter configuration file.
- Enable X11-forwarding.
  - Update Vagrantfile
  - Update vagrant.yaml
- New Ipython file provisioner in vagrant.yaml.
  - Add ``ipython_config.tpl`` configuration template.

### Fixed

- Fix Vagrant executable crashing.
  - Resolving explicitly any provisioner relative paths to absolute.

### Changed

- Replace ``join`` ruby method with ``File.join``.
  - Update vagrant-host ruby module for file and shell provisioners.
- Network selection solely on vagrant.yaml.
  - Removed from Vagrantfile.
  - Separate networks to: ``vpn`` and ``lan``.
  - Update vagrant.yaml, explict selection based on tag.
- Rename scripts folder to provisioners.
  - Subfolder per provisioner.
  - Preparing Ansible integration.
- Update .gitattributes
  - Add ``.ini`` and ``.conf`` text files.
- Update .gitignore
  - Exclude ``.tox`` folder.
- Remove tabs from project files.
- Update ``chocolatey.config``.
  - Add Sublime text 3.
  - Add Python 3.
- Update project file structure in README.
- Update steps in CONTRIBUTING.
- Rename the vagrant YAML configuration file.
- Update provisioned packages in README.

## [1.0.0] - 2019-02-25

### Added

- The first release of the Vagrant development & testing environment.
