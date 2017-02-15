#!/bin/bash

#makes symlink of assignments located at $src to pwd
#symlink names = student netIDs
#provide lab number as arg

lab=$1

src="/Users/derekobrien/NYU/spring17/CS101/Labs/$lab"

find $src -name "*.java" | while read file;
do

#replace whitespace with underscore
fixed=`echo $file | sed 's/ /_/g'`

#remove filepath up to student name
fixed=`echo $fixed | awk '{ print substr( $0, 46, length($0) ) }'`

#remove student name
fixed=`echo $fixed | sed 's/[A-Za-z,_]*(//'`

#removes all but netID
fixed=`echo $fixed | sed 's/\([a-z]*[0-9]*\)\(.*$\)/\1/'`

#create symlink
ln -s "$file" "$fixed"
done;

