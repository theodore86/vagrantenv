# How to


If you run into issues with Vagrant enabling logging can display helpful information in order to troubleshoot your issues. To enable logging the ``VAGRANT_LOG`` environment variable must be set to the desired log level name, such as ``INFO`` or ``DEBUG``. For example on Linux systems:

```console
$ VAGRANT_LOG=INFO vagrant up
```

On Windows you must use ``set`` to set an environmental variable:

```console
> set VAGRANT_LOG=INFO
> vagrant up
```

Users are encouraged to start with ``INFO`` level, as it adds a significant amount of additional information over the default output without becoming unreadable.
