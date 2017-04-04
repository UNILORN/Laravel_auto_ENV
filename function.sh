#!/bin/sh

#
# config.sh chenged
#
function ConfigChange(){
  text=`cat Laravel_auto_ENV/config.sh | grep $1`
  config=`sed -e 's/'$text'/'$1'='$2'/g' Laravel_auto_ENV/config.sh`
  echo "$config" > Laravel_auto_ENV/config.sh
  echo " [ OK ] config.sh $1 = $2 Chenged!!"
}

#
# .env chenged
#
function envChange(){
  text=`cat .env | grep $1`
  config=`sed -e 's/'$text'/'$1'='$2'/g' .env`
  echo "$config" > .env
  echo " [ OK ] .env $1 = $2 Chenged!!"
}

#
# Input Data config.sh
#
function printText(){
  echo " [    ] config.sh ($1) Not Found"
    while : ;do
      echo "=============== INPUT NOW ! ==============="
      read $"$1"
      echo "=============== END INPUT ! ==============="

      text=`eval echo '$'$1`
      ps=0

      if [ -n "$2" ];then
        ps=1
      fi

      if [ ! -n "$text" -a $ps = 0 ];then
        echo " [ ER ] ($1) is Empty !!!!!!!"
      else
        break
      fi
    done
    ConfigChange $1 $text
}

function visu(){
  echo ""
  echo "------------------------------------------"
  echo ""
}

function initsh_start(){
  echo ""
  echo "+-----------------------------------------+"
  echo "|        Laravel .env                     |"
  echo "|                Auto Update !!           |"
  echo "|                       by UNILORN        |"
  echo "+-----------------------------------------+"
  echo ""
  echo " [ OK ] Start!!"
  echo ""

  if [ ! -e ./.git ]; then
    rm -rf .git/
  fi
}

function configReset(){
  visu
  ConfigChange DATABASE
  ConfigChange MYSQL_USER
  ConfigChange MYSQL_PASS
  ConfigChange ENV_STATUS 0
  ConfigChange COMPOSER_UPDATE 1
  ConfigChange COMPOSER_INSTALL 0
  ConfigChange DB_UPDATE 1
  visu
}
