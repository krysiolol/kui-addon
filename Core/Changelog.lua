-------------------------------------------------------------------------------
--  KrysioUI\Core\Changelog.lua
--  In-addon changelog viewer (popup-based, same visual style)
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI

-- Changelog data — developer edits this directly
KUI._changelog = {
    {
        version = "1.0.0",
        title   = "Initial Release",
        date    = "2025-06-23",
        changes = {
            "KrysioUI addon installer released",
            "EllesmereUI profile support (all modules)",
            "BigWigs profile import",
            "Blizzard Edit Mode layout import",
            "Blizzard Cooldown Manager import (per spec)",
            "Interactive step-by-step installer",
            "Minimap button + slash commands (/krysio, /kui)",
            "Version tracking and update notifications",
            "English and Spanish localization",
        },
    },
}

-- -------------------------------------------------------------------------------
-- Get changelog entries
-- -------------------------------------------------------------------------------
function KUI:GetChangelog()
    return self._changelog
end

-- -------------------------------------------------------------------------------
-- Get latest version string
-- -------------------------------------------------------------------------------
function KUI:GetLatestChangelogVersion()
    if #self._changelog == 0 then return nil end
    return self._changelog[1].version
end

-- -------------------------------------------------------------------------------
-- Check if the changelog has new entries since last viewed
-- -------------------------------------------------------------------------------
function KUI:HasNewChangelog()
    if not KrysioUIDB or not KrysioUIDB.profile or not KrysioUIDB.profile.viewedChangelog then
        return true
    end
    for _, entry in ipairs(self._changelog) do
        if not KrysioUIDB.profile.viewedChangelog[entry.version] then
            return true
        end
    end
    return false
end

-- -------------------------------------------------------------------------------
-- Show the changelog popup
-- -------------------------------------------------------------------------------
function KUI:ShowChangelog()
    -- Use the Installer's popup system if available
    if KUI._ShowPopup then
        local lines = {}
        for _, entry in ipairs(self._changelog) do
            lines[#lines + 1] = "|cffa626e6" .. entry.version .. "|r — " .. entry.title .. " (" .. entry.date .. ")"
            for _, change in ipairs(entry.changes) do
                lines[#lines + 1] = "  • " .. change
            end
            lines[#lines + 1] = ""
        end

        KUI:_ShowPopup({
            title = L("CHANGELOG_TITLE"),
            width = 500,
            height = 450,
            scrollable = true,
            text = table.concat(lines, "\n"),
            buttons = {
                { text = L("CLOSE"), primary = true, action = function() end },
            },
        })
    else
        -- Fallback: print to chat
        KUI:Print(L("CHANGELOG_TITLE"))
        for _, entry in ipairs(self._changelog) do
            KUI:Print("|cffa626e6" .. entry.version .. "|r — " .. entry.title .. " (" .. entry.date .. ")")
            for _, change in ipairs(entry.changes) do
                KUI:Print("  • " .. change)
            end
        end
    end

    -- Mark as viewed
    if KrysioUIDB and KrysioUIDB.profile and KrysioUIDB.profile.viewedChangelog then
        for _, entry in ipairs(self._changelog) do
            KrysioUIDB.profile.viewedChangelog[entry.version] = true
        end
    end
end

-- -------------------------------------------------------------------------------
-- Show changelog on version bump (called at PLAYER_LOGIN)
-- -------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    C_Timer.After(5, function()
        if KUI:HasNewChangelog() then
            KUI:Print(L("NEW_CHANGELOG"))
            KUI:Print(L("TYPE_CHANGELOG"))
        end
    end)
end)