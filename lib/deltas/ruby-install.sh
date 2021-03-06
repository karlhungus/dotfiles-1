#!/bin/bash
set -euo pipefail

define_option short=v long=version variable=version desc="The version to install"

valid_options() {
  [ -n "${version}" ]
}

applied() {
  [[ "$(which ruby-install && ruby-install -V)" =~ "ruby-install: ${version}" ]]
}

apply() {
  download_file "https://github.com/postmodern/ruby-install/archive/v${version}.tar.gz" /tmp || return $?
  extract_archive "/tmp/v${version}.tar.gz" || return $?

  pushd /tmp/ruby-install-${version} >/dev/null
  # prevent sudo from making a ~/.cache/ruby-install/ruby dir
  mkdir -p ~/.cache/ruby-install/ruby
  sudo make install
  popd >/dev/null

  rm -rf /tmp/v${version}.tar.gz /tmp/ruby-install-${version}
}
