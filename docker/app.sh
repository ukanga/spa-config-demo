#!/bin/sh
# vim:sw=4:ts=4:et

set -e

export APP_CODENAME=${APP_CODENAME:-"The Philosopher Supreme"}
export APP_NAME=${APP_NAME:-"React Runtime Configuration Demo"}
confd -onetime -backend env
sed -i "s/CONFIG_VERSION/`date '+%s'`/" /usr/share/nginx/html/index.html
