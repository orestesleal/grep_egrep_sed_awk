#!/bin/sh
#
# Description: Extract Ethernet Mac Addresses from an input file
#              and look for the vendor in the OUI db. The DB will
#              be downloaded in case it doesn't exist.
#
# Orestes Leal Rodriguez, 2018.
#
# NOTE: there are a few pipe(2)s used here. I would like to
#       improve this code by using only 'awk' to avoid the pipe I/O
#       and the invoking the bourne shell loop, etc.
#
# NOTE2: This code would NOT work on the default 'awk' of freebsd
#        since it doesn't support bounds (\{N\})
#
# Start.
# do some housekeeping, test for the OUI db, download it
# if not found, check if wget is installed

OUIDB=http://standards-oui.ieee.org/oui.txt 

if [ ! -f "oui.txt" ]; then
  echo "### warning: the OUI db is not here, downloading now..."
  
  which wget 1>/dev/null

  if [ "$?" -eq "0" ]; then
     wget "$OUIDB" 2>/dev/null
  else 
     # fall back to curl, try to find it... # TODO: walk the PATH env variable
     which curl 1>/dev/null
     if [ "$?" -eq "0" ]; then    
         curl $OUIDB
     else 
         echo "### Error: neither CURL or WGET were found, install one of them"
         exit 1
     fi
  fi
fi


# Speed Hack. parse oui.txt extracting only the 'hex' entries
# in my case this provides at least a 2x improvement in speed
# as measured by time(1)
awk '/^([A-F0-9]{2})-/' oui.txt > /tmp/oui2.txt


# use one RE to match Ethernet MAC addresses, conver them
# to uppercase, repl with sed any address that used a format
# that is not XX-XX-... and process the entries for matching

awk '{ 
       if ($1 ~ /^ *([a-fA-F0-9]{2}[-:.]){5}[0-9A-Fa-f]{2} *$/) 
           print toupper($1)
     }' $1 \
 |
sed 's/[:\.]/-/g' | \

for mac in $(awk -F"-" '{ print $1"-"$2"-"$3 }')
  do
     awk /$mac/ /tmp/oui2.txt | awk '{ print $3 " -> " $1}'    # TODO: improve it without the pipe

  done  | sort   #  sort by Vendor. this sort makes the script looks slower but the origin
                 #  end of the pipeline is just buffering to pass the data to sort

