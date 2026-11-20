# JUXILO – zwei Websites, getrennte automatische Live-Uploads

## Welche Website ist welche?

| Domain | Repository-Verzeichnis | Zweck |
|---|---|---|
| `https://juxilo.de/` | `site/` | Öffentliche JX04-Vorschauseite ohne Demo-Links, App-Namen oder Screenshots |
| `https://demo.juxilo.de/` | `demo/` | Interaktive Übersicht mit allen sechs spielbaren JUXILO-Demos |

Die native Flutter-App `Wer muss?!` liegt weiterhin unter `lib/` und wird durch keinen dieser FTP-Uploads verändert.

## Einmalige GitHub-Secrets

GitHub-Repository → **Settings → Secrets and variables → Actions → New repository secret**.

Für den FTP-Zugang von **juxilo.de**:

- `JUXILO_SITE_FTP_SERVER`: FTP-Hostname aus ALL-INKL KAS (nur Hostname, ohne `ftp://`, `/...` oder `:21`)
- `JUXILO_SITE_FTP_USERNAME`: FTP-Benutzername für juxilo.de
- `JUXILO_SITE_FTP_PASSWORD`: Passwort für diesen FTP-Benutzer

Für den eigenen FTP-Zugang von **demo.juxilo.de**:

- `JUXILO_DEMO_FTP_SERVER`: FTP-Hostname aus ALL-INKL KAS
- `JUXILO_DEMO_FTP_USERNAME`: FTP-Benutzername für demo.juxilo.de
- `JUXILO_DEMO_FTP_PASSWORD`: Passwort für diesen FTP-Benutzer

**Optional:** `JUXILO_SITE_FTP_DIRECTORY` beziehungsweise `JUXILO_DEMO_FTP_DIRECTORY`, falls sich der Upload-Ordner nicht direkt im FTP-Startverzeichnis befindet. Bei FTP-Benutzern, deren Heimatverzeichnis auf das Domain-Webverzeichnis zeigt, beide Felder **weglassen**. Kein führender Slash nötig.

Die FTP-Anmeldedaten gehören ausschließlich in die GitHub-Secrets, niemals in den Repository-Code oder den Chat.

## Automatischer Live-Upload und manueller Fallback

Seit **20.11.2026** sind beide Workflows zusätzlich zu `workflow_dispatch` auf `push` für Branch `main` und den jeweiligen Dateipfad konfiguriert:

1. Änderungen unter `site/**` (oder an `.github/workflows/deploy-juxilo-site.yml`) starten automatisch den FTPS-Upload für **juxilo.de**.
2. Änderungen unter `demo/**` (oder an `.github/workflows/deploy-test.yml`) starten automatisch den FTPS-Upload für **demo.juxilo.de**.
3. Reine Änderungen an `README.md` oder Konzeptdateien starten **keinen** Upload; einzelne App-Code-Änderungen außerhalb der Webordner werden durch diese Workflows **nicht** veröffentlicht.

Für einen erneuten manuellen Upload (z. B. nach Netzwerkfehlern) bleiben beide Links verfügbar:

1. [**juxilo.de veröffentlichen**](https://github.com/tennis-schiri/wer-muss-app/actions/workflows/deploy-juxilo-site.yml) → **Run workflow**. Überträgt ausschließlich `site/`.
2. [**demo.juxilo.de veröffentlichen**](https://github.com/tennis-schiri/wer-muss-app/actions/workflows/deploy-test.yml) → **Run workflow**. Überträgt ausschließlich `demo/`.

**Wichtig:** Automatisch ausgelöst ist nicht gleich erfolgreich hochgeladen. Bei fehlenden Secrets, FTP-Problemen oder fehlgeschlagenen Checks zeigt GitHub Actions einen Fehler. Der grüne Workflow-Lauf muss weiterhin geprüft werden. Die Anzeigen-/In-App-Kauf-Implementierung ist noch nicht live und wird durch einen Website-Upload nicht installiert.

Jeder Workflow prüft vor dem Hochladen Dateivollständigkeit und FTP-Erreichbarkeit (Port 21, explizites FTPS). Ein grüner GitHub-Actions-Lauf bestätigt den FTP-Upload, nicht automatisch die korrekte DNS-, SSL- oder Webverzeichnis-Zuordnung.

## ALL-INKL vor Veröffentlichung überprüfen

- juxilo.de und demo.juxilo.de haben jeweils ein eigenes, korrekt zugewiesenes Webverzeichnis.
- Die FTP-Benutzer haben Rechte auf das zugehörige Webverzeichnis, nicht auf das des jeweils anderen Auftritts.
- Für beide Domains ist HTTPS mit gültigem SSL-Zertifikat eingerichtet.
- Der FTP-Server erlaubt eingehende FTPS-Verbindungen von GitHub Actions auf Port 21.
- Nach Upload beide Domains in einem Browser testen.

Die öffentliche Vorschauseite enthält keinerlei Links zu den Demos; `demo.juxilo.de` ist bei direkter Eingabe dennoch **öffentlich erreichbar**. Sie ist nicht passwortgeschützt. Die Demo-Seiten sind mit `noindex` gekennzeichnet; Suchmaschinen können dadurch eine Indexierung vermeiden, das stellt aber keinen Zugriffsschutz dar.

## Ehemalige Testadresse

Die bisherige Domain `test.wer-muss.wiedeck.de` wird durch diese neuen Workflows **nicht mehr aktualisiert**. Sie bleibt eventuell online, bis sie in ALL-INKL separat abgeschaltet oder per Weiterleitung auf die neue Demo-Domain umgestellt wird. Vor einem Redirect sollte die neue Demo-Domain erfolgreich getestet sein.
