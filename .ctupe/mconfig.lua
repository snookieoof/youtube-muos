local Config = {}

Config.MPV_PATH = "/opt/muos/script/launch/ext-mpv-ctupe.sh"
Config.MEDIA_PATH = "data/media"
Config.API_KEY_PATH = "data/api"

Config.FONT_PATH = "Assets/Font/Font.ttf"

Config.SEARCH_URL = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=%s&type=video&maxResults=%s&key=%s"
Config.SEARCH_MAX_RESULT = 10

Config.PLAY_CMD =
[[
#!/bin/sh

. /opt/muos/script/var/func.sh

URL="%s"

GPTOKEYB="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/gptokeyb/gptokeyb2"
APP_DIR="/mnt/mmc/MUOS/application/.ctupe/data"

HOME="$(GET_VAR "device" "board/home")"
export HOME

SDL_HQ_SCALER="$(GET_VAR "device" "sdl/scaler")"
SDL_ROTATION="$(GET_VAR "device" "sdl/rotation")"
SDL_BLITTER_DISABLED="$(GET_VAR "device" "sdl/blitter_disabled")"
export SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED

export SDL_GAMECONTROLLERCONFIG_FILE="/usr/lib/gamecontrollerdb.txt"

SET_VAR "system" "foreground_process" "ffplay"

$GPTOKEYB "ffplay" -c "$APP_DIR/general_ffplay.gptk" &
youtube-dl "$URL" -o - | /usr/bin/ffplay - -autoexit -loglevel quiet

killall -q gptokeyb2

unset SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED
]]

return Config