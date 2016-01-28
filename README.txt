Einrichten der Entwicklungsumgebung:
====================================

Die Entwicklungs-VM wird mit Vagrant verwaltet. Die aktuelle Version
findest Du hier: https://www.vagrantup.com/downloads.html
Die Entwicklungs-VM startest Du mit:

       vagrant up	

Die MySQL Datenbank in der Vagrant VM ist
vom Host aus erreichbar unter:
  
       Host:     localhost
       Port:     3308

       DB         Login      Passwort
       ------------------------------
        	                root       mysql
       devdb      devdb   devdb

Features:
=========

 - Dateien, die geschrieben werden erscheinen
   in log/htdocs

 - Log Dateien des Apache und emails erscheinen in
   log/logs

 - Das log Verzeichnis kann mit dem Skript
   scripts/clean-log.sh aufgeraeumt werden.


Tipps:
======

 - Apache restart:
   vagrant ssh -- sudo apache2ctl restart

 - Aufräumen des log/ Verzeichnis:
   a) scripts/clean.log-sh
   b) git clean -fdx log
      vagrant ssh -- sudo /etc/init.d/overlayfs restart

 - Alle Schreibzugriffe die Du in /src/main/php erwarten
   würdest werden nach log/htdocs umgelenkt.
   

Beobachtung von Fehlermeldungen
===============================

 - Apache logs:
   - log/logs/access.log
   - log/logs/errror.log

 - Mails:
   - log/logs/sendmail-*

 - letzter_fehler.txt:
   - log/htdocs/includes/letzter_fehler.txt
