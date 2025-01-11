local love = require("love")
local Config = require("config")
local json = require("json")
local Thread = require("thread")

local CT = {}

local API_KEY = ""

function CT.LoadOldData()
    local file = io.open(Config.SEARCH_RESUTL_JSON, "r")
    local dataResultJs = file:read("*all")
    file:close()

    local rsObj = json.decode(dataResultJs)
    local items = rsObj.items

    local resultData = {}
    if items ~= nil and table.getn(items) > 0 then
        for idx, item in pairs(items) do
            table.insert(
                resultData,
                {
                    id = item.id.videoId,
                    time = string.sub(item.snippet.publishedAt, 1, 10),
                    title = item.snippet.title,
                    description = item.snippet.description,
                    thumbnail = item.snippet.thumbnails.default.url,
                    thumbnailMed = item.snippet.thumbnails.medium.url,
                    channelTitle = item.snippet.channelTitle
                 })
        end
    end

    return resultData
end

function CT.LoadAPIKEY()
    local file = io.open(Config.API_KEY_PATH, "r")
    API_KEY = file:read("*all")
    file:close()

    return API_KEY
end

function CT.Search(searchKey)
    if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") ~= "1" then
        local searchCmd = string.format(Config.SEARCH_URL, searchKey, Config.SEARCH_MAX_RESULT, API_KEY)
        local command = "wget \"" .. searchCmd .."\" -O " .. Config.SEARCH_RESUTL_JSON
        os.execute(command)
    end

    return CT.LoadOldData()
end

function CT.GenerateMediaFile(url)
    local command = "youtube-dl -f \"bestvideo[width<=640][height<=480]+bestaudio\" -o - \"" .. url .."\" > " .. Config.MEDIA_PATH
    os.execute(command)
end

function CT.Play(url)
    Thread.GetPlayUrl():push(url)
end

return CT