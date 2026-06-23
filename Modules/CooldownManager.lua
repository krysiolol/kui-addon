-------------------------------------------------------------------------------
--  KrysioUI\Modules\CooldownManager.lua
--  Blizzard Cooldown Manager layout import handler
--
--  Uses CooldownViewerSettings API. CDM layouts are class-specific,
--  so imports work per-spec.
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI.Modules = KUI.Modules or {}
KUI.Modules.CooldownManager = {}

local CDM = KUI.Modules.CooldownManager

-- -------------------------------------------------------------------------------
-- Helpers
-- -------------------------------------------------------------------------------
local function GetLayoutManager()
    if not CooldownViewerSettings or not CooldownViewerSettings.GetLayoutManager then
        return nil
    end
    return CooldownViewerSettings:GetLayoutManager()
end

local function GetDataProvider()
    if not CooldownViewerSettings or not CooldownViewerSettings.GetDataProvider then
        return nil
    end
    return CooldownViewerSettings:GetDataProvider()
end

local function GetLayoutIDByName(layoutName)
    local lm = GetLayoutManager()
    if not lm then return nil end
    local _, layouts = lm:EnumerateLayouts()
    for layoutID, layout in pairs(layouts) do
        if layout and layout.layoutName == layoutName then
            return layoutID
        end
    end
end

local function RemoveLayoutByName(layoutName)
    local lm = GetLayoutManager()
    if not lm then return end
    local id = GetLayoutIDByName(layoutName)
    if id then
        lm:RemoveLayout(id)
    end
end

local function ImportLayoutString(profileString, profileKeyToReplace)
    if not profileString or profileString == "" then return nil end

    local lm = GetLayoutManager()
    if not lm then return nil end

    if profileKeyToReplace then
        RemoveLayoutByName(profileKeyToReplace)
    end

    if lm.AreLayoutsFullyMaxed and lm:AreLayoutsFullyMaxed() then
        local activeID = lm:GetActiveLayoutID()
        if activeID then lm:RemoveLayout(activeID) end
    end

    local layoutIDs = lm:CreateLayoutsFromSerializedData(profileString)
    if layoutIDs and layoutIDs[1] then
        lm:SaveLayouts()
        return layoutIDs[1]
    end
end

local function GetCurrentSpecTag()
    if not CooldownViewerUtil or not CooldownViewerUtil.GetCurrentClassAndSpecTag then
        return nil
    end
    return tonumber(CooldownViewerUtil.GetCurrentClassAndSpecTag())
end

local function ActivateLayout(layoutID)
    local lm = GetLayoutManager()
    if not lm or not layoutID then return false end

    local dataProvider = GetDataProvider()
    if dataProvider and dataProvider.CheckBuildDisplayData then
        pcall(function() dataProvider:CheckBuildDisplayData() end)
    end

    if dataProvider and dataProvider.MarkDirty then
        dataProvider:MarkDirty()
    end

    local didActivate = false
    if dataProvider and dataProvider.SetActiveLayoutByID and dataProvider.GetDisplayData and dataProvider:GetDisplayData() then
        dataProvider:SetActiveLayoutByID(layoutID)
        didActivate = true
    else
        didActivate = lm:SetActiveLayoutByID(layoutID)
    end

    if CooldownViewerSettings and CooldownViewerSettings.RefreshLayout then
        pcall(function() CooldownViewerSettings:RefreshLayout() end)
    end

    if lm.NotifyListeners then
        lm:NotifyListeners()
    end

    if CooldownViewerSettings and CooldownViewerSettings.SaveCurrentLayout then
        pcall(function() CooldownViewerSettings:SaveCurrentLayout() end)
    else
        lm:SaveLayouts()
    end

    return didActivate
end

-- -------------------------------------------------------------------------------
-- Remove ALL CDM layouts whose name starts with the given prefix (e.g.
-- "KrysioUI").  We do this BEFORE the import loop so every spec gets a
-- clean layout slot — avoids CDM layout-cap limits.
-- -------------------------------------------------------------------------------
local function RemoveAllLayoutsByPrefix(prefix)
    local lm = GetLayoutManager()
    if not lm or not prefix then return end

    local _, layouts = lm:EnumerateLayouts()
    for layoutID, layout in pairs(layouts) do
        if layout and layout.layoutName and layout.layoutName:find(prefix, 1, true) == 1 then
            lm:RemoveLayout(layoutID)
        end
    end
    lm:SaveLayouts()
