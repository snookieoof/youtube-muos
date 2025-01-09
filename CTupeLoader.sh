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

if [ -e "mnt/mmc/MUOS/application/CTupe.sh" ]; then
    rm -r "mnt/mmc/MUOS/application/CTupe.sh"
fi

mv "CTupeData/UnzipData/YtMuos-master/.ctupe" "mnt/mmc/MUOS/application/"
mv "CTupeData/UnzipData/YtMuos-master/CTupe.sh" "mnt/mmc/MUOS/application/CTupe.sh"

echo "-----------------------------------"
echo "|Author     : CuongNV             |"
echo "|Complete!                        |"
echo "|Thanks!                          |"
echo "-----------------------------------"
sleep 3