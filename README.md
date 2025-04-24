# Frameworkless backend

## DB
Voorzie je db onder de db folder.

## ABL Language server
Editeer openedge-project.json en pas aan zodat jouw folder/naam/db juist staan.

## PASOE

### Creatie PASOE
Pas in onderstaande de paden en naam van de pasoe aan zodat het overeen komt met jouw omgeving

```shell 
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

Download **swagger-ui** (https://github.com/swagger-api/swagger-ui/tree/master/dist) en plaats onder {pasoe}/webapps/ROOT/static/swagger. 
Editeer swagger-initializer.js:
```js
window.onload = function() {
  //<editor-fold desc="Changeable Configuration Block">

  // the following lines will be replaced by docker/configurator, when it runs in a docker-container
  window.ui = SwaggerUIBundle({
    url: "/swagger-sports2020.yaml",
    dom_id: '#swagger-ui',    
    deepLinking: true,
    persistAuthorization: true,            
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  });

};
```

Editeer onder {pasoe}/webapps/ROOT/swagger-config.json en {pasoe}/webapps/ROOT/swagger-sports2020.yaml. 

Probeer in de yaml zoveel mogelijk aan te vullen, bijv. welke parameters nodig zijn, welke foutboodschappen en responses kunnen verwacht worden.

Je **handlers** dien je aan te geven in **{pasoe}/conf/openedge.properties** (zie voorbeeld handler1). Bij het definiëren van volgende handlers mag er geen gat zitten. 

Swagger zal beschikbaar zijn onder http://localhost:10101/static/swagger/