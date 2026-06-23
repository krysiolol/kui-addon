-------------------------------------------------------------------------------
--  KrysioUI\Data\EllesmereUI.lua
--  EllesmereUI profile strings
--
--  Developer: Export profiles from EllesmereUI and paste them below.
--  Each EllesmereUI sub-module has its own profile string per resolution.
--
--  To export from in-game:
--    1. Open EllesmereUI settings
--    2. Go to the Profiles page for each module
--    3. Click "Export" and copy the string
--    4. Paste below
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI:SetProfileData("EllesmereUI", {
    version = "8.2.2",

    -- Per-module profile strings
    modules = {
        -- === Action Bars ===
        -- ActionBars = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Nameplates ===
        -- Nameplates = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Unit Frames ===
        -- UnitFrames = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Cooldown Manager ===
        -- CooldownManager = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Resource Bars ===
        -- ResourceBars = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Raid Frames ===
        -- RaidFrames = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === AuraBuff Reminders ===
        -- AuraBuffReminders = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Quality of Life ===
        -- QoL = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Bags ===
        -- Bags = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Friends List ===
        -- Friends = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Mythic+ Timer ===
        -- MythicTimer = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Quest Tracker ===
        -- QuestTracker = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Minimap ===
        -- Minimap = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Damage Meters ===
        -- DamageMeters = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },

        -- === Chat ===
        -- Chat = {
        --     ["1080p"] = "PASTE_EXPORT_STRING_HERE",
        --     ["1440p"] = "PASTE_EXPORT_STRING_HERE",
        -- },
    },

    -- Global settings (non-profile specific)
    -- global = {
    --     ["1080p"] = "PASTE_GLOBAL_EXPORT_STRING",
    --     ["1440p"] = "PASTE_GLOBAL_EXPORT_STRING",
    -- },
})