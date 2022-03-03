#!/bin/bash

echo >&2 "Updating file permissions ..."
sudo usermod -u $USER_ID www-data
sudo chown -R $USER_ID:$USER_ID /var/www/html/
find /var/www/html/* -type f -exec sudo chmod 655 -- {} +
find /var/www/html/* -type d -exec sudo chmod 755 -- {} +

exec "$@"
