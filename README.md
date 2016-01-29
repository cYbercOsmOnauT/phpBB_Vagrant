Prerequisites:
===

The devsystem is managed by [Vagrant](https://www.vagrantup.com). The newest version can be downloaded [here](https://www.vagrantup.com/downloads.html).

Vagrant needs [Virtualbox](https://www.virtualbox.org). You can download it [here](https://www.virtualbox.org/wiki/Downloads).

To boot the devsystem just simply open a terminal inside the project root and type `vagrant up`. If a commit tells you to *Provision* type `vagrant provision`. 

Devsystem:
===
- You can reach the *MySQL Database* of the Vagrant VM with:

        Host:     localhost
        Port:     3308

        DB            Login           Passwort
        --------------------------------------
                      root            mysql
        devdb         devdb           devdb

- *FTP access* is not needed because all saves inside the *work directory* is automatically inside the *Docroot* of the VM.

- *XDebug* is provided on **Port *9000*** with **Remote Connect back** and the **IDEKey *Vagrant***

- Last but not least: You can reach the VM inside your browser with <http://local.web-coding.eu> or <http://www.local.devsystem.com> if you don't want to use my DNS server and know how to edit `/etc/hosts` and set `www.local.devsystem.com` to `192.168.99.99` - _https_ is also provided with a selfsigned certificate

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
 - All mails sent by *sendmail* are saved as textfiles inside **log/logs/**
   

Logfiles and Mails:
===

 - Apache logs:
    - log/logs/access.log
	- log/logs/errror.log

 - Mails:
		- log/logs/sendmail-*
		
How to reset the development system:
===

	- Delete everything inside *src/devsystem/work*
	- Copy the contents of *src/devsystem/vanilla* into it
	- Type `vagrant destroy` to destroy the VM.
	- Type `vagrant up` to make Vagrant create a complete new VM.