#!/bin/sh
# ICON: youtube

if [ -d "YoutubeData" ]; then
  rm -r "YoutubeData"
fi

wget -P "YoutubeData/" https://github.com/nvcuong1312/YtMuos/archive/refs/heads/master.zip
unzip -o "YoutubeData/master.zip" -d "YoutubeData/UnzipData/"

if [ -d "mnt/mmc/MUOS/application/.Youtube" ]; then
  rm -r "mnt/mmc/MUOS/application/.Youtube"
fi

if [ -e "mnt/mmc/MUOS/application/Youtube.sh" ]; then
    rm -r "mnt/mmc/MUOS/application/Youtube.sh"
fi

mv "YoutubeData/UnzipData/YtMuos-master/.Youtube" "mnt/mmc/MUOS/application/"
mv "YoutubeData/UnzipData/YtMuos-master/Youtube.sh" "mnt/mmc/MUOS/application/Youtube.sh"

echo "-----------------------------------"
echo "|Author     : CuongNV             |"
echo "|Complete!                        |"
echo "|Thanks!                          |"
echo "-----------------------------------"
sleep 3