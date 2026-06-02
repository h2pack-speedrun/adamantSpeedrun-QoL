local ExcludedScreens = {
    UpgradeChoice = true,
    SpellScreen = true,
    TalentScreen = true,
}

local BlockingScreens = {
    "Codex",
    "MetaUpgrade",
    "ShrineUpgrade",
    "MusicPlayer",
    "QuestLog",
    "Mutator",
    "GhostAdmin",
    "AwardMenu",
    "RunClear",
    "RunHistory",
    "GameStats",
    "TraitTrayScreen",
    "WeaponUpgradeScreen",
    "InventoryScreen",
    "MarketScreen",
    "WeaponShop",
    "DebugEnemySpawn",
    "DebugConversations",
}

return {
    option = {
        type = "checkbox",
        alias = "KBMEscape",
        label = "KBM Escape Fix",
        default = true,
        tooltip =
        "KBM Escape will now work during boon/pom Selection, Hex selection, PoS menu, and during death sequences."
    },
    hooks = {
        function(module)
            module.hooks.wrap("IsPauseBlocked", function(host, runtime, base)
                if not runtime.data.read("KBMEscape") or not host.isEnabled() then return base() end

                if SessionMapState.HandlingDeath then
                    return false
                end
                if SessionMapState.BlockPause then
                    return true
                end

                if CurrentRun ~= nil then
                    if CurrentRun.Hero.FishingStarted then
                        return true
                    end
                end

                for screenName, screen in pairs(ActiveScreens) do
                    if ExcludedScreens[screenName] then
                        return false
                    end
                    if screen.BlockPause then
                        return true
                    end
                end

                for _, name in ipairs(BlockingScreens) do
                    if ActiveScreens[name] then
                        return true
                    end
                end

                return false
            end)
        end,
    },
}
