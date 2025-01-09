#!/bin/sh
# ICON: ctupe

if [ -d "CTupeData" ]; then
  rm -r "CTupeData"
fi

wget -P "CTupeData/" https://github.com/nvcuong1312/YtMuos/archive/refs/heads/master.zip
unzip -o "CTupeData/master.zip" -d "CTupeData/UnzipData/"

if [ -d "mnt/mmc/MUOS/application/.ctupe" ]; then
  rm -r "mnt/mmc/MUOS/application/.ctupe"
fi

cp "CTupeData/UnzipData/YtMuos-master/.ctupe" "mnt/mmc/MUOS/application/"

if [ -e "mnt/mmc/MUOS/application/CTupe.sh" ]; then
    rm -r "mnt/mmc/MUOS/application/CTupe.sh"
fi

cp "CTupeData/UnzipData/YtMuos-master/CTupe.sh" "mnt/mmc/MUOS/application/CTupe.sh"

if [ -e "usr/bin/youtube-dl" ]; then
    rm -r "usr/bin/youtube-dl"
fi

cp "CTupeData/UnzipData/YtMuos-master/.ctupe/bin/yt-dlp" "usr/bin/youtube-dl"

if [ -e "opt/muos/script/launch/ext-mpv-ctupe.sh" ]; then
    rm -r "opt/muos/script/launch/ext-mpv-ctupe.sh"
fi

cp "CTupeData/UnzipData/YtMuos-master/.ctupe/data/ext-mpv-ctupe.sh" "opt/muos/script/launch/ext-mpv-ctupe.sh"

echo "-----------------------------------"
echo "|Author     : CuongNV             |"
echo "|Complete!                        |"
echo "|Thanks!                          |"
echo "-----------------------------------"
sleep 3