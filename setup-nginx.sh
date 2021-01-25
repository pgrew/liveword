#!/bin/bash

ufw allow 'Nginx HTTP'
ufw allow 'OpenSSH'
ufw allow https

echo y | ufw enable

adduser liveword --system --disabled-password --disabled-login

mkdir -p /home/liveword/www
chown -R liveword:www-data /home/liveword/www

echo "welcome" >> /home/liveword/www/index.html
chmod -R 644 /home/liveword/www/index.html

echo "
server {
    listen 80;
    server_name _;

    root /home/liveword/www;
    index index.html;
}
" >> /etc/nginx/sites-available/liveword.blog

unlink /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/liveword.blog /etc/nginx/sites-enabled/

systemctl restart nginx
