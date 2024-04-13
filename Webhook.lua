local Thoth = loadstring(game:HttpGet("https://raw.githubusercontent.com/AledLeVrai/Thoth-Library/main/Thoth.lua"))()
local HttpService = Thoth.HttpService

local Webhook = {}
Webhook.__index = Webhook

function Webhook.new(url)
    local self = setmetatable({}, Webhook)

    self._url = url

    return self
end

function Webhook:Send(data, yields)
    if (typeof(data) == "string") then
        data = {content = data}
    end

    local function send()
        request({
            Url = self._url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end

    if (yields) then
        pcall(send)
    else
        task.spawn(send)
    end
end

return Webhook
