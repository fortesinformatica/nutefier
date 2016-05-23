#!/bin/sh -x

# Script gerado para tasks do pm2 no servidor de produção.


if [ "$1" = 'deploy' ] || [ "$1" = 'DEPLOY' ]; then 
  if [ "$2" = 'production' ] || [ "$2" = 'PRODUCTION' ]; then 
    echo "Efetuando deploy em produção..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "cd nutefier;         git pull; npm install; NODE_2=production pm2 restart -n nutefier_production app.js"
  else
    echo "Efetuando deploy em homologação..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "cd nutefier_staging; git pull; npm install; NODE_2=staging    pm2 restart -n nutefier_staging app.js"
  fi;
elif [ "$1" = 'STOP' ] || [ "$1" = 'stop' ]; then
  if [ -z "$2" ]; then
    echo "Parando todos os servers..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 stop all"
  elif [ "$2" = 'production' ] || [ "$2" = 'PRODUCTION' ]; then 
    echo "Parando server de produção..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 stop nutefier_production"
  else
    echo "Parando server de homologação..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 stop nutefier_staging"
  fi;
elif [ "$1" = 'START' ] || [ "$1" = 'start' ]; then
  if [ -z "$2" ]; then
    echo "Iniciando todos os servers..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 start all"
  elif [ "$2" = 'production' ] || [ "$2" = 'PRODUCTION' ]; then 
    echo "Iniciando server de produção..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 start nutefier_production"
  else
    echo "Iniciando server de homologação..."
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 start nutefier_staging"
  fi;
elif [ "$1" = 'STATUS' ] || [ "$1" = 'status' ]; then
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 status"
elif [ "$1" = 'MONIT' ] || [ "$1" = 'monit' ]; then
    ssh -i eva-master.pem ubuntu@23.22.56.56 "pm2 monit"
else
  echo "What is glove?"
  echo "========================================================================"
  echo "Uso: sh runner.sh COMMAND [ENVIRONMENT]"
  echo "COMMAND: deploy, stop, start, status, monit"
  echo "ENVIRONMENT: production, staging"
  echo "========================================================================"
  echo "Exemplos:"
  echo "sh runner.sh deploy production"
  echo "sh runner.sh stop staging"
  echo "sh runner.sh status"
  echo "========================================================================"

  echo "Certifique-se de que o arquivo eva-master.pem esteja no mesmo diretório"
fi;