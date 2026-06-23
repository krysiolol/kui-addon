-------------------------------------------------------------------------------
--  KrysioUI\Modules\EditMode.lua
--  Blizzard Edit Mode layout import handler
--
--  Uses C_EditMode API: ConvertStringToLayoutInfo, SaveLayouts, SetActiveLayout
--  Pattern confirmed through testing.
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI.Modules = KUI.Modules or {}
KUI.Modules.EditMode = {}

local EM = KUI.Modules.EditMode
local LAYOUT_NAME = "KrysioUI"

-- -------------------------------------------------------------------------------
-- Import (or update) the Edit Mode layout
-- -------------------------------------------------------------------------------
function EM:Import(resolution, profileData, options, callback)
    if InCombatLockdown() then
        if callback then callback(false, L("CANT_OPEN_IN_COMBAT")) end
        return
    end

    -- Data is already validated by importFn before calling us
    local layoutString = profileData[resolution]
    if not layoutString or layoutString == "" then
        if callback then callback(false, L("NO_PROFILE_DATA", L("EDITMODE_NAME"))) end
        return
    end

    local layoutsInfo = C_EditMode.GetLayouts()
    layoutsInfo.layouts = layoutsInfo.layouts or {}

    local layoutInfo = C_EditMode.ConvertStringToLayoutInfo(layoutString)
    if not layoutInfo then
        if callback then callback(false, L("NO_PROFILE_DATA", L("EDITMODE_NAME"))) end
        return
    end

    layoutInfo.layoutName = LAYOUT_NAME
    layoutInfo.layoutType = Enum.EditModeLayoutType.Account

    -- Update if exists, insert if new
    local customIndex
    for i, layout in ipairs(layoutsInfo.layouts) do
        if layout.layoutName == LAYOUT_NAME then
            layoutsInfo.layouts[i] = layoutInfo
            customIndex = i
            break
        end
    end

    if not customIndex then
        if #layoutsInfo.layouts >= 5 then
            error("Edit Mode layout limit reached (5). Delete a layout and try again.")
        end
        table.insert(layoutsInfo.layouts, layoutInfo)
        customIndex = #layoutsInfo.layouts
    end

    C_EditMode.SaveLayouts(layoutsInfo)

    -- Activate for current spec
    local activeIndex = Enum.EditModePresetLayoutsMeta.NumValues + customIndex
    C_EditMode.SetActiveLayout(activeIndex)

    KUI:Print(L("EDITMODE_IMPORTED"))
    if callback then callback(true, L("EDITMODE_IMPORTED")) end
end

-- -------------------------------------------------------------------------------
-- Load (activate) existing Edit Mode layout
-- -------------------------------------------------------------------------------
function EM:LoadProfile(resolution)
    if InCombatLockdown() then
        KUI:Print(L("CANT_OPEN_IN_COMBAT"))
        return
    end

    local layoutsInfo = C_EditMode.GetLayouts()
    layoutsInfo.layouts = layoutsInfo.layouts or {}

    local customIndex
    for i, layout in ipairs(layoutsInfo.layouts) do
        if layout.layoutName == LAYOUT_NAME then
            customIndex = i
            break
        end
    end

    if not customIndex then
        KUI:Print(L("EDITMODE_NOT_FOUND"))
        return
    end

    local activeIndex = Enum.EditModePresetLayoutsMeta.NumValues + customIndex
    C_EditMode.SetActiveLayout(activeIndex)

    KUI:Print(L("EDITMODE_ACTIVATED"))
end