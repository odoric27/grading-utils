#!/bin/bash

#Use with labcp to follow links and copy files to pwd to running

echo "Listing files..."
ls -al
echo "Looking for java file..."
myDir=$(pwd)
for file in $myDir/*
do
	if [[ $file != *".sh"* ]]; then
		echo -n "found: "
		echo -n $file
		echo -n " > "
		target="$(readlink $file)"
		echo $target
		cp "$target" ./
		copy="${target%.*}" #drop extension
		copy="${copy##*/}" #drop filepath
		echo -n "copy="
		echo $copy
		open "$copy.java"
		javac "$copy.java"
		java $copy
		echo "Hit any key to remove tempfiles and get next link..."
		read
		rm *.java
		rm *.class
		echo ""
	fi
	echo "No more files."
done