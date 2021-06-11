#!/bin/bash
chown www-data:www-data /var/www/files -Rf
#chmod -R 444 /var/www/html/ojs 
#chmod -R 750 /var/www/html/ojs/cache 
#chmod -R 750 /var/www/html/ojs/public 
#chmod -R 766 /var/www/html/site 
source /etc/apache2/envvars
#tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND