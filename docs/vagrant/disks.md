# Overview

Vagrant Disks is a feature that allows users to define what mediums should be attached to their guests, as well as allowing users to **resize** their primary disk.

# Supported providers

Currently, only **VirtualBox** is supported. Please refer to the [VirtualBox documentation](https://developer.hashicorp.com/vagrant/docs/disks/virtualbox) for more information on using disks with the VirtualBox provider!

# Customizations

This feature requires the following environmental flag to be used:

```console
export VAGRANT_EXPERIMENTAL="disks"
```

!!! info "Reload Vagrant"
    You will need to reload vagrant from the command line for resizing to take affect.

Multiple disks can be added in the ``vagrant.yaml`` configuration file but only the disk with the ``:primary: true``
option is what tells to vagrant to *expand* the guests main drive. Without this option, vagrant will instead attach a *new*
disk to the guest.

```yaml
:host:
    :disks:
        - :type: 'disk'
          :options:
              :primary: true
              :size: '80GB'
        - :type: 'disk'
          :options:
              :size: '40GB
```

- If Vagrant is provisioned for the first time the [local ansible provisioner](../vagrant/provisioners.md#local-ansible-provisioner) will take care of the logical volume and filesystem resizing.
- If Vagrant is **already provisioned** then you will need to execute:

```console
vagrant provision --provision-with sandbox
```

or

from inside the Vagrant box:

```console
cd /shared/provisioners/ansible
ansible-playbook -i inventory.yml playbook.yml --tags resize_disk
```

Supported options are:

- ``type``: The kind of the disk type, current accepts:

    - *disk*
    - *dvd*
    - *flopppy*

- ``options``:
    - ``primary``: Configures disk to be the *primary* disk t o manae on the guest.
    - ``size``: The size of the disk to create. For example *10GB*. Not used for type *dvd*.

# Limitations

- Disks can only be **increased** in size. There is no facility to shrink a disk.
- Depending on the guest, you may need to resize the partition and the filesystem</br>from within the guest.
- Vagrant attaches all new disks defined to guests's primary controller. As of Virtualbox *6.1.x*</br>
  storage controllers have the following limits to the number of disks that are supported per guest:

    - IDE Controllers: 4
    - SATA Controllers: 30
    - SCSI Controllers: 16

# References

- [vagrant-disks](https://developer.hashicorp.com/vagrant/docs/disks)
- [vagrant-disksize-plugin](https://github.com/sprotheroe/vagrant-disksize)
- [increasing-disk-space-vagrant-box](https://marcbrandner.com/blog/increasing-disk-space-of-a-linux-based-vagrant-box-on-provisioning/)
