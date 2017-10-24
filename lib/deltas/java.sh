#!/bin/bash
set -euo pipefail

applied() {
  # this version test is the only thing common across openjdk and oracle java
  [[ $(which java && java -version 2>&1) =~ "version" ]]
}

apply() {
  if osx; then
    brew cask install java
    apply_delta "install sbt" "bin/apply packages sbt" || return $?
  elif linux; then
    sudo apt-get install -y default-jre
  fi
}
