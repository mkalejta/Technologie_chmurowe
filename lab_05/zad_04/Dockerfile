ARG PYTHON_VERSION=3.11
ARG APP_PORT=5000

FROM alpine:latest

ARG PYTHON_VERSION
ARG APP_PORT

RUN apk add --no-cache python3 py3-pip && python3 -m venv /opt/venv

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENV APP_PORT=${APP_PORT}

WORKDIR /usr/src/app

COPY ./app ./

VOLUME ["/usr/src/app/data"]

EXPOSE ${APP_PORT}

CMD ["python3", "app.py"]
