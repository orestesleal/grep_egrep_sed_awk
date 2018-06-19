~ Scripting and text processing using E|GREP(1), SED(1) and G|AWK(1) ~

=macfilter.sh= contains an example using egrep to extrac the Ethernet MAC addresses
from a text file, also used sed to round up the result. Several formats are 
supported. The "mac" file can be used as an input"

AA:BB:CC:DD:EE:FF will match but also AA.BB.CC.DD.EE.FF and AA-BB-CC-DD-EE-FF

=oui.sh=
# Description: Extract Ethernet Mac Addresses from an input file
#              and look for the vendor in the OUI db. The DB will
#              be downloaded in case it doesn't exist.


