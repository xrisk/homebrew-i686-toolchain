#!/usr/bin/env bash

# Run `source ~/cross-dev.sh` when using the toolchain.

export CC="$(brew --prefix i686-elf-gcc)/bin/i686-elf-gcc"
export LD="$(brew --prefix i686-elf-binutils)/bin/i686-elf-ld"
export AR="$(brew --prefix i686-elf-binutils)/bin/i686-elf-ar"
