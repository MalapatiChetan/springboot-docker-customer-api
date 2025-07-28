#!/bin/sh

host="$1"
shift
cmd="$@"

until pg_isready -h "$host" -p 5432 -U "chetan"; do
  echo "Postgres is unavailable - sleeping"
  sleep 2
done

echo "Postgres is up - executing command"
exec $cmd
