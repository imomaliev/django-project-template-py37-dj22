FROM python:3.7-alpine3.10

# postgresql-client is required by psql
# postgresql-dev musl-dev gcc are required by psycopg
# NOTE: there is py3-psycopg2
# gettext-dev is required by ./manage.py makemessages

RUN set -ex \
    \
    && apk add --no-cache --virtual .psql-deps \
        postgresql-client \
    && apk add --no-cache --virtual .psycopg-deps \
        postgresql-dev \
        musl-dev \
        gcc \
    && apk add --no-cache --virtual .gettext-deps \
        gettext-dev
RUN pip install pipenv

WORKDIR /project/backend

ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    PYTHONPATH="${PYTHONPATH}:/project/backend/src:/project/backend/tests" \
    PIP_NO_CACHE_DIR=0 \
    PIPENV_VENV_IN_PROJECT=1 \
    DJANGO_SETTINGS_MODULE=project.settings.development

COPY backend/Pipfile backend/Pipfile.lock ./

# NOTE: add here only build deps
RUN pipenv install --deploy --ignore-pipfile --dev
