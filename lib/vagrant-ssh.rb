# The module serves only as a namespace for SSH settings of Vagrant itself.

module Ssh
    extend self

    @@config = nil

    def configure(config, settings)
        set_config(config)
        options(settings)
    end

    def set_config(value)
        @@config = value
    end

    def config
        @@config
    end

    private

    def options(options = {})
        options.each_key do |key|
            eval "config.ssh.#{key} = options[key]"
        end
    end
end
