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
    There is no need to use the host machine as your main development environment, alternative *you can use the guest machine*
    which is already provisioned with all the required development tools, either you can take advantage of vagrant [synced folders](../vagrant/shared.md)
    functionality or just clone the source code inside the guest machine after the completion of *ansible provisioning process*.

# Basic example

Put the basic information about your project and the test environments you want your project to run in into a ``tox.ini`` file.

```ini
# content of: tox.ini
[tox]
project = Vagrantenv (Sandbox)
minversion = 3.7.0
skipsdist = true
envlist = pre-testenvs,linters,tests
skip_missing_interpreters = true


[testenv]
changedir = {toxinidir}
basepython = python3
setenv =
    VIRTUAL_ENV = {envdir}
    PYTHONDONTWRITEBYTECODE = 1
    PYTHONWARNINGS = ignore
    VIRTUALENV_NO_DOWNLOAD = 1
    PIP_CONFIG_FILE = .pip.conf
passenv =
    USER
    HOME
    TERM
    BUNDLE_PATH
    PRE_COMMIT_HOME
    VAGRANT_HOME
    SKIP
    DEBUG
sitepackages = False
whitelist_externals =
    bash
deps = -r requirements.d/testenv.txt
parallel_show_output = true
commands =
    - bash -c 'find {toxinidir} -type d -name "__pycache__" | xargs rm -rf'
    - bash -c 'find {toxinidir} -type d -name ".pytest_cache" | xargs rm -rf'
    - bash -c 'find {toxinidir}  -type d -name ".bundle" | xargs rm -rf'
    {envpython} -m pip check


[testenv:linters]
description = Execute all project linters
deps = -r requirements.d/linters.txt
commands =
    {envpython} -m pre_commit run {posargs:--all-files --verbose}


[testenv:tests]
description = Execute project test automation
depends = pre-testenvs
deps = -r requirements.d/tests.txt
commands =
    {envpython} -m pytest {posargs:-s -v}


[testenv:docs]
description = Project documentation
deps = -r requirements.d/docs.txt
commands =
    {envpython} -m mkdocs serve {posargs}


[testenv:venv]
description = Any local command in virtualenv
commands = {posargs}
```

You can also try generating a ``tox.ini`` file automatically, by running ``tox-quickstart`` and then answering a few simple questions.

Install and test your project, just type:

```console
tox
```

and watch things happening. When you run ``tox`` a second time you’ll note that it runs much faster because **it keeps track of virtualenv details** and will not recreate or re-install dependencies.

# Test environments

The main purpose of using ``tox`` in this project is to automate and encapsulate most of the test operations during the development of the project source code. The default ``tox`` test environment is the ``[testenv]``. This environment will be triggered when we are calling the ``tox`` command without any command line option. Despite of the ``[testenv]`` it is possible to override the global settings and create more virtual environments based on your project needs.

Test environments are defined by:

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

The supported test environments are:

- ``[testenv]``

Default test environment, pre-checks and dependencies validation.<br>

Just type:

```console
tox
```

- ``[testenv:linters]``

Will execute the [pre-commit](./hooks.md) framework in order to perform code validation, linting and formating.<br>

Just type:

```console
tox -e linters
```

- ``[testenv:tests]``

Project test automation activities: ``unit`` or ``integration`` tests against project source code.

```console
tox -e tests
```

- ``[testenv:docs]``

Project documentation using the [mkdocs](./mkdocs.md). It will spawn an http server in order to serve the documentation. This environment is useful whenever we want to extend the project documentation using the [Markdown Language](https://en.wikipedia.org/wiki/Markdown).<br>

Just type:

```console
tox -e docs
```

# References

- [Tox automation project](https://tox.readthedocs.io/en/latest/)
- [Managing a Project's Virtualenvs with tox](https://www.seanh.cc/2018/09/01/tox-tutorial/)
