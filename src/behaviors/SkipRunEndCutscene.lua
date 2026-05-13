return {
    option = {
        type = "checkbox",
        alias = "SkipRunEndCutscene",
        label = "Skip Run End Cutscene",
        default = true,
        tooltip =
        "Skip the end-of-run cutscene. The victory screen will still appear, but you will be immediately returned to the main menu."
    },
    hooks = {
        function(host, store)
            lib.hooks.Wrap("EndEarlyAccessPresentation", function(baseFunc)
                if not store.read("SkipRunEndCutscene") or not host.isEnabled() then
                    return baseFunc()
                end

                AddInputBlock({ Name = "EndEarlyAccessPresentation" })
                SetPlayerInvulnerable("EndEarlyAccessPresentation")

                CurrentRun.Hero.Mute = true
                CurrentRun.ActiveBiomeTimer = false
                ToggleCombatControl(CombatControlsDefaults, false, "EarlyAccessPresentation")

                wait(0.1)
                StopAmbientSound({ All = true })
                SetAudioEffectState({ Name = "Reverb", Value = 1.5 })
                EndAmbience(0.5)
                EndAllBiomeStates()
                FadeOut({ Duration = 0.375, Color = Color.Black })

                EndBiomeRecords()
                RecordRunCleared()

                SetPlayerVulnerable("EndEarlyAccessPresentation")
                RemoveInputBlock({ Name = "EndEarlyAccessPresentation" })
                ToggleCombatControl(CombatControlsDefaults, true, "EarlyAccessPresentation")

                CurrentRun.Hero.Mute = false
                thread(Kill, CurrentRun.Hero)
                wait(0.15)

                FadeIn({ Duration = 0.5 })
            end)
        end,
    },
}
