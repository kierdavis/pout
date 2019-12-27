#!/bin/sh
set -o errexit -o nounset -o pipefail
pkg=/tmp/pout-build
nix-build -o $pkg -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
export G_MESSAGES_DEBUG=all
exec $pkg/bin/pout "$@"
