# What is Tox?

This quote comes straight from the [Tox official site:](https://tox.readthedocs.io/en/latest/)

---

Tox is a generic [virtualenv](https://pypi.org/project/virtualenv) management and test command line tool you can use for:

- checking your package installs correctly with different Python versions and interpreters.
- running your tests in each of the environments, configuring your test tool of choice.
- acting as a frontend to Continuous Integration servers, greatly reducing boilerplate and merging CI and shell-based testing.

---

# Features

- automation of tedious Python (not only) related test activities.
- test your Python package against many interpreter and dependency configs.
    - test-tool agnostic: runs pytest, nose or unittests in a uniform manner.
    - installs your ``setup.py`` based project into each virtual environment.
    - automatic customizable (re)creation of virtualenv test environments.
- cross-platform: Windows and Unix style environments
- integrates with continuous integration servers like [Jenkins](https://jenkins.io/index.html) (formerly known as Hudson) and helps you to avoid boilerplatish and platform-specific build-step hacks.
- driven by a simple ini-style config file.
- [plugin system](https://tox.readthedocs.io/en/latest/plugins.html) to modify tox execution with simple hooks.

# Installation

In order to install ``tox`` you need first to install ``python3`` and ``pip3``.

You can easily install python on Windows using the [chocolatey](../../chocolatey/guide/#What is Chocolatey) package manager:

```console
choco install python3
```

On latest Linux distribution systems python3 support comes out of the box,<br>
you just need to install the [pip](https://packaging.python.org/tutorials/installing-packages/) tool:

```console
<package manager> install python3-pip
```

Finally, install ``tox`` automation tool, either from your command line:

```console
pip3 install tox
```

!!! attention "Windows OS deprecation"
    In ``v2.0.0`` release due to [ansible and ansible-lint](./ansible.md) limitation on Windows platforms only the Linux/Unix OS
    as development environments are supported.

!!! tip
    There is no need to use the host machine as your main development environment, alternative **you can use the guest machine**
    which is already provisioned with all the required development tools, either you can take advantage of vagrant [synced folders](../vagrant/shared.md)
    functionality or just clone the source code inside the guest machine after the provisioning process.

# Basic example

Put the basic information about your project and the test environments you want your project to run in into a ``tox.ini`` file.

```ini
# content of: tox.ini
[tox]
project = Vagrant
minversion = 3.2.1
skipsdist = true
envlist = py{2,3}
skip_missing_interpreters = true

[testenv]
# set environment variables
setenv =
    LANG = en_US.UTF-8
    VIRTUAL_ENV = {envdir}
    PYTHONDONTWRITEBYTECODE = 1
    VIRTUALENV_NO_DOWNLOAD = 1
    PIP_CONFIG_FILE = .pip.conf
# pass environment variables
passenv =
    HTTP_PROXY
    HTTPS_PROXY
sitepackages = False
# allow any external command line tool
whitelist_externals =
    find
# install mkdocs in the virtualenv where commands will be executed
deps =
    mkdocs>=1.0.4
commands =
    # NOTE: you can run any command line tool here - not just tests
    - find . -type f -name "*.pyc" -delete
    - find . -type d -name "__pycache__" -delete
    {envpython} -m pip check
```

You can also try generating a ``tox.ini`` file automatically, by running ``tox-quickstart`` and then answering a few simple questions. Install and test your project against Python2.7 and Python3.6, just type:

```console
tox
```

and watch things happening. When you run ``tox`` a second time you’ll note that it runs much faster because **it keeps track of virtualenv details** and will not recreate or re-install dependencies.

# Test environments

The main purpose of using ``tox`` in this project is to automate and encapsulate most of the test operations during the development of the project source code. The default ``tox`` test environment is the ``[testenv]``. This environment will be triggered when we are calling the ``tox`` command without any command line option. Despite of the ``[testenv]`` it is possible to override the global settings and create more virtual environments based on your project needs.

Test environments are defined by a:
```ini
[testenv:NAME]
commands = ...
```
section. The ``NAME`` will be the name of the virtual environment. Defaults for each setting in this section are looked up in the:
```console
[testenv]
commands = ...
```
``testenv`` default section. Complete list of settings can be found at [tox configuration section](https://tox.readthedocs.io/en/latest/config.html)

Currently the supported test environments are:

- ``[testenv]``

Default test environment, will check the python dependencies in python 2 and 3.<br>

Just type:
```console
tox
```

- ``[testenv:lint]``

Will execute the ``pre-commit`` framework in order to perform code validation, linting and formating.<br>

Just type:
```console
tox -e lint
```

- ``[testenv:vagrantlint]``

Will execute the vagrant command: ``vagrant validate Vagrantfile``.<br>
It performs an dry-run on the [Vagrantfile](../../vagrant/vagrantfile/#Introduction).<br>

Just type:
```console
tox -e vagrantlint
```

- ``[testenv:docs]``

Project documentation using the [mkdocs](./mkdocs.md). It will spawn an http server in order to serve the documentation. This environment is useful whenever we want to extend the project documentation using the [Markdown Language](https://en.wikipedia.org/wiki/Markdown).<br>

Just type:
```console
tox -e docs
```

- ``[testenv:jenkins]``

Jenkins test environment **should not** be executed manually. It will be triggered whenever an commit is pushed to the remote repository. After each commit (except of ``[ci-skip]`` in commit message) Jenkins will perform code validation and will permantly generate and serve the project documentation.

In brief this environment is being used for [CI/CD](https://www.infoworld.com/article/3271126/what-is-cicd-continuous-integration-and-continuous-delivery-explained.html) purposes.<br>

Just type:
```console
tox -e jenkins
```

# References

- [Tox automation project](https://tox.readthedocs.io/en/latest/)
- [Managing a Project's Virtualenvs with tox](https://www.seanh.cc/2018/09/01/tox-tutorial/)
