#!/bin/bash



mkdir -p download

while IFS= read -r linea || [[ -n "$linea" ]]; do
    titolo=$(echo "$linea" | cut -d"," -f1)
    link=$(echo "$linea" | cut -d"," -f2)


    index=$(echo "$link" | sed -n 's/.*[?&]index=\([0-9]\+\).*/\1/p')


    if [[ -n "$index" ]]; then
	yt-dlp --playlist-items "$index" --cookies-from-browser chrome -x --audio-format mp3 "$link" -o "download/$titolo.mp3"	
    else
        yt-dlp --playlist-items 1 --cookies-from-browser chrome -x --audio-format mp3 "$link" -o "download/$titolo.mp3"
    fi

done < "$1"
