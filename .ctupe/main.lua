local love = require("love")
local CT = require("ct")

local msg = ""
local hasAPIKEY = false

function love.load()
    if CT.LoadAPIKEY() == "YOUR_API_KEY_HERE" then
        msg = "APIKEY"
        return
    end

    hasAPIKEY = true
end

function love.draw()
    love.graphics.print(msg)
end

function love.update(dt)
end

-- Header
function HeaderUI()
    local xPos = 0
    local yPos = 0

    love.graphics.setColor(0.31, 0.31, 0.118)
    love.graphics.rectangle("fill", xPos, yPos, 640, 30)

    love.graphics.setColor(0.98, 0.98, 0.749)
    love.graphics.setFont(fontBig)
    love.graphics.draw(ic_bluetooth, 640 - 25, yPos + 4)
    love.graphics.print("Bluetooth Settings", xPos + 250, yPos + 2)

    Now = os.date('*t')
    local formatted_time = string.format("%02d:%02d", tonumber(Now.hour), tonumber(Now.min))
    love.graphics.setColor(0.98, 0.98, 0.749, 0.7)
    love.graphics.print(formatted_time, xPos + 10, yPos + 2)

    love.graphics.setFont(fontSmall)
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
    end

    if key == "a" then
        CT.Play("https://www.youtube.com/watch?v=YJzh5XSnxC0")
    end

    if key == "b" then
    end
 end