ARG RUBY_VERSION
# === Base image ===
FROM ruby:${RUBY_VERSION}-slim-buster as base

ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    vim \
    git \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Node
RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash -

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# App's dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    nodejs \
    yarn=${YARN_VERSION}-1 \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN mkdir /app /bundle

# Bundler
ENV LANG=C.UTF-8 \
  BUNDLE_PATH=/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
ENV BUNDLE_APP_CONFIG=${BUNDLE_PATH} \
  BUNDLE_BIN=${BUNDLE_PATH}/bin
ENV PATH /app/bin:${BUNDLE_BIN}:${PATH}
RUN gem update --system \
    && gem install bundler:${BUNDLER_VERSION}

WORKDIR /app
EXPOSE 3000


# === Development image ===
FROM base as development
ENV RAILS_ENV=development
CMD ["/usr/bin/bash"]


# === Production image ===
FROM base as production
ENV RAILS_ENV=production

# Container user
RUN groupadd ruby \
  && useradd --gid ruby --shell /bin/bash --create-home ruby \
  && chown -R ruby:ruby /app /bundle

USER ruby

COPY --chown=ruby:ruby Gemfile* .
RUN bundle install --without development test

COPY --chown=ruby:ruby . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
