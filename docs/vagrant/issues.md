# Overview

This page lists some common issues people run into with Vagrant and VirtualBox as well as solutions for those issues.

# Issues

### SSH forwarding agent not working
------------------------------------

On Windows when SSH agent forwarding (``config.ssh.forward_agent=true``) is enabled private key forwarding will only work for the **vagrant ssh** actions but not for the **vagrant provision** or ``config.vm.provision`` (keys from agent are not visible) due to the fact that [net-ssh](https://github.com/net-ssh/net-ssh ruby) is being used by the **vagrant provision** command in contrast to **vagrant ssh** command which uses the OpenSSH client.

!!! info "Workaround"
    *vagrant provision* command and SSH private key forwarding on Windows will only work if the SSH private key is loaded through [Pageant](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).

- References:
    - [net-ssh doesn't work with ssh-agent on Windows](https://github.com/net-ssh/net-ssh/issues/754)
    - [Pageant is the only option on Windows](https://github.com/net-ssh/net-ssh/issues/192)
    - [SSH agent forwarding does not work with provisioner on Windows](https://github.com/hashicorp/vagrant/issues/1735)

### Goodhosts plugin permissions error
--------------------------------------

If you install the [vagrant-goodhosts](https://github.com/goodhosts/vagrant) (installed by default unless removed from plugins in your `vagrant.yaml`) you might get a permissions error when Vagrant tries changing the hosts file. On a macOS or Linux workstation, you're prompted for a `sudo` password so the change can be made, but on Windows, you have to do one of the following to make sure hostsupdater works correctly:

1. Run PowerShell or whatever CLI you use with Vagrant as an administrator. Right click on the application and select 'Run as administrator', then proceed with `vagrant` commands as normal.

2. Change the permissions on the hosts file so your account has permission to edit the file (this has security implications, so **it's best to use option 1** unless you know what you're doing). To do this, open `%SystemRoot%\system32\drivers\etc` in Windows Explorer, right-click the `hosts` file, and under Security, add your account and give yourself full access to the file.

### Symbolic links in a shared folder permission error.
-------------------------------------------------------

**On Windows** creating symbolic links in a shared folder will fail with a permission or protocol error.

There are two parts to this:

1. VirtualBox does not allow guest VMs to create symlinks in synced folders by default.
2. Windows does not allow the creation of symlinks unless your local policy allows it. Even if local policy allows it, many users experience problems in the creation of symlinks.

Using Ubuntu bash under Windows 10 *can* make this easier, but there are still issues when creating and managing symlinks between the bash environment and the guest Vagrant operating system.

- References:
    - [TechNet](https://technet.microsoft.com/en-us/library/dn221947%28v=ws.10%29.aspx)

### "Authentication failure" on vagrant up
------------------------------------------

On **Windows** you may encounter authentication failure once the VM is booted (e.g. *Sandbox: Warning: Authentication failure. Retrying...*).

To fix this, do the following:

1. Delete `~/.vagrant.d/insecure_private_key`
2. Run `vagrant ssh-config`
3. Restart the VM with `vagrant reload` command.

- References:
    - [drupalvm-issue-170](https://github.com/geerlingguy/drupal-vm/issues/170)

### Ansible version check in provisioner does not work
------------------------------------------------------

[Ansible](https://pypi.org/project/ansible) package includes the [ansible-base](https://pypi.org/project/ansible-base) and [ansible-community](https://pypi.org/user/ansible-community), the *version* parameter in the ```vagrant.yaml``` for the ansible provisioner specifies the requested version of the *ansible* python package but the output of the command ```ansible --version``` displays the version of the *ansible-base*.

- References
    - [vagrant-issue-12204](https://github.com/hashicorp/vagrant/issues/12204)
