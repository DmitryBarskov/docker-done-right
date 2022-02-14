# Docker done right

For development purposes only

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
rails new docker-done-right --database=postgresql --skip-active-storage --skip-action-cable --skip-test --skip-system-test --api
exit
```

After that the project generated in the container appeared on my host machine.
