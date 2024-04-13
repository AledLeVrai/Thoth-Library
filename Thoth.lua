local Thoth = {}

-- Dynamically retrieve and cache all available Roblox services
function Thoth.fetchServices()
    for _, service in ipairs(game:GetChildren()) do
        if pcall(function() game:GetService(service.ClassName) end) then
            Thoth[service.ClassName] = service
        end
    end
end

-- Initialize and cache all services when the module is loaded
Thoth.fetchServices()

-- Retrieve the LocalPlayer
function Thoth.localPlayer()
    return Thoth.Players.LocalPlayer
end

-- Retrieve the CurrentCamera from the Workspace
function Thoth.camera()
    return Thoth.Workspace.CurrentCamera
end

-- Retrieve the Mouse from the LocalPlayer
function Thoth.mouse()
    local player = Thoth.localPlayer()
    return player and player:GetMouse()
end

function Thoth.bones(character)
    character = character or Thoth.localPlayer().Character
    if not character then
        warn("Character is not available.")
        return {}
    end
    local bones = {}
    for _, bone in ipairs(character:GetDescendants()) do
        if bone:IsA("Bone") then
            table.insert(bones, bone)
        end
    end
    return bones
end

-- Round a number to the specified number of decimal places
function Thoth:round(number, decimalPlaces)
    local multiplier = 10 ^ (decimalPlaces or 0)
    return math.floor(number * multiplier + 0.5) / multiplier
end

-- Compare two strings and return the number of matching characters
function Thoth:compare(str1, str2)
    local count = 0
    local visited = {}
    for i = 1, #str1 do
        local char = str1:sub(i, i)
        if not visited[char] and str2:find(char, 1, true) then
            count = count + 1
            visited[char] = true
        end
    end
    return count
end

-- Utility function able to print a string/table/jsondata
function Thoth:print(data)
    local function printTable(t, indent)
        indent = indent or ""
        for key, value in pairs(t) do
            if type(value) == "table" then
                print(indent .. tostring(key) .. ":")
                printTable(value, indent .. "  ")
            else
                print(indent .. tostring(key) .. ": " .. tostring(value))
            end
        end
    end

    if type(data) == "string" then
        if pcall(function() return self.Http:JSONDecode(data) end) then
            local decoded = self.Http:JSONDecode(data)
            printTable(decoded)
        else
            print(data)
        end
    elseif type(data) == "table" then
        printTable(data)
    else
        print(tostring(data))
    end
end

--//Roblox Functions

-- Return the Character model of the specified player (defaults to LocalPlayer)
function Thoth:character(player)
    player = player or self.localPlayer()
    return player and player.Character
end

-- Return the Humanoid of the specified player (defaults to LocalPlayer)
function Thoth:humanoid(player)
    player = player or self.localPlayer()
    return player and player.Character and player.Character:FindFirstChildOfClass("Humanoid")
end

-- Return the HumanoidRootPart of the specified player (defaults to LocalPlayer)
function Thoth:root(player)
    player = player or self.localPlayer()
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

-- Rejoins the game to a random server
function Thoth:serverhop()
    local TeleportService = self.Teleport
    local placeId = game.PlaceId
    local player = self.localPlayer()

    TeleportService:Teleport(placeId, player)
end

return Thoth
