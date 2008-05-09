#!/bin/sh

### mp2png.sh -- Converts METAPOST output to PNG

# Author: Micha�l Gr�newald
# Date: Sam 10 d�c 2005 09:58:48 GMT
# Lang: fr_FR.ISO8859-15

# $Id$


# Global Variables:

AUTHOR="Micha�l Gr�newald <michael.grunewald@laposte.net>"
COPYRIGHT="(c)2005"
PROGNAME=`basename "$0"`

resolution=1200

# Ancillary functions

prerr()
{
    echo "$@" 1>&2
}

HELP()
{
    cat - <<EOF
Usage: $PROGNAME [-h] [-r resolution] [file1 [file2 [...]]]
 Converts from MetaPost output to PNG
Options:
 -r RESOLUTION [$resolution]
    Indicate a resolution, in dot per inches. See Notes below.
 -h Display a cheerful help message to you.
Notes:
 The conversion is done thanks to TeX and epsf.tex.
 The program will not work if you use the prologue facility (if you
 do not know about it, this is probably ok).
 Typical resolution for screen viewing ranges from 72 to 100, for
 deskjet printers from 300 to 400, and for laserjet or other high
 quality device, from 600 to above.
Author: ${AUTHOR}
Copyright: ${COPYRIGHT}
EOF
}

INVALIDOPT() {
    prerr "${PROGNAME}: unknown option: $1" 
}

mp2png_process()
{
    local file
    file=`mktemp mp2png.XXXXX`
    cp $1 $file
    mp2eps $file
    gs -dNOPAUSE -sDEVICE=pngalpha -sOutputFile=$1.png -r${resolution}x${resolution} $file.eps
    rm $file $file.eps
}

# Process Arguments

while getopts "hr:" OPTION; do
    case $OPTION in
	r) resolution=${OPTARG};;
	h) HELP; exit 0;;
	?) INVALIDOPT $OPTION; HELP; exit 1;;
    esac
done

shift $(( $OPTIND - 1 ))

# Let's roll

for a in "$@"; do mp2png_process "$a"; done

### End of file `mp2png.sh'