end

-- -------------------------------------------------------------------------------
-- Exposed: clean ALL KrysioUI CDM layouts (call once before button-based
-- import so each spec gets a fresh slot)
-- -------------------------------------------------------------------------------
function CDM:CleanLayouts()
    RemoveAllLayoutsByPrefix("KrysioUI")
end

-- -------------------------------------------------------------------------------
-- Exposed: import a SINGLE CDM spec profile (for button-based Step 2b UI).
-- Does NOT call CleanLayouts — call it once before the first button click.
--   tag      : integer tag (e.g. 111 for Druid Balance)
--   callback : function(success, message)
-- -------------------------------------------------------------------------------
function CDM:ImportOne(resolution, profileData, tag, callback)
    local cdmData = profileData.cdmData
    if not cdmData then
        if callback then callback(false, "No CDM data") end
        return
    end
    local profiles = cdmData.profiles or {}
    local tagProfiles = profiles[tag]
    if not tagProfiles then
        if callback then callback(false, "No data for tag " .. tostring(tag)) end
        return
    end

    local lm = GetLayoutManager()
    if not lm then
        if callback then callback(false, "CDM layout API not available") end
        return
    end

    for profileKey, profileString in pairs(tagProfiles) do
        local layoutID
        local ok, err = pcall(function()
            layoutID = ImportLayoutString(profileString, profileKey)
        end)
        if ok and layoutID then
            -- Activate if this spec matches the player's current spec
            local currentTag = GetCurrentSpecTag()
            local tagNum = tonumber(tag)
            if currentTag and tagNum and currentTag == tagNum then
                ActivateLayout(layoutID)
                if C_Timer and C_Timer.After then
                    C_Timer.After(0, function()
                        if not (InCombatLockdown and InCombatLockdown()) then
                            ActivateLayout(layoutID)
                        end
                    end)
                end
            end
            if callback then callback(true, profileKey) end
            return
        else
            local reason
            if not ok then
                reason = tostring(err)
            else
                reason = "CDM API returned nil"
            end
            if callback then callback(false, profileKey .. ": " .. reason) end
            return
        end
    end
    if callback then callback(false, "No profile string found") end
end

