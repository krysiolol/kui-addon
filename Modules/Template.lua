-------------------------------------------------------------------------------
--  KrysioUI\Modules\Template.lua
--  TEMPLATE — copy this file to add support for a new addon
--
--  Steps to add a new module:
--    1. Copy this file to Modules/YourAddon.lua
--    2. Register it in Modules/ModuleRegistry.lua (copy a block and adapt)
--    3. Create Data/YourAddon.lua with the profile strings
--       3a. Add a VersionManifest entry in Data/VersionManifest.lua
--    4. Add locale strings in Locales/*.lua
--    5. Done!
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI.Modules = KUI.Modules or {}
KUI.Modules.Template = {} -- Change "Template" to "YourAddon"

local M = KUI.Modules.Template

-- -------------------------------------------------------------------------------
-- Import profile
-- -------------------------------------------------------------------------------
function M:Import(resolution, profileData, options)
    -- profileData comes from Data/YourAddon.lua
    -- resolution is "1080p" or "1440p"
    -- options is a table with user choices

    local profileString = profileData and profileData[resolution]
    if not profileString or profileString == "" then
        error("No profile string for resolution: " .. resolution)
    end

    -- === IMPLEMENT IMPORT LOGIC HERE ===
    -- Use the addon's native API (like BigWigsAPI, C_EditMode, etc.)
    -- or write directly to its SavedVariables.

    -- Example: writing to a hypothetical addon's DB
    -- if YourAddonDB and YourAddonDB.profile then
    --     YourAddonDB.profile = profileString
    -- end

    KUI:Print(L("MODULE_IMPORTED", "Your Addon"))
end

-- -------------------------------------------------------------------------------
-- Load existing profile (switch to it without re-importing)
-- -------------------------------------------------------------------------------
function M:LoadProfile(resolution)
    -- === IMPLEMENT LOAD LOGIC HERE ===
    -- For most addons, profiles are loaded automatically from SavedVariables
    -- so this might just be a no-op with a notification.
    KUI:Print(L("MODULE_LOADED", "Your Addon"))
end