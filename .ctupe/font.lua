local love = require("love")

local Font = {}

function Font.Load()
    love.graphics.newFont(Config.FONT_PATH, 17)
end

return Font