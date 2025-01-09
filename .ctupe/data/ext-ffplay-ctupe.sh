#!/bin/sh

. /opt/muos/script/var/func.sh

URL=$1

HOME="$(GET_VAR "device" "board/home")"
export HOME

SDL_HQ_SCALER="$(GET_VAR "device" "sdl/scaler")"
SDL_ROTATION="$(GET_VAR "device" "sdl/rotation")"
SDL_BLITTER_DISABLED="$(GET_VAR "device" "sdl/blitter_disabled")"
export SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED

SET_VAR "system" "foreground_process" "ffplay"

youtube-dl "$URL" -o - | /usr/bin/ffplay - -autoexit -loglevel quiet

unset SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED
