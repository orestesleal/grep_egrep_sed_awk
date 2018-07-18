#! /bin/sh

# this support script do full by 'octet by octet' validation
# of the ipv4 address for the Mighty IPv4 scavenger in ipscav.sed

sed -Ef ipscav.sed ips \
 |
awk -F. '
{
 if (NF != 4)
  next            # Invalid IP address, goto next record, in practice
 else             # this is catched by the scavenger in the sed(1) script
   for (i = 1; i < NF; i++)
     if ($i > 255)
       next       # octet is higher than 255, not a valid # for an ipv4 octet
   print $0
}'
