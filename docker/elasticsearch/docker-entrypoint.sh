#!/bin/bash

set -e

# add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	for path in $ES_HOME/data $ES_HOME/logs
	; do
		chown -R elasticsearch:elasticsearch "$path"
	done
	set -- su-exec elasticsearch "$@"
fi

exec "$@"
