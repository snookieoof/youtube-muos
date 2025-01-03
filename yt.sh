#!/bin/sh
echo "runnnn"
mpv --fs --keep-open --input-ipc-server=/tmp/mpv.socket --ytdl-format="(bestvideo[height<=?480][width<=?640]+bestaudio/best)[vcodec~='^((he|a)vc|h26[45])'] / (bv*+ba/b)" https://www.youtube.com/watch?v=YJzh5XSnxC0

echo "done"

sleep 5