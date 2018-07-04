- Scripting and text processing using sed, grep & awk ~

- macfilter.sh
  contains an example using egrep to extrac the Ethernet MAC addresses
  from a text file, also used sed to round up the result. Several formats are
  supported. The "mac" file can be used as an input"

     AA:BB:CC:DD:EE:FF will match 
     AA.BB.CC.DD.EE.FF and AA-BB-CC-DD-EE-FF will also match too

- oui.sh
  Parse Ethernet mac addresses from the file passed as input in the first argument
  and then use the oui.txt Vendor DB for getting the vendor for each MAC address.
  clt.c is an alternative tool coded specifically to make an http 1.1 request
  and download the OUI db oui.txt to be used for this script

- format.sh
  a sed(1) formatter for a language described on doc.txt the output can be seen 
  in doc.txt.format
  
- sortshell.sh
  sort and organize a list of users, system users, by shell

