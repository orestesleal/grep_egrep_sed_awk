#!/bin/sh

# Description: Extract Ethernet Mac Addresses from an input file
#              and look for the vendor in the OUI db. The DB will
#              be downloaded in case it doesn't exist.

# Orestes Leal Rodriguez, 2018.


# do some housekeeping, test for the OUI db, download it
# if not found, check if wget is installed
# TODO: fallback to curl in case wget is not found


OUIDB=http://standards-oui.ieee.org/oui.txt 

if [ ! -f "oui.txt" ]; then
  echo "### warning: the OUI db is not here, downloading now..."
  
  which wget 1>/dev/null

  if [ "$?" -eq "0" ]; then
     wget "$OUIDB" 2>/dev/null
  else 
     # fall back to curl, try to find it...
     which curl 1>/dev/null
     if [ "$?" -eq "0" ]; then    
         curl $OUIDB
     else 
         echo "### Error: neither CURL or WGET were found, install one of them"
         exit 1
     fi
  fi
fi


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
     awk /$mac/ oui.txt | awk '{ print $1 " -> " $3}'    # TODO: improve it without the pipe
  done

