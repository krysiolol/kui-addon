-------------------------------------------------------------------------------
--  KrysioUI\Core\Version.lua
--  Version tracking & update notification system
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI

-- Version manifest loaded from Data/VersionManifest.lua
KUI._versionManifest = {}

-- -------------------------------------------------------------------------------
-- Set the version manifest (called from Data/VersionManifest.lua)
-- -------------------------------------------------------------------------------
function KUI:SetVersionManifest(manifest)
    self._versionManifest = manifest
end

-- -------------------------------------------------------------------------------
-- Get the latest version for a module from the manifest
-- -------------------------------------------------------------------------------
function KUI:GetManifestVersion(moduleKey)
    return self._versionManifest[moduleKey]
end

-- -------------------------------------------------------------------------------
-- Get the installed (saved) version for a module
-- -------------------------------------------------------------------------------
function KUI:GetInstalledVersion(moduleKey)
    if not KrysioUIDB or not KrysioUIDB.profile or not KrysioUIDB.profile.installedVersions then
        return nil
    end
    return KrysioUIDB.profile.installedVersions[moduleKey]
end

-- -------------------------------------------------------------------------------
-- Mark a module version as installed
-- -------------------------------------------------------------------------------
function KUI:SetInstalledVersion(moduleKey, version)
    if not KrysioUIDB or not KrysioUIDB.profile then return end
    if not KrysioUIDB.profile.installedVersions then
        KrysioUIDB.profile.installedVersions = {}
    end
    KrysioUIDB.profile.installedVersions[moduleKey] = version or self:GetManifestVersion(moduleKey)
end

-- -------------------------------------------------------------------------------
-- Check if a module has an update available
-- -------------------------------------------------------------------------------
function KUI:IsModuleOutdated(moduleKey)
    local manifestVer = self:GetManifestVersion(moduleKey)
    if not manifestVer then return false end

    local installedVer = self:GetInstalledVersion(moduleKey)
    if not installedVer then return true end

    return self:ParseVersion(manifestVer) > self:ParseVersion(installedVer)
end

-- -------------------------------------------------------------------------------
-- Check if the addon itself has an update
-- -------------------------------------------------------------------------------
function KUI:IsKrysioUIOutdated()
    return self:IsModuleOutdated(self.ADDON_NAME)
end

-- -------------------------------------------------------------------------------
-- Run update check and notify user
-- -------------------------------------------------------------------------------
local function DoUpdateCheck()
    if not KrysioUIDB or not KrysioUIDB.profile then return end

    local outdated = {}
    for moduleKey, manifestVer in pairs(KUI._versionManifest) do
        if KUI:IsModuleOutdated(moduleKey) then
            outdated[#outdated + 1] = moduleKey
        end
    end

    if #outdated > 0 then
        C_Timer.After(5, function()
            KUI:Print(L("UPDATES_AVAILABLE", #outdated))
            KUI:Print(L("TYPE_STATUS"))
        end)
    end
end

-- -------------------------------------------------------------------------------
-- Public command: check updates
-- -------------------------------------------------------------------------------
function KUI:CheckForUpdates(verbose)
    if not KrysioUIDB or not KrysioUIDB.profile then return end

    local count = 0
    for moduleKey, manifestVer in pairs(self._versionManifest) do
        if self:IsModuleOutdated(moduleKey) then
            if verbose then
                local installed = self:GetInstalledVersion(moduleKey) or L("NEVER_IMPORTED")
                KUI:Print(L("MODULE_OUTDATED", moduleKey, installed, manifestVer))
            end
            count = count + 1
        end
    end

    if count == 0 then
        if verbose then
            KUI:Print(L("ALL_UPDATED"))
        end
    end
end

-- Schedule update check on login
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    DoUpdateCheck()
end)