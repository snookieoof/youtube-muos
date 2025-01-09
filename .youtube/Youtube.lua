local Config = require("Config")

local Youtube = {}

local apiKey = ""

function Youtube.Load()
    local file = io.open(Config.APIKEY_PATH, "r")
    if file then
        apiKey = file:read("*a")
        file:close()
    end

    print(apiKey)
end

return Youtube