#!/bin/bash
set -e

# You can run it from any directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Execute common pre-setup, include test functions.
# shellcheck disable=SC1090
source "$DIR/common.sh"

printTestStarted

# Create several files that should be synced to remote machine.
mkdir "$BUILD_DIR/src"
touch "$BUILD_DIR/src/file1.txt"
touch "$BUILD_DIR/src/file2.txt"
touch "$BUILD_DIR/src/file3.txt"

# Run mainframer that creates "build" result file that should be synced back to local machine.
"$MAINFRAMER_EXECUTABLE" 'mkdir build && touch build/buildresult.txt'

# Make sure files exist on local machine after sync.
fileMustExistOnLocalMachine "build/buildresult.txt" "(sync problem)"

printTestEnded
