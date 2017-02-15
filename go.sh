#!/bin/bash

#Find java files in pwd and run them
#Prompt before delete, but will always delete with any input
#only useful when one program in pwd

echo "Listing files..."
ls -al
echo "Looking for java file..."
myDir=$(pwd)
for file in $myDir/*
do
	if [[ $file == *".java"* ]]; then
		echo -n "found file: "
		echo $file
		f="${file%.*}" #drop extension
		g="${f##*/}" #drop filepath
		javac $file
		open "$g.java"
		java $g
		break
	fi
done

echo "Press any key to remove .java/.class files..."
read

rm *.class
rm *.java