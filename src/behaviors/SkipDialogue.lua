return {
    option = {
        type = "checkbox",
        alias = "SkipDialogue",
        label = "Auto Skip Dialogue",
        default = false,
        tooltip =
        "Automatically skips dialogue prompts during gameplay."
    },
    hooks = {
        function(host, store)
            host.hooks.wrap("PlayTextLines", function(base, source, textLines, args)
                if not store.read("SkipDialogue") or not host.isEnabled() then
                    return base(source, textLines, args)
                end

                -- Not in a run
                if CurrentRun.Hero.IsDead then
                    return base(source, textLines, args)
                end

                if not textLines then return end

                -- Don't skip main story conversations (wants-to-talk icon)
                if textLines.StatusAnimation == 'StatusIconWantsToTalk' then
                    return base(source, textLines, args)
                end

                -- Don't skip NPC choice dialogues
                if textLines.PrePortraitExitFunctionName then
                    local hasChoice = string.find(textLines.PrePortraitExitFunctionName, 'Choice')
                    if hasChoice then
                        return base(source, textLines, args)
                    end
                end

                return
            end)
        end,
    },
}
