# .env auto update!

## 必要環境

  - Laravel
  - composer
  - php5.6~
  - mysql
  - shellscript


## 手順

### 1. Laravelプロジェクトを構築します

  任意のディレクトリにLaravelを構築します

### 2. このリポジトリをクローンします。

  `cd ~/{YourLaravelProject}`

  `git clone https://github.com/UNILORN/Laravel_auto_ENV`

### 3. 実行します

  `sh Laravel_auto_ENV/init.sh`


## 詳細

  ### `config.sh`の内容について

  `config.sh`の内容は`init.sh`を実行時に変更されます。  
  未記入の場合は記入を促され、フラグ部分は実行有無のキャッシュデータとして保持します。


  - ### `DATABASE`
    データベースのスキーマ名です。（必須）  
    記入済みの場合は入力を促されません。

  - ### `MYSQL_USER`
    mysqlのユーザ名です。（必須）  
    記入済みの場合は入力を促されません。

  - ### `MYSQL_PASS`
    mysqlのパスワードです。  
    記入済みの場合は入力を促されません。

  - ### `ENV_STATUS`
    envが最新状態かどうかの記録を行います。  
    変更を加えたい場合は `env` オプションを使います。  
    0 : envファイルを更新しません。`config.sh`の内容を元に手順を行います。  
    1 : envファイルを更新します。更新後は自動的に`1`に変更されます。

  - ### `COMPOSER_UPDATE`
    0 : `composer update`を行います。行った後自動的に`1`に変更されます  
    1 : `composer update`は行いません。

  - ### `COMPOSER_INSTALL`
    0 : `composer install`を行います。行った後自動的に`1`に変更されます  
    1 : `composer install`アップデートは行いません。

  - ### `DB_UPDATE` `DB_MIGRATE` `DB_SEED`
    いずれもTrueFalseで、動作的には同じです。  
    0 : 何も行いません。  
    1 : 毎回行います。  
    - `DB_UPDATE` : DB作り直し
    - `DB_MIGRATE` : `php artisan migrate`
    - `DB_SEED` : `php artisan db:seed`


  ### オプション

  - ### `reset`
    config.shを初期値に戻します。

  - ### `revival`
    config.shの内部が破損した場合、init.shは機能しません。  
    よって、このコマンドで復活させてあげてください。

  - ### `env`
    envの更新を行います。Database,Username,Password　の変更ができます。

  - ### `config {option}`
    - `d {0 or 1}` : `DB_UPDATE`の値を変更します。
    - `m {0 or 1}` : `DB_MIGRATE`の値を変更します。
    - `s {0 or 1}` : `DB_SEED`の値を変更します。
    - `u {0 or 1}` : `COMPOSER_UPDATE`の値を変更します。
    - `i {0 or 1}` : `COMPOSER_INSTALL`の値を変更します。
