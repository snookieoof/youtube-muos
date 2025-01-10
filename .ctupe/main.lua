local love = require("love")
local CT = require("ct")
local Font = require("font")

local msg = ""
local hasAPIKEY = false

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

    for i = 1, 5, 1 do
        local h = heightItem * (i - 1) + i
        love.graphics.setColor(0.004, 0.173, 0.231)
        love.graphics.rectangle("fill", xPos, yPos + h , widthItem, heightItem)

        love.graphics.setColor(0.004, 0.373, 0.231)
        love.graphics.rectangle("fill", xPos, yPos + h, widthImgItem, heigthImgItem)
    end

    local widthImgMain = 239
    local heightImgMain = 239
    love.graphics.setColor(0.004, 0.173, 0.231)
    love.graphics.rectangle("fill", xPos + widthItem + 1, yPos, widthImgMain, heightImgMain)
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
        CT.Search("real madrid")

        msg = "done"
    end

    if key == "a" then
        CT.Play("https://www.youtube.com/watch?v=YJzh5XSnxC0")
    end

    if key == "b" then
    end
 end