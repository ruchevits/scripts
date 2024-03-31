#!/bin/bash

tmp=$(mktemp)

curl -fsSL https://raw.githubusercontent.com/ruchevits/scripts/master/build/setup.bsx >$tmp

/bin/bash $tmp

rm $tmp
