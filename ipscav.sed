#n
# = The Mighty IP Scavenger using sed(1) =
#
# using FreeBSD's sed(1) or GNU sed(1) this  have to be called like 
#	"sed -Ef ipscav.sed infile"
# -E is needed because this program make uses of EREs

# remove everything that is not a number
s/^[^0-9]*//

# enough cleanup (probably), now filter by IP format

s/([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*/\1/p

# BUGS (so far): 
#	"1.1.1.1 more random text 2.2.2.2" match only the first IP.
