# Docker for Development

## Installation

You need `docker` and `docker-compose` installed (for MacOS just use [official app](https://docs.docker.com/engine/installation/mac/)).

### Linux users

Linux users have a problem with file permissions. Files written in host volume created by root user in Docker containers are also owned by root on the host. Use Docker namespaces to map your host user to the container root.

Guide how to fix - https://www.jujens.eu/posts/en/2017/Jul/02/docker-userns-remap/

Docker docs - https://docs.docker.com/engine/security/userns-remap/

## Provisioning

Run the following commands to prepare your Docker dev env:

```sh
$ docker-compose build
$ docker-compose run --rm backend bundle install
$ docker-compose run --rm backend bundle exec rake db:setup
```

It builds the Docker image, installs Ruby dependencies, creates database, run migrations and seeds.

You're all set! Now you're ready to code!

## Commands

* Running the app:

```sh
# Running Rails server
$ docker-compose up rails
```

* Running tests and other tools

You can spin a container to run tests:

```sh
$ RAILS_ENV=test docker-compose run --rm backend bundle exec rspec
```

There is a way to run a `bash` session within a container and run commands
from inside:

```sh
$ docker-compose run --rm backend
root@aef12:/app#
```

## Image Versioning

Every time you change the `Dockerfile` contents, you **must** increase the version number in the `docker-compose` file using the following rules:
- Increase the patch version if a bug has been fixed
- Increase the minor version if a dependency has been added or upgraded (e.g. new Ruby version)
- Increase the major version only if the app stack has changed drastically (e.g. switched from fullstack app to API only, or from Ruby to Haskell)

## Docker Tips

**TIP #1**: Docker doesn't cleanup after itself well, so you have to do it manually.

```sh
# to monitor disk usage
docker system df

# to stop and clean application related containers
docker-compose down

# and with volumes (useful to reset databases state)
docker-compose down --volumes

# or even clean the whole docker system (it'll affect other applications too!)
docker system prune
```

**TIP #2**: Use `--rm` flag with `run` command to automatically destroy the
container on exit, e.g. `docker-compose run --rm runner`.

**TIP #3**: Add system aliases:

```
alias dcr='docker-compose run --rm'
alias dcu='docker-compose up'
alias dcs='docker-compose stop'
alias dstats='docker stats --format "table {{.Name}}:\t{{.MemUsage}}\t{{.CPUPerc}}"'
```

**TIP #3**: Use [`dip`](./dip.yml).
