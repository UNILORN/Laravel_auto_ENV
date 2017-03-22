#!/bin/sh
source Laravel_auto_ENV/config.sh
source Laravel_auto_ENV/function.sh

if [ $COMPOSER_UPDATE = 0 ]; then
  ConfigChange COMPOSER_UPDATE 1
  # composer update
fi

if [ $COMPOSER_INSTALL = 0 ]; then
  ConfigChange COMPOSER_INSTALL 1
  # composer install
fi

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

if [ $ENV_STATUS = 0 ]; then

    if [ ! -n "$DATABASE" ];then
      printText DATABASE $DATABASE
      echo $DATABASE
    fi
    exit 0

    envChange DB_DATABASE $DATABASE

    echo "====================================================="
    echo "DBのユーザ名を入力"
    read username

    echo "====================================================="
    echo "DBのパスワードを入力"
    read userpass

    sed -i -e 's/DB_USERNAME=homestead/DB_USERNAME='$username'/' .env
    sed -i -e 's/DB_PASSWORD=secret/DB_PASSWORD='$userpass'/' .env

    echo "====================================================="
    echo "!! key:generate !!"
    echo "====================================================="
    php artisan key:generate
fi

echo "====================================================="
echo "$DATABASE を一度作成しましたか？(Y/N)"
read ans
echo "====================================================="

if [ $ans = N ]; then

    echo "====================================================="
    echo "Database[$DATABASE] Create Now!"
    echo "mySQLのパスワードを入力"
    echo "====================================================="

	mysql -u root -p -e 'create database '$DATABASE' '
	echo "====================================================="

else
    echo "====================================================="
    echo "[$DATABASE] Dump file write"
    echo "mySQLのパスワードを入力"
    echo "====================================================="
    mysql -u root -p -e 'drop database `'$DATABASE'`;create database `'$DATABASE'`'
fi

php artisan migrate
php artisan db:seed
