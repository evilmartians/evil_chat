ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}-stretch

ARG PG_MAJOR
ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

# PG
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' ${PG_MAJOR} > /etc/apt/sources.list.d/pgdg.list

# Node
RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash -

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# Other dependencies
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    postgresql-client-${PG_MAJOR} \
    nodejs \
    yarn=${YARN_VERSION}-1 \
    less \
    vim && \
  apt-get clean && \
  rm -rf /var/cache/apt/archives/* && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

# Configure bundler and PATH
ENV LANG=C.UTF-8 \
  GEM_HOME=/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

RUN gem update --system && \
    gem install bundler:${BUNDLER_VERSION}

RUN mkdir -p /app

WORKDIR /app
