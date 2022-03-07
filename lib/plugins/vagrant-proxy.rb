# Module for Vagrant proxy configuration settings.
# https://github.com/tmatilai/vagrant-proxyconf.
# The module servers only as a namespace for proxy plugin operations.

module Proxy
    extend self

    @@http_url = ''
    @@https_url = ''
    @@config = nil

    def configure(config, host)
        set_config(config)
        return unless host.key?(:proxy)

        set_http_url(host[:proxy])
        set_https_url(host[:proxy])
        system_wide(host[:proxy])
        applications(host[:proxy])
    end

    def set_config(value)
        @@config = value
    end

    def config
        @@config
    end

    def set_http_url(options = {})
        url = 'http://'
        http = options[:http]
        if http.key?(:auth)
            token = "#{http[:user]}:#{http[:pass]}@"
            url = "#{url}#{token}"
        end
        @@http_url = "#{url}#{http[:address]}:#{http[:port]}"
    end

    def http_url
        @@http_url
    end

    def set_https_url(options = {})
        https = options[:https]
        url_s = https[:is_supported] ? 'https://' : 'http://'
        if https.key?(:auth)
            token = "#{https[:user]}:#{https[:pass]}@"
            url_s = "#{url_s}#{token}"
        end
        @@https_url = "#{url_s}#{https[:address]}:#{https[:port]}"
    end

    def https_url
        @@https_url
    end

    private

    def system_wide(proxy = {})
        sys = proxy[:system]
        config.proxy.enabled = sys[:enabled]
        return unless sys[:enabled]

        no_proxy = sys[:no_proxy]
        no_proxy = no_proxy.compact.join(',') if no_proxy.respond_to?(:compact)
        config.proxy.no_proxy = no_proxy
        config.proxy.http = http_url
        config.proxy.https = https_url
    end

    def applications(proxy = {})
        sys = proxy[:system]
        applications = sys[:applications]
        config.proxy.enabled = applications
        applications.each_key do |application|
            eval "config.#{application}_proxy.http = http_url"
            eval "config.#{application}_proxy.https = https_url"
        end
    end
end
