-------------------------------------------------------------------------------
--  KrysioUI\Core\Installer\Steps.lua
--  Step-based installer wizard (Intro → Selection → Import → Finish)
--  Visual style: purple-black theme with Krysio signature purple accents
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

local C = KUI.COLORS

-- Current context while wizard is open
local ctx = nil

-- -------------------------------------------------------------------------------
-- Helper: create a row with checkbox + label (like EllesmereUI first-install)
-- -------------------------------------------------------------------------------
local function CreateCheckboxRow(parent, label, isChecked, onClick, font, pp, colWidth, yOff)
    local ROW_H = 28
    local BOX_SZ = 18
    local CHECK_INSET = 3

    local row = CreateFrame("Button", nil, parent)
    pp.Size(row, colWidth, ROW_H)
    row:ClearAllPoints()
    if yOff then
        row:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -yOff)
    end

    -- Checkbox background
    local box = CreateFrame("Frame", nil, row)
    pp.Size(box, BOX_SZ, BOX_SZ)
    box:SetPoint("LEFT", row, "LEFT", 8, 0)
    box:SetFrameLevel(row:GetFrameLevel() + 1)

    local boxBg = box:CreateTexture(nil, "BACKGROUND")
    boxBg:SetAllPoints()
    boxBg:SetColorTexture(C.CHECKBOX_BG.r, C.CHECKBOX_BG.g, C.CHECKBOX_BG.b, 1)

    local boxBorder = {}
    for _, edge in ipairs(KUI:MakeBorder(box, 1, 1, 1, 0.25, pp)) do
        boxBorder[#boxBorder + 1] = edge
    end

    local check = box:CreateTexture(nil, "ARTWORK")
    check:SetPoint("TOPLEFT", box, "TOPLEFT", CHECK_INSET, -CHECK_INSET)
    check:SetPoint("BOTTOMRIGHT", box, "BOTTOMRIGHT", -CHECK_INSET, CHECK_INSET)
    check:SetColorTexture(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 1)

    -- Status icon (if provided)
    local statusIcon

    -- Label
    local lbl = row:CreateFontString(nil, "OVERLAY")
    lbl:SetFont(font, 14, "")
    lbl:SetPoint("LEFT", box, "RIGHT", 8, 0)
    lbl:SetTextColor(1, 1, 1, 0.65)
    lbl:SetText(label)

    local state = isChecked

    local function UpdateVisual()
        if state then
            check:Show()
            for _, b in ipairs(boxBorder) do
                b:SetColorTexture(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, C.CHECKBOX_ACTIVE_BORDER.a)
            end
        else
            check:Hide()
            for _, b in ipairs(boxBorder) do
                b:SetColorTexture(1, 1, 1, C.CHECKBOX_BORDER.a)
            end
        end
    end
    UpdateVisual()

    row:SetScript("OnClick", function()
        state = not state
        UpdateVisual()
        if onClick then onClick(state) end
    end)
    row:SetScript("OnEnter", function()
        lbl:SetTextColor(1, 1, 1, 0.9)
    end)
    row:SetScript("OnLeave", function()
        lbl:SetTextColor(1, 1, 1, 0.65)
    end)

    return row, state
end

-- -------------------------------------------------------------------------------
-- Build the step-based installer
-- -------------------------------------------------------------------------------
function KUI:_BuildInstallerWizard(mode)
    mode = mode or "install" -- "install", "update", "load"

    -- Make sure modules are detected and status refreshed
    self:DetectModules()
    self:RefreshModuleStatuses()

    local allModules = self:GetAllModules()

    -- Build step pages
    local steps = {}
    -- Track what happened during import (shared between Step 3 and Step 4)
    local importResult = { imported = 0, alreadyCurrent = 0, notDetected = 0, notFound = 0, noData = 0, errors = 0 }
    -- CDM specs the user selected in Step 2b (shared with Step 3 import)
    local cdmSelectedSpecs = {}
    -- Whether Step 2b has been initialized (prevents refresh from re-populating)
    local cdmSpecsInitialized = false

    -- Wizard dimensions and helpers (declared before steps so closures can
    -- access dimmer, pp, etc.)
    local W = 520
    local H = 480
    local FONT = "Fonts\\FRIZQT__.TTF"
    if EllesmereUI and EllesmereUI._font then
        FONT = EllesmereUI._font
    end

    local pp = {
        Size = function(obj, w, h) obj:SetSize(w, h) end,
        Point = function(obj, ...) obj:SetPoint(...) end,
    }

    -- Dimmer (background overlay)
    local dimmer = CreateFrame("Frame", "KUIWizardDimmer", UIParent)
    dimmer:SetFrameStrata("FULLSCREEN_DIALOG")
    dimmer:SetAllPoints(UIParent)
    dimmer:EnableMouse(true)
    dimmer:EnableMouseWheel(true)
    dimmer:SetScript("OnMouseWheel", function() end)
    dimmer:SetScale(1)
    dimmer:Hide()

    -- ---------------------------------------------------------------------------
    -- Step 1: Introduction
    -- ---------------------------------------------------------------------------
    steps[#steps + 1] = {
        title = L("STEP_INTRO_TITLE"),
        build = function(panel, font, pp, W, H, navigation)
            local title = panel:CreateFontString(nil, "OVERLAY")
            title:SetFont(font, 22, "")
            title:SetTextColor(1, 1, 1, 1)
            title:SetPoint("TOP", panel, "TOP", 0, -30)

            if mode == "install" then
                title:SetText(L("WELCOME_TITLE"))
            elseif mode == "update" then
                title:SetText(L("UPDATE_TITLE"))
            else
                title:SetText(L("LOAD_TITLE"))
            end

            local yOff = -50

            local desc1 = panel:CreateFontString(nil, "OVERLAY")
            desc1:SetFont(font, 14, "")
            desc1:SetTextColor(1, 1, 1, 0.5)
            desc1:SetWidth(W - 80)
            desc1:SetJustifyH("CENTER")
            desc1:SetWordWrap(true)
            desc1:SetPoint("TOP", title, "BOTTOM", 0, yOff)

            local resolution = KUI:GetResolution()
            if mode == "install" then
                desc1:SetText(L("WELCOME_DESC", resolution))
            elseif mode == "update" then
                desc1:SetText(L("UPDATE_DESC"))
            else
                desc1:SetText(L("LOAD_DESC"))
            end

            yOff = yOff - 50

            local desc2 = panel:CreateFontString(nil, "OVERLAY")
            desc2:SetFont(font, 13, "")
            desc2:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.6)
            desc2:SetWidth(W - 80)
            desc2:SetJustifyH("CENTER")
            desc2:SetWordWrap(true)
            desc2:SetPoint("TOP", title, "BOTTOM", 0, yOff)

            if mode == "install" then
                desc2:SetText(L("WELCOME_HELP", "/kui help"))
            end

            -- Show res warning for non-1440p
            if not KUI:IsDesignedResolution() then
                local designedRes = KUI.DESIGNED_RESOLUTION
                local currentRes = KUI:GetResolution()

                yOff = yOff - 60

                -- Orange accent bar at the top of the warning
                local bar = panel:CreateTexture(nil, "ARTWORK")
                bar:SetColorTexture(C.ORANGE.r, C.ORANGE.g, C.ORANGE.b, 0.15)
                bar:SetPoint("LEFT", panel, "LEFT", 25, yOff + 60)
                bar:SetPoint("RIGHT", panel, "RIGHT", -25, yOff + 60)
                bar:SetHeight(4)

                -- Warning title
                local warnTitle = panel:CreateFontString(nil, "OVERLAY")
                warnTitle:SetFont(font, 16, "")
                warnTitle:SetTextColor(C.ORANGE.r, C.ORANGE.g, C.ORANGE.b, 0.9)
                warnTitle:SetPoint("TOP", panel, "TOP", 0, yOff)
                warnTitle:SetText(L("RES_WARNING_TITLE"))

                yOff = yOff - 10

                -- Warning description box (subtle orange-tinted background)
                local warnBg = panel:CreateTexture(nil, "BACKGROUND")
                warnBg:SetColorTexture(C.ORANGE.r, C.ORANGE.g, C.ORANGE.b, 0.04)
                warnBg:SetPoint("LEFT", panel, "LEFT", 25, yOff - 50)
                warnBg:SetPoint("RIGHT", panel, "RIGHT", -25, yOff + 10)

                local warnDesc = panel:CreateFontString(nil, "OVERLAY")
                warnDesc:SetFont(font, 13, "")
                warnDesc:SetTextColor(1, 1, 1, 0.65)
                warnDesc:SetWidth(W - 80)
                warnDesc:SetJustifyH("CENTER")
                warnDesc:SetWordWrap(true)
                warnDesc:SetPoint("TOP", panel, "TOP", 0, yOff)
                warnDesc:SetText(L("RES_WARNING_DESC", designedRes, currentRes))
            end
        end,
    }

    -- ---------------------------------------------------------------------------
    -- Step 2: Module Selection
    -- ---------------------------------------------------------------------------
    steps[#steps + 1] = {
        title = L("STEP_SELECTION_TITLE"),
        build = function(panel, font, pp, W, H, navigation)
            local title = panel:CreateFontString(nil, "OVERLAY")
            title:SetFont(font, 18, "")
            title:SetTextColor(1, 1, 1, 1)
            title:SetPoint("TOP", panel, "TOP", 0, -25)
            title:SetText(L("SELECTION_TITLE"))

            -- Column settings
            local COL_W = W - 80
            local ROW_H = 30
            local HEADER_H = 30
            local yOff = HEADER_H + 10

            -- Container for scrollable list
            local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
            scrollFrame:SetPoint("TOPLEFT", panel, "TOPLEFT", 35, -55)
            scrollFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -30, -85)

            local content = CreateFrame("Frame", nil, scrollFrame)
            scrollFrame:SetScrollChild(content)

            -- Module rows
            local rowY = 0
            local rowRefs = {}

            for _, mod in ipairs(allModules) do
                local label = mod.name
                local detected = mod.isDetected
                local status = mod.status or "missing"

                -- Read initial checked state from DB
                -- Undetected modules (addon not loaded) are unchecked by default
                local modChecked = detected
                if KrysioUIDB and KrysioUIDB.profile and KrysioUIDB.profile.selectedModules[mod.key] ~= nil then
                    modChecked = KrysioUIDB.profile.selectedModules[mod.key]
                end

                -- Append status indicator
                if not detected then
                    label = label .. "  " .. L("ADDON_NOT_FOUND")
                elseif status == "installed" then
                    local ver = KUI:GetInstalledVersion(mod.manifestKey) or ""
                    label = label .. "  |cff00ff00" .. ver .. "|r"
                elseif status == "outdated" then
                    local inst = KUI:GetInstalledVersion(mod.manifestKey) or "-"
                    local manif = KUI:GetManifestVersion(mod.manifestKey) or "-"
                    label = label .. "  |cffffd700" .. inst .. " → " .. manif .. "|r"
                end

                local row, checked = CreateCheckboxRow(content, label, modChecked,
                    function(newState)
                        local modKey = mod.key
                        if KrysioUIDB and KrysioUIDB.profile then
                            KrysioUIDB.profile.selectedModules[modKey] = newState
                        end
                    end,
                    font, pp, COL_W, nil)

                row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, rowY)
                rowRefs[#rowRefs + 1] = row
                rowY = rowY - ROW_H
            end

            content:SetSize(COL_W, -rowY + 20)

            -- Hide scrollbar if content fits (avoids showing empty track)
            if scrollFrame.ScrollBar then
                local contentH = -rowY + 20
                if contentH <= scrollFrame:GetHeight() then
                    scrollFrame.ScrollBar:Hide()
                end
            end

            -- Select / Deselect All buttons — same style as Back/Next (bg +
            -- border + green text + hover), centered as a pair
            local linkY = -H + 85
            local BTN_W, BTN_H, BTN_GAP = 130, 28, 15
            local pairW = BTN_W * 2 + BTN_GAP
            local panelW = W  -- H is the passed-in height, W is width

            local checkAllBtn = CreateFrame("Button", nil, panel)
            checkAllBtn:SetFrameLevel(panel:GetFrameLevel() + 2)
            pp.Size(checkAllBtn, BTN_W, BTN_H)
            local cbBg = checkAllBtn:CreateTexture(nil, "BACKGROUND")
            cbBg:SetAllPoints()
            cbBg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)
            KUI:MakeBorder(checkAllBtn, C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9, pp)
            local calLbl = checkAllBtn:CreateFontString(nil, "OVERLAY")
            calLbl:SetFont(font, 13, "")
            calLbl:SetPoint("CENTER")
            calLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
            calLbl:SetText(L("CHECK_ALL"))

            local uncheckAllBtn = CreateFrame("Button", nil, panel)
            uncheckAllBtn:SetFrameLevel(panel:GetFrameLevel() + 2)
            pp.Size(uncheckAllBtn, BTN_W, BTN_H)
            local ubBg = uncheckAllBtn:CreateTexture(nil, "BACKGROUND")
            ubBg:SetAllPoints()
            ubBg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)
            KUI:MakeBorder(uncheckAllBtn, C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9, pp)
            local ualLbl = uncheckAllBtn:CreateFontString(nil, "OVERLAY")
            ualLbl:SetFont(font, 13, "")
            ualLbl:SetPoint("CENTER")
            ualLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
            ualLbl:SetText(L("UNCHECK_ALL"))

            -- Center the pair horizontally
            checkAllBtn:SetPoint("TOPLEFT", panel, "TOPLEFT", (panelW - pairW) / 2, linkY)
            uncheckAllBtn:SetPoint("LEFT", checkAllBtn, "RIGHT", BTN_GAP, 0)

            checkAllBtn:SetScript("OnClick", function()
                for _, mod in ipairs(allModules) do
                    if KrysioUIDB and KrysioUIDB.profile then
                        KrysioUIDB.profile.selectedModules[mod.key] = true
                    end
                end
                if navigation and navigation.refresh then
                    navigation:refresh()
                end
            end)
            checkAllBtn:SetScript("OnEnter", function() calLbl:SetTextColor(1, 1, 1, 0.8) end)
            checkAllBtn:SetScript("OnLeave", function() calLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9) end)

            uncheckAllBtn:SetScript("OnClick", function()
                for _, mod in ipairs(allModules) do
                    if KrysioUIDB and KrysioUIDB.profile then
                        KrysioUIDB.profile.selectedModules[mod.key] = false
                    end
                end
                if navigation and navigation.refresh then
                    navigation:refresh()
                end
            end)
            uncheckAllBtn:SetScript("OnEnter", function() ualLbl:SetTextColor(1, 1, 1, 0.8) end)
            uncheckAllBtn:SetScript("OnLeave", function() ualLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9) end)
        end,
    }

    -- ---------------------------------------------------------------------------
    -- Step 2b (conditional): CDM Spec Selection — BUTTON style
    -- Each spec is a clickable button styled like Back/Next.  Clicking one
    -- imports that spec's CDM layout immediately.  No checkboxes.
    -- ---------------------------------------------------------------------------
    steps[#steps + 1] = {
        title = L("CDM_SELECT_TITLE"),
        build = function(panel, font, pp, W, H, navigation)
            local title = panel:CreateFontString(nil, "OVERLAY")
            title:SetFont(font, 18, "")
            title:SetTextColor(1, 1, 1, 1)
            title:SetPoint("TOP", panel, "TOP", 0, -25)

            -- Helper: show a message and enable Next
            local function skipStep(msg)
                title:SetText(L("CDM_SELECT_TITLE"))
                local desc = panel:CreateFontString(nil, "OVERLAY")
                desc:SetFont(font, 14, "")
                desc:SetTextColor(1, 1, 1, 0.5)
                desc:SetWidth(W - 80)
                desc:SetJustifyH("CENTER")
                desc:SetWordWrap(true)
                desc:SetPoint("TOP", title, "BOTTOM", 0, -15)
                desc:SetText(msg)
                if navigation then navigation:enableNext() end
            end

            -- 1) Only show if CDM is selected in Step 2
            if not (KrysioUIDB and KrysioUIDB.profile and KrysioUIDB.profile.selectedModules["CooldownManager"] ~= false) then
                skipStep(L("CDM_SKIP"))
                return
            end

            -- 2) Detect player's class via CDM API
            if not CooldownViewerUtil or not CooldownViewerUtil.GetCurrentClassAndSpecTag then
                skipStep(L("CDM_CLASS_NOT_DETECTED"))
                return
            end
            local currentTag = tonumber(CooldownViewerUtil.GetCurrentClassAndSpecTag())
            if not currentTag then
                skipStep(L("CDM_CLASS_NOT_DETECTED"))
                return
            end
            local currentClass = math.floor(currentTag / 10)

            -- 3) Find matching profiles for this class
            local profileData = KUI:GetProfileData("CooldownManager")
            local profiles = profileData and profileData.cdmData and profileData.cdmData.profiles or {}
            local profileKeys = profileData and profileData.cdmData and profileData.cdmData.profileKeys or {}

            local classSpecs = {}
            for tagStr, tagProfiles in pairs(profiles) do
                local tagNum = tonumber(tagStr)
                if tagNum and math.floor(tagNum / 10) == currentClass then
                    for profileKey, profileString in pairs(tagProfiles) do
                        local keyInfo = profileKeys[tagStr]
                        local coloredName = profileKey
                        local icon
                        if keyInfo and keyInfo[profileKey] then
                            coloredName = keyInfo[profileKey].coloredName or profileKey
                            icon = keyInfo[profileKey].icon
                        end
                        classSpecs[#classSpecs + 1] = {
                            tag = tagStr,
                            key = profileKey,
                            hasData = (profileString ~= nil and profileString ~= ""),
                            displayName = coloredName,
                            icon = icon,
                        }
                    end
                end
            end

            if #classSpecs == 0 then
                skipStep(L("CDM_NO_PROFILES"))
                return
            end

            -- 4) First visit: clean CDM layouts + initialize
            if not cdmSpecsInitialized then
                cdmSpecsInitialized = true
                -- Clean ALL existing KrysioUI CDM layouts (fresh slate)
                if KUI.Modules and KUI.Modules.CooldownManager and KUI.Modules.CooldownManager.CleanLayouts then
                    KUI.Modules.CooldownManager:CleanLayouts()
                end
                -- Track import state per spec: nil = not attempted, "importing", "done", "error"
                for _, spec in ipairs(classSpecs) do
                    cdmSelectedSpecs[spec.tag] = nil
                end
            end

            -- 5) Navigation helper
            local function updateNav()
                local anyAttempted = false
                for _, spec in ipairs(classSpecs) do
                    if cdmSelectedSpecs[spec.tag] == "done" or cdmSelectedSpecs[spec.tag] == "error" then
                        anyAttempted = true
                        break
                    end
                end
                if anyAttempted then
                    if navigation then navigation:enableNext() end
                else
                    if navigation then navigation:disableNext() end
                end
            end

            -- 6) Render UI
            title:SetText(L("CDM_SELECT_TITLE"))

            local subtitle = panel:CreateFontString(nil, "OVERLAY")
            subtitle:SetFont(font, 13, "")
            subtitle:SetTextColor(1, 1, 1, 0.5)
            subtitle:SetWidth(W - 80)
            subtitle:SetJustifyH("CENTER")
            subtitle:SetWordWrap(true)
            subtitle:SetPoint("TOP", title, "BOTTOM", 0, -10)
            subtitle:SetText(L("CDM_SELECT_DESC"))

            -- Scrollable list — pushed down to clear subtitle
            local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
            scrollFrame:SetPoint("TOPLEFT", panel, "TOPLEFT", 35, -90)
            scrollFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -30, -90)

            local content = CreateFrame("Frame", nil, scrollFrame)
            scrollFrame:SetScrollChild(content)

            local ROW_H = 40
            local rowY = 0

            for _, spec in ipairs(classSpecs) do
                local state = cdmSelectedSpecs[spec.tag]

                -- Row frame — styled like Next/Back button
                local row = CreateFrame("Button", nil, content)
                row:SetSize(W - 90, ROW_H)
                row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, rowY)
                row:SetFrameLevel(content:GetFrameLevel() + 1)

                local rowBg = row:CreateTexture(nil, "BACKGROUND")
                rowBg:SetAllPoints()
                rowBg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)

                local rowBorder = KUI:MakeBorder(row, C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.5, pp)

                -- Spec icon — get it from specIndex (tag % 10 = 1-based spec index)
                if spec.tag then
                    local specIndex = tonumber(spec.tag) % 10
                    if specIndex and specIndex >= 1 then
                        local specInfo = { GetSpecializationInfo(specIndex) }
                        local iconID = specInfo[4] -- (specID, name, desc, icon, role, ...)
                        if iconID then
                            local iconTex = row:CreateTexture(nil, "OVERLAY")
                            iconTex:SetSize(24, 24)
                            iconTex:SetPoint("LEFT", row, "LEFT", 10, 0)
                            iconTex:SetTexture(iconID)
                        end
                    end
                end

                -- Spec name
                local name = row:CreateFontString(nil, "OVERLAY")
                name:SetFont(font, 14, "")
                name:SetPoint("LEFT", row, "LEFT", spec.icon and 44 or 14, 0)
                name:SetText(spec.displayName)

                -- Status / Action label
                local actionLbl = row:CreateFontString(nil, "OVERLAY")
                actionLbl:SetFont(font, 12, "")
                actionLbl:SetPoint("RIGHT", row, "RIGHT", -14, 0)

                if not spec.hasData then
                    -- No layout data — grayed out, skip
                    rowBg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.4)
                    for _, e in ipairs(rowBorder) do
                        e:SetColorTexture(0.4, 0.4, 0.4, 0.3)
                    end
                    name:SetTextColor(0.4, 0.4, 0.4, 0.5)
                    actionLbl:SetTextColor(0.4, 0.4, 0.4, 0.5)
                    actionLbl:SetText(L("CDM_NO_STRING"))

                elseif state == "importing" then
                    name:SetTextColor(1, 1, 1, 0.7)
                    actionLbl:SetTextColor(1, 1, 0, 0.8)
                    actionLbl:SetText(L("IMPORTING_SHORT"))

                elseif state == "done" then
                    name:SetTextColor(0, 1, 0, 0.85)
                    actionLbl:SetTextColor(0, 1, 0, 0.85)
                    actionLbl:SetText(L("STATUS_DONE"))

                elseif state == "error" then
                    name:SetTextColor(1, 0.3, 0.3, 0.85)
                    actionLbl:SetTextColor(1, 0.3, 0.3, 0.85)
                    actionLbl:SetText(L("STATUS_FAILED"))

                else
                    -- Ready to import
                    name:SetTextColor(1, 1, 1, 0.65)
                    actionLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
                    actionLbl:SetText(L("CDM_BTN_IMPORT"))
                end

                -- Hover: brighter border + text only when in "ready" state
                if spec.hasData and not state then
                    row:SetScript("OnEnter", function()
                        name:SetTextColor(1, 1, 1, 0.9)
                        for _, e in ipairs(rowBorder) do
                            e:SetColorTexture(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
                        end
                    end)
                    row:SetScript("OnLeave", function()
                        name:SetTextColor(1, 1, 1, 0.65)
                        for _, e in ipairs(rowBorder) do
                            e:SetColorTexture(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.5)
                        end
                    end)
                end

                -- Click: only when hasData AND not already importing/done/error
                if spec.hasData and not state then
                    row:SetScript("OnClick", function()
                        -- Mark as importing
                        cdmSelectedSpecs[spec.tag] = "importing"
                        if navigation then navigation:refresh() end

                        -- Import this spec
                        local resolution = KUI:GetResolution()
                        local cb = function(success, msg)
                            cdmSelectedSpecs[spec.tag] = success and "done" or "error"
                            if success then
                                importResult.imported = importResult.imported + 1
                            else
                                importResult.errors = importResult.errors + 1
                                -- Show the error so the user can see WHY it failed
                                if UIErrorsFrame then
                                    UIErrorsFrame:AddMessage("|cffff4444[KrysioUI]|r " .. spec.displayName .. ": " .. (msg or "unknown error"), 1, 0, 0, 5)
                                end
                                KUI:Print("|cffff4444[ERROR]|r " .. spec.displayName .. ": " .. (msg or "unknown error"))
                            end
                            if navigation then navigation:refresh() end
                        end

                        if KUI.Modules and KUI.Modules.CooldownManager and KUI.Modules.CooldownManager.ImportOne then
                            KUI.Modules.CooldownManager:ImportOne(resolution, profileData, spec.tag, cb)
                        else
                            cb(false, "Module not available")
                        end
                    end)
                end

                rowY = rowY - ROW_H - 6
            end

            content:SetSize(W - 80, -rowY + 20)

            if scrollFrame.ScrollBar and (-rowY + 20) <= scrollFrame:GetHeight() then
                scrollFrame.ScrollBar:Hide()
            end

            -- Navigation: enable Next when at least one spec was attempted
            updateNav()
        end,
    }

    -- ---------------------------------------------------------------------------
    -- Step 3/4: Import progress
    -- ---------------------------------------------------------------------------
    steps[#steps + 1] = {
        title = L("STEP_IMPORT_TITLE"),
        build = function(panel, font, pp, W, H, navigation)
            local title = panel:CreateFontString(nil, "OVERLAY")
            title:SetFont(font, 18, "")
            title:SetTextColor(1, 1, 1, 1)
            title:SetPoint("TOP", panel, "TOP", 0, -25)
            title:SetText(L("IMPORTING_TITLE"))

            local statusText = panel:CreateFontString(nil, "OVERLAY")
            statusText:SetFont(font, 14, "")
            statusText:SetTextColor(1, 1, 1, 0.8)
            statusText:SetWidth(W - 80)
            statusText:SetJustifyH("CENTER")
            statusText:SetWordWrap(true)
            statusText:SetPoint("TOP", title, "BOTTOM", 0, -15)
            statusText:SetText(L("IMPORT_STARTING"))

            -- Get selected modules
            local selectedKeys = {}
            for _, mod in ipairs(allModules) do
                if KrysioUIDB and KrysioUIDB.profile and KrysioUIDB.profile.selectedModules[mod.key] ~= false then
                    -- Skip CDM if already handled in Step 2b button-based import
                    if mod.key == "CooldownManager" and cdmSpecsInitialized then
                        -- skip — will add separate progress line below
                    else
                        selectedKeys[#selectedKeys + 1] = mod.key
                    end
                end
            end

            if #selectedKeys == 0 then
                statusText:SetText(L("NO_MODULES_SELECTED"))
                -- Allow manual next
                if navigation and navigation.enableNext then
                    navigation:enableNext()
                end
                return
            end

            -- Progress text for each module
            local progressTexts = {}
            local yOff = 0
            for _, modKey in ipairs(selectedKeys) do
                local mod = KUI:GetModule(modKey)
                if mod then
                    local pt = panel:CreateFontString(nil, "OVERLAY")
                    pt:SetFont(font, 13, "")
                    pt:SetTextColor(1, 1, 1, 0.5)
                    pt:SetWidth(W - 80)
                    pt:SetJustifyH("LEFT")
                    pt:SetPoint("TOPLEFT", panel, "TOPLEFT", 40, -110 - yOff)
                    pt:SetText("  " .. mod.name .. " ...")
                    progressTexts[modKey] = pt
                    yOff = yOff + 25
                end
            end

            -- If CDM was handled in Step 2b, show it as done
            if cdmSpecsInitialized then
                local pt = panel:CreateFontString(nil, "OVERLAY")
                pt:SetFont(font, 13, "")
                pt:SetTextColor(0, 1, 0, 0.6)
                pt:SetWidth(W - 80)
                pt:SetJustifyH("LEFT")
                pt:SetPoint("TOPLEFT", panel, "TOPLEFT", 40, -110 - yOff)
                pt:SetText("  |cff00ff00[v]|r " .. L("CDM_HANDLED_STEP2"))
                yOff = yOff + 25
            end

            -- Disable navigation during import
            if navigation then
                navigation:disableNext()
                navigation:disableBack()
            end

            -- Helper: build dynamic completion text from importResult
            local function getCompletionText()
                if importResult.errors > 0 then
                    return L("IMPORT_COMPLETE_WARN")
                elseif importResult.imported > 0 and importResult.noData == 0 then
                    return L("IMPORT_COMPLETE")
                elseif importResult.imported > 0 then
                    return L("IMPORT_COMPLETE_MIXED", importResult.imported, importResult.alreadyCurrent)
                elseif importResult.noData > 0 and importResult.alreadyCurrent == 0 and importResult.notDetected == 0 and importResult.notFound == 0 then
                    return L("IMPORT_COMPLETE_NOADDON")
                elseif importResult.alreadyCurrent > 0 and importResult.notDetected == 0 and importResult.notFound == 0 and importResult.noData == 0 then
                    return L("IMPORT_COMPLETE_NONE")
                elseif importResult.noData > 0 or importResult.notDetected > 0 or importResult.notFound > 0 then
                    return L("IMPORT_COMPLETE_NOADDON")
                end
                return L("IMPORT_COMPLETE")
            end

            -- Helper: mark step as done, update status dynamically
            local function onAllDone()
                -- Update title if nothing was actually imported
                if importResult.imported == 0 then
                    title:SetText(L("IMPORT_CHECKING_TITLE"))
                end
                statusText:SetText(getCompletionText())
                if navigation then
                    navigation:enableNext()
                    navigation:enableBack()
                end
            end

            -- Run imports
            local completed = 0
            local total = #selectedKeys

            for i, modKey in ipairs(selectedKeys) do
                local mod = KUI:GetModule(modKey)
                if not mod then
                    importResult.notFound = importResult.notFound + 1
                    completed = completed + 1
                    if progressTexts[modKey] then
                        progressTexts[modKey]:SetText("  |cffff4444[x]|r " .. L("MODULE_NOT_FOUND", modKey))
                    end
                    if completed >= total then onAllDone() end
                elseif not mod.isDetected then
                    -- Addon not loaded — skip
                    importResult.notDetected = importResult.notDetected + 1
                    completed = completed + 1
                    if progressTexts[modKey] then
                        progressTexts[modKey]:SetText("  |cffff8800[-]|r " .. mod.name .. " — " .. L("ADDON_NOT_DETECTED_SKIP"))
                    end
                    if completed >= total then onAllDone() end
                elseif mode ~= "install" and KUI:GetInstalledVersion(mod.manifestKey) and not KUI:IsModuleOutdated(mod.manifestKey) then
                    -- Already up to date — skip (only in update/load mode)
                    importResult.alreadyCurrent = importResult.alreadyCurrent + 1
                    completed = completed + 1
                    local ver = KUI:GetInstalledVersion(mod.manifestKey)
                    if progressTexts[modKey] then
                        progressTexts[modKey]:SetText("  |cff00ff00[v]|r " .. mod.name .. " — " .. L("ALREADY_CURRENT", ver))
                    end
                    if completed >= total then onAllDone() end
                else
                    -- Pre-check: skip if profile data is missing (not an error
                    -- — just dev hasn't populated Data/*.lua yet)
                    local pData = KUI:GetProfileData(modKey)
                    local res = KUI:GetResolution()
                    local missingData = false
                    if not pData then
                        missingData = true
                    elseif mod.hasSpecs then
                        missingData = (pData.cdmData == nil)
                    else
                        missingData = (pData[res] == nil or pData[res] == "")
                    end

                    if missingData then
                        importResult.noData = importResult.noData + 1
                        completed = completed + 1
                        if progressTexts[modKey] then
                            progressTexts[modKey]:SetText("  |cffff8800[-]|r " .. mod.name .. " — " .. L("ADDON_NOT_DETECTED_SKIP"))
                        end
                        if completed >= total then onAllDone() end
                    else
                        -- Import
                        if progressTexts[modKey] then
                            progressTexts[modKey]:SetText("  |cffffff00[>]|r " .. L("IMPORTING", mod.name))
                        end

                        -- Pass CDM-selected specs options when applicable
                        local importOpts = {}
                        if modKey == "CooldownManager" then
                            local tags = {}
                            for tag, _ in pairs(cdmSelectedSpecs) do
                                tags[#tags + 1] = tag
                            end
                            importOpts.selectedSpecs = tags
                        end

                        KUI:ImportModule(modKey, importOpts, function(success, msg)
                            completed = completed + 1
                            if progressTexts[modKey] then
                                if success then
                                    importResult.imported = importResult.imported + 1
                                    progressTexts[modKey]:SetText("  |cff00ff00[v]|r " .. mod.name .. " — " .. (msg or ""))
                                else
                                    importResult.errors = importResult.errors + 1
                                    progressTexts[modKey]:SetText("  |cffff4444[x]|r " .. mod.name .. " — " .. (msg or ""))
                                end
                            end

                            -- Check if all done
                            if completed >= total then onAllDone() end
                        end)
                    end
                end
            end
        end,
    }

    -- ---------------------------------------------------------------------------
    -- Step 4: Finish
    -- ---------------------------------------------------------------------------
    steps[#steps + 1] = {
        title = L("STEP_FINISH_TITLE"),
        build = function(panel, font, pp, W, H, navigation)
            -- Dynamic finish message based on what actually happened
            local hasWork = (importResult.imported > 0)
            local noAddons = (importResult.notDetected > 0 or importResult.notFound > 0 or importResult.noData > 0) and importResult.imported == 0

            local title = panel:CreateFontString(nil, "OVERLAY")
            title:SetFont(font, 22, "")
            title:SetTextColor(1, 1, 1, 1)
            title:SetPoint("TOP", panel, "TOP", 0, -40)
            if hasWork then
                title:SetText(L("FINISH_TITLE"))
            elseif noAddons then
                title:SetText(L("FINISH_TITLE_NOADDON"))
            else
                title:SetText(L("FINISH_TITLE_NONE"))
            end

            local desc = panel:CreateFontString(nil, "OVERLAY")
            desc:SetFont(font, 14, "")
            desc:SetTextColor(1, 1, 1, 0.5)
            desc:SetWidth(W - 80)
            desc:SetJustifyH("CENTER")
            desc:SetWordWrap(true)
            desc:SetPoint("TOP", title, "BOTTOM", 0, -15)
            if hasWork then
                desc:SetText(L("FINISH_DESC"))
            elseif noAddons then
                desc:SetText(L("FINISH_DESC_NOADDON"))
            else
                desc:SetText(L("FINISH_DESC_NONE"))
            end

            -- Button: Reload UI (if work was done) or Close (if nothing changed)
            local btn = CreateFrame("Button", nil, panel)
            btn:SetFrameLevel(panel:GetFrameLevel() + 2)
            pp.Size(btn, 200, 39)
            btn:SetPoint("BOTTOM", panel, "BOTTOM", 0, 50)

            local bbg = btn:CreateTexture(nil, "BACKGROUND")
            bbg:SetAllPoints()
            bbg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)

            KUI:MakeBorder(btn, C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9, pp)

            local lbl = btn:CreateFontString(nil, "OVERLAY")
            lbl:SetFont(font, 16, "")
            lbl:SetPoint("CENTER")
            lbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
            lbl:SetText(hasWork and L("RELOAD_UI") or L("CLOSE"))

            btn:SetScript("OnEnter", function()
                lbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 1)
            end)
            btn:SetScript("OnLeave", function()
                lbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
            end)
            btn:SetScript("OnClick", function()
                if hasWork then
                    KUI:Print(L("RELOADING"))
                    ReloadUI()
                else
                    dimmer:Hide()
                end
            end)
        end,
    }

    -- ---------------------------------------------------------------------------
    -- Now build the wizard frame (dimmer, W, H, FONT, pp declared above)
    -- ---------------------------------------------------------------------------
    local dimTex = dimmer:CreateTexture(nil, "BACKGROUND")
    dimTex:SetAllPoints()
    dimTex:SetColorTexture(0, 0, 0, 0.35)

    -- Wizard panel
    local frame = CreateFrame("Frame", "KUIWizard", dimmer)
    frame:SetScale(1)
    frame:SetFrameStrata("FULLSCREEN_DIALOG")
    frame:SetFrameLevel(dimmer:GetFrameLevel() + 10)
    pp.Size(frame, W, H)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:EnableMouse(true)
    frame:EnableKeyboard(true)
    frame:SetScript("OnKeyDown", function(self, key)
        self:SetPropagateKeyboardInput(key ~= "ESCAPE")
        if key == "ESCAPE" then
            dimmer:Hide()
        end
    end)

    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 1)
    KUI:MakeBorder(frame, 1, 1, 1, 0.15, pp)

    -- Header bar (title + step indicator)
    local headerBar = frame:CreateTexture(nil, "ARTWORK")
    headerBar:SetColorTexture(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.06)
    headerBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    headerBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    headerBar:SetHeight(50)

    -- Logo icon
    local logoIcon = frame:CreateTexture(nil, "OVERLAY")
    logoIcon:SetTexture(KUI.ICON_TEXTURE)
    logoIcon:SetSize(20, 20)
    logoIcon:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -14)

    local logoTitle = frame:CreateFontString(nil, "OVERLAY")
    logoTitle:SetFont(FONT, 18, "")
    logoTitle:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
    logoTitle:SetPoint("LEFT", logoIcon, "RIGHT", 10, 0)
    logoTitle:SetText(KUI.ADDON_NAME)

    local verText = frame:CreateFontString(nil, "OVERLAY")
    verText:SetFont(FONT, 11, "")
    verText:SetTextColor(1, 1, 1, 0.3)
    verText:SetPoint("LEFT", logoTitle, "RIGHT", 8, 0)
    verText:SetText("v" .. KUI.VERSION)

    -- (step indicator removed — user preferred cleaner header)

    -- Content area (step pages render here)
    local contentFrame = CreateFrame("Frame", nil, frame)
    contentFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -60)
    contentFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, -75)

    -- Navigation: Back / Next buttons
    local navY = 36

    local backBtn = CreateFrame("Button", nil, frame)
    backBtn:SetFrameLevel(frame:GetFrameLevel() + 2)
    pp.Size(backBtn, 120, 30)
    backBtn:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 25, navY)
    local backBg = backBtn:CreateTexture(nil, "BACKGROUND")
    backBg:SetAllPoints()
    backBg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)
    KUI:MakeBorder(backBtn, 1, 1, 1, 0.35, pp)
    local backLbl = backBtn:CreateFontString(nil, "OVERLAY")
    backLbl:SetFont(FONT, 13, "")
    backLbl:SetPoint("CENTER")
    backLbl:SetTextColor(1, 1, 1, 0.55)
    backLbl:SetText(L("BACK"))

    local nextBtn = CreateFrame("Button", nil, frame)
    nextBtn:SetFrameLevel(frame:GetFrameLevel() + 2)
    pp.Size(nextBtn, 140, 30)
    nextBtn:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25, navY)
    local nextBg = nextBtn:CreateTexture(nil, "BACKGROUND")
    nextBg:SetAllPoints()
    nextBg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)
    local nextBorder = KUI:MakeBorder(nextBtn, C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9, pp)
    local nextLbl = nextBtn:CreateFontString(nil, "OVERLAY")
    nextLbl:SetFont(FONT, 13, "")
    nextLbl:SetPoint("CENTER")
    nextLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9)
    nextLbl:SetText(L("NEXT"))

    -- State
    local currentStep = 1
    local navDisabled = false

    -- Navigation functions
    local function updateNavigation()
        if currentStep <= 1 then
            backBtn:Hide()
        else
            backBtn:Show()
        end
        if currentStep >= #steps then
            nextLbl:SetText(L("CLOSE"))
        else
            nextLbl:SetText(L("NEXT"))
        end
    end

    local function renderStep()
        -- Hide previous step's children AND regions
        -- (FontStrings are regions, not children — GetChildren() misses them)
        for _, child in ipairs({ contentFrame:GetChildren() }) do
            child:Hide()
        end
        -- GetRegions() returns (region1, region2, ..., count) — strip the count
        local regions = { contentFrame:GetRegions() }
        local regionCount = #regions
        local last = regions[regionCount]
        if type(last) == "number" then
            regionCount = last
        end
        for i = 1, regionCount do
            regions[i]:Hide()
        end

        local step = steps[currentStep]
        if step and step.build then
            step.build(contentFrame, FONT, pp, W - 20, H - 130, {
                enableNext = function()
                    navDisabled = false
                    nextBtn:Enable()
                    nextLbl:SetAlpha(1)
                end,
                disableNext = function()
                    navDisabled = true
                    nextBtn:Disable()
                    nextLbl:SetAlpha(0.4)
                end,
                enableBack = function()
                    backBtn:Enable()
                    backLbl:SetAlpha(1)
                end,
                disableBack = function()
                    backBtn:Disable()
                    backLbl:SetAlpha(0.4)
                end,
                refresh = function()
                    renderStep()
                end,
            })
        end

        updateNavigation()
    end

    local function goNext()
        if navDisabled then return end
        if currentStep < #steps then
            currentStep = currentStep + 1
            renderStep()
        else
            dimmer:Hide()
        end
    end

    local function goBack()
        if currentStep > 1 then
            currentStep = currentStep - 1
            renderStep()
        end
    end

    backBtn:SetScript("OnClick", goBack)
    nextBtn:SetScript("OnClick", goNext)

    -- Hover effects
    backBtn:SetScript("OnEnter", function() backLbl:SetTextColor(1, 1, 1, 0.85) end)
    backBtn:SetScript("OnLeave", function() backLbl:SetTextColor(1, 1, 1, 0.55) end)
    nextBtn:SetScript("OnEnter", function() nextLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 1) end)
    nextBtn:SetScript("OnLeave", function() nextLbl:SetTextColor(C.PURPLE.r, C.PURPLE.g, C.PURPLE.b, 0.9) end)

    -- Close button (X) in header — bigger, clear of step indicator
    local closeBtn = CreateFrame("Button", nil, frame)
    closeBtn:SetFrameLevel(frame:GetFrameLevel() + 3)
    pp.Size(closeBtn, 34, 34)
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
    local closeLbl = closeBtn:CreateFontString(nil, "OVERLAY")
    closeLbl:SetFont(FONT, 22, "")
    closeLbl:SetTextColor(1, 1, 1, 0.4)
    closeLbl:SetPoint("CENTER")
    closeLbl:SetText("×")
    closeBtn:SetScript("OnClick", function() dimmer:Hide() end)
    closeBtn:SetScript("OnEnter", function() closeLbl:SetTextColor(1, 1, 1, 0.8) end)
    closeBtn:SetScript("OnLeave", function() closeLbl:SetTextColor(1, 1, 1, 0.4) end)

    -- Render first step
    renderStep()
    dimmer:Show()

    return frame
end

-- -------------------------------------------------------------------------------
-- Public entry point
-- -------------------------------------------------------------------------------
function KUI:OpenInstaller(mode)
    if InCombatLockdown() then
        KUI:Print(L("CANT_OPEN_IN_COMBAT"))
        return
    end
    self:_BuildInstallerWizard(mode)
end