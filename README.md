# Frameworkless backend

## DB
Voorzie je db onder de db folder.

## ABL Language server
Editeer openedge-project.json en pas aan zodat jouw folder/naam/db juist staan.

## PASOE

### Creatie PASOE
Pas in onderstaande de paden en naam van de pasoe aan zodat het overeen komt met jouw omgeving

```
mkdir servers
cd servers
c:/Progress/oe128/servers/pasoe/bin/tcman.bat create -f -p 10101 -P 10102 -s 10103 -Z dev -v pasoe_sports2020
pasoe_sports2020/bin/oeprop.bat -a ROOT -A pasoe_sports2020 -f C:/cce/workspaces/sports2020/cfg/servser/pasoe_sports2020/openedge.properties.merge
copy -R C:/cce/workspaces/sports2020/cfg/servers/pasoe_sports2020/webapps/ROOT pasoe_sports2020/webapps 
```

### Start/stop PASOE

Editeer .vscode/tasks.json naar jouw PASOE
Gebruik standaard tasks in VSCode voor starten/stoppen

## Swagger

Editeer onder {pasoe}/webapps/ROOT/swagger-config.json en {pasoe}/webapps/ROOT/swagger-sports2020.yaml. Probeer in de yaml zoveel mogelijk aan te vullen, bijv. welke parameters nodig zijn, welke foutboodschappen en responses kunnen verwacht worden.

Je handlers dien je aan te geven in {pasoe}/conf/openedge.properties (zie voorbeeld handler1). Bij het definiëren van volgende handlers mag er geen gat zitten. 

Swagger zal beschikbaar zijn onder http://localhost:10101/static/swagger/