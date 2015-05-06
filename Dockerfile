FROM ruby:2.1
MAINTAINER Guillermo Guerrero Ibarra <wolf.fox1985@gmail.com>

# Install ruby dependencies
RUN apt-get update
RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Install nodejs
RUN apt-get install -y nodejs

# Install Nginx.
RUN apt-get install -y nginx
RUN chown -R www-data:www-data /var/lib/nginx

# Add default nginx config
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
ADD docker/nginx-sites.conf /etc/nginx/sites-enabled/default

# Install foreman
RUN gem install foreman
RUN gem install bundler
RUN gem install sqlite3

# Install the latest postgresql lib for pg gem
RUN apt-get install -y libpq-dev

## Install MySQL(for mysql, mysql2 gem)
RUN apt-get install -y libmysqlclient-dev

# Install Rails App
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app


# Add default unicorn config
ADD docker/unicorn.rb /app/config/unicorn.rb

# Add default foreman config
ADD docker/Procfile /app/Procfile

ENV RAILS_ENV production

CMD bundle exec rake assets:precompile
CMD bundle exec rake db:create
CMD bundle exec rake db:migrate
CMD bundle exec rake db:seed
CMD foreman start -f Procfile


