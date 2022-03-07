# What is Cmder?

Cmder is portable console emulator for **Windows** only. It combines the console emulator, [ConEmu](https://conemu.github.io/)
with cmd enhacements from [Clink](http://mridgers.github.io/clink/) and Git support from [mysysgit](https://github.com/msysgit/msysgit/releases). In short, it is the one command prompt you'll ever want to use.

# Why Cmder?

Cmder comes out of the box with the following features:

- Git for Windows
- SSH agent
- Alias for commands
- Unix commands
- Multi-tabs (Ctrl+T)
- Portable

# How to install

In order to install the latest version of Cmder you need to download the *mini* or the *full* version from [here](https://cmder.net/). There is no need to go directly to the official web site because Cmder is already included in the Chocolatey ``chocolatey.config`` xml manifest.

# How to configure

Cmder is fully customizable, the installation path (*assuming that has been installed through Chocolatey*) can be found under: ``C:\tools\Cmder``. Under the installation path there is an folder ``config`` where we can defined user specific settings. Inside this folder there are two configurations files: ``user_aliases.cmd`` and ``user_profile.cmd``.

In brief:

- ``user_aliases.cmd`` : User specific aliases in cmd.
- ``user_profile.{cmd|sh|ps1}`` : User specific startup commands.

Before we start using the Cmder we need to **remove** the Windows *OpenSSH* version from the system ``PATH`` (Windows comes with their own version of OpenSSH):

```text
$ which ssh-agent
\c\WINDOWS\SYSTEM32\OpenSSH
```

Add the following line in ``user_profiles.cmd``:

```text
set "PATH=%GIT_INSTALL_ROOT%\usr\bin;%PATH%"
```

To automatically start the ssh-agent at startup uncomment the following line in ``user_profiles.cmd``:


```text
:: uncomment this to have the ssh agent load when cmder starts
call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd" /k exit
```

Moreover, we can create an alias for the ssh private key if we want to clone any Git repository inside the virtual machine (*due to SSH forwarding*) in order to avoid repeating the same command every time:

```text
myalias=ssh-add "%USERPROFILE%\.ssh\id_rsa"
```

# Generate a new SSH key

If you don't already have an SSH key, you must generate a new SSH key in order to authenticate with any Git repository.

- Open *Cmder*
- Paste the text below, substituting in your Enterprise email address.

```console
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

This creates a new ssh key, using the provided email as a label.

```console
> Generating public/private rsa key pair.
```

- When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.

```console
> Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]
```

- At the prompt, type a secure passphrase.

```console
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

- Ensure the ssh-agent is running

```console
# start the ssh-agent in the background
$ eval $(ssh-agent -s)
> Agent pid 59566
```

- Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace **id_rsa** in the command with the name of your private key file.

```console
$ ssh-add ~/.ssh/id_rsa
```

# References

- [Cmder vs Cygwin](https://www.slant.co/versus/5488/11867/~cmder_vs_cygwin)
- [How to generate an new SSH key](https://help.github.com/en/enterprise/2.16/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Working with SSH key passphrases](https://help.github.com/en/enterprise/2.16/user/articles/working-with-ssh-key-passphrases)
- [Checking for existing SSH keys](https://help.github.com/en/enterprise/2.16/user/articles/checking-for-existing-ssh-keys)
