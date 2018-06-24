#! /bin/sh

# formatter for a kind of markup or simple formatting language
# I just invented. see doc.txt
# Orestes Leal Rodriguez, 2018

sed '
s/^\[=\]$/ ======================================================/
s/\.hd1/ >> /
s/\.hd[23]/  -> |/

/^\.text/,/\.\\text/{   
	/^\.[\]*text/d
	s/^ /     /
}' $*
