# Overview

Synced folders enable Vagrant to sync a folder on the host machine to the guest machine, allowing you to continue working on your project's files on your host machine, but use the resources in the guest machine to compile or run your project.

By default, Vagrant will share your project directory to ``/vagrant``.

# Options

- **NFS**
    - Requires ``nfsd`` support inside the guest machine.
    - NFS folders do not work on Windows hosts. Supports Linux and OS X host machines.
    - Plugin for [NFS support on Windows](https://github.com/winnfsd/vagrant-winnfsd).
- **SMB**
    - Requires ``samba samba-common cifs-utils`` support inside the guest machine.
    - To use the SMB synced folder type on a Windows host, the machine must have PowerShell version 3 or later installed.
    - Requires authentication.
    - on Windows hosts only.
- **Rsync**
    - Requires ``rsync`` to be installed on the host machine.
    - Vagrant automatically install ``rsync`` on the guest machine.
    - One-time sync from the host machine to the guest machine.
    - Supports **Auto-syncing** - ``vagrant rsync-auto``.
    - Unline NFS or VM shared folders, filesystem permissions are not tampered with in the guest machine.
    - Cross-platform alternative for Windows host machines.
    - Fastest option.
    - Sync from guest to host machine is possilbe through [vagrant-rsync-back](https://github.com/smerrill/vagrant-rsync-back)
- **VirtualBox's native shared folder** (*vboxsf*)
    - Simpliest solution.
    - Requires administration privileges in case of symlinks.
    - Bidirectional sync.
    - Loussy performance.

# Folders

Customization of the Vagrant synced/shared folders is achieved through the ``vagrant.yaml``.

```yaml
:synced_folders:
        - :src: '.'
          :dest: '/vagrant'
          :options:
              :disabled: true
        - :src: '.'
          :dest: '/shared'
          :options:
              :create: true
              :mount_options: ['dmode=774', 'fmode=664']
              :id: 'shared-root'
        - :src: '~/ws'
          :dest: '/ws'
          :options:
              :create: true
              :mount_options: ['dmode=774', 'fmode=774']
              :id: 'workspace'
```

Supported options are:

- ``:src:`` Absolute or relative path to a directory on the host machine.
    - If the path is relative, it is relative to the project root.
- ``:dest:`` Absolute path of where to share the folder within the guest machine.
    - This folder will be created (recursively, if it must) if it does not exist.
- ``:options:`` Optional parameters when configuring synced folders.
    - ``:disabled:`` If true, this synced folder will be disabled and will not be setup.
    - ``:create:`` If true, the host path will be created if it does not exist.
    - ``:mount_options:`` A list of additional mount options to pass to the *mount* command.
    - ``:id:`` The name for the mount point of this synced folder in the guest machine.

By default Vagrant will always share your project directory to ``/vagrant``.<br>
For security reasons this option is **disabled**.

- Project directory on host machine is shared under ``/shared`` directory in guest machine.
- The user workspace will be shared under ``/ws`` directory in guest machine.
