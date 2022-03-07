# Module for Vagrant configuration operations.

require 'English'
require 'pathname'
require 'yaml'

module Utils
    extend self

    HOST_OS = RbConfig::CONFIG['host_os']

    def project_root_path
        root_path = PROJECT_PATH if defined?(PROJECT_PATH)
        root_path ||= Dir.pwd
        return Pathname.new(root_path).expand_path
    end

    def expand_host_path(path)
        Pathname.new(path).absolute? ? path : project_root_path.join(path).to_s
    end

    def raise_msg(msg)
        raise Vagrant::Errors::VagrantError.new, msg
    end

    def load_config(config_file)
        raise_msg "Configuration file #{config_file} not found!" unless File.exist?(config_file)
        return YAML.load_file(config_file)
    end

    def cpus
        cpus = -1
        begin
            if HOST_OS =~ /darwin/
                cpus = `sysctl -n hw.ncpu`.to_i
            elsif HOST_OS =~ /linux/
                cpus = `nproc`.to_i
            elsif HOST_OS =~ /mswin|mingw|cygwin/
                cpus = `wmic cpu Get NumberOfCores`.split[1].to_i
            end
        rescue Errno::ENOENT => e
            raise_msg e.to_s
        end
        return cpus
    end

    def memory
        mem = -1
        begin
            if HOST_OS =~ /darwin/
                mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024
            elsif HOST_OS =~ /linux/
                mem = `grep 'MemTotal.*kB' /proc/meminfo | grep -Eo '[0-9]+'`.to_i / 1024
            elsif HOST_OS =~ /mswin|mingw|cygwin/
                mem = `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024 / 1024
            end
        rescue Errno::ENOENT => e
            raise_msg e.to_s
        end
        return mem
    end

    def ensure_plugins(plugins)
        logger = Vagrant::UI::Colored.new
        installed = false
        plugins.each do |plugin|
            plugin_name = plugin[:name]
            plugin_version = plugin.fetch(:version, '> 0')
            manager = Vagrant::Plugin::Manager.instance
            next if manager.installed_plugins.key?(plugin_name)

            logger.warn("Installing plugin `#{plugin_name}` (#{plugin_version})")
            manager.install_plugin(
                plugin_name,
                sources: plugin.fetch(:sources, %w[https://rubygems.org/ https://gems.hashicorp.com/]),
                version: plugin_version
            )
            installed = true
        end
        return unless installed

        logger.warn('`vagrant up` must be re-run now that plugins are installed')
        exit
    end
end
