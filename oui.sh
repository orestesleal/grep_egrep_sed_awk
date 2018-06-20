#!/bin/sh

# Description: Extract Ethernet Mac Addresses from an input file
#              and look for the vendor in the OUI db. The DB will
#              be downloaded in case it doesn't exist.
# Orestes Leal Rodriguez, 2018.
# TODOs: 1. walk the PATH env variable to find 'curl' & 'wget'

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
# Speed Hack. 
awk 'gsub(" *\\(hex\\).\t", " ")' oui.txt | awk '/^([[:alnum:]]{2})-/' > /tmp/oui2.txt
awk '{ 
       if ($1 ~ /^ *([[:xdigit:]]{2}[-:.]){5}[[:xdigit:]]{2} *$/) 
           print toupper($1)
     }' $1 \
 |
sed 's/[:\.]/-/g' | \

for mac in $(awk -F"-" '{ print $1"-"$2"-"$3 }'); do
    awk /$mac/ /tmp/oui2.txt
  done  | sort   # sort by Vendor.
