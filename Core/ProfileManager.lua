-------------------------------------------------------------------------------
--  KrysioUI\Core\ProfileManager.lua
--  Profile import/export orchestration
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI

-- Profile data table (populated by Data/*.lua)
KUI._profileData = {}

-- -------------------------------------------------------------------------------
-- Register profile data for a module
--   key  : module key
--   data : table with module's profile strings
-- -------------------------------------------------------------------------------
function KUI:SetProfileData(key, data)
    self._profileData[key] = data
end

-- -------------------------------------------------------------------------------
-- Get profile data for a module
-- -------------------------------------------------------------------------------
function KUI:GetProfileData(key)
    return self._profileData[key]
end

-- -------------------------------------------------------------------------------
-- Import a single module's profiles
--   moduleKey : registered module key
--   options   : table with user choices (theme, specs, etc.)
--   callback  : function(success, message) called when done
-- -------------------------------------------------------------------------------
function KUI:ImportModule(moduleKey, options, callback)
    local mod = self:GetModule(moduleKey)
    if not mod then
        if callback then callback(false, L("MODULE_NOT_FOUND", moduleKey)) end
        return
    end

    if not mod.importFn then
        if callback then callback(false, L("MODULE_NO_IMPORT", moduleKey)) end
        return
    end

    local resolution = self:GetResolution()
    options = options or {}

    -- Callback wrapper: on success mark version as installed
    local importCallback = function(success, msg)
        if success then
            self:SetInstalledVersion(mod.manifestKey)
        end
        if callback then
            callback(success, msg or (success and L("MODULE_IMPORTED", mod.name) or "Import failed"))
        end
    end

    -- importFn(self, resolution, options, importCallback)
    -- Can be sync (calls callback before returning) or async (e.g. BigWigs
    -- confirmation popup — calls callback when user responds)
    local ok, err = pcall(mod.importFn, mod, resolution, options, importCallback)
    if not ok then
        -- Synchronous error (pcall caught an error() call)
        importCallback(false, tostring(err))
    end
end

-- -------------------------------------------------------------------------------
-- Import all selected modules sequentially
--   selectedKeys : table of module keys to import
--   options      : per-module option overrides
--   progressFn   : function(current, total, moduleKey, status, message)
-- -------------------------------------------------------------------------------
function KUI:ImportAll(selectedKeys, options, progressFn)
    local total = #selectedKeys
    local successes = 0
    local failures = {}

    for i, moduleKey in ipairs(selectedKeys) do
        if progressFn then
            progressFn(i, total, moduleKey, "importing", nil)
        end

        self:ImportModule(moduleKey, (options or {})[moduleKey], function(success, msg)
            if success then
                successes = successes + 1
                if progressFn then
                    progressFn(i, total, moduleKey, "done", msg)
                end
            else
                failures[#failures + 1] = { moduleKey = moduleKey, error = msg }
                if progressFn then
                    progressFn(i, total, moduleKey, "error", msg)
                end
            end
        end)
    end
end

-- -------------------------------------------------------------------------------
-- Load (switch to) an already-installed profile for a module
-- -------------------------------------------------------------------------------
function KUI:LoadModuleProfile(moduleKey, callback)
    local mod = self:GetModule(moduleKey)
    if not mod then
        if callback then callback(false, L("MODULE_NOT_FOUND", moduleKey)) end
        return
    end

    if not mod.loadFn then
        -- Fallback: just verify it's installed
        local installed = self:GetInstalledVersion(mod.manifestKey)
        if installed then
            if callback then callback(true, L("MODULE_ALREADY_INSTALLED", mod.name, installed)) end
        else
            if callback then callback(false, L("MODULE_NOT_INSTALLED", mod.name)) end
        end
        return
    end

    local resolution = self:GetResolution()
    local success, err = pcall(mod.loadFn, mod, resolution)
    if success then
        if callback then callback(true, L("MODULE_LOADED", mod.name)) end
    else
        if callback then callback(false, tostring(err)) end
    end
end