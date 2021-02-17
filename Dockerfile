# syntax = docker/dockerfile:1.0-experimental
FROM python:3.8-buster

LABEL maintainer="Kohei Matsubara <https://github.com/matsuby>"

ENV LD_LIBRARY_PATH /usr/local/lib

RUN apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && git clone --depth 1 https://github.com/taku910/mecab.git /tmp/mecab \
    && cd /tmp/mecab/mecab \
    && ./configure \
    && make \
    && make check \
    && make install \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/ipadic-neologd \
    && /tmp/ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y -a \
    && git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd.git /tmp/unidic-neologd \
    && /tmp/unidic-neologd/bin/install-mecab-unidic-neologd -n -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/mecab \
    && rm -rf /tmp/ipadic-neologd \
    && rm -rf /tmp/unidic-neologd
