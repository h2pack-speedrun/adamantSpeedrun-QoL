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
        function(host, store)
            lib.hooks.Wrap("SpecialInteractChangeNextRunRNG", function(base, usee, args)
                base(usee, args)
                if not store.read("RerollSave") or not host.isEnabled() then
                    return
                end
                RequestPreRunLoadoutChangeSave()
            end)
        end,
    },
}
