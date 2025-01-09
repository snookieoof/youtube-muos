local love = require("love")
local CT = require("ct")

local msg = ""
function love.load()
end

function love.draw()
    love.graphics.print(msg)
end

function love.update(dt)
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
        CT.GenerateMediaFile("https://www.youtube.com/watch?v=chqimsVKYt4")
        msg = "GenerateFile done"
    end

    if key == "a" then
        CT.Play()
    end

    if key == "b" then
        -- local ipc = io.open("/tmp/ctupesocket", "w")
        -- ipc:write('{"command": ["quit"]}')
        -- ipc:close()

        -- os.execute("sleep 1")

        -- player:close()
    end
 end