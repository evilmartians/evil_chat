# Docker on Dip Development Configuration

We have development [Docker configuration]((./docker.md).

In addition to it you can also use [`dip`](https://github.com/bibendi/dip) – CLI that gives the "native" interaction with applications configured with Docker Compose. It is for the local development only. In practice, it creates the feeling that you work without containers.

To install `dip` copy and run the command below:

```sh
gem install dip
```

or

```sh
brew install bibendi/dip/dip
```

## Usage

```sh
# list available commands
dip ls

# provision application
dip provision

# run web app with all debuging capabilities (i.e. `binding.pry`)
dip rails s

# run rails console
dip rails c

# run migrations
dip rake db:migrate

# pass env variables into application
dip VERSION=20100905201547 rake db:migrate:down

# simply launch bash within app directory
dip bash

# Additional commands

# update gems or packages
dip bundle install

# run psql console
dip psql

# run redis console
dip redis-cli

# run tests
dip rspec spec/path/to/single/test.rb:23

# shutdown all containers
dip down
```

Dip can be easily integrated into ZSH (especially if used `agnostic` theme) or Bash shell. 
So, there is allow us using all above commands without `dip` prefix. And it looks like we are not using Docker at all (really that's not true).

```sh
eval "$(dip console)"

rails c
rails s
rspec spec/test_spec.rb:23
psql evilmartians_development
VERSION=20100905201547 rake db:migrate:down
rake routes | grep blog
```

But after we get out to somewhere from the project's directory, then all Dip's aliases will be cleared. And if we get back, then Dip's aliases would be restored.
