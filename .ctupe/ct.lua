local Config = require("config")
local https = require("https")

local CT = {}

local API_KEY = ""

function CT.LoadAPIKEY()
    local file = io.open(Config.API_KEY_PATH, "r")
    API_KEY = file:read("*all")
    file:close()

    return API_KEY
end

function CT.Search(searchKey)
    local searchUrl = string.format(Config.SEARCH_URL, searchKey, Config.SEARCH_MAX_RESULT, API_KEY)
    print(searchUrl)
    local body, statusCode, headers, statusText = https.request(searchUrl)
    -- print(body, statusCode, headers, statusText)
    -- print(body)
    print(statusCode)
end

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