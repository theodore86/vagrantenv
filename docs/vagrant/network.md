# Overview

In order to access the Vagrant test machine created, Vagrant exposes some high-level networking options for things such as:

- forwarded ports (``config.vm.network "forwarded_port"``)
- connecting to a public network (``config.vm.network "private_network"``)
- creating a private network (``config.vm.network "public_network"``)

The high-level networking options are meant to define an **abstraction** that works across multiple [providers](../providers/#Overview).This means that you can take your Vagrantfile you used to spin up a VirtualBox machine and you can reasonably expect that Vagrantfile to behave the same with something like VMware.

# VirtualBox

VirtualBox is the default provider for the Vagrant test environment.When working with VirtualBox VMs is a good understanding of how networking works. In this section, we’ll discuss the most important differences between them, and their limitations when you use VirtualBox to experiment with setting up network services on a VM.

A VirtualBox VM can be assigned **4 network adapters** from the GUI (Machine > Settings > Network), and even more from the command line.

You can choose the type of adapter between:

- **Network Address Translation (NAT)**: The VM is in an isolated network and has an Internet link through a virtual gateway. There is no route from the host system to the VM, though. This is the best way to ensure your *VM has Internet access*.

![NAT interface](../img/vbnat.png "NAT interface")

- **NAT Network**: Like the previous type, but network traffic between VMs in the same NAT network is possible.


- **Bridged (Br)**: The VM gets direct access to the physical network adapter of the host system. If a DHCP server is active on the network, the VM will get an IP within the same range as the host system. For other hosts on this network, the VM appears as just another host.

![Bridged interface](../img/vbbridged.png "Bridged interface")

- **Host only (HO)**: The host system and the VM are attached to a configurable virtual network (File > Preferences > Network > Host-only Networks). You can even set up a virtual DHCP server that issues your VMs with an IP address. Consequently, network traffic between hosts and VMs is possible. However, there is no gateway to the Internet in a host-only network.
- **Internal (Int)**: VMs are attached to a virtual network, but the host system is not. There is also no gateway to the Internet, nor is DHCP provided.

![Host-Only interface](../img/vbho.png "Host-Only interface")

The table below gives an overview of the consequences of each adapter on network routing between the VM and the rest of the world.

|    Route     | NAT | HO | Br | Int |
|     ---      | --- | ---| ---| --- |
|   VM ↔ Host  |  -  |  V |  V |  -  |
|   VM ↔ VM    |  -  |  V |  V |  V  |
|   VM ↔ LAN   |  -  |  - |  V |  -  |
| VM → Internet|  V  |  - |  V |  -  |

At first sight, the *Bridged adapter* appears to be the most suitable for setting up a network service in a VM, but this is not the case.

Finally, the NAT network and internal interfaces aren’t discussed in this section, they aren’t used as often as the other ones. Be sure to read the [VirtualBox](https://www.virtualbox.org/manual/ch06.html) documentation if you want to delve deeper into the subject!

# NAT + Host-only

Limitations:

- The NAT adapter doesn’t allow you to access the VM from the host
- The host-only adapter does, but your VM doesn’t have Internet access (so installing packages is kind of hard)
- The bridged interface is too unreliable: the VM’s IP address depends on the physical LAN, if it gets one at all…

**So, no single adapter type is ideal**.

Bring up the Vagrant testing virtual machine having VirtualBox as provider you will notice that by default 2 network adapters exist:

- **Adapter 1** is attached to an NAT interface, so your VM has Internet access and can install packages from on-line repositories.
- **Adapter 2** is attached to a host-only interface, so you can access the server from the host system.

In brief, based on the Vagrant networking options:

- By default Vagrant is always set the fist adapter as *NAT*.
- Private network, adapter 2 will be an *host-only*.

# Customizations

The network customization is performed through the ``vagrant.yaml`` configuration file. In order to adapt the Vagrant networking based on our needs, another layer of abstraction has been introduced, in brief two network types are supported:

```yaml
:networks:
        - :vpn:
              :type: 'forwarded_port'
              :disabled: true
              :options:
                  - :id: 'mkdocs'
                    :guest: 8000
                    :protocol: &tcp 'tcp'
                    :host_ip: &localhost '127.0.0.1'
                    :host: 8000
                    :auto_correct: true
                  - :id: 'rfdocs'
                    :guest: 8010
                    :protocol: *tcp
                    :host_ip: *localhost
                    :host: 8010
                    :auto_correct: true
                  - :id: 'reports'
                    :guest: 8080
                    :protocol: *tcp
                    :host_ip: *localhost
                    :host: 8080
                    :auto_correct: true
                  - :id: 'vault'
                    :guest: 8200
                    :protocol: *tcp
                    :host_ip: *localhost
                    :host: 8200
                    :auto_correct: true
        - :lan:
              :type: 'private_network'
              :disabled: false
              :options:
                  - :type: 'static'
                    :ip: '172.16.0.2'
                    :netmask: '255.255.255.252'
                    :nic_type: 'virtio'
                    :hostsupdater: 'no_skip'
```

- **VPN - Cisco Anyconnect**: This network must be enabled when we are connecting to our test environment through the **SSL/TLS Cisco Anyconnect client** (split tunnelling is not enabled). Any service of the guest machine is accessible through the **localhost**. The main restriction of this network option is the limited *service accessibility*. Any new service requires **an new port forwarding rule** to be added to the existing list of rules.

Assuming that we want to access our newly installed web app:

```yaml
:networks:
        - :vpn:
              :type: 'forwarded_port'
              :disabled: true
              :options:
                  - :id: 'mkdocs'
                    :guest: 8000
                    :protocol: 'tcp'
                    :host_ip: '127.0.0.1'
                    :host: 8000
                    :auto_correct: true
                  # Start of port forwarding rule
                  - :id: 'my-web-app'
                    # This is the web app service port inside the VM.
                    :guest: 8443
                    :protocol: 'tcp'
                    :host_ip: '127.0.0.1'
                    # This is the web app service port from the host system.
                    :host: 8440
                    :auto_correct: true
```

So, the web app is now accessible from the host system through the URL:

```text
http://localhost:8440
```

- **LAN - Office**: This network must be enabled when we are directly connected to our office premises. Any service of the guest machine is accessible without any restriction. Moreover, using the [vagrant-goodhosts](https://github.com/goodhosts/vagrant) plugin there is no need to know the private ip address of the guest machine but we can point to any service using the virtual machine hostname:

```yaml
:host:
    :name: 'TestVM'
```

The boolean value of the ``:disabled:`` key controls which of the two networks will be active. Only **one network** could be active in any given time. If for example the ``:disabled:`` key value is being set to ``true`` for both networks then only the first network from the YAML list will be active.

# References

- [vagrant-networking](https://www.vagrantup.com/docs/networking/)
- [virtualbox-networking-an-overview](http://bertvv.github.io/notes-to-self/2015/09/29/virtualbox-networking-an-overview/)
- [vagrant-networking-explained](https://blog.jeffli.me/blog/2017/04/22/vagrant-networking-explained/)
