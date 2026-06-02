return {
    option = {
        type = "checkbox",
        alias = "RerollSave",
        label = "Rerolling Saves the Game",
        default = true,
        tooltip =
        "Saluting the Oath statue now triggers game save."
    },
    hooks = {
        function(module)
            module.hooks.wrap("SpecialInteractChangeNextRunRNG", function(host, runtime, base, usee, args)
                base(usee, args)
                if not runtime.data.read("RerollSave") or not host.isEnabled() then
                    return
                end
                RequestPreRunLoadoutChangeSave()
            end)
        end,
    },
}
