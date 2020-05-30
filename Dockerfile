FROM ruby:2.6.5-alpine

RUN apk update && apk add git build-base nodejs yarn imagemagick postgresql-dev postgresql-client tzdata curl openssh rsync

RUN mkdir -p /app
WORKDIR /app

COPY . .
