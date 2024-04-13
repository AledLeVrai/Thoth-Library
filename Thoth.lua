local Thoth = {}

function Thoth.getServices(services)
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

Thoth.getServices(services)

function Thoth.LocalPlayer()
    return Thoth.Players.LocalPlayer
end

function Thoth.Camera()
    return Thoth.Workspace.CurrentCamera
end

function Thoth.Mouse()
    local player = Thoth.getLocalPlayer()
    return player and player:GetMouse()
end

return Thoth
