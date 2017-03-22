#!/bin/sh

#
# include shell file
#
source Laravel_auto_ENV/config.sh
source Laravel_auto_ENV/function.sh

initsh_start

if [ -n "$1" ]; then
  #
  # Reset Config
  #
  if [ $1 = reset ]; then
    echo "=============== Config Reset Start ==============="
    configReset
    echo "=============== Config Reset End ==============="
    source Laravel_auto_ENV/config.sh
  fi

  #
  # Revival Congig
  #
  if [ $1 = revival ]; then
    echo "=============== Config Revival ==============="
    cp Laravel_auto_ENV/config_bk config.sh
    source Laravel_auto_ENV/config.sh
  fi
fi


#
# composer update & install
#
if [ $COMPOSER_UPDATE = 0 ]; then
  ConfigChange COMPOSER_UPDATE 1
  # composer update
fi

if [ $COMPOSER_INSTALL = 0 ]; then
  ConfigChange COMPOSER_INSTALL 1
  # composer install
fi

#
# touch .env
#
if [ ! -e .env ];then
echo " [    ]  .env Not Found"

  if [ -e .env.example ]; then
    echo " [    ] .env.example Found"
    cp .env.example .env
    echo " [ OK ] Copy Success!! .env.example -> .env"
  else
    echo " [    ]  .env.example Not Found"
    cp Laravel_auto_ENV/.env.example .env
    echo " [ OK ] Copy Success!! Laravel_auto_ENV/.env.example -> .env"
  fi

fi
visu

#
# .env Update
#
if [ $ENV_STATUS = 0 ]; then

    #
    # mysql Database name
    #
    if [ ! -n "$DATABASE" ];then
      printText DATABASE
    fi
    envChange DB_DATABASE $DATABASE

    #
    # mysql Username
    #
    if [ ! -n "$MYSQL_USER" ];then
      printText MYSQL_USER
    fi
    envChange DB_USERNAME $MYSQL_USER

    #
    # mysql UserPassword
    #
    if [ ! -n "$MYSQL_PASS" ];then
      printText MYSQL_PASS pass
    fi
    envChange DB_PASSWORD $MYSQL_PASS

    #
    # key:generate
    #
    echo " [    ] php artisan key:generate"
    # php artisan key:generate

    exit 0

fi
visu

#
# Database Update
#
if [ $DB_UPDATE = 1];then

    if [  ]
fi
visu

php artisan migrate
php artisan db:seed
