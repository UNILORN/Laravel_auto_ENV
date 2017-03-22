#!/bin/sh

function ConfigChange(){
  text=`cat Laravel_auto_ENV/config.sh | grep $1`
  config=`sed -e 's/'$text'/'$1'='$2'/g' Laravel_auto_ENV/config.sh`
  echo "$config" > Laravel_auto_ENV/config.sh
  echo " [ OK ] config.sh $1 = $2 Chenged!!"
}

function envChange(){
  text=`cat .env | grep $1`
  config=`sed -e 's/'$text'/'$1'='$2'/g' .env`
  echo "$config" > .env
  echo " [ OK ] .env $1 = $2 Chenged!!"
}

function printText(){
  echo " [    ] config.sh ($1) Not Found"
    while : ;do
      echo "=============== INPUT NOW ! ==============="
      read $"$1"
      echo "=============== END INPUT ! ==============="
      text=`eval echo '$'$1`
      if [ ! -n "$text" ];then
        echo " [ ER ] ($1) is Empty !!!!!!!"
      else
        break
      fi
    done
}
