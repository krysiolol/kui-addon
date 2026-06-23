-------------------------------------------------------------------------------
--  KrysioUI\Modules\ModuleRegistry.lua
--  Registers all known modules. Each module defines detection, status,
--  import, and load functions. The data (profile strings) lives in Data/*.lua
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

-- -------------------------------------------------------------------------------
-- Helper: common addon-loaded checks
-- -------------------------------------------------------------------------------
local function IsAddonLoaded(name)
    local C_AddOns = C_AddOns
    if C_AddOns and C_AddOns.IsAddOnLoaded then
        return C_AddOns.IsAddOnLoaded(name)
    end
    return false
end

local function IsAddonEnabled(name)
    if not name then return true end
    if C_AddOns and C_AddOns.GetAddOnEnableState then
        local char = UnitName("player")
        return (C_AddOns.GetAddOnEnableState(name, char) or 0) > 0
    end
    return true
end

-- -------------------------------------------------------------------------------
-- 1. EllesmereUI (main focus)
-- -------------------------------------------------------------------------------
KUI:RegisterModule({
    key = "EllesmereUI",
    name = "EllesmereUI",
    description = L("ELLESMEREUI_DESC"),
    manifestKey = "EllesmereUI",
    requiredAddons = { "EllesmereUI" },
    hasResolution = true,
    hasSpecs = false,

    detectFn = function(self)
        return IsAddonLoaded("EllesmereUI")
    end,

    statusFn = function(self)
        if not self:detectFn() then return "missing" end
        -- Check if at least one EUI sub-addon has been imported
        local installed = KUI:GetInstalledVersion(self.manifestKey)
        if not installed then return "missing" end
        if KUI:IsModuleOutdated(self.manifestKey) then return "outdated" end
        return "installed"
    end,

    importFn = function(self, resolution, options, callback)
        -- Profile data is loaded from Data/EllesmereUI.lua
        local profileData = KUI:GetProfileData("EllesmereUI")
        if not profileData then
            if callback then callback(false, L("NO_PROFILE_DATA", self.name)) end
            return
        end

        local theme = (options and options.theme) or "dark"
        local isClassColor = (theme == "class")

        -- The actual import logic is in Modules/EllesmereUI.lua
        if KUI.Modules and KUI.Modules.EllesmereUI then
            local ok, err = pcall(KUI.Modules.EllesmereUI.Import, KUI.Modules.EllesmereUI, resolution, profileData, isClassColor)
            if ok then
                if callback then callback(true, L("EUI_IMPORTED", "all")) end
            else
                if callback then callback(false, tostring(err)) end
            end
        else
            if callback then callback(false, L("MODULE_IMPL_MISSING", self.name)) end
        end
    end,

    loadFn = function(self, resolution)
        if KUI.Modules and KUI.Modules.EllesmereUI then
            KUI.Modules.EllesmereUI:LoadProfiles(resolution)
        end
        return true
    end,
})

-- -------------------------------------------------------------------------------
-- 2. BigWigs
-- -------------------------------------------------------------------------------
KUI:RegisterModule({
    key = "BigWigs",
    name = "BigWigs",
    description = L("BIGWIGS_DESC"),
    manifestKey = "BigWigs",
    requiredAddons = { "BigWigs" },
    hasResolution = true,
    hasSpecs = false,

    detectFn = function(self)
        return IsAddonLoaded("BigWigs")
    end,

    statusFn = function(self)
        if not self:detectFn() then return "missing" end
        return KUI:GetInstalledVersion(self.manifestKey) and "installed" or "missing"
    end,

    importFn = function(self, resolution, options, callback)
        local profileData = KUI:GetProfileData("BigWigs")
        if not profileData then
            if callback then callback(false, L("NO_PROFILE_DATA", self.name)) end
            return
        end

        if KUI.Modules and KUI.Modules.BigWigs then
            -- BigWigs:Import is async — passes callback to RegisterProfile
            KUI.Modules.BigWigs:Import(resolution, profileData, options, callback)
        else
            if callback then callback(false, L("MODULE_IMPL_MISSING", self.name)) end
        end
    end,

    loadFn = function(self, resolution)
        if KUI.Modules and KUI.Modules.BigWigs then
            KUI.Modules.BigWigs:LoadProfile(resolution)
        end
        return true
    end,
})

-- -------------------------------------------------------------------------------
-- 3. Blizzard Edit Mode
-- -------------------------------------------------------------------------------
KUI:RegisterModule({
    key = "EditMode",
    name = L("EDITMODE_NAME"),
    description = L("EDITMODE_DESC"),
    manifestKey = "EditMode",
    requiredAddons = {},
    hasResolution = true,
    hasSpecs = false,

    detectFn = function(self)
        -- Edit Mode is always available in modern WoW (no addon needed)
        return C_EditMode ~= nil
    end,

    statusFn = function(self)
        return KUI:GetInstalledVersion(self.manifestKey) and "installed" or "missing"
    end,

    importFn = function(self, resolution, options, callback)
        local profileData = KUI:GetProfileData("EditMode")
        if not profileData then
            if callback then callback(false, L("NO_PROFILE_DATA", self.name)) end
            return
        end

        -- Check data availability BEFORE calling the module (avoids raw
        -- error() messages that can include file paths in some Lua builds)
        local layoutString = profileData[resolution]
        if not layoutString or layoutString == "" then
            if callback then callback(false, L("NO_PROFILE_DATA", self.name)) end
            return
        end

        if KUI.Modules and KUI.Modules.EditMode then
            KUI.Modules.EditMode:Import(resolution, profileData, options, callback)
        else
            if callback then callback(false, L("MODULE_IMPL_MISSING", self.name)) end
        end
    end,

    loadFn = function(self, resolution)
        if KUI.Modules and KUI.Modules.EditMode then
            KUI.Modules.EditMode:LoadProfile(resolution)
        end
        return true
    end,
})

-- -------------------------------------------------------------------------------
-- 4. Blizzard Cooldown Manager
-- -------------------------------------------------------------------------------
KUI:RegisterModule({
    key = "CooldownManager",
    name = L("CDM_NAME"),
    description = L("CDM_DESC"),
    manifestKey = "CooldownManager",
    requiredAddons = {},
    hasResolution = true,
    hasSpecs = true,

    detectFn = function(self)
        return CooldownViewerSettings ~= nil
    end,

    statusFn = function(self)
        local installed = KUI:GetInstalledVersion(self.manifestKey)
        if not installed then return "missing" end
        if KUI:IsModuleOutdated(self.manifestKey) then return "outdated" end
        return "installed"
    end,

    importFn = function(self, resolution, options, callback)
        local profileData = KUI:GetProfileData("CooldownManager")
        if not profileData then
            if callback then callback(false, L("NO_PROFILE_DATA", self.name)) end
            return
        end

        -- Check data availability BEFORE calling the module
        if not profileData.cdmData then
            if callback then callback(false, L("NO_PROFILE_DATA", self.name)) end
            return
        end

        if KUI.Modules and KUI.Modules.CooldownManager then
            KUI.Modules.CooldownManager:Import(resolution, profileData, options, callback)
        else
            if callback then callback(false, L("MODULE_IMPL_MISSING", self.name)) end
        end
    end,

    loadFn = function(self, resolution)
        if KUI.Modules and KUI.Modules.CooldownManager then
            KUI.Modules.CooldownManager:LoadProfiles(resolution)
        end
        return true
    end,
})