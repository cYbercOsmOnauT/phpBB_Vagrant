
Die Verzeichnisse log/hdocs und log/logs sind in die Vagrant VM
eingebelndet und vom Web-Server schreibbar.

log/logs:
- Hier legt der Apache sein Log dateien ab.
- Fake sendmail legt hier zu sendende emails ab.

log/htdocs:
Schreibzugriffe auf das Webserver Root Verzeichnis werden
hierher umgeleitet. So können Schreibzugriffe leicht beobachtet
werden. Der Webserver kann somit auch keine Dateien in src/main/php
überschreiben. Bewegtdaten sind vom Programmcode getrennt.


Werden Dateien in log/ geändert, so muss dies der Vagrant VM
mitgeteilt werden:

 vagrant ssh -- sudo /etc/init.d/overlayfs restart


Aufräumen lässt sich log/ mittels

 git clean -fdx log
 vagrant ssh -- sudo /etc/init.d/overlayfs restart

