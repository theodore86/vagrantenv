# Intranet access control

## Accessing the project source code

Before you begin working with the (*vagrant*) Sandbox it is **mandatory** to authenticate yourself in order to *clone* the project source code.

1. Request membership to [vagrantenv](https://github.com/theodore86/vagrantenv) project.

## Network connectivity.

#### Internet resources

If you have already clone the project source code and your laptop has internet access, installation and provisioning is straighforward:

1. Edit the ``vagrant.yaml`` configuration file and override the default **system** proxy settings:

```yaml
        :system:
            :enabled: false
```

2. Build and provision the (*vagrant*) Sandbox.

```console
vagrant up
```
