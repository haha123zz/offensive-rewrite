---@diagnostic disable: undefined-global
local env = {}
env.modules = {}
env.debugging = true

if (getgenv().env) then
    return game:GetService("Players").LocalPlayer:Kick()
end

getgenv().env = env 


env.load = function(path)
    warn("Loading "..path)
    local success, result = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/haha123zz/offensive-rewrite/main/"..path)
    end)

    if (success) then
        loadstring(result)
    else
        warn(result)
    end
end

getgenv().env.modules.connect = env.load("Modules/Connect.lua")
getgenv().env.modules.connect()