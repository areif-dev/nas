FROM docker.io/jellyfin/jellyfin:latest 

RUN curl -L -o "/usr/bin/yt-dlp" "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" && \
    chmod +x "/usr/bin/yt-dlp"

RUN apt-get update -y && \
    apt-get install -y id3v2
