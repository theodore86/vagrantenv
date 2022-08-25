# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/vagrant-host'
require_relative 'lib/vagrant-ssh'
require_relative 'lib/vagrant-utils'
require_relative 'lib/plugins/vagrant-proxy'
require_relative 'lib/plugins/vagrant-goodhosts'
require_relative 'lib/plugins/vagrant-vbguest'
require_relative 'lib/providers/vagrant-vb'

PROJECT_PATH = File.dirname(File.expand_path(__FILE__))
VCONFIG = Utils.load_config(File.join(PROJECT_PATH, 'vagrant.yaml'))

Vagrant.require_version ">= #{VCONFIG[:min_required_version]}"

Utils.ensure_plugins(VCONFIG[:plugins])

HOST = VCONFIG[:host]
SSH = VCONFIG[:ssh]

Vagrant.configure('2') do |config|
    #-- Vagrant SSH settings --#
    Ssh.configure(config, SSH)

    #-- ProxyConf plugin settings --#
    Proxy.configure(config, HOST) if Vagrant.has_plugin?('vagrant-proxyconf')

    #-- GoodHosts plugin settings --#
    GoodHosts.configure(config, HOST) if Vagrant.has_plugin?('vagrant-goodhosts')

    #-- VirtualBox Guest Additions plugin --#
    VbGuest.configure(config, HOST) if Vagrant.has_plugin?('vagrant-vbguest')

    #-- VM Settings --#
    config.vm.define HOST[:name] do |node|
        #-- Box Settings --#
        node.vm.box = HOST[:box]
        node.vm.box_url = HOST[:box_url]
        node.vm.box_check_update = HOST[:box_update]
        node.vm.hostname = HOST[:name]
        node.vm.boot_timeout = HOST[:boot_timeout]

        #-- Provider Settings --#
        node.vm.provider 'virtualbox' do |vb|
            vb.gui = HOST[:gui]
            vb.name = HOST[:name]
            VirtualBox.resources(vb, HOST)
            VirtualBox.modify_vm(vb, HOST)
            VirtualBox.guest_property(vb, HOST)
        end

        #-- Networking --#
        Host.networking(node.vm, HOST)

        #-- Shared Folders --#
        Host.synced_folders(node.vm, HOST)

        #-- File Provisioners --#
        Host.file_provision(node.vm, HOST)

        #-- Shell Provisioners --#
        Host.shell_provision(node.vm, HOST)

        #-- Local Ansible Provisioner -- ##
        Host.ansible_provision(node.vm, HOST)

        #-- Post up message --#
        Host.post_up_message(node.vm, HOST)
    end
end
