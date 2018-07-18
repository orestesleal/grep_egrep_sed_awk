#n
# = The Mighty IP Scavenger using sed(1) =
#
# using FreeBSD's sed(1) or GNU sed(1) this  have to be called like 
#  '$ sed -Ef ipscav.sed infile'
# -E is needed because this program make uses of EREs

# remove everything that is not a number
s/^[^0-9]*//

# 'mark' the ip address. this will signal to later filtering
# for being more efficient for removal, will mark something
# like sf(kk192.168.0.1I to "sf(kk^192.168.0.1!I"

s/([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})/\^\1!/

# now completely filter by the markings to get the final result
s/.*\^//
s/!.*//p

# BUGS (so far): 
#	"1.1.1.1 more random text 2.2.2.2" match only the first IP.
#        400.500.600.600 will match, there is nothing sed(1) can do
#        to avoid this, taking this script to the next level will
#        require awk(1)
