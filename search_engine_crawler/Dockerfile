FROM python:3.6.0-alpine

WORKDIR /search_engine_crawler
ADD . /search_engine_crawler/
RUN apk --no-cache --update add build-base busybox-extras && \
    pip install -r requirements.txt && \
    pip install -r requirements-test.txt && \
    apk del build-base

ENV EXCLUDE_URLS .*github.com
CMD python3 -u crawler/crawler.py https://vitkhab.github.io/search_engine_test_site/
