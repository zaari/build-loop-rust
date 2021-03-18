#!/bin/sh

#
# Cyclic build script which builds when a file changes. Helpful when editing Rust 
# source code without an IDE or language server. This script is similar to cargo-watch extension.
#
# Dependencies: 
#   inotify-tools (Linux-only)
#   cargo-audit
#   cargo-outdated
#

COMMAND=${1:-test}

# Reset terminal
reset

# Some statistics
find src -name "*.rs" | xargs wc -l && sleep 1s && echo ""

# Update, show vulnerable crates and list outdated root crates
cargo update && echo ""
cargo help outdated &>/dev/null && cargo outdated -R && sleep 1s && echo ""
cargo help audit &>/dev/null && cargo audit && sleep 1s && echo ""

# The initial build
shift 2>/dev/null
echo "Running cargo with subcommand '$COMMAND' $*"
cargo $COMMAND $*

# Build on demand
while inotifywait -e modify --exclude target -r . &>/dev/null ; do
    sync
    clear
    cargo $COMMAND $*
done

