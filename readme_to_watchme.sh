#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage : $0 <README.txt>"
    exit 1
fi

if [ ! -f "a.mp4" ]; then
    pip3 install youtube-dl
    youtube-dl -f mp4 https://www.youtube.com/watch?v=Zph7YXfjMhg -o a.mp4
fi

i=0
while IFS= read -r line; do
    if [ -z "$line" ]; then continue; fi
    echo "$i"
    echo "00:"`printf %02d $(( i / 60 ))`":"`printf %02d $(( i % 60 ))`",498 --> 00:"`printf %02d $(( ( i + 2 ) / 60 ))`":"`printf %02d $(( ( i + 2 ) % 60 ))`",827"
    i=$(( i + 2 ))
    echo $line
    echo
done < $1 > tmp.srt

rm -f WATCHME.mp4
ffmpeg -i a.mp4 -i tmp.srt -c copy -c:s mov_text WATCHME.mp4
rm tmp.srt
vlc --sub-track 0 WATCHME.mp4