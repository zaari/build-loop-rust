
# build-loop-rust

A looping build script which builds when a file changes. Helpful when editing Rust 
source code without a proper IDE or language server. This script uses cargo-watch if 
it is available or Linux inotify if not.

# Features

* Shows line counts
* Runs cargo audit
* Runs cargo update
* Runs cargo outdated
* Runs cargo test (or any other subcommand) when any source file is changed

# Installation

You have to add the location of the script to PATH environment variable or
save (or link) the script to a location on the PATH.

It's recommended that [cargo-watch], [cargo-audit] and [cargo-outdated] extensions are installed.

[cargo-watch]: https://github.com/watchexec/cargo-watch
[cargo-audit]: https://github.com/RustSec/cargo-audit
[cargo-outdated]: https://github.com/kbknapp/cargo-outdated

