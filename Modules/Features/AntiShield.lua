---@diagnostic disable: undefined-global
local httpService = game:GetService("HttpService")
local userInputService = game:GetService("UserInputService")
local players = game:GetService("Players")

local client = players.LocalPlayer
local character = client.Character or client.CharacterAdded:Wait()

local oldIndex
oldIndex = hookmetamethod(game, "__index", function(i, v) -- anti shield
    if (tostring(i) == "Blocking" and v == "Value" and getgenv().settings.combat.antiShield.enabled and math.random(1, 100) <= getgenv().settings.combat.antiShield.chance) then
        return false 
    end

    return oldIndex(i, v)
end)