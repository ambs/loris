Run `setup.py`
==============

Create a user that will own the loris application, e.g.:

```
$ sudo adduser loris
```

This user needs to have a home directory (unless you want to override it in the WSGI [`home=` directive](https://code.google.com/p/modwsgi/wiki/ConfigurationDirectives#WSGIDaemonProcess)) and the user and group name should match the `run_as_user` and `run_as_group` options in the `[loris.Loris]` section of `loris2.conf` and the `--loris-owner` and `--loris-group` options that you pass to `setup.py` (see below).

Finally, from the `loris` (not `loris/loris`) directory, run

    $ sudo ./setup.py install

with the options of your choice.

For Ubuntu 20:

    $ sudo python3 ./setup.py install

There are a bunch of flags that can be passed to `setup.py install` to customize where things wind up:


```
 --kdu-expand      Path to the Kakadu executable [Default: /usr/local/bin/kdu_expand]
 --libkdu          Path to __the directory that contains__ libkdu.so [Default: /usr/local/lib]
 --image-cache     Path to image cache directory [Default: /var/cache/loris2]
 --tmp-dir         Path to temporary directory (loris will make its temporary files and pipes here) [Default: /tmp/loris2]
 --www-dir         Path to www directory (wsgi and index file will be here) [Default: /var/www/loris2]
 --log-dir         Path to directory for logs [Default: /var/log/loris2]
 --source-images   Path to source images directory [Default: /usr/local/share/images]
 --config-dir      Where to put the config file. loris2.conf will be here after install. [Default: /etc/loris2]
 --info-cache      Path to info cache directory [Default: /var/cache/loris2]
 --loris-owner     User that will own the application and has permission to write to caches. [Default: loris]
 --loris-group     Group that will own the application and has permission to write to caches. [Default: loris]
```

All of these will be updated in the config file during deployment.

After running `setup.py`, you have to run:

    $ sudo ./bin/setup_directories.py 
    
This script will then create any directories that don't exist and set the ownership and permissions appropriately.

For Ubuntu 20:

    $ sudo python3 ./bin/setup_directories.py

The `loris2.wsgi` WSGI file should now have been created and can be found in the directory that is configured as the `www_dp` directory in the `loris2.conf` file (by default: `/var/www/loris2`).

Note again that __Kakadu is no longer installed__ by the setup script; it didn't work for too many people. You may use the copy that is bundled with Loris, provided you comply with the [terms outlined by NewSouth Innovations](http://www.kakadusoftware.com/index.php?option=com_content&task=view&id=26&Itemid=22) and this version works on your system. Either of these may well not be the case, in which case you will need to obtain a copy of Kakadu 7+ separately and may need to compile it for your system.


* * *

Proceed to [Deploy with Apache](apache.md) or go [Back to README](../README.md)
