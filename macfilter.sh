#!/bin/sh

# matching an Ethernet MAC address with egrep using a regular expression
# sed is used finally to remove leading spaces inserted in the beginning of the line

# separate the regex using on this script for easy
# modifcation of it 
#
REGEX="^ *([a-fA-F0-9]{2}[-\.:]){5}[a-fA-F0-9]"

# check the argument before anything else
 if [ "$#" -lt 1 ]; then
    echo "Not enough arguments for the program, pass the file as first parameter"
    exit 1
 fi

# check to see if the input is an existing file
 if [ ! -f "$1" ]; then 
    echo "input $1 is Not a file, good bye"
    exit 1
 fi

# requirement list for software that should be available
# this list can be extended to include more utilities
# that are required by this script, don't assume they are
# already in place
req="sed egrep"

for f in $req; do
  `which $f &>/dev/null`   # do the test to get the return value
   if [ "$?" = 1 ]; then 
      echo "$f was not found, install $f first"
      exit 1
   fi
done

# get the egrep & sed binary locations to call it directly
EGREP=`which egrep`
SED=`which sed`

# execute egrep & sed
${EGREP} "${REGEX}" $1 | ${SED} 's/^ *//'
