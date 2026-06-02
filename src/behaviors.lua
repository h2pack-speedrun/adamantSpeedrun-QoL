local behaviors = {
    hooks = {},
    options = {},
}

local function register(path)
    local behavior = import(path)
    if behavior.option then
        table.insert(behaviors.options, behavior.option)
    end
    for _, hook in ipairs(behavior.hooks or {}) do
        table.insert(behaviors.hooks, hook)
    end
end

register("behaviors/KBMEscape.lua")
register("behaviors/RerollSave.lua")
register("behaviors/ShowLocation.lua")
register("behaviors/SkipDeathCutscene.lua")
register("behaviors/SkipDialogue.lua")
register("behaviors/SkipRunEndCutscene.lua")
register("behaviors/SpawnLocation.lua")
register("behaviors/VictoryScreen.lua")

return behaviors
