Overview
--------
Quick and easy setup of Microsoft SQL Server 2000 Desktop Engine on Windows XP vm in VirtualBox on Mac OS X (and possibly linux, but not tested).

Installation of Microsoft SQL Server Management Studio Express.

Configures host-only adapter on the vm.


Usage
-----
clone repository and execute ```mssqlvm.sh``` or simply execute
```curl -s https://raw.github.com/twr/mssqlvm/master/mssqlvm.sh | bash```


Installation
------------
At one point VirtualBox can go full screen. When this happens press Cmd+F to go out.


Database details
----------------
If everything goes ok, it should be possible to connect to db on the vm from host using:

 * IP: 192.168.56.101,
 * port: 1433,
 * user: sa,
 * password: devadmin


Dependencies
------------
* [7-zip](http://sourceforge.net/projects/sevenzip/files/7-Zip/9.22/7z922.exe/download)
* [curl](http://curl.haxx.se/gknw.net/7.29.0/dist-w32/curl-7.29.0-rtmp-ssh2-ssl-sspi-zlib-idn-static-bin-w32.zip)
* [ievms](https://github.com/xdissent/ievms) - used to create base VM


Acknowledgements
----------------
[ievms](https://github.com/xdissent/ievms) - takes care of setting up a VM
