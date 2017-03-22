#!/bin/sh
source Laravel_auto_ENV/config.sh
source Laravel_auto_ENV/function.sh

if [ $COMPOSER_UPDATE=0 ]; then
  ConfigChange COMPOSER_UPDATE 1
  # composer update
fi

if [ $COMPOSER_INSTALL = 0 ]; then
  ConfigChange COMPOSER_INSTALL 1
  # composer install
fi

if [ ! -e .env ];then

  if [ -e .env.example ]; then
    cp .env.example .env
  else
    touch .env
  fi

fi
exit 0

if [ $ENV_STATUS = 0 ]; then

    cp .env.example .env

    echo "====================================================="
    echo "DatabaseNameを$DATABASEとして.envを更新します"
    sed -i -e 's/DB_DATABASE=homestead/DB_DATABASE='$DATABASE'/' .env

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
