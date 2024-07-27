#!/usr/bin/env bash
set -e

script_dir="$(dirname $0)"
existing_dot_files=($(find $HOME -maxdepth 1 -type f -exec basename \{\} \; | sed 's/\.//g'))
mkdir -p "${script_dir}/backup_dot_files/" 
for file in $(ls "${script_dir}/dot_files"); do
  if printf '%s\0' "${existing_dot_files[@]}" | grep -Fxqz "${file}"; then
    mv "${HOME}/.${file}" "${script_dir}/backup_dot_files/${file}" 
  fi
  if ! test -f "${HOME}/.${file}"; then
    ln -s "${script_dir}/dot_files/${file}" "${HOME}/.${file}"
  fi
done
