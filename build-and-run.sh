#!/bin/sh
set -o errexit -o nounset -o pipefail
pkg=$(nix-build --no-out-link -E 'with import <nixpkgs> {}; callPackage ./default.nix {}')
exec $pkg/bin/cheese "$@"
