#!/bin/bash

#install nginx
yes "" | apt install nginx
rc=($?)
if [ $rc -eq 0 ]
then
    echo "Nginx installed"
else
    echo "Failed Nginx Installation"
fi

#install apache2
yes "" | apt install apache2
rc=($?)
if [ $rc -eq 0 ]
then
    echo "Apache2 installed"
else
    echo "Failed Apache2 Installation"
fi




#install fail2ban
yes "" | apt install fail2ban
rc2=($?)
if [ $rc2 -eq 0 ]
then
    echo "Fail2ban installed"
else
    echo "Failed Failed2ban Installation"
fi

 
echo "$(hostname -I)  www.lisa.dubois" >> /etc/hosts 

cp /workspace/ports.conf /etc/apache2
cp /workspace/reverse_proxy.conf /etc/nginx/conf.d
cp /workspace/index.html /var/www/html
chmod -R 755 /etc/nginx/conf.d
chmod -R 755 /var/www/html

# satrt nginx
systemctl start nginx
systemctl start apache2

systemctl reload nginx 
yes "" | apt install ufw
ufw allow 80

echo "Done"






