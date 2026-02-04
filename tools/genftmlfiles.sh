#!/bin/bash

# This script rebuilds the algorithmically-generated ftml files. See README.md

# Copyright (c) 2020-2025 SIL Global  (https://www.sil.org)
# Released under the MIT License (https://opensource.org/licenses/

# Assumes we're in the root folder, i.e., font-idiqlat

set -e

if [ ! -e OFL.txt ] 
then
	echo "Please cd to root of font project to use this script"
	exit 2
fi

prevfont="references/v2.0/bjcrus.ttf"
prevver="2.000"

commonParams=( \
	--prevfont "$prevfont"  \
	-s "url(../$prevfont)"  \
#	-s "url(../$prevfont)|$prevver"  \
	--ap '_?dia[ABO]$'  \
	--xsl ../tools/ftml.xsl  \
	--scale 250  \
	-i source/glyph_data.csv  \
	-w 75%  \
#	-s "url(../references/v2.0/BJCree-Regular.ttf)"  \
)

echo "Rebuilding ftml files..."
tools/psfgenftml.py -q -t 'AllChars (auto)'                      source/masters/BJCree-Regular.ufo  tests/AllChars-auto.ftml        -l tests/logs/AllChars.log         "${commonParams[@]}" -s 'url(../results/BJCree-Regular.ttf)' -s 'url(../results/BJCree-Medium.ttf)' -s 'url(../results/BJCree-SemiBold.ttf)' -s 'url(../results/BJCree-Bold.ttf)' &

wait
echo done.
