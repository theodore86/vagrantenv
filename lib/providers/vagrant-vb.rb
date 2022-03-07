# Virtualbox customization through host yaml configuration file.
# The VirtualBox module serves as a namespace for varius operations.

require_relative '../vagrant-utils'

module VirtualBox
    extend self

    def modify_vm(provider, host)
        return unless host.key?(:customize)

        commands = host[:customize]
        commands.each do |command|
            name = command.fetch(:command, nil)
            next unless name == 'modifyvm'

            settings = command.fetch(:settings, nil)
            break unless settings

            settings.each { |s| provider.customize [name, :id] + s }
        end
    end

    def guest_property(provider, host)
        return unless host.key?(:customize)

        commands = host[:customize]
        commands.each do |command|
            name = command.fetch(:command, nil)
            next unless name == 'guestproperty'

            actions = command.fetch(:actions, nil)
            break unless actions

            actions.each do |action|
                action.each { |a, s| provider.customize [name, a.to_s, :id] + s }
            end
        end
    end

    # https://github.com/rdsubhas/vagrant-faster
    # 1/4th of memory, if you have more than 2GB RAM
    # 1/2 of the available CPU cores, if you have more than 1 CPU
    # or will simply leave the machine defaults as it is
    def resources(provider, host)
        cpus = host.key?(:cpus) ? host[:cpus] : nil
        memory = host.key?(:memory) ? host[:memory] : nil
        unless cpus
            cpus = Utils.cpus
            cpus /= 2 if cpus > 1
        end
        unless memory
            memory = Utils.memory
            memory /= 4 if memory > 2048
        end
        provider.cpus = cpus if cpus.positive?
        provider.memory = memory if memory.positive?
    end
end
