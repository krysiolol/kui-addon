-------------------------------------------------------------------------------
--  KrysioUI\Core\Locale.lua
--  Localization system — lightweight, no external dependency
--  Inspired by EllesmereUI's locale engine
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
local GetLocale = GetLocale

-- Locale string table
KUI.L = {}

-- Active locale code
local localeCode = GetLocale()

-- Locale data tables populated by Locales/*.lua
KUI._localeData = {}

-- -------------------------------------------------------------------------------
-- Register a locale table (called from Locales/*.lua)
-- -------------------------------------------------------------------------------
function KUI:RegisterLocale(locale, data)
    self._localeData[locale] = data
end

-- -------------------------------------------------------------------------------
-- Resolve the active translation
-- -------------------------------------------------------------------------------
function KUI:GetLocale()
    -- Try exact match first
    if self._localeData[localeCode] then
        return localeCode
    end
    -- Try base language (e.g., esES -> es)
    local base = localeCode:sub(1, 2)
    for code, _ in pairs(self._localeData) do
        if code:sub(1, 2) == base then
            return code
        end
    end
    -- Fallback to enUS
    return "enUS"
end

-- -------------------------------------------------------------------------------
-- L[key] shortcut — returns localized string
-- -------------------------------------------------------------------------------
function KUI:GetString(key, ...)
    local active = self._localeData[self:GetLocale()] or self._localeData["enUS"] or {}
    local str = active[key] or self._localeData["enUS"] and self._localeData["enUS"][key] or key

    if select("#", ...) > 0 then
        return format(str, ...)
    end
    return str
end

-- Alias at module level for easy access
function L(key, ...)
    return KUI:GetString(key, ...)
end

-- -------------------------------------------------------------------------------
-- Build the translatable string table immediately
-- -------------------------------------------------------------------------------
function KUI:FinalizeLocale()
    self.L = {}
    local active = self._localeData[self:GetLocale()] or self._localeData["enUS"] or {}
    for key, val in pairs(self._localeData["enUS"] or {}) do
        self.L[key] = active[key] or val
    end
end