#!/bin/sh                                                                                                                                                     
######################## Transcode the files using ... ########################
#vcodec="mp4v"
acodec="mp3"
#vb="1024"
ab="256"
mux="mp3"
INPUT_DIR=$1
OUTPUT_DIR=$2
###############################################################################

# Store path to VLC in $vlc
if command -pv vlc >/dev/null 2>&1; then
    # Linux should find "vlc" when searching PATH
    vlc="vlc"
else
    # macOS seems to need an alias
    vlc="/Applications/VLC.app/Contents/MacOS/VLC"
fi
# Sanity check
if ! command -pv "$vlc" >/dev/null 2>&1; then
    printf '%s\n' "Cannot find path to VLC. Abort." >&2
    exit 1
fi


for filename in $INPUT_DIR/*; do
    printf '%s\n' "=> Transcoding '$filename'... "
    "$vlc" -I dummy -q "$filename" \
       --sout="#transcode{acodec=$acodec,ab=$ab}:standard{mux=$mux,dst=$filename.$mux,access=file}" \
       vlc://quit
    ls -lh "$filename" "$filename.$mux"
    printf '\n'
done

echo "moving converted files from $INPUT_DIR to $OUTPUT_DIR"
mkdir $OUTPUT_DIR
mv $INPUT_DIR/*.mp3 $OUTPUT_DIR/

