-------------------------------------------------------------------------------
--  KrysioUI\Data\VersionManifest.lua
--  Version manifest — developer bumps these when profile data changes
--
--  Each key maps to a module's manifestKey (set in module registration).
--  KrysioUI version tracks the addon itself.
--  Add a new key when adding support for a new addon.
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI:SetVersionManifest({
    KrysioUI         = "1.0.0",
    EllesmereUI      = "8.2.2",
    BigWigs          = "1.0.0",
    EditMode         = "1.0.0",
    CooldownManager  = "1.0.0",
    -- Add new modules here:
    -- Plater         = "1.0.0",
    -- WeakAuras      = "1.0.0",
})