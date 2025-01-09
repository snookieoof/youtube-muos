local Config = require("Config")

local CT = {}

function CT.GenerateMediaFile(url)
    local command = "youtube-dl -f best -o - \"" .. url .."\" > " .. Config.MEDIA_PATH
    os.execute(command)
end

function CT.Play(url)
    -- local command = string.format(". /opt/muos/script/launch/ext-mpv-ctupe.sh %s %s", "CTupe" , Config.MEDIA_PATH)

    local command = string.format(". /opt/muos/script/launch/ext-ffplay-ctupe.sh %s", url)

    -- local command = "youtube-dl \"".. url .."\" -o - | ffplay - -autoexit -loglevel quiet"

    -- local command =
    -- [[
    --     . /opt/muos/script/var/func.sh
    --     HOME="$(GET_VAR "device" "board/home")"
    --     export HOME

    --     SDL_HQ_SCALER="$(GET_VAR "device" "sdl/scaler")"
    --     SDL_ROTATION="$(GET_VAR "device" "sdl/rotation")"
    --     SDL_BLITTER_DISABLED="$(GET_VAR "device" "sdl/blitter_disabled")"
    --     export SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED

    --     SET_VAR "system" "foreground_process" "ffplay"

    --     youtube-dl "]] .. url .. [[" -o - | ffplay - -autoexit -loglevel quiet > output.txt 2>&1

    --     unset SDL_HQ_SCALER SDL_ROTATION SDL_BLITTER_DISABLED
    -- ]]

    os.execute(command)
end

return CT