#!/bin/bash

echo "\$0 = $0"

me=$(
    cd "$(dirname "$0")"
    pwd
)/"$(basename "$0")"

ARCHIVE=$(awk '/^enter_yo_mama/ {print NR + 1; exit 0; }' $0)

echo "\$ARCHIVE = $ARCHIVE"
echo "\$me = $me"

exit 0
enter_yo_mama
