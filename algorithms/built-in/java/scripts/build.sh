#!/usr/bin/env bash
# Builds Maven project

CURR_DIR=$(pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/..
mvn -q package
cd $CURR_DIR
