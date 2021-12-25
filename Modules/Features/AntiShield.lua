local oldIndex
oldIndex = hookmetamethod(game, "__index", function(i, v) -- anti shield
    if (tostring(i) == "Blocking" and v == "Value" and getgenv().settings.combat.antiShield.enabled and math.random(1, 100) <= getgenv().settings.combat.antiShield.chance) then
        return false 
    end

    return oldIndex(i, v)
end)