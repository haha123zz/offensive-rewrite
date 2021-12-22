---@diagnostic disable: undefined-global

warn("Attempting to connect...")

if (getgenv().key == "wasd") then
    warn(string.format("Connected with key: %s", getgenv().key))
end