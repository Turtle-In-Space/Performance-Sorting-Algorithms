#!/usr/bin/env bash
# Cleans maven project

CURR_DIR=$(pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/..
mvn -q clean
cd $CURR_DIR
