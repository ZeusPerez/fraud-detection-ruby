FROM ubuntu:16.04

RUN apt-get update && apt-get install -y build-essential \
                                         libxslt-dev libxml2-dev \
                                         git-core \
                                         ruby-dev ruby2.3 rubygems


ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

# Gems
RUN gem install --no-ri --no-rdoc rspec


# Generate structure
RUN mkdir /app
WORKDIR /app

COPY . /app

RUN ruby -v
