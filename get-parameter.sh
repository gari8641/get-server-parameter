#!/bin/bash

# 日付を取得（yy-mm-dd形式）
date=$(date '+%y-%m-%d')

# ホスト名を取得
hostname=$(hostname)

# ファイル名を作成
filename="${date}_${hostname}システム環境設定書.md"

rm $filename

echo \\newpage >> $filename

echo 対象サーバー：${hostname} >> $filename

echo  >> $filename
echo 	\# ユーザー一覧 >> $filename
echo  >> $filename
echo  >> $filename
echo '```' >> $filename
echo \# cat /etc/passwd >>  $filename
cat	/etc/passwd >>  $filename
echo '```' >> $filename


echo  >> $filename
echo \\newpage >> $filename
echo \# グループ一覧 >> $filename
echo  >> $filename
echo '```' >> $filename
echo 	\# cat /etc/group >> $filename
cat /etc/group >> $filename
echo '```' >> $filename



echo >> $filename
echo \\newpage >> $filename
echo \# OS Firewall >> $filename
echo \#\#	使用ソフトウェア >> $filename
echo Firewalldを使用する。 >> $filename
echo  >> $filename
echo \#\#	Firewalldの設定ルール >> $filename
echo - 必要なポート又はサービスのみ開放する。 >> $filename
echo  >> $filename
echo \#\#	Firewalldの設定内容 >> $filename
echo  >> $filename
echo '```' >> $filename
echo \# firewall-cmd --list-all >> $filename
firewall-cmd --list-all >> $filename
echo '```' >> $filename

echo \\newpage >> $filename
echo  >> $filename
echo \# systemctl サービス起動設定一覧 >> $filename
echo '```' >> $filename
echo \# systemctl list-unit-files --type=service >> $filename
systemctl list-unit-files --type=service >> $filename
echo '```' >> $filename


echo \\newpage >> $filename
echo  >> $filename
echo \# DNF >> $filename
echo  >> $filename
echo \#\#	追加リポジトリ >> $filename
echo  >> $filename
echo 無し 。>> $filename
echo  >> $filename
echo \#\#	追加パッケージ >> $filename
echo  >> $filename
echo \#\# インストール済みパッケージ一覧 >> $filename
echo '```' >> $filename
echo \# dnf list installed >> $filename
dnf list installed >> $filename
echo '```' >> $filename

echo \\newpage >> $filename
echo  >> $filename
echo \# rsyslog >> $filename
echo  >> $filename
echo \#\#	ルール >> $filename
echo  >> $filename
echo - Webのログを分けて転送する >> $filename
echo  >> $filename
echo - ログは複製してオリジナルサーバーとsyslog両方で保持する >> $filename
echo  >> $filename

echo \#\#	/etc/rsyslog.conf >> $filename
echo /etc/rsyslog.confの内容： >> $filename
echo '```' >> $filename
echo \# cat /etc/rsyslog.conf >> $filename
cat /etc/rsyslog.conf >> $filename
echo '```' >> $filename
echo  >> $filename
echo デフォルト設定との差異： >> $filename
echo  >> $filename
echo '```' >> $filename
echo \# diff /etc/rsyslog.conf.ORG /etc/rsyslog.conf >> $filename
diff /etc/rsyslog.conf.ORG /etc/rsyslog.conf >> $filename
echo '```' >> $filename
echo  >> $filename
echo /etc/rsyslog.d/ 配下はデフォルトのまま。>> $filename
echo  >> $filename
echo /etc/rsyslog.d/の内容：>> $filename
echo '```' >> $filename
echo \# cat /etc/rsyslog.d/21-cloudinit.conf >> $filename
cat /etc/rsyslog.d/21-cloudinit.conf >> $filename
echo '```' >> $filename

