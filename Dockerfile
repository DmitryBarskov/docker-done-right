FROM ruby:3.1.0-alpine

ARG RAILS_ROOT=/docker-done-right
ARG PACKAGES="vim openssl-dev postgresql-dev mongodb-tools build-base \
  curl less tzdata git postgresql-client bash screen"

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache $PACKAGES

RUN gem install bundler:2.3.7

