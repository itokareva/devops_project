FROM python:3.6.0-alpine

WORKDIR /search_engine_crawler/ui
ADD . /search_engine_crawler/
RUN apk --no-cache --update add build-base && \
    pip install -r ../requirements.txt && \
    pip install -r ../requirements-test.txt && \
    apk del build-base

CMD FLASK_APP=ui.py gunicorn ui:app -b 0.0.0.0