echo \\newpage >> $filename
echo  >> $filename
echo \# logrotate >> $filename
echo  >> $filename
echo \#\#	ルール >> $filename
echo  >> $filename
echo - 保持期間 >> $filename
echo '    '- sv-syslogに保存するシスログ >> $filename
echo '        '- 1ヶ月 >> $filename
echo '    '- sv-syslog以外 >> $filename
echo '        '- 2年 >> $filename
echo - ローテーションサイクル >> $filename
echo '    '- 原則daily（日毎） >> $filename
echo '    '- btmp、wtmpについては旧システム踏襲でmonthly（月毎） >> $filename
echo  >> $filename
echo \#\#	/etc/logrotate.conf >> $filename
echo /etc/logrotate.confの内容： >> $filename
echo  >> $filename
echo '```' >> $filename
echo \#cat /etc/logrotate.conf >> $filename
cat /etc/logrotate.conf >> $filename
echo '```' >> $filename
echo  >> $filename
echo デフォルト設定との差異： >> $filename
echo '```' >> $filename
echo \# diff /etc/logrotate.conf.ORG /etc/logrotate.conf >> $filename
diff /etc/logrotate.conf.ORG /etc/logrotate.conf >> $filename
echo '```' >> $filename
echo  >> $filename
echo \#\# /etc/logrotate.d/ 配下： >> $filename

