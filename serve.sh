#! /bin/bash
IP=$(hostname -i)
if [ "$APP_URL" == "" ]
then
    export APP_URL="http://$IP:$PORT"
fi
echo PORT $PORT
echo APP_URL $APP_URL

php artisan key:generate
php artisan config:cache
php artisan migrate:fresh
php artisan serve --host=0.0.0.0 --port=$PORT
