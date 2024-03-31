#!/bin/bash

log_file="./log.txt"

# exec 2>&1 1>./log.txt
# exec > >(tee $log_file) 2>&1

os="$(uname)"   # os type
tw=$(tput cols) # terminal width

function abort() {
    abortPrintFmt="\n\033[31;1m%s\033[0m\n\n"
    printf $abortPrintFmt "$@" >&2
    exit 1
}

if [[ "${os}" != "Darwin" ]]; then
    abort "This script is only supported on MacOS."
fi

function printf_separator() {
    printf "\n\033[30;1m"
    for i in $(eval echo {1..$tw}); do
        printf "-"
    done
    printf "\033[0m\n\n"
}

printf "\033[30;1m%s\033[0m\n" \
    "                                                                 " \
    "   ____                   _                      _   _           " \
    "  |  _ \   _   _    ___  | |__     ___  __   __ (_) | |_   ___   " \
    "  | |_) | | | | |  / __| | '_ \   / _ \ \ \ / / | | | __| / __|  " \
    "  |  _ <  | |_| | | (__  | | | | |  __/  \ V /  | | | |_  \__ \  " \
    "  |_| \_\  \__,_|  \___| |_| |_|  \___|   \_/   |_|  \__| |___/  "

printf_separator

tmpDir=$(mktemp -d /tmp/selfextract.XXXXXX)
printf "\033[30;1m%s\n%s\n\033[0m" "Temporary directory created:" "$tmpDir"

dataArchive=$(awk '/^enter_yo_mama/ {print NR + 1; exit 0; }' $0)

printf "\n\033[30;1m%s\033[0m\n" "Extracting data archive:"

printf "\033[30;1m"
tail -n+$dataArchive $0 | tar xzv -C $tmpDir
printf "\033[0m"

cd $tmpDir
cp -r payload.*/ .
rm -rf payload.*/

printf_separator

# TODO: check if ZSH is available
/bin/zsh ./main.sh $@

printf_separator

rm -rf $tmpDir
printf "\033[30;1m%s\n%s\n\033[0m\n" "Temporary directory deleted:" "$tmpDir"

exit 0
enter_yo_mama
