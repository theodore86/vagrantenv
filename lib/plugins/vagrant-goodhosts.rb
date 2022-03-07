# Module to add entries to your /etc/hosts on the host system.
# https://github.com/goodhosts/vagrant.
# The module servers only as a namespace for host-updater plugin operations.

module GoodHosts
    extend self

    @@config = nil

    def configure(config, host)
        set_config(config)
        updater(host[:goodhosts]) if host.key?(:goodhosts)
    end

    def set_config(value)
        @@config = value
    end

    def config
        @@config
    end

    private

    def updater(options = {})
        options.each_key do |key|
            eval "config.goodhosts.#{key} = options[key]"
        end
    end
end
