#!/usr/bin/env bash
# Cleans Go project

CURR_DIR=$(pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/..
go clean
cd $CURR_DIR
