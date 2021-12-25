---@diagnostic disable: undefined-global
local httpService = game:GetService("HttpService")
local userInputService = game:GetService("UserInputService")
local players = game:GetService("Players")

local client = players.LocalPlayer
local character = client.Character or client.CharacterAdded:Wait()

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...) -- anti drown
    local args = {...}

    if (getnamecallmethod() == "GetState" and getgenv().settings.physics.antiDrown.enabled) then
        return Enum.HumanoidStateType.RunningNoPhysics
    end
    
    return oldNamecall(self, ...)
end)