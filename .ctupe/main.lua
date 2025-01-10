local love = require("love")
local Config = require("config")
local CT = require("ct")
local Font = require("font")
local http = require("socket.http")

local msg = ""
local hasAPIKEY = false

local searchData = {}
local imgData = {}
local cPage = 1
local cIdx = 1

function love.load()
    Font.Load()

    if CT.LoadAPIKEY() == "YOUR_API_KEY_HERE" then
        msg = "APIKEY"
        return
    end

    hasAPIKEY = true
end

function love.draw()
    love.graphics.setBackgroundColor(0.027, 0.004, 0.102)
    HeaderUI()
    BodyUI()
    BottomUI()
    GuideUI()

    if not hasAPIKEY then return end
end

function love.update(dt)
end

-- Header
function HeaderUI()
    local xPos = 0
    local yPos = 0

    love.graphics.setColor(0.969, 0.153, 0.153)
    love.graphics.rectangle("fill", xPos, yPos, 640, 30)

    love.graphics.setColor(0.98, 0.98, 0.749)
    love.graphics.setFont(Font.Big())
    DrawCenteredText(xPos, yPos, 640, "CTupe")

    Now = os.date('*t')
    local formatted_time = string.format("%02d:%02d", tonumber(Now.hour), tonumber(Now.min))
    love.graphics.setColor(0.98, 0.98, 0.749, 0.7)
    DrawLeftText(xPos, yPos, formatted_time)

    love.graphics.setFont(Font.Normal())
end

function BodyUI()
    local xPos = 0
    local yPos = 30
    local widthItem = 400
    local heightItem = 83
    local widthImgItem = 83
    local heigthImgItem = 83

    local widthImgMain = 239
    local heightImgMain = 239

    local total = table.getn(searchData)
    local idxStart = cPage * Config.GRID_PAGE_ITEM - Config.GRID_PAGE_ITEM + 1
    local idxEnd = cPage * Config.GRID_PAGE_ITEM
    local iPos = 0

    for i = idxStart, idxEnd do
        if i > total then break end

        local h = heightItem * (iPos) + iPos + 1
        love.graphics.setColor(0.004, 0.173, 0.231)
        love.graphics.rectangle("fill", xPos, yPos + h , widthItem, heightItem)

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(imgData[i].data, xPos, yPos + h, 0, 0.66, 0.66, 0 , 0)

        love.graphics.setColor(1,1,1,0.6)
        love.graphics.setFont(Font.Normal())
        love.graphics.printf(searchData[i].title, xPos + widthImgItem + 1, yPos + h, 320)
        love.graphics.setFont(Font.Small())
        love.graphics.print(searchData[i].channelTitle, xPos, yPos + h + 63)
        love.graphics.print(searchData[i].time, xPos + widthImgItem + 250, yPos + h + 63)

        if cIdx == iPos + 1 then
            love.graphics.setColor(1, 1, 0.4, 0.15)
            love.graphics.rectangle("fill", xPos, yPos + h, widthItem, heightItem, 4)
        end

        iPos = iPos + 1
    end

    love.graphics.setColor(0.004, 0.173, 0.231)
    love.graphics.rectangle("fill", xPos + widthItem + 1, yPos, widthImgMain, heightImgMain)
end

function imageFromUrl(url)
	return love.graphics.newImage(
	       love.image.newImageData(
	       love.filesystem.newFileData(
	       http.request(url), '', 'file')))
end

function BottomUI()
    local xPos = 0
    local yPos = 480 - 30 + 1
    love.graphics.setColor(0.102, 0, 0.459)
    love.graphics.rectangle("fill", xPos, yPos, 640, 29)

    love.graphics.setColor(1,1,1)
    DrawLeftText(xPos, 450, msg)
    -- love.graphics.print(msg, xPos + 5, yPos)
end

function GuideUI()
    local xPos = 401
    local yPos = 30 + 240
    local width = 239
    local height = 180

    love.graphics.setColor(0.004, 0.173, 0.231)
    love.graphics.rectangle("fill", xPos, yPos, width, height)

    love.graphics.setColor(1,1,1,0.9)
    love.graphics.setFont(Font.Small())
    DrawLeftText(xPos + 5, yPos, "[X]: Search")
    DrawLeftText(xPos + 5, yPos + 20, "[A]: Play")
end

