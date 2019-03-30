#!/bin/sh
# 
#  Orestes Leal Rodriguez, 2019, <olealrd1981@gmail.com>
#  
#  print only rfc1898 addresses.
#  the input file should be a list
#  IPv4 addresses, one per line.
#  
#  Usage: ./check_priv.sh input_file
#   
#  1. https://tools.ietf.org/html/rfc1918


#  detect rfc 1918 addresses [1] and return 1 if rfc1918 or 0
#  if outside #  the rfc ranges
priv_cidr()
{
    if [ $1 -ge "16" ] && [ $1 -lt 32 ]; then
         return 1
    else 
         return 0
    fi
}

for ip in `egrep "^(10|172|192\.168)" $1`
  do
    i=`echo $ip | awk -F. '{print$2}'`
    priv_cidr $i $ip
    if [ $? -eq "1" ]; then
       echo $ip
    fi
  done
     
