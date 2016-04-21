`wget -O -  http://fh-hfv-git01.hf.brnet.int/sigmundd/vks-control/blob/master/install.sh | bash`

# VKS-Control

Eine node.js-Applikation, die es Usern erlaubt, Ihnen erlaubte Quellen und Senken zu verbinden. Im Hintergrund werden CAN-Commandos verwendet, um die Schaltungen vorzunehmen.

Diese Applikation wird benötigt um die Videkreuzschienen für Bayern 1, Bayern 3 und das trimediale Studio Schwaben in Augsburg zu steuern.

## backend

### application
Aufgebaut mit node.js.
Hat 3 Aufgaben:
- Anzeige der Webseiten für User und Admin
- Absetzen der CAN-Commandos
- Empfangen der CAN-Commandos

Für User-Datenbank und CAN werden eigene Module (Klassen in node.js-Sprech) erstellt.

#### users
config.json->userFolder
Class User:
```js
{
	id:"hash",
	login:"string",
	pwd:"bcrypt-string",
	admin:"bool",
	defined: {
		senken:[], //Array with numbers
		quellen:[] //Array with numbers
	},
	current: [
		{
			senke:"int",
			quelle:"int"
		},
		...
	],
	load(id),
	save(),
	delete(),
	User([id])
}
```
Class UserList:
```js
{
	users:[],
	getUser(id),
	updateUser(id, User),
	save([id]),
	addUser(),
	deleteUser(id)
}
```

#### can
Eigene Lib zum parsen mit custom binaries von Helmut:
* candump (liest Meldungen)
* cansend (schickt Meldungen)

Meldungen, die mit ID C0C3 starten, sind Schaltungen.
Senden mit ID#Daten

Beim Hochfahren des Servers senden wir den Befehl ????????? um alle Schaltungen zu bekommen.


### database
Es gibt keine echte Datenbank, einzig die User werden in einzelnen JSON-Dateien gespeichert.

Beim Hochfahren des Servers werden die Daten in-Memory geladen.
Die Current-Configuration wird dann überschrieben, da die gespeicherte ungültig ist.

Aufbau eines user-JSONS:
```json
{
	id: "hash",
	login:"string",
	pwd:"bcrypt-string",
	admin:"bool",
	defined: {
		senken:[], //Array with numbers
		quellen:[] //Array with numbers
	},
	current: [
		{
			senke:"int",
			quelle:"int"
		},
		...
	]
}
```

## frontend

### user
Das Frontend wird mit Bootstrap einfach aufgebaut.
Der User loggt sich ein, um dann in einer einfachen Tabelle zu seinen Senken die Quellen auswählen zu können.
Demo: http://www.codeply.com/go/LPycyajpLw

Die Checkbox unten deaktiviert die "Speichern"-Buttons und erlaubt ein direktes umschalten.

Nach der Auswahl einer Quelle (bzw dem Speichern) erscheint in der Mitte statt dem Pfeil ein Ladebalken, der erst wieder zum Pfeil wird, wenn die Quelle geschalten ist.

### admin
Auf der Admin-Webseite können:
- User angelegt werden
- User bearbeitet werden
	- Änderung Login
	- Änderung Admin-Status
	- Zurücksetzen Passwort
	- Definieren der erlaubten Senken / Quellen

## tests / docs
Tests und Dokumentation werden im Projekt gehalten und beim erstellen auf dem Zielsystem erzeugt.


---
remove below this

# TODO

## Backend
* modules
* package scripts
	* deploy
		* canutils make
		* jade to html
		* less to css
		* minify js
		* minify css
		* copy all to public
	* test
	* docs
* server
* database
* routes

## Frontend
* bower component
* basic structure
* controller
* templates
*
