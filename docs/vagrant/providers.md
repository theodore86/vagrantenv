# Overview

While Vagrant ships out of the box with support for [VirtualBox](https://www.virtualbox.org/), [Hyper-V](https://azure.microsoft.com/en-us/?ocid=cloudplat_hp), and [Docker](https://www.docker.com/), Vagrant has the ability to manage other types of machines as well. This is done by using other providers with Vagrant.

Alternate providers can offer different features that make more sense in your use case. For example, if you are using Vagrant for any real work, [VMware](https://www.vmware.com/) providers are recommended since they're well supported and generally more stable and performant than VirtualBox.

Before you can use another provider, you must install it. Installation of other providers is done via the [Vagrant plugin system](../plugins).

# Installation

Providers are distributed as Vagrant plugins, and are therefore installed using standard [plugin installation steps](../plugins/#How to interact). After installing a plugin which contains a provider, the provider should immediately be available.

# Supported

Vagrant supports an variety of providers:

- [vagrant-libvirt](https://github.com/pradels/vagrant-libvirt)
- [vagrant-aws](https://github.com/mitchellh/vagrant-aws)
- [vagrant-vmware-esxi](https://github.com/josenk/vagrant-vmware-esxi)
- [vagrant-azure](https://github.com/MSOpenTech/Vagrant-Azure)
- [vagrant-openstack](https://github.com/mat128/vagrant-openstack)
- [vagrant-openstack-provider](https://github.com/ggiamarchi/vagrant-openstack-provider)
- [vagrant-rackspace](https://github.com/mitchellh/vagrant-rackspace)
- [vagrant-digitalocean](https://github.com/smdahlen/vagrant-digitalocean)
- [vagrant-google](https://github.com/mitchellh/vagrant-google)
- [vagrant-vcenter](https://github.com/gosddc/vagrant-vcenter)
- [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)
- [vagrant-docker (integrated into Vagrant 1.6+)](https://github.com/fgrehm/docker-provider)
