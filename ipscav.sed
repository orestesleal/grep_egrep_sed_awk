#n

# The IP Scavenger using sed(1)

# using FreeBSD's sed(1) this have to be called
# like sed -Ef ipgrop.sed infile
# 'E' because I'm using the Extended REs

# remove trailing a leading spaces
s/^[	 ]*//
s/ *$//
# remove empty lines
/^$/d

# remove all tabs at the beginning of the line
s/^	*//

# from left to right, remove all letters, spaces, and so on
# XXX: put POSIX character classes here to cover the ranges
s/^ *[a-zA-Z  \.:,'"	\^-]*//g

# enough cleanup (probably), now filter by IP format

s/([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*/\1/p

# BUGS (so far): 
#	"1.1.1.1 more random text 2.2.2.2" match only the first IP.
