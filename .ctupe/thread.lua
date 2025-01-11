local love = require("love")

local Thread = {}

function Thread.Create()
    love.thread.newThread("threads/ImgDownload.lua"):start()
    love.thread.newThread("threads/PlayVideo.lua"):start()
end

function Thread.GetDownloadResutlChannel()
    return love.thread.getChannel("download_result")
end

function Thread.GetDownloadUrlChannel()
    return love.thread.getChannel("download_url")
end

function Thread.GetPlayUrl()
    return love.thread.getChannel("play_url")
end

function Thread.GetPlayDone()
    return love.thread.getChannel("play_done")
end

return Thread