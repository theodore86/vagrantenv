# Overview

Vagrant comes with many great features out of the box to get your environments up and running. Sometimes, however, you want to change the way Vagrant does something or add additional functionality to Vagrant. This can be done via Vagrant *plugins*. Vagrant plugins are written in *Ruby* programming language.

# How to interact?

To interact with the vagrant plugins you need to execute the ``vagrant plugin`` subcommand.

- Install an vagrant plugin:
    - ``vagrant plugin install <plugin name>``
- Uninstall an vagrant plugin:
    - ``vagrant plugin uninstall <plugin name>``
- Upgrade an vagrant plugin:
    - ``vagrant plugin update <plugin name>``
- List all installed vagrant plugins
    - ``vagrant plugin list``

More information regarding the plugin subcommand:

```console
$ vagrant plugin --help
Usage: vagrant plugin <command> [<args>]

Available subcommands:
     expunge
     install
     license
     list
     repair
     uninstall
     update
```

# Where are installed?

- Lists all installed plugins
    - ``%USERPROFILE%\.vagrant.d\plugins.json``
- Actual source code
    - ``%USERPROFILE%\.vagrant.d\gems\gems\"plugin_name-version"``
- Ryby packages
    - ``%USERPROFILE%\.vagrant.d\gems\specifications\"plugin_name-version".gemspec``

# Automatic plugin installation

Vagrant plugins can be added in ``vagrant.yaml`` as a list (optionally version pinned) and automatically be installed during creation or reloading of the guest machine.

```yaml
:plugins:
    - :name: 'vagrant-vbguest'
      :version: '0.28.0'
    - :name: 'sahara'
      :version: '0.0.17'
    - :name: 'vagrant-proxyconf'
      :version: '2.0.10'
    - :name: 'vagrant-goodhosts'
      :version: '1.0.13'
    - :name: 'vagrant-netinfo'
      :version: '0.0.4'
```

Supported options are:

- ``:name``: The plugin name.
- ``:version``: Version constraint of the plugin.
    - You can set it to a specific version, such as ``1.2.3``
    - You can set it to a version constraint, such as ``> 1.0.2``
    - You can set it to a more complex constraint such as ``> 1.0.2, < 1.1.0``
- ``:sources``: Custom sources for downloading the plugin.

# Notable Plugins

- [List of available Vagrant plugins from GitHub wiki.](https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins)
- [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) - autoupdate VirtualBox guest additions (according to VB version).
- [vagrant-goodhosts](https://github.com/goodhosts/vagrant) - adds an entry to your /etc/hosts file on the host system.
- [sahara](https://github.com/jedi4ever/sahara) - easy manage VM state (commit/rollback while experimenting with software stack).
- [vagrant-netinfo](https://github.com/vStone/vagrant-netinfo) - shows network mapping information on a running VM.
- [vagrant-proxyconf](https://github.com/tmatilai/vagrant-proxyconf) - plugin that configures the virtual machine to use specified proxies.
