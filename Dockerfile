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
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/neologd \
    && /tmp/neologd/bin/install-mecab-ipadic-neologd -n -y -a \
    && sed -ie 's#/usr/local/lib/mecab/dic/ipadic#/usr/local/lib/mecab/dic/mecab-ipadic-neologd#' /usr/local/etc/mecabrc \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/mecab \
    && rm -rf /tmp/neologd
