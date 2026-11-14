# Sicherheitsrichtlinie – Maik Software-Freigaben

Dieses öffentliche Repository ist **ausschließlich** ein Auslieferungskanal für freigegebene Programm-Updates. Hier werden **keine** Quelltexte, Zugangsdaten, VPN-Profile, persönlichen Dateien oder privaten Signierschlüssel veröffentlicht.

## Fail-closed-Freigaberegeln

Ein Installationspaket darf erst als produktives Update veröffentlicht werden, wenn **alle** Punkte nachweisbar erfüllt sind:

1. Produkt-ID, Betriebssystem/Architektur, Versionsnummer und eindeutiger Paketname stimmen überein.
2. Das vollständige Release-Manifest wurde mit dem **offline verwahrten** privaten RSA-PSS-Schlüssel signiert; die App prüft es gegen den fest eingebauten öffentlichen Schlüssel.
3. Der SHA-256-Hash des vollständigen Pakets stimmt mit dem signierten Manifest überein.
4. Windows: Herausgeber-/Authenticode-Signatur und die installierte Programmidentität werden unabhängig geprüft. Android: APK-Paketname, steigender Versionscode und derselbe Android-App-Signierschlüssel wie bei der bereits installierten App werden geprüft.
5. Download und erlaubte Weiterleitungen erfolgen nur über vertrauenswürdiges HTTPS.
6. Installation in einen geprüften, app-spezifischen Ordner; **keine** frei bestimmbaren Installationspfade oder ausführbaren Skripte aus Paketen.
7. Vor Austausch: Anwendung kontrolliert beenden, Benutzerdaten getrennt und unangetastet lassen, Backup und Wiederherstellung testen.
8. Windows: Nach Startfehler Rückfall auf vorherige Programmversion; Android: nur System-Paketinstaller, kein Umgehen der OS-Signaturkontrolle.
9. Ein realer Installations-/Aktualisierungstest auf passender Plattform hat bestanden.
10. Erst danach Freigabestatus `freigegeben`; **niemals** Testbuild, Debug-APK oder unsigniertes Paket als Produktiv-Release markieren.

## Aktueller Veröffentlichungsstatus

**Keine produktiven Updates freigegeben.** Die öffentlichen Downloads bleiben leer, bis gültige Signiermittel und reproduzierbare Installationsnachweise vorhanden sind. Ein fehlender Download ist ein beabsichtigter sicherer Fehlerzustand.

## Meldung von Schwachstellen

Keine Passwörter, private Zertifikate oder Tokens in öffentliche Issues schreiben. Sicherheitsprobleme bitte über GitHubs private Meldemöglichkeit (falls aktiviert) oder einen vertraulichen, mit dem Repository-Inhaber vereinbarten Kanal melden.
