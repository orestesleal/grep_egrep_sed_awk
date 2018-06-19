~ Scripting and text processing using E|GREP(1), SED(1) and G|AWK(1) ~

=macfilter.sh= contains an example using egrep to extrac the Ethernet MAC addresses
from a text file, also used sed to round up the result. Several formats are 
supported. The "mac" file can be used as an input"

AA:BB:CC:DD:EE:FF will match but also AA.BB.CC.DD.EE.FF and AA-BB-CC-DD-EE-FF

=oui.sh=
Parse ethernet mac addresses from the file passed as input in the first argument
and then use the oui.txt Vendor DB for getting the vendor for each MAC address.

