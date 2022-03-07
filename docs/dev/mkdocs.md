# What is MkDocs

MkDocs is a documentation generator that focuses on **speed** and **simplicity**.<br>

It has many great features including:

- Preview your documentation as you write it.
- Easy customization with themes and extensions.
- Writing documentation with [Markdown](https://en.wikipedia.org/wiki/Markdown).

---
An alternative tool for building and writing documentation is the [Sphinx](https://www.sphinx-doc.org/en/master/) project<br>
which is based on [restructuredText](https://docutils.sourceforge.io/rst.html) markup syntax.

---

# Quick start

MkDocs is an python executable with its own command line options, the official installation process is no required, [Vagrant](../vagrant/overview.md) and [Tox](./tox.md) have all the required dependencies in order to start generating or enhance the existing documentation.

In order to display all the available mkdocs command line options:

```console
tox -e docs -- --help
```

At the root of the project repository there is the ``mkdocs.yml`` which holds the MkDocs configuration, and ``docs/index.md``
which is the Markdown file that is the entry point for your documentation.

# Writing your docs

MkDocs has an detailed configuration guide where you can read to get familiar on [how to start writing](https://www.mkdocs.org/user-guide/writing-your-docs/) your documentation, the most important setting is the [nav](https://www.mkdocs.org/user-guide/configuration/#nav), is used to determine the format and layout of the global navigation for the project documentation:

```yaml
    - Home: index.md
    - User Guide:
          - 'Vagrant':
                - 'Overview': 'vagrant/overview.md'
                - 'Commands': 'vagrant/commands.md'
                - 'Vagrantfile': 'vagrant/vagrantfile.md'
                - 'Providers': 'vagrant/providers.md'
                - 'Networking': 'vagrant/network.md'
                - 'System': 'vagrant/system.md'
                - 'Provisioners': 'vagrant/provision.md'
                - 'Synced Folders': 'vagrant/shared.md'
                - 'Plugins': 'vagrant/plugins.md'
                - 'Debugging': 'vagrant/debugging.md'
                - 'Workflow': 'vagrant/workflow.md'
                - 'Common Issues': 'vagrant/issues.md'
          - 'Cmder': 'cmder/guide.md'
          - 'Chocolatey': 'chocolatey/guide.md'
          - 'Git Bash': 'gitbash/guide.md'
    - Developer Guide:
          - 'Ruby': 'dev/ruby.md'
          - 'YAML': 'dev/yaml.md'
          - 'Tox': 'dev/tox.md'
          - 'Pre-commit': 'dev/hooks.md'
          - 'MkDocs': 'dev/mkdocs.md'
```

Navigation setting in ``mkdocs.yml`` documentation is separated into 3 major parts:

- ``Home`` the documentation main/entry page.
- ``User Guide`` guide for regular users who wants to try out the project capabilities.
- ``Developer Guide`` documentation for the necessary tools to develop and enhance the project.

# How to build and serve docs

To generate (build) and build the project documentation locally in your test virtual machine you need to execute:

```console
tox -e docs -- --dev-addr 0.0.0.0:8000
```

by default Mkdocs will build the Markdown files into HTML and starts a development server inside the virtual machine exposing the internal service port (``::8000``) to your host machine at [http://TestVM/8000](http://TestVM:8000) in order to browse your documentation.

Depending on your selected [network](../vagrant/network.md) setup from the ``vagrant.yaml``:

- If you are behind an **VPN**:

```console
tox -e docs -- --dev-addr 0.0.0.0:8001
```

```yaml
:networks:
    - :vpn:
          :type: 'forwarded_port'
          :disabled: true
          :options:
              - :id: 'mkdocs'
                :guest: 8001
                :protocol: &tcp 'tcp'
                :host_ip: &localhost '127.0.0.1'
                :host: 8001
                :auto_correct: true
```

- If you are working on **LAN**:

Only the guest service port needs to be changed.

# Linting your documentation

To verify your markdown syntax you can use the project linters:

```console
tox -e lint
```

There is an [pre-commit](./hooks.md) local hook to build the documentation in ``--strict`` mode.

# References

- [MkDocs](https://www.mkdocs.org/)
