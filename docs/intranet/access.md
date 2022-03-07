# Intranet access control

## Accessing the project source code

Before you begin working with the (*vagrant*) TestVM it is **mandatory** to authenticate yourself in order to *clone* the project source code.

1. Request membership to [vagrant-e2e](https://gitlab.athmg.eecloud.dynamic.nsn-net.net/e2e/e2e-vagrant) project.

## Network connectivity.

#### Internet resources

If you have already clone the project source code and your laptop has internet access, installation and provisioning is straighforward:

1. Edit the ``vagrant.yaml`` configuration file and override the default **system** proxy settings:

```yaml
        :system:
            :enabled: false
```

2. Build and provision the (*vagrant*) TestVM.

```console
vagrant up
```

#### Intranet access

If you are connected to intranet **LAN** or **VPN*, accessing the coorporate resources requires to perform authentication (intranet credentials) on:

1. [GR-Athens - Site main firewall](http://10.85.55.218/) - ```mandatory```
2. [fw.athmg.eecloud.dynamic.nsn-net.net](ssh://fw.athmg.eecloud.dynamic.nsn-net.net) testing team intra firewall - ```mandatory```.
3. [Espoo firewall](https://cloudlogin.espoo.nsn-rdnet.net/) for the internal *PYPI* repository access - ```mandatory```.
4. [Tampere firewall](https://logintolabra.tre.noklab.net/dana-na/auth/url_5/welcome.cgi) for *SRN vHSS* access- ```optional```.
5. [GitLab project access](http://baltehwrtb01.lab.sk.alcatel-lucent.com/), for *GitLab* actions - ```mandatory```.
