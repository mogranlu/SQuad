#!/bin/bash
#============================================================
# @author: Morten Granlund
#
# Comment:
# --------
# This script creates a md5sum snapshot output which can be
# compared with a file structure at any other time to detect
# which files have been added, deleted or changed.
#
# Finding the files changed, added, or removed is as simple
# as diffing the output from this command run at two different
# point in time.  
#
# 
# Two things to note about the internal mechanisms of this script: 
#            --------
#
# 1) The crawling mechanism is base on the linux "ls" 
#	 (list files) command with the following two options:
#      --almost-all (lists hidden files)
#      --dereference (follows symbolic links)
#    Look out for cyclic links due to the sym links
# 2) All checksums are created using the "md5sum" command,
#    which by default treats all files as text. For other
#	 options, check out "md5sum --help"
#
#============================================================

#------------------------------------------------------------
# A general function for printing the usage of this script.
#------------------------------------------------------------
function printUsage() {
	echo "Usage: $0 <file-or-dir>"
} >&2

#------------------------------------------------------------
# A general function for printing the checksum of files
# within a directory (may call itself recursively).
#
# @param $1 = <filepath>, e.g. javazoneman/scripts/source
#------------------------------------------------------------
function stockDir() {
	local filesInDir=$(ls --almost-all --dereference $1)
	for nextFile in $filesInDir; do
		nextFile=$1/$nextFile

		if [ -d "$nextFile" ]; then
			stockDir $nextFile		
		elif [ -f "$nextFile" ]; then  
			stockFile $nextFile
		else
			echo "404 file not found : $nextFile"
		fi	  

	done
}

#------------------------------------------------------------
# A general function for printing a checksum for a 
# single file.
#
# @param $2 = <filepath>, e.g. "/home/niceguy/script/hack.sh"
#------------------------------------------------------------
function stockFile() {
	md5sum $1 | awk '{ print $2, $1}'
}


#============================================================
# Start of actual script!
#============================================================
# Start crawling from the file given by command-line param #1
rootFile=$1

# Check the file, and start crawling&creating checksums:
if [ "$rootFile" == "" ]; then
	echo "Error: You must specify a file or directory!" >&2
	printUsage
	exit 1
elif [ ! -e "$rootFile" ]; then
	echo "FILE DOES NOT EXIST!"
	printUsage
	exit 1
elif [ -d "$rootFile" ]; then
	stockDir $rootFile
elif [ -f "$rootFile" ]; then
	stockFile $rootFile
fi

