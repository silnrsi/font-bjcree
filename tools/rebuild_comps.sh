#!/bin/bash

# Rebuild composites in UFOs
# 2025-02-13 pm

COMP_DEFS='../composites.txt'

message() {
        echo "--- $1"
}


build_one() {

        SOURCE_UFO="$1"
        if [ -z "$2" ]
        then
                TARGET_UFO="$1"
                message "Building composites in ${SOURCE_UFO}, using ${COMP_DEFS}..."
        else
                TARGET_UFO="$2"
                message "Building composites from ${SOURCE_UFO} to ${TARGET_UFO}, using ${COMP_DEFS}..."
        fi

        # Check we're in the same directory as the source UFO
        [ -d "$SOURCE_UFO" ] || \
        {
                message "Error: Please run this script from the source directory containing '$SOURCE_UFO'";
                exit 1;
        }

        # Check the source UFO exists
        [ -d "$SOURCE_UFO" ] || \
        {
                message "Error: Source UFO '$SOURCE_UFO' does not exist.";
                exit 1;
        }

        # Check the composite definitions file exists
        [ -f "$COMP_DEFS" ] || \
        {
                message "Error: Composite definitions file '$COMP_DEFS' does not exist.";
                exit 1;
        }

        # docs: https://github.com/silnrsi/pysilfont/blob/master/docs/scripts.md#psfbuildcomp
        # colors: unchanged, changed, new glyphs
                # We're not using color specifications since the defaults are now in line with
                # Font Workflow 157 Cell Mark Colors
                # https://docs.google.com/document/d/1yd3ppWdcaP3FFerVqVorPsTQOAJKLfcx92G6OZnAASk
                # --colors="none" \
        psfbuildcomp \
                -p scrlevel=w \
                -f \
                --noflatten \
                --colors="leave,g_purple,g_red" \
                -i "$COMP_DEFS" "$SOURCE_UFO" "$TARGET_UFO"

        message "Removing key: com.schriftgestaltung.Glyphs.shapeOrder..."
        psfremovegliflibkeys "$TARGET_UFO" com.schriftgestaltung.Glyphs.shapeOrder

}

message "Rebuilding composites in the UFOs..."

# Build each master
build_one "BJCree-Regular.ufo"
build_one "BJCree-Bold.ufo"

message "Composite rebuild done."
