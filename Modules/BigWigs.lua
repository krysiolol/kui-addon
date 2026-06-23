-------------------------------------------------------------------------------
--  KrysioUI\Modules\BigWigs.lua
--  BigWigs profile import handler
--
--  BigWias provides BigWigsAPI.RegisterProfile for importing profiles
--  and BigWigsAPI.SwapProfile for switching to an existing one.
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI.Modules = KUI.Modules or {}
KUI.Modules.BigWigs = {}

local BW = KUI.Modules.BigWigs
local PROFILE_NAME = "KrysioUI"

-- -------------------------------------------------------------------------------
-- Import BigWigs profile (async — BigWigs shows a confirmation popup)
-- -------------------------------------------------------------------------------
function BW:Import(resolution, profileData, options, callback)
    if not BigWigsAPI then
        if callback then callback(false, L("BIGWIGS_API_MISSING")) end
        return
    end

    local profileString = profileData and profileData[resolution]
    if not profileString or profileString == "" then
        if callback then callback(false, "No BigWigs profile string for resolution: " .. resolution) end
        return
    end

    if not BigWigsAPI.RegisterProfile then
        if callback then callback(false, "BigWigs RegisterProfile API not available") end
        return
    end

    -- RegisterProfile shows a confirmation popup and calls the callback
    -- when the user accepts (accepted = true/nil) or cancels (accepted = false)
    BigWigsAPI.RegisterProfile(PROFILE_NAME, profileString, PROFILE_NAME, function(accepted)
        if accepted ~= false then
            KUI:Print(L("BIGWIGS_IMPORTED"))
            if callback then callback(true, L("BIGWIGS_IMPORTED")) end
        else
            if callback then callback(false, L("IMPORT_CANCELLED", "BigWigs")) end
        end
    end)
end

-- -------------------------------------------------------------------------------
-- Load (switch to) an existing BigWigs profile
-- -------------------------------------------------------------------------------
function BW:LoadProfile(resolution)
    if not BigWigsAPI then
        KUI:Print(L("BIGWIGS_API_MISSING"))
        return
    end

    -- Try SwapProfile first (modern API with confirmation popup)
    if BigWigsAPI.GetProfileName and BigWigsAPI.SwapProfile then
        local currentProfile = BigWigsAPI.GetProfileName()
        if currentProfile == PROFILE_NAME then
            KUI:Print(L("BIGWIGS_ALREADY_ACTIVE"))
            return
        end

        local found = BigWigsAPI.SwapProfile(PROFILE_NAME, PROFILE_NAME, function(accepted)
            if accepted then
                KUI:Print(L("BIGWIGS_PROFILE_LOADED"))
            end
        end)
        return
    end

    -- Fallback: re-import via RegisterProfile (creates or overwrites)
    local profileData = KUI:GetProfileData("BigWigs")
    if profileData then
        self:Import(resolution, profileData)
    end
end