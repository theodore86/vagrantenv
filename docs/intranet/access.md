# Intranet access control

## Accessing the project source code

Before you begin working with the (*vagrant*) Sandbox you need to *clone* the [project source code](https://github.com/theodore86/vagrantenv).

## Network connectivity.

#### Internet access without proxy server

If you have already clone the project source code and your laptop has internet access:

* Edit the ``vagrant.yaml`` configuration file and ensure that the **system** proxy settings:

```yaml
    :proxy:
        :system:
            :enabled: false
```

* Build and provision the (*vagrant*) Sandbox.

```console
vagrant up
```

#### Internet access behind proxy server

If you are behind a (forward) proxy then you need to adjust the proxy address and application settings:

* Edit the ``vagrant.yaml`` configuration file:

```yaml
    :proxy:
        :http:
            :address: &proxy_addr '172.16.0.32'
            :port: &proxy_port 8080
        :https:
            :address: *proxy_addr
            :port: *proxy_port
            :is_supported: false
        :system:
            :enabled: false
            :no_proxy:
                - '127.0.0.1'
                - 'localhost'
            :applications:
                :apt:
                    :enabled: false
                    :skip: false
                :git:
                    :enabled: false
                    :skip: false
                :docker:
                    :enabled: false
                    :skip: false
```

Supported options are:

- ``:http(s):`` Proxy URL scheme (by default, same settings are applied for SSL/TLS).
    - ``:address:`` Proxy network address (``IPv4/IPv6``).
    - ``:port:`` Proxy network port (default: ``8080``).
- ``system:`` Proxy settings at system level.
    - ``:enabled:`` Enable or disable the system level proxy (default: ``false``).
    - ``:no_proxy:`` List of IP addresses or domain names with optional ``:port`` part to exclude.
    - ``applications:`` Proxy settings only on application level.
        - ``:apt:``
            - ``:enabled:`` Enable or disable ``apt`` proxy settings (default: ``false``)
            - ``:skip:`` Apply or remove ``apt`` proxy settings (default: ``false``)
        - ``:git:``
            - ``:enabled:`` Enable or disable ``git`` proxy settings (default: ``false``)
            - ``:skip:`` Apply or remove ``git`` proxy settings (default: ``false``)
        - ``:docker:``
            - ``:enabled:`` Enable or disable ``docker`` proxy settings (default: ``false``)
            - ``:skip:`` Apply or remove ``docker`` proxy settings (default: ``false``)

!!! note
    If you want to enable or disable the proxy settings for a specific application
    you need to ensure that the system level proxy is being set to ``false``.

* Build and provision the (*vagrant*) Sandbox.

```console
vagrant up
```

# References

- [vagrant-proxyconf plugin](https://github.com/tmatilai/vagrant-proxyconf)
- [What is a Proxy server](https://wiki.archlinux.org/title/Proxy_server)
- [Understand NO_PROXY env variable](https://about.gitlab.com/blog/2021/01/27/we-need-to-talk-no-proxy/)
