#! /usr/bin/env bash

set -e

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <output wasm file>"
    exit 1
fi

cargo build --target wasm32-wasip1 --release
wizer --allow-wasi --wasm-bulk-memory true --dir . -o "$1" target/wasm32-wasip1/release/wizened_sample.wasm
# If wasm-opt is installed, run it to optimize the output
if command -v wasm-opt &> /dev/null
then
    wasm-opt -O3 -o "$1" "$1"
fi
echo -n "Component size: "
ls -lh "$1" | awk '{print $5}'