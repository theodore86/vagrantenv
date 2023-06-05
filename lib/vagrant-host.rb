# Host settings are derived from the YAML configuration file.
# The module serves only as a namespace for Host operations.

require_relative 'vagrant-utils'

module Host
    extend self

    def synced_folders(vm, host)
        return unless host.key?(:synced_folders)

        folders = host[:synced_folders]
        folders.each do |folder|
            vm.synced_folder folder[:src], folder[:dest], folder[:options]
        end
    end

    def shell_provision(vm, host)
        return unless host.key?(:provisioners)

        provisioners = host[:provisioners]
        return unless provisioners.key?(:shell)

        shells = provisioners[:shell]
        shells.each do |shell|
            if shell.key?(:options)
                options = shell[:options]
                if options[:path].is_a?(Array)
                    path = File.join(options[:path])
                    options[:path] = Utils.expand_host_path(path)
                end
            end
            vm.provision shell[:name], **shell[:options]
        end
    end

    def file_provision(vm, host)
        return unless host.key?(:provisioners)

        provisioners = host[:provisioners]
        return unless provisioners.key?(:file)

        files = provisioners[:file]
        files.each do |file|
            if file.key?(:options)
                options = file[:options]
                if options[:source].is_a?(Array)
                    src = File.join(options[:source])
                    options[:source] = Utils.expand_host_path(src)
                end
            end
            vm.provision file[:name], file[:options]
        end
    end

    def networking(vm, host)
        return unless host.key?(:networks)

        nets = host[:networks]
        return if nets.empty?

        nets.each do |net|
            data = net.values[0]
            next unless data.key?(:disabled)

            next if data[:disabled]

            next unless data.key?(:options)

            options = data[:options]
            options.each { |opts| vm.network data[:type], **opts }
        end
    end

    def ansible_provision(vm, host)
        return unless host.key?(:provisioners)

        provisioners = host[:provisioners]
        return unless provisioners.key?(:ansible)

        ansible = provisioners[:ansible]
        name = ansible.fetch(:name, 'ansible')
        opts = ansible.fetch(:options, {})
        paths = [:inventory_path, :provisioning_path, :playbook, :extra_vars]
        paths.each do |path|
            if opts[path].is_a?(Array)
                filepath = File.join(opts[path])
                opts[path] = filepath
            end
        end
        vm.provision name, **opts
    end

    def disks(vm, host)
        return unless host.key?(:disks)

        disks = host[:disks]
        return unless disks.is_a?(Array)

        disks.each_with_index do |disk, index|
            next unless disk.key?(:type)

            type = disk[:type].to_s.to_sym
            opts = disk.fetch(:options, {})
            opts[:name] ||= "storage-#{index}"
            vm.disk type, **opts
        end
    end

    def post_up_message(vm, host)
        return unless host.key?(:name)

        msg = "#{host[:name]} has been successfully deployed:)"
        msg << "\n* You can SSH into the machine with `vagrant ssh`."
        vm.post_up_message = msg
    end
end
