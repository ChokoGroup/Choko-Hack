#!/bin/sh
# Rebuild hackinstall.tar.gz from src/hackinstall
# and copy it to the installer and updater folders.

set -eu

_var_repo_folder="$(cd "$(dirname "$0")" && pwd)"
_var_source_folder="${_var_repo_folder}/src/hackinstall"
_var_temporary_file="$(mktemp)"
trap 'rm -f "$_var_temporary_file"' EXIT

# Owner root:root so extracting as root never leaves /etc or /usr owned by another uid
tar -C "$_var_source_folder" --sort=name --owner=0 --group=0 --numeric-owner --mode='go-w' -cf - .choko etc root usr | gzip -9n > "$_var_temporary_file"

for _var_destination_folder in "${_var_repo_folder}/FILES_TO_COPY_TO_CHA_DRIVE" "${_var_repo_folder}"/Choko\ Hack\ v*\ Updater\ for\ USB*/CHA_MOD
do
  if [ ! -d "$_var_destination_folder" ]
  then
    echo "Folder not found: $_var_destination_folder" >&2
    exit 1
  fi
  cp "$_var_temporary_file" "${_var_destination_folder}/hackinstall.tar.gz"
  echo "Updated: ${_var_destination_folder#"$_var_repo_folder"/}/hackinstall.tar.gz"
done

echo "Size: $(wc -c < "$_var_temporary_file") bytes"
echo "MD5:  $(md5sum < "$_var_temporary_file" | cut -d' ' -f1)"
