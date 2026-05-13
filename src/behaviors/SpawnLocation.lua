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
        function(host, store)
            lib.hooks.Context.Wrap("KillHero", function(_, _, _)
                lib.hooks.Wrap("LoadMap", function(base, argTable)
                    if not store.read("SpawnLocation") or not host.isEnabled() then
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
