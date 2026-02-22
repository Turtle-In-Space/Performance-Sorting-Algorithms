#!/usr/bin/env bash
# Runs python project

CURR_DIR=$(pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/..

args=("-l $1" "-u $2" "-s $3" "-i $4")
[ -n "$5" ] && args+=("-o $5")

python3 sort.py ${args[@]}

cd $CURR_DIR
