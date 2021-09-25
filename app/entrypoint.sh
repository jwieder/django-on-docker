#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! (bash -c '</dev/tcp/'"$SQL_HOST"'/'"$SQL_PORT"' && echo PORT OPEN') 2>/dev/null ; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py migrate

exec "$@"