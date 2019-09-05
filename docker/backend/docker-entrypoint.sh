#!/bin/sh
# NOTE: if there is no bash can cause
# standard_init_linux.go:190: exec user process caused "no such file or directory"

# https://docs.docker.com/compose/startup-order/
set -euo pipefail

if [[ "$1" = 'backend' ]]; then
    DATABASE_URL=${DATABASE_URL:-postgres://postgres:postgres@postgres:5432/postgres}

    # convert to connection string
    # https://www.postgresql.org/docs/current/static/libpq-connect.html#LIBPQ-CONNSTRING
    POSTGRES_URL=${DATABASE_URL%%\?*}
    # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
    POSTGRES_URL=${POSTGRES_URL/#postgis:/postgres:}

    # let postgres and other services (e.g. elasticsearch) to warm up...
    # https://www.caktusgroup.com/blog/2017/03/14/production-ready-dockerfile-your-python-django-app/
    until psql $POSTGRES_URL -c '\q'; do
        >&2 echo 'Postgres is not available - sleeping'
        sleep 1
    done
    # >&2 echo 'Postgres is up - executing command'

    echo 'Applying migrations'
    pipenv run manage migrate --noinput -v 0
    echo 'Generating translations'
    pipenv run manage compilemessages --locale ru -v 0
    echo 'Starting server'
    exec pipenv run server 0.0.0.0:8000
fi

exec "$@"
