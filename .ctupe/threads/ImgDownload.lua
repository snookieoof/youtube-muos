local love = require("love")
local http = require("socket.http")
local ltn12 = require("ltn12")
local Thread = require("thread")

local rsChn  = Thread.GetDownloadResutlChannel()
local uChn = Thread.GetDownloadUrlChannel()

while true do
    local uObj = uChn:pop()
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
            rsChn:push(
            {
                id = uObj.id,
                imgData = file_data,
                type = uObj.type
            })
        end
    end
end