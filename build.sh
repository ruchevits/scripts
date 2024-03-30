#!/bin/bash

srcDir=src
outDir=build

if [ ! -d $outDir ]; then
	mkdir $outDir
fi

export tmpDir=$(mktemp -d payload.XXXXXXXX)
echo "Temporary directory created: $tmpDir"

echo "Consolidating resources"

cp -rf $srcDir/$1/* $tmpDir/
tar cf $outDir/$tmpDir.tar $tmpDir/*

cd $outDir/
echo "Creating Self Extracting Bash Deployable"
if [ -e "$tmpDir.tar" ]; then
	gzip $tmpDir.tar

	if [ -e "$tmpDir.tar.gz" ]; then
		DATE=$(date +%Y%m%d%H%M%S)
		FILE=$1
		# FILE=$1_$DATE
		cat ../src/runner.sh $tmpDir.tar.gz >$FILE.bsx
		echo "... DONE!"
	else
		echo "$tmpDir.tar.gz does not exist"
		exit 1
	fi
else
	echo "$tmpDir.tar does not exist"
	exit 1
fi

echo "$FILE.bsx has been saved to the $outDir directory."
echo "Temporary Files adn Directories have been removed"
cd ..
rm -rf $tmpDir
rm -f $outDir/$tmpDir.tar.gz

exit 0
