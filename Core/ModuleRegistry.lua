-------------------------------------------------------------------------------
--  KrysioUI\Core\ModuleRegistry.lua
--  Module registration API (LIGHTWEIGHT — just the registration contract)
--  Modules are instantiated in Modules/ModuleRegistry.lua
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI

-- Registered modules table
KUI._registeredModules = {}
KUI._modulesByKey = {}

-- -------------------------------------------------------------------------------
-- Register a module
--
-- Module definition:
--   key           : String — unique identifier (e.g., "EllesmereUI")
--   name          : String — human-readable display name
--   description   : String — what this module does
--   manifestKey   : String — key in VersionManifest for version checking
--   requiredAddons: String[] — addon folders to check if loaded
--   hasResolution : Bool — whether profiles differ per resolution
--   hasSpecs      : Bool — whether profiles are spec-specific (CDM)
--   detectFn      : Function() -> Bool — is the addon available?
--   statusFn      : Function() -> "installed"|"outdated"|"missing"
--   importFn      : Function(resolution, options, callback) — import profiles
--   loadFn        : Function(resolution, options, callback) — switch to existing profile
--   getPagesFn    : Function() -> table[] — installer step pages (see Installer)
-- -------------------------------------------------------------------------------
function KUI:RegisterModule(definition)
    if not definition or not definition.key then
        error("KrysioUI: Module must have a key")
    end
    if self._modulesByKey[definition.key] then
        error("KrysioUI: Module '" .. definition.key .. "' already registered")
    end

    -- Defaults
    definition.hasResolution = definition.hasResolution ~= false
    definition.hasSpecs = definition.hasSpecs or false
    definition.requiredAddons = definition.requiredAddons or {}
    definition.manifestKey = definition.manifestKey or definition.key

    self._modulesByKey[definition.key] = definition
    table.insert(self._registeredModules, definition)

    return definition
end

-- -------------------------------------------------------------------------------
-- Get a module by key
-- -------------------------------------------------------------------------------
function KUI:GetModule(key)
    return self._modulesByKey[key]
end

-- -------------------------------------------------------------------------------
-- Get all registered modules in order
-- -------------------------------------------------------------------------------
function KUI:GetAllModules()
    return self._registeredModules
end

-- -------------------------------------------------------------------------------
-- Auto-detect which modules are available
-- -------------------------------------------------------------------------------
function KUI:DetectModules()
    for _, mod in ipairs(self._registeredModules) do
        mod.isDetected = mod.detectFn and mod:detectFn() or false
    end
    return self._registeredModules
end

-- -------------------------------------------------------------------------------
-- Refresh module statuses (installed/outdated/missing)
-- -------------------------------------------------------------------------------
function KUI:RefreshModuleStatuses()
    for _, mod in ipairs(self._registeredModules) do
        if mod.statusFn then
            mod.status = mod:statusFn()
        elseif mod.isDetected then
            local installed = self:GetInstalledVersion(mod.manifestKey)
            if not installed then
                mod.status = "missing"
            elseif self:IsModuleOutdated(mod.manifestKey) then
                mod.status = "outdated"
            else
                mod.status = "installed"
            end
        else
            mod.status = "missing"
        end
    end
    return self._registeredModules
end