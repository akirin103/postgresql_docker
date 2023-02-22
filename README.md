# postgresql_docker

PostgreSQLの学習用のリポジトリです。  

<br />

## DB起動方法
   1. 下記のコマンドを実行する。

      ```sh
      $ sh db-init.sh
      ```

<br />

## DB、スキーマ作成〜権限設定まで

1. スーパーユーザでログインする。  

   ```sh
   $ psql \
      --host=localhost \
      --port=5432 \
      --username=postgres \
      --password \
      --dbname=postgres
   ```
2. データベースを作成する。  
   ```sh
   CREATE DATABASE test01;
   ```

3. 現在のデータベースを変更する。(postgres => test01)  
   ```sh
   \c test01;
   ```

4. スキーマを作成する。  
   ```sh
   CREATE SCHEMA myschema;
   ```

5. テーブルを作成する。  
   <b>スキーマを指定せずにテーブルを作成する場合は public スキーマ内に作成されます。  
   Public スキーマは誰でもアクセスできるスキーマです。</b>
   ```sh
   create table myschema.mybook (
     id integer, 
     name varchar(10)
   );
   insert into myschema.mybook(id, name) values (1, 'pai');
   select * from myschema.mybook;
   ```

6. ロールを作成する。  
   <b>PostgreSQLで「ユーザ」というのは「ログイン権限」をもつ「ロール」を指します。</b>

   ```sh
   CREATE ROLE app_user WITH LOGIN PASSWORD 'password';
   ```
   <b>この時点で`app_user`は`myschema`に対するアクセス権限を持ちません。</b>

7. 作成したロールに権限を付与する。

   ```sh
   \c test01;
   ALTER SCHEMA myschema OWNER TO app_user;
   GRANT ALL ON ALL TABLES IN SCHEMA myschema TO app_user;
   ```

8. 作成したユーザで再ログインする。
   ```sh
   exit

   $ psql \
      --host=localhost \
      --port=5432 \
      --username=app_user \
      --password \
      --dbname=test01
   ```
9. テーブルの操作ができることを確認をする。
   ```sh
   select * from myschema.mybook;
   ```
<br />

## その他

1. 便利なコマンド
   ```sh
   # 現在のユーザ、データベースの表示
   select current_user,current_database();

   # スキーマ一覧
   \dn
   ```

## コンテナ初期化時にSQLを実行する

コンテナの`/docker-entrypoint-initdb.d/`に`*.sql`や`*.sh`を置くことで、初期化処理が可能。

<br />

参考

- [PostgreSQLにおけるデータベース、スキーマ、テーブルの関係](https://www.dbonline.jp/postgresql/schema/index1.html)

- [psqlコマンドのインストール](https://zenn.dev/hdmt/articles/80e12573ec3a9051624b)

- [PostgreSql コマンドの覚え書き](https://qiita.com/mm36/items/1801573a478cb2865242)

- [【初心者向け】PostgreSQLのロールについて分かり易く解説](https://eng-entrance.com/postgresql-role)

- [PostgreSQLのロール](https://qiita.com/nuko_yokohama/items/085b75ee4c0938936ab9)

- [PostgreSQL の Public ロールと Public スキーマ](https://www.se-from30.com/it/postgresql-role-and-schema/)

- [Docker Hub公式PostgreSQLで初期化ずみデータベースコンテナを作る](https://qiita.com/hirosemi/items/199a3c753130c12d52f1)
