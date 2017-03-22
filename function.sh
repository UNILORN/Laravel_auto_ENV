#!/bin/sh

function ConfigChange(){
  text=`cat Laravel_auto_ENV/config.sh | grep $1`
  config=`sed -e 's/'$text'/'$1'='$2'/g' Laravel_auto_ENV/config.sh`
  echo "$config" > Laravel_auto_ENV/config.sh
}

function envChange(){
  text=`cat .env | grep $1`
  config=`sed -e 's/'$text'/'$1'='$2'/g' .env`
  echo "$config" > .env
}
