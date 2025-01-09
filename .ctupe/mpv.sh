#!/bin/sh

. /opt/muos/script/var/func.sh

NAME=$1
FILE=$2

LOG_INFO "$0" 0 "Content Launch" "DETAIL"
LOG_INFO "$0" 0 "NAME" "$NAME"
LOG_INFO "$0" 0 "FILE" "$FILE"

GPTOKEYB="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/gptokeyb/gptokeyb2"
MPV_DIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/mpv"

HOME="$(GET_VAR "device" "board/home")"
export HOME

SDL_HQ_SCALER="$(GET_VAR "device" "sdl/scaler")"
SDL_ROTATION="$(GET_VAR "device" "sdl/rotation")"
SDL_BLITTER_DISABLED="$(GET_VAR "device" "sdl/blitter_disabled")"
export SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED

export SDL_GAMECONTROLLERCONFIG_FILE="/usr/lib/gamecontrollerdb.txt"

SET_VAR "system" "foreground_process" "mpv"

$GPTOKEYB "mpv" -c "data/general.gptk" & /usr/bin/mpv "$FILE"

killall -q gptokeyb2

unset SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED