# get-server-parameter
サーバーのパラメーターシートを作成するbashスクリプト。markdown形式。

- get-parameter.sh
  - RHEL系OS用
  - RHEL9で実際に使用した
- ubuntu-get-parameter.sh
  - Ubuntu用
  - Ubuntu22.04で実際に使用した


## 不具合


- get-parameter.sh (RHEL)

で、

- diff /etc/php.ini.ORG /etc/php.ini
- diff /etc/php-fpm/www.conf.ORG /etc/php-fpm/www.conf
- diff /etc/my.cnf.ORG /etc/my.cnf

あたりが、ファイルに記録されない。

if文で括らなかったら正常に動作した気がしたけど、、深堀りしてない。次に利用するときに深堀りしようと思う。
