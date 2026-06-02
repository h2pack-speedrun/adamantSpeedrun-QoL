return {
    option = {
        type = "checkbox",
        alias = "SpawnLocation",
        label = "Spawn in Training Grounds",
        default = true,
        tooltip =
        "Spawns you in the Training Grounds instead of the House of Hades. Useful for testing and practicing."
    },
    hooks = {
        function(module)
            module.hooks.contextWrap("KillHero", function(host, runtime, context)
                context.wrap("LoadMap", function(base, argTable)
                    if not runtime.data.read("SpawnLocation") or not host.isEnabled() then
                        base(argTable)
                        return
                    end
                    if argTable.Name == "Hub_Main" then
                        argTable.Name = "Hub_PreRun"
                    end
                    base(argTable)
                end)
            end)
        end,
    },
}
