-------------------------------------------------------------------------------
--  KrysioUI\Core\Minimap.lua
--  Minimap button — tries LibDBIcon first, falls back to simple clickable texture
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI

function KUI:SetupMinimapButton()
    -- Try LibDBIcon-1.0 first (cleanest, most common)
    local icon = LibStub and LibStub("LibDBIcon-1.0", true)
    local LDB = LibStub and LibStub("LibDataBroker-1.1", true)

    if LDB and icon then
        local dataobj = LDB:NewDataObject(KUI.ADDON_NAME, {
            type = "launcher",
            icon = KUI.MEDIA_PATH .. "icon.png",
            OnClick = function()
                if KUI.OpenInstaller then KUI:OpenInstaller() end
            end,
            OnTooltipShow = function(tooltip)
                if not tooltip or not tooltip.AddLine then return end
                tooltip:AddLine(KUI.ADDON_NAME)
                tooltip:AddLine(L("MINIMAP_TOOLTIP"))
                tooltip:AddLine(" ")
                tooltip:AddLine(L("LEFT_CLICK_INSTALL"))
            end,
        })

        icon:Register(KUI.ADDON_NAME, dataobj, KrysioUIDB and KrysioUIDB.profile and KrysioUIDB.profile.minimap)
        return
    end

    -- Fallback: simple minimap button
    self:_CreateSimpleMinimapButton()
end

function KUI:_CreateSimpleMinimapButton()
    local btn = CreateFrame("Button", "KrysioUIMinimapButton", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)

    -- Position on minimap (default top-right area)
    local pos = KrysioUIDB and KrysioUIDB.profile and KrysioUIDB.profile.minimap and KrysioUIDB.profile.minimap.minimapPos or 220
    btn:SetPoint("CENTER", Minimap:GetName() and _G[Minimap:GetName() .. "Cluster"] or Minimap, "CENTER", 0, 0)

    -- Simple circle background
    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0, 0, 0, 0.6)

    -- Border
    local brd = KUI:MakeBorder(btn, 0.65, 0.15, 0.90, 0.8)
    btn._borders = brd

    -- Icon label
    local lbl = btn:CreateFontString(nil, "OVERLAY")
    lbl:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
    lbl:SetTextColor(0.65, 0.15, 0.90)
    lbl:SetPoint("CENTER")
    lbl:SetText("K")

    -- Tooltip
    btn:SetScript("OnEnter", function()
        GameTooltip:SetOwner(btn, "ANCHOR_LEFT")
        GameTooltip:AddLine(KUI.ADDON_NAME)
        GameTooltip:AddLine(L("MINIMAP_TOOLTIP"))
        GameTooltip:Show()
    end)

    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    btn:SetScript("OnClick", function()
        if KUI.OpenInstaller then KUI:OpenInstaller() end
    end)

    -- Save minimap position on drag
    btn:SetMovable(true)
    btn:SetUserPlaced(true)
    btn:RegisterForDrag("LeftButton")
    btn:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    btn:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local pos = Minimap:GetNormalizedPosition(self)
        if pos then
            if KrysioUIDB and KrysioUIDB.profile then
                if not KrysioUIDB.profile.minimap then KrysioUIDB.profile.minimap = {} end
                KrysioUIDB.profile.minimap.minimapPos = pos
            end
        end
    end)
end