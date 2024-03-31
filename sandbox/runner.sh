export TMPDIR=$(mktemp -d /tmp/selfextract.XXXXXX)

echo "Temporary directory created: $TMPDIR"

echo "\nExtracting data archive:"
printf '%s' "$archive_data" | tar xzv -C "$TMPDIR"

echo "\nRemoving the temporary directory"
rm -rf $TMPDIR

exit 0
