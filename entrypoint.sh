#!/bin/bash
set -e

RAILS_PORT=3000
if [ -n "$PORT" ]; then
  RAILS_PORT=$PORT
fi

bin/rails assets:precompile
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

rm -f tmp/pids/server.pid

bin/rails s -p $RAILS_PORT -b 0.0.0.0