-- -------------------------------------------------------------------------------
-- Import CDM layouts for selected specs (or all available)
-- -------------------------------------------------------------------------------
function CDM:Import(resolution, profileData, options, callback)
    -- Data is already validated by importFn before calling us
    local cdmData = profileData.cdmData
    local profileKeys = cdmData.profileKeys or {}
    local profiles = cdmData.profiles or {}

    -- Quick feedback via UIErrorsFrame (visible immediately, unlike KUI:Print)
    local function UIMsg(msg, isError)
        local r, g, b = 1, 1, 1
        if isError then r, g, b = 1, 0.2, 0.2 end
        if UIErrorsFrame then
            UIErrorsFrame:AddMessage(msg, r, g, b)
        end
    end

    -- Verify the layout manager is available before doing anything
    local lm = GetLayoutManager()
    if not lm then
        UIMsg("Cooldown Manager layout API not available.", true)
        if callback then callback(false, "CDM layout API not available.") end
        return
    end

    -- Determine which tags to import
    local tagsToImport = {}
    if options and options.selectedSpecs then
        local count = 0
        for _ in ipairs(options.selectedSpecs) do count = count + 1 end
        if count > 0 then
            tagsToImport = options.selectedSpecs
        end
    end

    -- If no specs were passed or array was empty, import all available
    if #tagsToImport == 0 then
        for tag, _ in pairs(profiles) do
            tagsToImport[#tagsToImport + 1] = tag
        end
    end

    if #tagsToImport == 0 then
        UIMsg("No CDM profile data found for any spec.", true)
        KUI:Print(L("CDM_NO_PROFILES"))
        if callback then callback(false, L("CDM_NO_PROFILES")) end
        return
    end

    -- Import all selected specs and track imported layout IDs per tag
    local imported = 0
    local errors = 0
    local errDetails = {}
    local importedLayouts = {}  -- tag -> layoutID for current spec activation

    for _, tag in ipairs(tagsToImport) do
        local tagProfiles = profiles[tag]
        if tagProfiles then
            for profileKey, profileString in pairs(tagProfiles) do
                local layoutID
                local ok, err = pcall(function()
                    layoutID = ImportLayoutString(profileString, profileKey)
                end)
                if ok and layoutID then
                    imported = imported + 1
                    importedLayouts[tag] = layoutID
                    UIMsg("CDM imported: " .. profileKey)
                    KUI:Print(L("CDM_IMPORTED_SPEC", profileKey))
                else
                    errors = errors + 1
                    local reason
                    if not ok then
                        reason = "Lua error: " .. tostring(err)
                    elseif not layoutID then
                        reason = "CDM API returned nil (layout limit or corrupt string?)"
                    end
                    errDetails[#errDetails + 1] = profileKey .. " — " .. reason
                    UIMsg("CDM failed: " .. profileKey .. " (" .. reason .. ")", true)
                    KUI:Print("|cffff4444[KrysioUI] CDM import error: " .. profileKey .. " — " .. reason .. "|r")
                end
            end
        else
            errors = errors + 1
            local tagStr = tostring(tag)
            errDetails[#errDetails + 1] = "No profile data for tag " .. tagStr
            UIMsg("CDM: no profile data for tag " .. tagStr, true)
        end
    end

    if imported == 0 then
        UIMsg("Failed to import any CDM layouts.", true)
        KUI:Print(L("CDM_NO_PROFILES"))
        if callback then callback(false, "No CDM layouts were imported (0/" .. (#tagsToImport) .. " tags). Errors: " .. table.concat(errDetails, "; ")) end
        return
    end

    -- Activate the current spec's layout if it was imported: import + immediate activation with retry
    local currentTag = GetCurrentSpecTag()
    if currentTag and importedLayouts[currentTag] then
        local activeID = importedLayouts[currentTag]
        ActivateLayout(activeID)
        -- Retry after 0s to handle CDM race conditions
        if C_Timer and C_Timer.After then
            C_Timer.After(0, function()
                if not (InCombatLockdown and InCombatLockdown()) then
                    ActivateLayout(activeID)
                end
            end)
        end
        UIMsg("CDM layout activated for current spec!")
        KUI:Print(L("CDM_ACTIVATED_SPEC"))
    end

    local resultMsg = L("CDM_IMPORTED_COUNT", imported)
    if errors > 0 then
        resultMsg = resultMsg .. " (" .. errors .. " errors: " .. table.concat(errDetails, "; ") .. ")"
    end
    KUI:Print(resultMsg)
    if callback then callback(true, resultMsg) end
end

-- -------------------------------------------------------------------------------
-- Load (activate) CDM layout for current spec
-- -------------------------------------------------------------------------------
function CDM:LoadProfiles(resolution)
    local profileData = KUI:GetProfileData("CooldownManager")
    if not profileData or not profileData.cdmData then
        KUI:Print(L("CDM_NO_DATA"))
        return
    end

    local currentTag = GetCurrentSpecTag()
    if not currentTag then
        KUI:Print(L("CDM_SPEC_NOT_DETECTED"))
        return
    end

    -- Find matching tag within ±5 range
    local profiles = profileData.cdmData.profiles or {}
    for tag, tagProfiles in pairs(profiles) do
        tag = tonumber(tag)
        if tag and math.abs(tag - currentTag) <= 5 then
            for profileKey, profileString in pairs(tagProfiles) do
                local layoutID = ImportLayoutString(profileString, profileKey)
                if layoutID then
                    ActivateLayout(layoutID)
                    KUI:Print(L("CDM_ACTIVATED", profileKey))
                    return
                end
            end
        end
    end

    KUI:Print(L("CDM_NO_LAYOUT"))
end