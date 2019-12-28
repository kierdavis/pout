#!/bin/sh
set -o errexit -o nounset -o pipefail
pkg=/tmp/pout-build
nix-build -o $pkg -E 'with import <nixpkgs> {}; callPackage ./default.nix { inherit (rustPlatform) buildRustPackage; }'
#export G_MESSAGES_DEBUG=all
#export GST_DEBUG=4  # INFO
$pkg/bin/pout
