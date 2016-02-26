#!/bin/bash

REMOTEMYSQLIP=$1

#install apache 2.4 php5
yum install httpd php php-mysql -y

#start
service httpd start

#auto-start
chkconfig httpd on

#disable firewalld
chkconfig firewalld off
service firewalld stop


#php test file
cat > /var/www/html/info.php <<EOF
<?php
phpinfo();
?>
EOF

#mysql connection test file
cat > /var/www/html/mysql.php <<EOF
<?php
\$link = mysql_connect('localhost', '', '');
if (!\$link) {
    die('Could not connect:' . mysql_error());
}
echo 'Connected Local MySQL Node sucessfully';
?>
EOF

cat > /var/www/html/remotemysql.php <<EOF
<?php
\$link = mysql_connect('$REMOTEMYSQLIP', 'root', '');
if (!\$link) {
    die('Could not connect:' . mysql_error());
}
echo 'Connected Remote MySQL Node sucessfully';
?>
EOF
