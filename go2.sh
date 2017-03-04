#!/bin/bash

#Use with labcp to follow links and copy files to pwd to running

echo "Looking for java file..."
myDir=$(pwd)
for file in $myDir/*
do
	if [[ $file != *".sh"* ]]; then
		echo -n "found: "
		echo $file
		echo -n "Grade this submission? [S/s] to skip, anything else to grade: "
		read skip
		case $skip in
			[Ss]* ) echo "Skipping..."
					continue;
		esac
		target="$(readlink $file)"
		student=`echo $file | awk '{ print substr( $0, 33, length($0) ) }'`
		echo "==================================="
		echo "Currently grading netID: $student"
		#add in actual name instead of id here... see labcp regex
		echo "==================================="

		cp "$target" ./
		copy="${target%.*}" #drop extension
		copy="${copy##*/}" #drop filepath
		open "$copy.java"
		javac "$copy.java"
		
		#run tests
		echo "Running test cases..."
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
	
		echo "Hit return to remove tempfiles and get next link..."
		read
		echo "Cleaning up..."
		rm "$myDir/tests/output"
		rm *.java
		rm *.class
		echo ""
		echo "========================================"
		echo ""
	fi
done
echo "No more files."