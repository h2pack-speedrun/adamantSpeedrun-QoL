local module = {
    option = {
        type = "checkbox",
        alias = "ShowLocation",
        label = "Always Show Location",
        default = true,
        tooltip =
        "Always displays the current location in the UI."
    },
}

local RoomCountComponentId = nil

local function DestroyDepthCounter()
    if RoomCountComponentId ~= nil then
        Destroy({ Id = RoomCountComponentId })
    end
    RoomCountComponentId = nil
end

local function ShowDepthCounter()
    if RoomCountComponentId ~= nil then
        return
    end

    local screen = { Name = "RoomCount", Components = {} }
    screen.ComponentData = {
        RoomCount = DeepCopyTable(ScreenData.TraitTrayScreen.ComponentData.RoomCount)
    }
    CreateScreenFromData(screen, screen.ComponentData)
    local component = screen.Components.RoomCount
    if component == nil then
        return
    end

    RoomCountComponentId = component.Id
end

module.hooks = {
    function(module)
        module.hooks.wrap("ShowHealthUI", function(host, runtime, baseFunc)
            baseFunc()
            if runtime.data.read("ShowLocation") and host.isEnabled() then
                ShowDepthCounter()
            else
                DestroyDepthCounter()
            end
        end)

        module.hooks.wrap("HideHealthUI", function(_, _, baseFunc, args)
            DestroyDepthCounter()
            return baseFunc(args)
        end)
    end,
}

return module
