# What are Git hooks?

Git hooks are scripts that Git executes before or after events such as: commit, push and receive. Some example hook scripts include:

- pre-commit: Check the commit message for spelling errors.
- pre-receive: Enforce project coding standards.
- post-commit: Email team members of a new commit.
- post-receive: Push the code to production.

Git hook scripts are useful for identifying simple issues before submission to code review. We run our hooks on every commit to automatically point out issues in code such as: missing semicolons, trailing whitespace, mixed line ending, debug statements.

By pointing these issues out before code review, this allows a code reviewer to focus on the architecture of a change while not wasting time with trivial style nitpicks.

# Pre-commit framework

This quote comes straight from the [pre-commit website](https://pre-commit.com/#intro):

---

 *It is a multi-language package manager for pre-commit hooks. You specify a list of hooks you want and pre-commit manages the installation and execution of any hook written in any language before every commit. pre-commit is specifically designed to not require root access. If one of your developers doesn’t have node installed but modifies a JavaScript file, pre-commit automatically handles downloading and building node to run eslint without root.*

 ---

# Minimal pre-commit setup

Pre-commit framework is an python package residing on the official [Pypi server](https://pypi.org).

- ``.pre-commit-config.yaml`` inside the repo
- ``pip install pre-commit`` or [equivalent](https://pre-commit.com/#install)
- ``pre-commit install``

Once done, the hooks configured in the pre-commit config file will run on each commit and check the files which are in the changeset. If any of the hooks fails during the commit, the commit itself will fail as well.

# Tox and pre-commit

There is **no need** to manually install the pre-commit framework as [tox](../tox/#What is Tox?) will automate the procedure.<br> Executing the command from the command line:
```console
tox -e lint
```
tox will create the virtual environment, install the pre-commit package and pre-commit will fire up the configured hooks/plugins in the ``.pre-commit-config.yaml``.

Moreover, integration of the pre-commit framework inside ``tox`` simplifies the **CI/CD pipeline**, it is a one-shot operation whenever someone from the team is **pushing** code to the remote repository. In such case Jenkins will build and execute the pre-commit framework.

# Add a new pre-commit plugin

Pre-commit framework consists of many [out of the box plugins](https://pre-commit.com/hooks.html) but can be extended with [custom plugins](https://pre-commit.com/#new-hooks) written in any programming language. In order to add an new plugin/hook you need to add an new entry in the YAML list of the ``.pre-commit-config.yaml``.

An sample repository:
```yaml
repos:
     - repo: https://github.com/jorisroovers/gitlint
          rev: v0.11.0
          hooks:
              - id: gitlint
                name: GIT Linter
                description: Linter for Git commit message
                language: python
```

# References

- [pre-commit framework](https://pre-commit.com/)
- [Git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [pre-commit-is-awesome](https://blog.jerrycodes.com/pre-commit-is-awesome/)
