local love = require("love")
local http = require("socket.http")
local ltn12 = require("ltn12")

local result_channel  = love.thread.getChannel("download_result")
local url_channel = love.thread.getChannel("download_url")

while true do
    local uObj = url_channel:pop()
    if uObj then
        local buffer = {}
        local success, status = pcall(function()
            http.request{
                url = uObj.url,
                sink = ltn12.sink.table(buffer)
            }
        end)

        if success then
            local file_data = love.filesystem.newFileData(table.concat(buffer), '' ,'file')
            result_channel:push(
            {
                id = uObj.id,
                imgData = file_data,
                type = uObj.type
            })
        end
    end
end
