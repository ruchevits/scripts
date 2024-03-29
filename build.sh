#!/bin/bash

SOURCE_DIR=src
BUILD_DIR=build

if [ ! -d $BUILD_DIR ]; then
	mkdir $BUILD_DIR
fi

echo "Consolidating configuration resources"
export TMPDIR=$(mktemp -d payload.XXXXXXXX)

#cp Source/RUNme.sh payload/
# cp -r $SOURCE_DIR/general/ $TMPDIR/
# cp $TMPDIR/keys/* $TMPDIR/
cp -f $SOURCE_DIR/$1/* $TMPDIR/
tar cf $BUILD_DIR/$TMPDIR.tar $TMPDIR/*
cd $BUILD_DIR/
echo "Creating Self Extracting Bash Deployable"
if [ -e "$TMPDIR.tar" ]; then
	gzip $TMPDIR.tar

	if [ -e "$TMPDIR.tar.gz" ]; then
		DATE=$(date +%Y%m%d%H%M%S)
		FILE=$1
		# FILE=$1_$DATE
		cat ../runner.sh $TMPDIR.tar.gz >$FILE.bsx
		echo "... DONE!"
	else
		echo "$TMPDIR.tar.gz does not exist"
		exit 1
	fi
else
	echo "$TMPDIR.tar does not exist"
	exit 1
fi

echo "$FILE.bsx has been saved to the $BUILD_DIR directory."
echo "Temporary Files adn Directories have been removed"
cd ..
rm -rf $TMPDIR
rm -f $BUILD_DIR/$TMPDIR.tar.gz
exit 0
