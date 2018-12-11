#!/bin/sh
# this script needs mail-utils installed
# tested on linux only
# Orestes Leal ROdriguez <oleard1981@gmail.com>, 2018.
#
#  The question is: Who is logged in into my computer?
#  
#  step 1. configue your email in the below variable.
#       2. Configure your username below in the 'me' variable
#       3. Run and discover who is in and will be in in the next
#          hours,days,weeks.
#
email=leal@cs.uky.edu
me=leal
whowasin()
{
  for u in $2
    do
      if [ "$1" = "$u" ]; then
        return 1
      fi
    done
   return 0
}
addhim()
{
   list="$list $1"
}
list=""
while true
 do
   for who in `w|egrep "tty|pts" | awk '{print $1}'`
    do
      if [  "$who" = "$me" ]; then
        echo -n "-"
        sleep 0.1
      else
        whowasin $who $list
        if [ "$?" -eq "0" ]; then
          details=`w | grep $who | tail -n 1`
          fromwhere=`w | egrep ^$who | awk '{print $3}'`
          if [ "$?" -eq "0" ]; then
mail -s "$who is logged in from $fromwhere" $email << EOF
$who is logged in. 
$details
EOF
        addhim $who
          fi
        fi
      fi
    done
 echo -n "+"
 sleep 1
 done
