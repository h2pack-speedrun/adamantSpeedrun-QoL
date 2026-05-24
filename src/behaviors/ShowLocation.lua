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

local function ShowDepthCounter()
    local screen = { Name = "RoomCount", Components = {} }
    screen.ComponentData = {
        RoomCount = DeepCopyTable(ScreenData.TraitTrayScreen.ComponentData.RoomCount)
    }
    CreateScreenFromData(screen, screen.ComponentData)
end

module.hooks = {
    function(host, store)
        host.hooks.wrap("ShowHealthUI", function(baseFunc)
            baseFunc()
            if store.read("ShowLocation") and host.isEnabled() then
                ShowDepthCounter()
            end
        end)
    end,
}

return module
