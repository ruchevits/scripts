#!/bin/bash

printf -- "\033[30;1m%s\n%s\n%s\033[0m\n" \
    "   ____                   _                      _   _           " \
    "  |  _ \   _   _    ___  | |__     ___  __   __ (_) | |_   ___   " \
    "  | |_) | | | | |  / __| | '_ \   / _ \ \ \ / / | | | __| / __|  " \
    "  |  _ <  | |_| | | (__  | | | | |  __/  \ V /  | | | |_  \__ \  " \
    "  |_| \_\  \__,_|  \___| |_| |_|  \___|   \_/   |_|  \__| |___/  " \
    "                                                                 " \
    "-----------------------------------------------------------------"

export tmpDir=$(mktemp -d /tmp/selfextract.XXXXXX)
printf -- "\nTemporary directory created:\nx $tmpDir\n"
printf -- "\nExtracting data archive:\n"
dataArchive=$(awk '/^enter_yo_mama/ {print NR + 1; exit 0; }' $0)
tail -n+$dataArchive $0 | tar xzv -C $tmpDir

cd $tmpDir
cp -r payload.*/ .
rm -rf payload.*/

# echo "\nConfiguring file permissions"
# sudo chmod +x *.sh
# sudo chown root:wheel *

printf -- "\n"

printf -- "-----------------------------------------------------------------\n"

printf "\033[0m"

/bin/zsh ./main.sh

printf "\033[30;1m"

printf -- "-----------------------------------------------------------------\n"

echo "\nRemoving the temporary directory\n"
rm -rf $tmpDir

printf "\033[0m"
exit 0
enter_yo_mama
