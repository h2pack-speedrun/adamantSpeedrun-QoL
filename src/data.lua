local PACK_ID = "speedrun"

local data = {
    hooks = {},
    options = {},
}

local function register(path)
    local behavior = import(path)
    if behavior.option then
        table.insert(data.options, behavior.option)
    end
    for _, hook in ipairs(behavior.hooks or {}) do
        table.insert(data.hooks, hook)
    end
end

function data.buildStorage()
    local storage = {}
    for _, option in ipairs(data.options) do
        if option.type == "checkbox" then
            table.insert(storage, {
                type = "bool",
                alias = option.alias,
                default = option.default == true,
            })
        else
            error(("Unsupported option type '%s' in %s"):format(tostring(option.type), PACK_ID .. ".QoL"))
        end
    end
    return storage
end

register("behaviors/KBMEscape.lua")
register("behaviors/RerollSave.lua")
register("behaviors/ShowLocation.lua")
register("behaviors/SkipDeathCutscene.lua")
register("behaviors/SkipDialogue.lua")
register("behaviors/SkipRunEndCutscene.lua")
register("behaviors/SpawnLocation.lua")
register("behaviors/VictoryScreen.lua")

return data