# /etc/logrotate.d/ 配下のすべてのファイルをループ
for file in /etc/logrotate.d/*; do
    echo '```' >> $filename
    echo "# cat $file" >> $filename
    cat $file >> $filename
    echo '```' >> $filename
    echo -e "\n" >> $filename
done



#
if dnf list installed | grep "httpd"; then
  echo \\newpage >> $filename
  echo  >> $filename
  echo \# Apache >> $filename
  echo \#\# /etc/httpd/conf/ 配下設定 >> $filename
  echo '```' >> $filename
  echo \# cat /etc/httpd/conf/httpd.conf >> $filename
  cat /etc/httpd/conf/httpd.conf >> $filename
  echo '```' >> $filename
  echo  >> $filename
  echo \#\# /etc/httpd/conf.d/ 配下設定 >> $filename
  echo '```' >> $filename
  echo ls -l /etc/httpd/conf.d/ >> $filename
  ls -l /etc/httpd/conf.d/ >> $filename
  echo '```' >> $filename
  echo  >> $filename
  echo /etc/httpd/conf.d/配下の有効なconfファイル内容： >> $filename

  # /etc/httpd/conf.d/ 配下のすべてのファイルをループ
  for file in /etc/httpd/conf.d/*.conf; do
      echo '```' >> $filename
      echo "# cat $file" >> $filename
      cat $file >> $filename
      echo '```' >> $filename
      echo -e "\n" >> $filename
  done

  echo  >> $filename
  echo \#\# ssl証明書 >> $filename
  echo '```' >> $filename
  echo \# ls -l /etc/httpd/conf/ssl.crt/ >> $filename
  ls -l /etc/httpd/conf/ssl.crt/ >> $filename
  echo '```' >> $filename
  echo  >> $filename
  echo \#\# sslキー >> $filename
  echo '```' >> $filename
  echo \# ls -l /etc/httpd/conf/ssl.key/ >> $filename
  ls -l /etc/httpd/conf/ssl.key/ >> $filename
  echo '```' >> $filename

fi

if dnf list installed | grep "php"; then
  echo \\newpage >> $filename
  echo  >> $filename
  echo \# PHP >> $filename
  echo '```' >> $filename
  echo \# cat /etc/php.ini >> $filename
  cat /etc/php.ini >> $filename
  echo '```' >> $filename
  echo  >> $filename
  echo デフォルト設定との差異： >> $filename
  echo  >> $filename
  echo '```' >> $filename
  echo \# diff /etc/php.ini.ORG /etc/php.ini >> $filename
  diff /etc/php.ini.ORG /etc/php.ini >> $filename
  echo '```' >> $filename

  echo \\newpage >> $filename
  echo  >> $filename
  echo \# PHP-FPM >> $filename
  echo '```' >> $filename
  echo \# cat /etc/php-fpm.d/www.conf >> $filename
  cat /etc/php-fpm.d/www.conf >> $filename
  echo '```' >> $filename
  echo  >> $filename
  echo デフォルト設定との差異： >> $filename
  echo  >> $filename
  echo '```' >> $filename
  echo \# diff /etc/php-fpm.d/www.conf.ORG /etc/php-fpm.d/www.conf >> $filename
  diff /etc/php-fpm.d/www.conf.ORG /etc/php-fpm.d/www.conf >> $filename
  echo '```' >> $filename
fi

if dnf list installed | grep "mariadb-server"; then
  echo \\newpage >> $filename
  echo  >> $filename
  echo \# MariaDB >> $filename
  echo '```' >> $filename
  echo \# cat /etc/my.cnf >> $filename
  cat /etc/my.cnf >> $filename
  echo '```' >> $filename
  echo  >> $filename
  echo デフォルト設定との差異： >> $filename
  echo  >> $filename
  echo '```' >> $filename
  echo \# diff /etc/my.cnf.ORG /etc/my.cnf >> $filename
  diff /etc/my.cnf.ORG /etc/my.cnf >> $filename
  echo '```' >> $filename
fi

if dnf list installed | grep "vsftpd"; then
  echo  >> $filename
  echo \# FTPサーバー >> $filename
  echo \#\# 使用するソフトウェア >> $filename
  echo FTPサーバーのソフトウェアはvsftpdを使用する。 >> $filename
  echo  >> $filename
  echo \#\# vsftpdの設定内容 >> $filename
  echo /etc/vsftpd/vsftpd.confの内容： >> $filename
  echo '```' >> $filename
  echo \# cat /etc/vsftpd/vsftpd.conf >> $filename
  cat /etc/vsftpd/vsftpd.conf >> $filename
  echo '```' >> $filename
  echo  >> $filename
  echo デフォルト設定との差異： >> $filename
  echo '```' >> $filename
  echo \# diff vsftpd.ORG/vsftpd.conf vsftpd/vsftpd.conf >> $filename
  diff /etc/vsftpd.ORG/vsftpd.conf /etc/vsftpd/vsftpd.conf >> $filename
  echo '```' >> $filename

  echo  >> $filename
  echo /etc/vsftpd/user_listの内容： >> $filename
  echo '```' >> $filename
  echo \# cat /etc/vsftpd/user_list >> $filename
  cat /etc/vsftpd/user_list >> $filename
  echo '```' >> $filename

  echo デフォルト設定との差異： >> $filename
  echo '```' >> $filename
  echo \# diff vsftpd.ORG/user_list vsftpd/user_list >> $filename
  diff /etc/vsftpd.ORG/user_list /etc/vsftpd/user_list >> $filename
  echo '```' >> $filename

  echo \#\# 追加フォルダ・ファイル >> $filename
  echo 以下のフォルダ・ファイルを新規追加 >> $filename
  echo  >> $filename
  echo - `ls -1R /etc/vsftpd/chroot_list` >> $filename
  echo  >> $filename
  echo - `ls -1R /etc/vsftpd/vsftpd_user_conf` >> $filename
  echo  >> $filename
  echo /etc/vsftpd/chroot_listの内容： >> $filename
  echo '```' >> $filename
  echo \#cat /etc/vsftpd/chroot_list >> $filename
  cat /etc/vsftpd/chroot_list >> $filename
  echo '```' >> $filename

  echo /etc/vsftpd/vsftpd_user_conf/配下のファイルそれぞれの内容： >> $filename
  # /etc/vsftpd/vsftpd_user_conf/ 配下のすべてのファイルをループ
  for file in /etc/vsftpd/vsftpd_user_conf/*; do
      echo '```' >> $filename
      echo "# cat $file" >> $filename
      cat $file >> $filename
      echo '```' >> $filename
      echo -e "\n" >> $filename
  done
fi
