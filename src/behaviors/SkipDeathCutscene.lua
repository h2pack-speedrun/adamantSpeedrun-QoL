return {
    option = {
        type = "checkbox",
        alias = "SkipDeathCutscene",
        label = "Skip Death Cutscene",
        default = true,
        tooltip =
        "Skip the death cutscene. The death screen will still appear, but you will be immediately returned to the main menu."
    },
    hooks = {
        function(host, store)
            host.hooks.contextWrap("DeathPresentation", function()
                host.hooks.wrap("wait", function(base, duration, tag, persist)
                    if not store.read("SkipDeathCutscene") or not host.isEnabled() then
                        return base(duration, tag, persist)
                    end
                    return
                end)
            end)
        end,
    },
}
