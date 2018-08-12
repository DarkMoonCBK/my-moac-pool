#!/bin/sh

set -e

if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
fi

# Create fake Go workspace if it doesn't exist yet.
workspace="$PWD/build/_workspace"
root="$PWD"
mcdir="$workspace/src/github.com/DarkMoonCBK"
if [ ! -L "$mcdir/my-moac-pool" ]; then
    mkdir -p "$mcdir"
    cd "$mcdir"
    ln -s ../../../../../. my-moac-pool
    cd "$root"
fi

# Set up the environment to use the workspace.
# Also add Godeps workspace so we build using canned dependencies.
GOPATH="$workspace"
GOBIN="$PWD/build/bin"
export GOPATH GOBIN

# Run the command inside the workspace.
cd "$mcdir/my-moac-pool"
PWD="$mcdir/my-moac-pool"

# Launch the arguments with the configured environment.
exec "$@"
