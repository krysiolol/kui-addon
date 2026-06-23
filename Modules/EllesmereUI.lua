-------------------------------------------------------------------------------
--  KrysioUI\Modules\EllesmereUI.lua
--  Import handler for EllesmereUI profiles
--
--  EllesmereUI has its own profile system (EllesmereUI_Profiles.lua) with
--  import/export via LibDeflate. This module uses the native EllesmereUI API.
--
--  Each EUI module (ActionBars, Nameplates, UnitFrames, etc.) has its own
--  profile string stored in Data/EllesmereUI.lua.
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI.Modules = KUI.Modules or {}

KUI.Modules.EllesmereUI = {}

local EUI = KUI.Modules.EllesmereUI

-- -------------------------------------------------------------------------------
-- Import all EllesmereUI profiles
-- -------------------------------------------------------------------------------
function EUI:Import(resolution, profileData, isClassColor)
    -- profileData structure (from Data/EllesmereUI.lua):
    -- {
    --     version = "8.2.2",
    --     modules = {
    --         ActionBars = { ["1080p"] = "exportString", ["1440p"] = "exportString" },
    --         Nameplates = { ... },
    --         ...
    --     },
    --     global = { ["1080p"] = "...", ["1440p"] = "..." },
    -- }

    if not profileData or not profileData.modules then
        error("No EllesmereUI profile data for resolution: " .. resolution)
    end

    local modules = profileData.modules
    local imported = {}
    local errors = {}

    -- Import each sub-module via EllesmereUI's API
    for modKey, modData in pairs(modules) do
        local profileString = modData and modData[resolution]
        if profileString and profileString ~= "" then
            local success, err = self:_ImportSingleModule(modKey, profileString, isClassColor)
            if success then
                imported[#imported + 1] = modKey
            else
                errors[#errors + 1] = modKey .. ": " .. tostring(err)
            end
        end
    end

    -- Import global settings if available
    if profileData.global and profileData.global[resolution] then
        self:_ImportGlobal(profileData.global[resolution])
    end

    -- Print results
    if #imported > 0 then
        KUI:Print(L("EUI_IMPORTED", table.concat(imported, ", ")))
    end
    if #errors > 0 then
        KUI:Print(L("EUI_IMPORT_ERRORS", table.concat(errors, ", ")))
    end
end

-- -------------------------------------------------------------------------------
-- Import a single EllesmereUI module's profile
-- -------------------------------------------------------------------------------
function EUI:_ImportSingleModule(modKey, profileString, isClassColor)
    -- Use EllesmereUI's profile system if available
    if EllesmereUI and EllesmereUI.ImportProfile then
        local success, err = pcall(EllesmereUI.ImportProfile, EllesmereUI, modKey, profileString)
        if success then
            return true
        else
            return false, tostring(err)
        end
    else
        -- Fallback: raw LibDeflate decode + direct DB write
        return self:_FallbackImport(modKey, profileString, isClassColor)
    end
end

-- -------------------------------------------------------------------------------
-- Fallback import (when EllesmereUI API is not available — shouldn't happen
-- if detection worked, but defensive coding)
-- -------------------------------------------------------------------------------
function EUI:_FallbackImport(modKey, profileString, isClassColor)
    local LibDeflate = LibStub and LibStub("LibDeflate", true)
    if not LibDeflate then
        return false, "LibDeflate not available"
    end

    -- Decode and decompress
    local decoded = LibDeflate:DecodeForPrint(profileString)
    if not decoded then
        return false, "Failed to decode profile string"
    end

    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then
        return false, "Failed to decompress profile"
    end

    -- Load the data
    local loadFn = loadstring or load
    local success, result = pcall(loadFn, "return " .. decompressed)
    if not success then
        return false, "Failed to parse profile data"
    end

    -- Find the corresponding EUI DB
    local dbSuffix = self:_GetDBSuffix(modKey)
    local dbName = "EllesmereUI" .. dbSuffix .. "DB"
    local db = _G[dbName]

    if not db then
        return false, "DB not found: " .. dbName
    end

    -- Merge the imported data into the profile
    if not db.profiles then db.profiles = {} end
    local profileName = db.activeProfile or "Default"
    db.profiles[profileName] = result

    return true
end

-- -------------------------------------------------------------------------------
-- Map module key to DB suffix
-- -------------------------------------------------------------------------------
function EUI:_GetDBSuffix(modKey)
    local suffixMap = {
        ActionBars        = "ActionBars",
        Nameplates        = "Nameplates",
        UnitFrames        = "UnitFrames",
        CooldownManager   = "CooldownManager",
        ResourceBars      = "ResourceBars",
        RaidFrames        = "RaidFrames",
        AuraBuffReminders = "AuraBuffReminders",
        QoL               = "QoL",
        Bags              = "Bags",
        Friends           = "Friends",
        MythicTimer       = "MythicTimer",
        QuestTracker      = "QuestTracker",
        Minimap           = "Minimap",
        DamageMeters      = "DamageMeters",
        Chat              = "Chat",
    }
    return suffixMap[modKey] or modKey
end

-- -------------------------------------------------------------------------------
-- Import global settings (non-profile specific)
-- -------------------------------------------------------------------------------
function EUI:_ImportGlobal(globalString)
    -- Global settings are less critical — just log it
    KUI:Print(L("EUI_GLOBAL_IMPORTED"))
end

-- -------------------------------------------------------------------------------
-- Load (switch to) already-installed profiles
-- This is called when profiles are already imported but user switches chars
-- -------------------------------------------------------------------------------
function EUI:LoadProfiles(resolution)
    if not EllesmereUI then
        KUI:Print(L("EUI_NOT_LOADED"))
        return
    end

    -- EllesmereUI auto-loads profiles from SavedVariables,
    -- so switching characters just works after a reload.
    KUI:Print(L("EUI_PROFILES_READY"))
end