#!/bin/sh
set -eux

cd "$(dirname "$(readlink -f "$0")")/.."

bundle exec nanoc check internal_links
bundle exec nanoc deploy
