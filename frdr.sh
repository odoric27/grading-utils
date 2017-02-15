#!/bin/bash

#Loops through java files in pwd and prompts to run
#Prompts to delete .java and .class files used during session before exit

echo "Listing files..."
ls -al
myDir=$(pwd)
next=0
nexxt=0
nexxxt=0
i=0
counter=0
echo -n "Search for java files [Y/y] [N/n] ? "
while [[ $next != "n" || $next != "N" ]];
do
	read next
	if [[ $next = "y" || $next = "Y" ]]; then
	clear
		for file in $myDir/*
		do
			if [[ $file == *".java"* ]]; then
				echo -n "found file: "
				echo $file
				((counter++))
				echo -n "Want to run it [Y/y] [N/n] ? "
				while [[ $nexxt != "n" || $nexxt != "N" ]];
				do
					read nexxt
					if [[ $nexxt = "y" || $nexxt = "Y" ]]; then
						f="${file%.*}" #drop extension
						g="${f##*/}" #drop filepath
						javac $file
						tempfiles[$i]="$g.java" #copy .java to array
						((i++))
						tempfiles[$i]="$g.class" # copy .class to array
						((i++))
						open "$g.java"
						java $g

						while [[ $nexxxt != "n" || $nexxxt != "N" ]];
						do
							echo -n "Run this file again [Y/y] [N/n] ? "
							read nexxxt
							if [[ $nexxxt = "y" || $nexxxt = "Y" ]]; then
								java $g
							elif [[ $nexxxt = "n" || $nexxxt = "N" ]]; then
								echo -n "[F/f] to find next file, any other key to exit search: "
								read nexxxt
								if [[ $nexxxt = "f" || $nexxxt = "F" ]]; then
									break
								else
									nexxxt="q"
									break
								fi
							else
								echo "Illegal Input. Try again"
							fi
						done

						if [[ $nexxxt = "f" || $nexxxt = "F" ]]; then
							#nexxt=0 #reset sentinel
							break
						elif [[ $nexxxt = "q" ]]; then
							break
						fi

					elif [[ $nexxt = "n" || $nexxt = "N" ]]; then
						echo "Searching for next file..."
						nexxt=0 #reset sentinel
						break
					else
						echo "Illegal Input. Try again"
					fi
				done
				if [[ $nexxxt = "q" ]]; then
					break
				fi
			fi
		done
		echo "Search complete"
		if [[ $counter == 0 ]]; then
			echo "No java files here..."
		fi
	elif [[ $next = "n" || $next = "N" ]]; then
		echo "Delete files used this session?"
		printf "%s\n" "${tempfiles[@]}"
		echo -n "[Y/y] to delete, any other key to exit without delete "
			read next
			if [[ $next = "y" || $next = "Y" ]]; then
				echo "Deleting files..."
				rm -f ${tempfiles[@]}
			else
				echo "OK. Files still in: $myDir"
			fi
		echo "Quitting..."
		break
	else
		echo "Illegal Input. Try again"
	fi
	echo "Search again [Y/y] [N/n] ?"
	next=0
	nexxt=0
	nexxxt=0
	counter=0
done