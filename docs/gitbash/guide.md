# What is Git Bash?

Git Bash is an application for Microsoft Windows environments which provides an emulation layer for a Git command line experience. Bash is an acronym for Bourne Again Shell. A shell is a terminal application used to interface with an operating system through written commands. Bash is a popular default shell on Linux and macOS. Git Bash is a package that installs Bash, some common bash utilities, and Git on a Windows operating system.

# Why Git Bash?

Git Bash some of his advantages are:

- Lightweight.
- Contains ``bash`` and a collection of basic other *nix utilities.
- Faster than [Cmder](../../cmder/guide).
- Highly configurable.
- Easy to use.

# How to install

Git Bash comes included as part of the [Git For Windows package](https://gitforwindows.org/). Download and install Git For Windows like other Windows applications. Once downloaded find the included .exe file and open to execute Git Bash.

# How to configure

Git Bash simulates an linux environment in such case you can configure through:

- ``~/.bashrc`` or ``~/.profile``
- ``~/.bash_aliases``.

You can run the *ssh-agent* automatically when you open bash or Git shell.
Copy the following lines and paste them into your ``~/.profile`` or ``~/.bashrc`` file in Git shell:

```console
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
```

If your private key is not stored in one of the default locations (like ``~/.ssh/id_rsa``), you'll need to tell your SSH authentication agent where to find it

# References

- [Git for Windows](https://github.com/git-for-windows/git/wiki)
- [Working with SSH key passphrases](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/working-with-ssh-key-passphrases#auto-launching-ssh-agent-on-git-for-windows)
