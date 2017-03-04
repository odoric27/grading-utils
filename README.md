# grading-utils
A collection of scripts to make grading student assignments more efficient

labcp - navigates student submission directory and creates symlinks of files in pwd
go2 - after creating symlinks with 'labcp', go2 cycles through pwd and runs each one. tests can be queued up as input. all results concatenated into one 'output' file for review. Also opens up source code for manual review. Cleans up temp files after each run.
frdr - a more verbose version of go. a starting place for the afore-mentioned scripts.