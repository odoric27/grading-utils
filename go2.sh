#!/bin/bash

#Use with labcp to follow links and copy files to pwd to running

echo "Looking for java file..."
myDir=$(pwd)
for file in $myDir/*
do
	if [[ $file != *".sh"* ]]; then
		echo -n "found: "
		echo $file
		target="$(readlink $file)"
		cp "$target" ./
		copy="${target%.*}" #drop extension
		copy="${copy##*/}" #drop filepath
		open "$copy.java"
		javac "$copy.java"
		
		#run tests
		echo "Running test caes..."
		touch $myDir/tests/output
		for test in $myDir/tests/*
		do
			if [[ $test != *"output" ]]; then
				java $copy < $test > "$test.out"
				cat "$test.out" >> "$myDir/tests/output"
				echo "" >> "$myDir/tests/output"
				rm "$test.out"
			fi
		done
		less ./tests/output
	
		echo "Hit any key to remove tempfiles and get next link..."
		read
		echo "Cleaning up..."
		rm "$myDir/tests/output"
		rm *.java
		rm *.class
		echo ""
	fi
done
echo "No more files."