#!/bin/sh

#
# Cyclic build script triggered by file changes. Useful when editing with an ordinary
# text editor.
#
# yaourt -S inotify-tools
#

COMMAND=${1:-test}

# Some statistics
find src -name "*.rs" | xargs wc -l

# Show outdated crates
echo ""
cargo update
echo ""
cargo outdated
echo ""

# Let's use incremental build if available
export CARGO_INCREMENTAL=1

# The initial build
echo "Running cargo with command '$COMMAND'"
cargo $COMMAND

# Build on demand
while inotifywait -e close_write -r . &>/dev/null
    do sync
    reset
    cargo $COMMAND
done

