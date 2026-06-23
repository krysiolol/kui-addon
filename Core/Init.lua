-------------------------------------------------------------------------------
--  KrysioUI\Core\Init.lua
--  SavedVariables defaults, constants, and core initialization
-------------------------------------------------------------------------------

local addonName, KUI = ...
_G.KrysioUI = KUI

-- -------------------------------------------------------------------------------
-- Constants
-- -------------------------------------------------------------------------------
KUI.ADDON_NAME = "KrysioUI"
KUI.VERSION = "1.0.0"
KUI.MEDIA_PATH = "Interface\\AddOns\\KrysioUI\\media\\"
KUI.ICON_TEXTURE = KUI.MEDIA_PATH .. "icon.png"

-- Resolution detection
function KUI:GetResolution()
    local _, vertical = GetPhysicalScreenSize()
    return (vertical <= 1200) and "1080p" or "1440p"
end

-- Designed resolution check
KUI.DESIGNED_RESOLUTION = "1440p"

function KUI:IsDesignedResolution()
    return self:GetResolution() == self.DESIGNED_RESOLUTION
end

-- Color helpers (Krysio signature purple + black)
KUI.COLORS = {
    PURPLE     = { r = 0.65, g = 0.15, b = 0.90 }, -- signature purple
    LIGHT_PURPLE = { r = 0.78, g = 0.42, b = 1.0 }, -- hover / highlight
    WHITE      = { r = 1,    g = 1,    b = 1 },
    GREY       = { r = 0.6,  g = 0.6,  b = 0.6 },
    RED        = { r = 1,    g = 0.2,  b = 0.2 },
    YELLOW     = { r = 1,    g = 0.82, b = 0 },
    ORANGE     = { r = 1,    g = 0.55, b = 0.05 },
    DIM_WHITE  = { r = 1,    g = 1,    b = 1, a = 0.45 },
    PANEL_BG   = { r = 0.032, g = 0.012, b = 0.050 }, -- deep purple-black
    BORDER     = { r = 0.65, g = 0.15, b = 0.90, a = 0.20 }, -- purple tint
    CHECKBOX_BG = { r = 0.06, g = 0.02, b = 0.10 },
    CHECKBOX_BORDER = { r = 0.65, g = 0.15, b = 0.90, a = 0.30 },
    CHECKBOX_ACTIVE_BORDER = { r = 0.78, g = 0.42, b = 1.0, a = 0.85 },
}

-- Status icons for module list (ASCII only — FRIZQT__.TTF has no Unicode)
KUI.STATUS_ICONS = {
    INSTALLED   = "|cff00ff00[v]|r",
    OUTDATED    = "|cffffd700[*]|r",
    MISSING     = "|cffff4444[x]|r",
    LOCKED      = "|cff888888[-]|r",
    PENDING     = "|cffffff00[>]|r",
}

-- -------------------------------------------------------------------------------
-- SavedVariables Defaults
-- -------------------------------------------------------------------------------
KUI.defaultDB = {
    profile = {
        -- Installed version tracking per module
        installedVersions = {},
        -- User's module selection (persisted for repeat installs)
        selectedModules = {
            EllesmereUI = true,
            BigWigs = true,
            EditMode = true,
            CooldownManager = true,
        },
        -- Per-module options
        moduleOptions = {
            EllesmereUI = {
                theme = "dark", -- "dark" or "class"
            },
            CooldownManager = {
                importAllSpecs = false,
                selectedSpecs = {},
            },
        },
        -- UI preferences
        minimap = {
            hide = false,
            minimapPos = 220,
        },
        -- First install flag
        firstInstallDone = false,
        -- Changelog viewed versions
        viewedChangelog = {},
    },
    global = {
        -- Developer: bump this when profile data changes
        dataVersion = 1,
    },
}

-- -------------------------------------------------------------------------------
-- Initialize DB
-- -------------------------------------------------------------------------------
function KUI:InitializeDB()
    if not KrysioUIDB then KrysioUIDB = {} end
    if not KrysioUIDB.profile then KrysioUIDB.profile = {} end
    if not KrysioUIDB.global then KrysioUIDB.global = {} end

    -- Merge defaults (shallow merge for profile, deep for nested tables)
    local function MergeDefaults(src, defaults)
        for k, v in pairs(defaults) do
            if src[k] == nil then
                src[k] = v
            elseif type(v) == "table" and type(src[k]) == "table" then
                MergeDefaults(src[k], v)
            end
        end
    end

    MergeDefaults(KrysioUIDB.profile, self.defaultDB.profile)
    MergeDefaults(KrysioUIDB.global, self.defaultDB.global)

    self.db = KrysioUIDB
    self.db.profile = KrysioUIDB.profile
    self.db.global = KrysioUIDB.global
end

-- -------------------------------------------------------------------------------
-- Version comparison
-- -------------------------------------------------------------------------------
function KUI:ParseVersion(verStr)
    if not verStr or verStr == "" then return 0 end
    local major, minor, patch = strsplit(".", tostring(verStr))
    major = tonumber(major) or 0
    minor = tonumber(minor) or 0
    patch = tonumber(patch) or 0
    return major * 10000 + minor * 100 + patch
end

function KUI:IsNewerVersion(newVer, oldVer)
    return self:ParseVersion(newVer) > self:ParseVersion(oldVer)
end

-- -------------------------------------------------------------------------------
-- Print helper
-- -------------------------------------------------------------------------------
function KUI:Print(msg)
    print("|cffa626e6[KrysioUI]|r " .. (msg or ""))
end

-- -------------------------------------------------------------------------------
-- Boot sequence
-- -------------------------------------------------------------------------------
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function(self, event, name)
    if event == "ADDON_LOADED" then
        if name ~= addonName then return end
        self:UnregisterEvent("ADDON_LOADED")
        KUI:InitializeDB()

    elseif event == "PLAYER_LOGIN" then
        self:UnregisterEvent("PLAYER_LOGIN")

        -- Finalize locale resolution
        KUI:FinalizeLocale()

        -- Boot minimap button (deferred so other addons can init first)
        C_Timer.After(2, function()
            KUI:SetupMinimapButton()
        end)
    end
end)