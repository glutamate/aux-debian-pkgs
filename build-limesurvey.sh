rm -rf /tmp/lime_install_root
mkdir -p /tmp/lime_install_root/etc/nginx/conf.d
mkdir -p /tmp/lime_install_root/etc/nginx/sites-enabled
mkdir -p /tmp/lime_install_root/var/www

cp limesurvey/nginx-limesurvey.conf /tmp/lime_install_root/etc/nginx/sites-enabled/limesurvey


if [ ! -f limesurvey.zip ]; then
   wget -nv 'http://www.limesurvey.org/en/stable-release/finish/25-latest-stable-release/1133-limesurvey205plus-build140703-tar-gz' -O limesurvey.zip
fi

cp limesurvey.zip /tmp/lime_install_root/var/www/

(cd /tmp/lime_install_root/var/www/ && tar -xvzf limesurvey.zip && rm limesurvey.zip)


cd /tmp/lime_install_root

fpm -s dir -t deb -n limesurvey -v 2.05.0.1 -d nginx -d pwgen -d 'mysql-server' -d 'php5-fpm' -d 'php5-mysql' \
    -d 'php5-gd' -d 'php5-ldap' -d 'php5-imap' \
    -d 'nginx-bucket-64' --after-install ../limesurvey/postinst --prefix / .