function DrawCenteredText(rectX, rectY, rectWidth, text)
    local font       = love.graphics.getFont()
	local textWidth  = font:getWidth(text)
	love.graphics.print(text, rectX + rectWidth / 2 - textWidth / 2, rectY)
end

function DrawLeftText(rectX, rectY, text)
    love.graphics.print(text, rectX, rectY, 0, 1, 1)
end

function love.gamepadpressed(joystick, button)
    local key = ""
    if button == "dpleft" then
        key = "left"
    end
    if button == "dpright" then
        key = "right"
    end
    if button == "dpup" then
        key = "up"
    end
    if button == "dpdown" then
        key = "down"
    end
    if button == "a" then
        key = "a"
    end
    if button == "b " then
        key = "b"
    end
    if button == "x" then
        key = "x"
    end
    if button == "y" then
        key = "y"
    end
    if button == "back" then
        key = "select"
    end
    if button == "start" then
        key = "start"
    end
    if button == "leftshoulder" then
        key = "l1"
    end
    if button == "rightshoulder" then
        key = "r1"
    end
    if button == "guide" then
        key = "guide"
    end

    OnKeyPress(key)
end

function love.keypressed( key )
	OnKeyPress(key)
end

function OnKeyPress(key)
    if key == "x" then
        if not hasAPIKEY then return end
        searchData = CT.Search("real madrid")

        for _,item in pairs(searchData) do
            table.insert(imgData, {data = imageFromUrl(item.thumbnail)})
        end
        msg = "done"
    end

    if key == "a" then
        CT.Play("https://www.youtube.com/watch?v=YJzh5XSnxC0")
    end

    if key == "b" then
    end

    if table.getn(searchData) > 0 then
        if key == "up" then
            GridKeyUp(searchData, cPage, cIdx, Config.GRID_PAGE_ITEM,
            function(idx) cIdx = idx end,
            function(page) cPage = page end)
        end

        if key == "down" then
            GridKeyDown(searchData, cPage, cIdx, Config.GRID_PAGE_ITEM,
            function(idx)
                cIdx = idx
             end,
            function(page)
                cPage = page
            end)
        end
    end
 end

 function GridKeyUp(list,currPage, idxCurr, maxPageItem, callBackSetIdx, callBackChangeCurrPage)
    local total = table.getn(list)
    if total < 1 then return end
    local isMultiplePage = total > maxPageItem
    if isMultiplePage then
        local remainder = total % maxPageItem
        local totalPage = 1
        local q, _ = math.modf(total / maxPageItem)
        if remainder > 0 then
            totalPage =  q + 1
        else
            totalPage = q
            remainder = maxPageItem
        end

        if currPage > 1 then
            if idxCurr > 1 then
                callBackSetIdx(idxCurr - 1)
            else
                if callBackChangeCurrPage then callBackChangeCurrPage(currPage - 1) end
                callBackSetIdx(maxPageItem)
            end
        else
            if idxCurr > 1 then
                callBackSetIdx(idxCurr - 1)
            else
                if callBackChangeCurrPage then callBackChangeCurrPage(totalPage) end
                callBackSetIdx(remainder)
            end
        end
    else
        if idxCurr > 1 then
            callBackSetIdx(idxCurr - 1)
        else
            callBackSetIdx(total)
        end
    end
end

function GridKeyDown(list, currPage, idxCurr, maxPageItem, callBackSetIdx, callBackChangeCurrPage)
    local total = table.getn(list)
    if total < 1 then return end
    local isMultiplePage = total > maxPageItem
    if isMultiplePage then
        local remainder = total % maxPageItem
        local totalPage = 1
        local q, _ = math.modf(total / maxPageItem)
        if remainder > 0 then
            totalPage =  q + 1
        else
            totalPage = q
            remainder = maxPageItem
        end

        if currPage < totalPage then
            if idxCurr < maxPageItem then
                callBackSetIdx(idxCurr + 1)
            else
                if callBackChangeCurrPage then callBackChangeCurrPage(currPage + 1) end
                callBackSetIdx(1)
            end
        else
            if  idxCurr < remainder then
                callBackSetIdx(idxCurr + 1)
            else
                if callBackChangeCurrPage then callBackChangeCurrPage(1) end
                callBackSetIdx(1)
            end
        end
    else
        if idxCurr < total then
            callBackSetIdx(idxCurr + 1)
        else
            callBackSetIdx(1)
        end
    end
end