FROM python:3.7-alpine

LABEL maintainer="Pulok <pulok.github@gmail.com>"

ENV PYTHONUNBUFFERED=1

COPY requirements.txt /app/requirements.txt

RUN apk add --update --no-cache postgresql-client \
    && apk add --update --no-cache --virtual .tmp-build-deps \
       gcc libc-dev linux-headers postgresql-dev \
    && pip install -r /app/requirements.txt \
    && apk del .tmp-build-deps

WORKDIR /app

COPY . /app

RUN adduser -D user
USER user

CMD ["sh", "-c", "python manage.py test && flake8"]
