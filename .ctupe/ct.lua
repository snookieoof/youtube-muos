local Config = require("Config")

local CT = {}

function CT.GenerateMediaFile(url)
    local command = "youtube-dl -f best -o - \"" .. url .."\" > " .. Config.MEDIA_PATH
    os.execute(command)
end

function CT.Play()
    local command = string.format(". %s %s %s", Config.MPV_PATH, "CTupe" , Config.MEDIA_PATH)
    return os.execute(command)
end

return CT