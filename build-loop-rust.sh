#!/bin/sh

#
# Cyclic build script triggered by file changes. Helpful when editing Rust 
# source code without an IDE or language server.
#
# Dependency: 
#   inotify-tools (Linux-only)
#   cargo-audit
#   cargo-outdated
#

COMMAND=${1:-test}

# Update, show vulnerable crates and list outdated root crates
cargo update && echo ""
cargo help audit &>/dev/null && cargo audit && sleep 1s && echo ""
cargo help outdated &>/dev/null && cargo outdated -R && sleep 1s && echo ""

# Some statistics
find src -name "*.rs" | xargs wc -l && sleep 1s && echo ""

# The initial build
shift
echo "Running cargo with subcommand '$COMMAND' $*"
cargo $COMMAND $*

# Build on demand
while inotifywait -e modify --exclude target -r . &>/dev/null ; do
    sync
    reset
    cargo $COMMAND $*
done

