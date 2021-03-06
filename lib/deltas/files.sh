#!/bin/bash
set -euo pipefail

define_option short=s long="source" variable=src desc="The source directory of dotfiles"
define_option short=t long=target variable=target default="${HOME}" desc="The target directory for dotfiles"

valid_options() {
  [ -n "${src+x}" ] && [ -n "${src}" ]
}

sources() {
  echo $(ls -A "${src}")
}

applied() {
  missing_links=()

  for entry in $(sources); do
    local link_source="$(real_path "${src}/${entry}")"
    local link_target="$(real_path ${target}/${entry})"

    if [ "${link_target}" != "${link_source}" ]; then
      missing_links+=("${entry}")
    fi
  done

  if [ ! -d "${HOME}/.gnupg" ]; then
    return -1
  fi

  echo "links: ${#missing_links[@]}"
  return ${#missing_links[@]}
}

apply() {
  for entry in ${missing_links[@]}; do
    ln -sf "$(real_path ${src}/${entry})" "${target}/${entry}" || return $?
    success "linked $(real_path "${src}/${entry}") to ${target}/${entry}"
  done

  if osx; then
    cp -a lib/fonts/. ${HOME}/Library/Fonts/
  fi

  if osx; then
    ln -sf "$(real_path lib/gnupg/osx)" "${target}/.gnupg" || return $?
    success "linked $(real_path lib/gnupg/osx) to ${target}/.gnupg"
  fi
  if linux; then
    ln -sf "$(real_path lib/gnupg/linux)" "${target}/.gnupg" || return $?
    success "linked $(real_path lib/gnupg/linux) to ${target}/.gnupg"
  fi
}
