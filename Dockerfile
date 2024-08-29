FROM timescaledev/timescaledb:nightly-pg16

ENV MQTT_BROKER=127.0.0.1
ENV POSTGRES_PASSWORD=123password

RUN apk add --update --no-cache python3 py3-pip py3-virtualenv

RUN apk add --no-cache --virtual .build-deps gcc musl-dev python3-dev

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install "cython<3.0.0" wheel

RUN mkdir /mqtt-pg-logger
COPY . /mqtt-pg-logger/
COPY sql/table.sql /docker-entrypoint-initdb.d/00_table.sql
COPY sql/convert.sql /docker-entrypoint-initdb.d/01_convert.sql
COPY sql/trigger.sql /docker-entrypoint-initdb.d/02_trigger.sql

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /mqtt-pg-logger
RUN python -m pip install -r requirements.txt

EXPOSE 5432

ENTRYPOINT ["/entrypoint.sh"]

