#! /usr/local/bin/ksh93

# Description: Extract Ethernet Mac Addresses from an input file
#              and look for the vendor in the OUI db.
# ~ Orestes Leal Rodriguez, 2018.

OUIDB=http://standards-oui.ieee.org/oui.txt

if [ ! -f "oui.txt" ]; then
  echo "# info: the OUI db oui.txt is not here, downloading now..."
  which wget 1>/dev/null
  if [ "$?" -eq "0" ]; then
     wget "$OUIDB" 2>/dev/null
  else
     # fall back to curl, try to find it...
     which curl 1>/dev/null
     if [ "$?" -eq "0" ]; then
         curl $OUIDB -O
     else
         echo "# Error: neither CURL or WGET were found, install one of them"
         exit 1
     fi
  fi
fi

# Speed Hack. I get a 2x improvement in speed filtering the interesting fields
gawk 'gsub(/ *\(hex\).\t/, " ")' oui.txt > /tmp/oui2.txt
gawk '{
       if ($1 ~ /^ *([[:xdigit:]]{2}[-:.]){5}[[:xdigit:]]{1,2} *$/)
           print toupper($1)
     }' $1 \
 |
sed 's/[:\.]/-/g' \
 |
for mac in $(gawk -F"-" '{ print $1"-"$2"-"$3 }'); do
   gawk /$mac/ /tmp/oui2.txt
done \
 |
sort \
 |
sed '1i\
\
OUI   -   Vendor\
===       ======\
'
