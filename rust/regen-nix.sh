#!/usr/bin/env nix-shell
#!nix-shell -p cargo carnix -i bash
set -o errexit -o nounset -o pipefail

crate_path=$(dirname ${BASH_SOURCE[0]})
cd $crate_path

cargo update
carnix generate-nix --src .
