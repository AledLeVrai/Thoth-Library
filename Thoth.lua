local Thoth = {}

-- Retrieve and cache services from Roblox
function Thoth.services(services)
    for name, serviceName in pairs(services) do
        local service = game:GetService(serviceName)
        if service then
            Thoth[name] = service
        else
            warn("Service not found:", serviceName)
        end
    end
end

local services = {
    Workspace = "Workspace",
    ReplicatedStorage = "ReplicatedStorage",
    Http = "HttpService",
    Tween = "TweenService",
    CoreGui = "CoreGui",
    Pathfinding = "PathfindingService",
    RunService = "RunService",
    Teleport = "TeleportService",
    Network = "NetworkClient",
    UserInput = "UserInputService",
    Players = "Players",
    GuiService = "GuiService",
    Lighting = "Lighting",
    CollectionService = "CollectionService"
}

Thoth.services(services)

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

-- Round a number to the specified number of decimal places
function Thoth:round(number, decimalPlaces)
    local multiplier = 10 ^ (decimalPlaces or 0)
    return math.floor(number * multiplier + 0.5) / multiplier
end

-- Compare two strings and return the percentage of matching characters
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
    local percentage = (count / math.min(#str1, #str2)) * 100
    return math.floor(percentage)
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
    local TeleportService = self.TeleportService
    local placeId = game.PlaceId
    local player = self.localPlayer()

    TeleportService:Teleport(placeId, player)
end

return Thoth
