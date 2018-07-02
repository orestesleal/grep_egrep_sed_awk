#! /bin/sh

# ~ Description:
#      Extract Ethernet Mac Addresses from an input file
#      and find the vendor for the adapter in the OUI db.
#   Orestes Leal Rodriguez, 2018.

if [ ! -f oui.txt ];
then
   echo "## manufacturers OUI db not found, downloading..."

   gawk 'BEGIN {

      ieee_server = "/inet/tcp/0/standards-oui.ieee.org/80"
      http_request = "GET /oui.txt HTTP/1.1\r\nHost: standards-oui.ieee.org\r\nConnection: close\r\n\r\n"

      print http_request |& ieee_server          # sent request over the gawk socket

      while ((ieee_server |& getline) > 0)
        if ( match($0, "(hex)") != 0) {          # match what I need. optimization
           sub(/ *\(hex\).\t/, " ", $0)
           print $0
        }

   }' > oui.txt

   if [ "$?" -ne "0" ];
   then
      echo "^^ An error has occurred while downloading the oui database, please try again"
      exit 1
   fi
fi

gawk '{
       if ($1 ~ /^ *([[:xdigit:]]{2}[-:.]){5}[[:xdigit:]]{1,2} *$/)
           print toupper($1)
     }' $1 \
 |
sed 's/[:\.]/-/g; s/^ *//' \
 |
for mac in $(gawk -F"-" '{ print $1"-"$2"-"$3 }'); do
    gawk /$mac/ oui.txt
done \
 |
sort \
 |  \
sed '1i\
\
   OUI   -   Vendor\
   ===       ======\
'

