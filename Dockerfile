FROM python:3.9.15-slim-bullseye

ENV TZ="Europe/Madrid"

RUN mkdir -p /usr/src/app
COPY app /usr/src/app/
COPY requirements.txt /usr/src/app/

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y postgresql-client

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

CMD python /usr/src/app/manage.py collectstatic --noinput && cd /usr/src/app && gunicorn custom_users.wsgi:application --bind 0.0.0.0:8000