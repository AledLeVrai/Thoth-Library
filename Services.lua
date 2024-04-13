local Service = {}

function Service.getServices(services)
    for name, serviceName in pairs(services) do
        local service = game:GetService(serviceName)
        if service then
            Service[name] = service
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

Service.getServices(services)

return Service
