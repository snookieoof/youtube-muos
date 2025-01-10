local Config = require("Config")

local CT = {}

function CT.GenerateMediaFile(url)
    local command = "youtube-dl -f best -o - \"" .. url .."\" > " .. Config.MEDIA_PATH
    os.execute(command)
end

function CT.Play(url)
    -- local command = string.format(". /opt/muos/script/launch/ext-mpv-ctupe.sh %s %s", "CTupe" , Config.MEDIA_PATH)
    -- local command = string.format(". /opt/muos/script/launch/ext-ffplay-ctupe.sh %s", url)
    -- local command = "youtube-dl \"".. url .."\" -o - | ffplay - -autoexit -loglevel quiet"

    local command = string.format(Config.PLAY_CMD, url)
    os.execute(command)
end

return CT