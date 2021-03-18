
# build-loop-rust

This is a small script which helps Rust development when an IDE is not used.
Its behaviour is similar to `cargo watch` command.
The script is run on the same directory where Cargo.toml file is located. 

# Features

* Shows line counts
* Runs cargo audit
* Runs cargo update
* Runs cargo outdated
* Runs cargo test (or any other subcommand) when any source file is changed

# Installation

You have to add the location of the script to PATH environment variable or
save (or link) the script to a location on the PATH.

It's expected that [cargo-audit] and [cargo-outdated] extensions are installed.

[cargo-audit]: https://github.com/RustSec/cargo-audit
[cargo-outdated]: https://github.com/kbknapp/cargo-outdated

