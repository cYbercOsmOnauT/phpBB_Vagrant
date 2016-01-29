Prerequisites:
===

The devsystem is managed by [Vagrant](https://www.vagrantup.com). The newest version can be downloaded [here](https://www.vagrantup.com/downloads.html).

Vagrant needs [Virtualbox](https://www.virtualbox.org). You can download it [here](https://www.virtualbox.org/wiki/Downloads).

To boot the devsystem just simply open a terminal inside the project root and type `vagrant up`.


Devsystem:
===
- You can reach the MySQL Database of the Vagrant VM with:

        Host:     localhost
        Port:     3308

        DB            Login           Passwort
        --------------------------------------
                      root            mysql
        devdb         devdb           devdb

- FTP-Access is not needed because all saves inside the *work directory* is automatically inside the *Docroot* of the VM.

- XDebug is provided on **Port *9000*** with **Remote Connect back** and the **IDEKey *Vagrant***


Hints:
===

 - Apache restart:
    - `vagrant ssh -- sudo apache2ctl restart`
    - `vagrant ssh -- sudo service apache2 restart`

 - Cleaning the **log/** directory:
    - `scripts/clean.log-sh`
    - `git clean -fdx log`
	- `vagrant ssh -- sudo /etc/init.d/overlayfs restart`
	- `vagrant ssh -- sudo service overlayfs restart`

 - All write accesses inside **Docroot** are redirected to **log/htdocs**.
   

Logfiles and Mails:
===

 - Apache logs:
    - log/logs/access.log
	- log/logs/errror.log

 - Mails:
		- log/logs/sendmail-*