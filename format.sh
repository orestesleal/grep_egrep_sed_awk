#! /bin/sh

# formatter for a kind of markup or simple formatting language
# I just invented which is based on the classic unix tools for
# formatting and typesetting although 100 times more basic. 
# see doc.txt for format (not finished)
# Orestes Leal Rodriguez, 2018

sed '
/^#.*$/d
/^\.draft/,/^\.\\draft/d
/^\.console/,/^\.\\console/{
   s/^ /    /
   /^\.console/d
   /^\.\\console/d
}
s/^\[\(─────\)\]/\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1/
s/^\.CH *//
s/\.hd[23]/  /
/^\.text/,/\.\\text/{   
	/^\.[\]*text/d
	s/^ /    /
}' $*

