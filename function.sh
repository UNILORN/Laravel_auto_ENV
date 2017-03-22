#!/bin/sh

function DataChange(){
  text=`cat Laravel_auto_ENV/config.sh | grep $1`
  config=`sed -e 's/'$text'/'$1'='$2'/g' Laravel_auto_ENV/config.sh`
  echo "$config" > Laravel_auto_ENV/config.sh 
}
