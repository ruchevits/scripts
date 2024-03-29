#!/bin/bash

export TMPDIR=$(mktemp -d /tmp/selfextract.XXXXXX)

echo "Temporary directory created: $TMPDIR"

echo "\nExtracting Server Config:"
ARCHIVE=$(awk '/^enter_yo_mama/ {print NR + 1; exit 0; }' $0)
tail -n+$ARCHIVE $0 | tar xzv -C $TMPDIR
CDIR=$(pwd)
cd $TMPDIR
cp -r payload.*/ .
rm -rf payload.*/

# echo "\nConfiguring file permissions"
# sudo chmod +x *.sh
# sudo chown root:wheel *

echo "\nRunning script"
clear
/bin/zsh ./main.sh

cd $CDIR

echo "\nRemoving the temporary directory"
rm -rf $TMPDIR

exit 0
enter_yo_mama
