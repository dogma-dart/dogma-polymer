#!/bin/sh
set -ex

# Get version
dart --version

# Install dependencies
pub install

# Lint the code
pub global activate linter
pub global run linter .

# Run the tests
#pub run test -p dartium
