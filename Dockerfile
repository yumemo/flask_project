FROM python:3
MAINTAINER ymmmtym
ENV HOSTNAME="keywoo-container" \
    FLASK_APP="/app/run.py" \
    APP_PATH="/app" \
    PS1="[\u@\h \W]# "
ADD ["requirements.in", "/tmp"]
ADD ["app", "$APP_PATH"]
WORKDIR /tmp
RUN apt-get -y update && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip install pip-tools && \
    pip-compile /tmp/requirements.in && \
    pip-sync
WORKDIR $APP_PATH
CMD flask run