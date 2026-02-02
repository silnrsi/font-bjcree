#!/usr/bin/python3
# this is a smith configuration file

# set the default output folders for release docs
DOCDIR = ["documentation", "web"]

# STANDARDS = 'references'
TESTDIR = ["tests"]

# set the font name and description
APPNAME = 'BJCree'
FAMILY = APPNAME
DESC_SHORT = "A Canadian Syllabics font for the Algonquian family of languages."

# Get version and authorship information from Regular UFO (canonical metadata); must be first function call:
getufoinfo('source/masters/' + FAMILY  + '-Regular.ufo')

# Set up the FTML tests
ftmlTest('tools/ftml-smith.xsl')

cmds = []
cmds.append(cmd('psfchangettfglyphnames ${SRC} ${DEP} ${TGT}', ['${source}']))
cmds.append(cmd('gftools fix-nonhinting -q --no-backup ${DEP} ${TGT}'))
#cmds.append(cmd('../tools/ttfaddemptyot.py -t gpos ${DEP} ${TGT}'))
#cmds.append(cmd('${TTFAUTOHINT} -n -W ${DEP} ${TGT}'))

designspace('source/' + FAMILY + '.designspace',
    target = process("${DS:FILENAME_BASE}.ttf", *cmds),
    params = "--decomposeComponents --removeOverlap --compregex ^_",
    # opentype = fea('srcs/${DS:FILENAME_BASE}.fea', master='source/empty.feax'),
    woff = woff('web/${DS:FILENAME_BASE}.woff',
        metadata=f'../source/bjcree-WOFF-metadata.xml',
        ),
    pdf = fret(params='-oi'),
    script = ['DFLT', 'cans'],
)

#def configure(ctx):
#    ctx.find_program('ttfautohint')
