-------------------------------------------------------------------------------
--  KrysioUI\Locales\esMX.lua
--  Spanish (Mexico) localization — mostly same as esES, adjusted for MX usage
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

-- Reuse esES as base, override MX-specific differences
local esES = KUI._localeData["esES"] or {}
local mx = {}
for k, v in pairs(esES) do
    mx[k] = v
end

-- MX-specific adjustments
mx.CLOSE = "Cerrar"
mx.RELOAD_UI = "Recargar UI"
mx.WELCOME_TITLE = "¡Bienvenido a KrysioUI!"

KUI:RegisterLocale("esMX", mx)