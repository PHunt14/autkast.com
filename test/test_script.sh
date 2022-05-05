#!/bin/sh
set -u
set -o errexit

someFunction() {
    endTime=$(( $(date +%s) + userTimeout ))
    for component in foo bar
    do
        echo "checking $component"
    done
}

someFunction