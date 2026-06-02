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
        function(module)
            module.hooks.contextWrap("DeathPresentation", function(host, runtime, context)
                context.wrap("wait", function(base, duration, tag, persist)
                    if not runtime.data.read("SkipDeathCutscene") or not host.isEnabled() then
                        return base(duration, tag, persist)
                    end
                    return
                end)
            end)
        end,
    },
}
