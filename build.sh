#!/bin/bash
# Use deterministic flags
export CXX=g++
export CXXFLAGS="-g -O2 -frandom-seed=42 -Wno-builtin-macro-redefined"
export LDFLAGS="-Wl,--build-id=none"

# Fix timestamps using SOURCE_DATE_EPOCH


# Compile
$CXX $CXXFLAGS hello.cpp -o hello

shasum -a 256 hello > hash
