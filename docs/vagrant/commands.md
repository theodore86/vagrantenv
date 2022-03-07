# Command Line

Almost all interaction with Vagrant is via the ``vagrant`` application on the command line.
``vagrant`` has many other subcommands that are invoked through it, such as ``vagrant up``, ``vagrant halt`` and ``vagrant package``. If you run ``vagrant`` by itself, it will output all of the available commands, as well as some usage information.

# Built-in Help

You can quickly and easily get help for any given command by simply adding the ``--help`` flag to any command. This will save you the trip of comming to this documentation page most of the time.

Example:

```console
$ vagrant up --help
Usage: vagrant up [options] [name|id]

Options:

        --[no-]provision             Enable or disable provisioning
        --provision-with x,y,z       Enable only certain provisioners, by type or by name.
        --[no-]destroy-on-error      Destroy machine if any fatal error happens (default to true)
        --[no-]parallel              Enable or disable parallelism if provider supports it
        --provider PROVIDER          Back the machine with a specific provider
        --[no-]install-provider      If possible, install the provider if it isn't installed
        -h, --help                   Print this help
```
