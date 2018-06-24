#!/bin/sh

# sort and organize a list of users, system users, by Shell
# /etc/passwd is world readable so the script will work for
# any user
# Orestes Leal Rodriguez, 2018

awk -F: '/^[a-zA-Z]/ { print $7 " " $1 " " $3 }' /etc/passwd \
 |
sort  \
 |
awk -F" "  '
$1 == shell {
      print "\t" $3 "\t" $2 
}
$1 != shell {
      shell = $1
      print $1 
      print "\t" $3 "\t" $2
}'
