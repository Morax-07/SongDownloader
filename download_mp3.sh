#!/bin/bash



while IFS= read -r linea || [[ -n "$linea" ]]; do
    titolo=$(echo "$linea" | cut -d"," -f1)
    link=$(echo "$linea" | cut -d"," -f2)

    # Use correctly formatted cookie file
    yt-dlp --cookies-from-browser chrome -x --audio-format mp3 "$link" -o "download/$titolo.mp3"

    estensione=$(echo "$titolo.*" | sed 's/.*\.//')

    if command -v ffmpeg &> /dev/null; then
        ffmpeg -i "$titolo.$estensione" -q:a 0 "$titolo.mp3"
    else
        echo "ffmpeg non è installato. Impossibile convertire in MP3."
    fi
done < $1