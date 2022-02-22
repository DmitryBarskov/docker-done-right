# Docker done right

For development purposes only.
The idea is that you enter a docker container and
you can run your application as usual on your host machine
but it has all system dependecies installed.

## Index

1. [Why is it right?](#why-is-it-right)
1. [Dockerfile](#dockerfile)
1. [docker-compose.yml](#docker-composeyml)
1. [Final result](#final-result)

## Why is it right?

This approach does not force developers to use docker. It is as easy as always
to setup the project natively on host machine (a developer's laptop).

## Dockerfile

First I created `Dockerfile` with the next content:

```Dockerfile
FROM ruby:3.1.0-alpine

ARG RAILS_ROOT=/docker-done-right
ARG PACKAGES="vim openssl-dev postgresql-dev mongodb-tools build-base \
  curl less tzdata git postgresql-client bash"

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache $PACKAGES
```

And run
```bash
docker build -t ddr .
docker run -it --rm -v $PWD:/docker-done-right ddr bash
gem install rails

rails new docker-done-right \
  --database=postgresql --skip-active-storage \
  --skip-action-cable --skip-test --skip-system-test --api

exit
```

After the project generated in the container it appeared on my host machine.

First try to run the server
```bash
docker run -it --rm -v $PWD:/docker-done-right -p 3000:3000 ddr bash
rails server -b 0.0.0.0
```

And we can open localhost:3000 in our browser and see an error! It works!

## docker-compose.yml

My application grew and got ActiveRecord models and Mongoid documents and now
it relies on PostgreSQL and MongoDB databases. So to run my app I need to run
them first.

```yaml
version: '3.7'

services:
  web:
    build: .
    volumes:
      # mount application directory so that changes I make on my local machine
      # with graphical code editor appear in application container and
      # generated code (produced with rails generate) appear on my local machine
      # and shown in code editor
      - .:/docker-done-right:cached
      # save the bundle between container runs
      - bundle_cache:/bundle_cache
    ports:
      - 3000:3000
    depends_on:
      # in fact it does not depend on mongo and postgres until I start
      # my application with rails server command
      - postgres
      - mongo
    environment:
      # tell bundler where to store gems
      BUNDLE_PATH: /bundle_cache
      # tell gem command where to store gems
      GEM_HOME: /bundle_cache
      GEM_PATH: /bundle_cache

      RAILS_PORT: 3000

      # environment variables for the app
      DATABASE_HOST: postgres
      DATABASE_USERNAME: postgres
      DATABASE_PASSWORD: postgres
      MONGODB_HOST: mongo
    # make web container hang so that I connect to it
    stdin_open: true
    tty: true
    command: bash

  postgres:
    image: postgres:14.1-alpine
    volumes:
      - pg_data:/var/lib/postgresql/data/pgdata
    ports:
      - 5432:5432
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      PGDATA: /var/lib/postgresql/data/pgdata

  mongo:
    image: mongo
    volumes:
      - mongo_data:/data/db
    ports:
      - 27017:27017
    restart: always

volumes:
  bundle_cache:
  mongo_data:
  pg_data:
```

## Final result

From now on to setup the project from scratch there is only a few commands:

1. Clone the projects itself:\
    `git clone git@github.com:DmitryBarskov/docker-done-right.git && cd docker-done-right`
1. Setup the development environment, run tests and enter the development environment:\
    `bin/docker`
1. Run the server as usual (binding on 0.0.0.0 is required):\
    `bin/server`

So there are only a few commands to get started.\
But at the same time I can setup my project as I always do installing Ruby, PostgreSQL, etc on my host machine.
