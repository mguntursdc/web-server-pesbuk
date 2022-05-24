#!/bin/bash

sudo apt-get update && cd && git clone https://github.com/sdcilsy/sosial-media

systemctl status apache2 | grep -E "*running"

if [ $? -eq 0 ]; then
        echo "Apache2 sudah terinstall"
else
        echo "Apache2 belum terinstall"
        sudo apt-get install -y apache2 php php-mysql
        systemctl status mysql
        if [ $? -eq 0]; then
          echo "MySql sudah terinstall"
        else
          echo "MySql belum terinstall"
          sudo apt-get install -y mysql-server
        fi
fi

sudo mv sosial-media/* /var/www/html

sudo mysql -u root -pguntur <<EXEC
CREATE USER 'devopscilsy'@'localhost' identified by '1234567890';
GRANT ALL privileges on *.* to 'devopscilsy'@'localhost';
CREATE database dbsosmed;
EXEC

cd  /var/www/html/
sudo mysql -u devopscilsy -p1234567890 dbsosmed < dump.sql