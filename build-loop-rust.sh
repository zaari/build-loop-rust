#!/bin/sh

#
# Cyclic build script triggered by file changes. Helpful when editing Rust 
# source code without an IDE or language server.
#
# Dependency: 
#   inotify-tools
#   cargo-audit
#   cargo-outdated
#

COMMAND=${1:-test}

# Show vulnerable and outdated crates
cargo update
echo ""
cargo audit
echo ""
sleep 1s
cargo outdated
echo ""
sleep 1s

# Some statistics
echo ""
find src -name "*.rs" | xargs wc -l
sleep 1s

# The initial build
echo ""
echo "Running cargo with subcommand '$COMMAND'"
cargo $COMMAND

# Build on demand
while inotifywait -e close_write -r . &>/dev/null
    do sync
    reset
    cargo $COMMAND
done

