-------------------------------------------------------------------------------
--  KrysioUI\Core\Installer\UI.lua
--  Custom popup UI framework (standalone, no ElvUI dependency)
--  Visual style: dimmer + dark purple-black panel + purple border + purple accents
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

local C = KUI.COLORS

-- -------------------------------------------------------------------------------
-- Font resolution
-- -------------------------------------------------------------------------------
local function GetFont()
    local f = "Fonts\\FRIZQT__.TTF"
    if EllesmereUI and EllesmereUI._font then
        f = EllesmereUI._font
    end
    return f
end

-- -------------------------------------------------------------------------------
-- 1px border helper (copied from EllesmereUI pattern)
-- -------------------------------------------------------------------------------
function KUI:MakeBorder(parent, r, g, b, alpha, PP)
    local borders = {}
    local function MakeEdge()
        local t = parent:CreateTexture(nil, "BORDER")
        t:SetColorTexture(r or 1, g or 1, b or 1, alpha or 0.15)
        if t.SetSnapToPixelGrid then
            t:SetSnapToPixelGrid(false)
            t:SetTexelSnappingBias(0)
        end
        return t
    end

    local onePhys = 1 / (parent:GetEffectiveScale() or 1)
    borders[1] = MakeEdge()
    borders[1]:SetPoint("TOPLEFT", 0, 0)
    borders[1]:SetPoint("TOPRIGHT", 0, 0)
    borders[1]:SetHeight(onePhys)

    borders[2] = MakeEdge()
    borders[2]:SetPoint("BOTTOMLEFT", 0, 0)
    borders[2]:SetPoint("BOTTOMRIGHT", 0, 0)
    borders[2]:SetHeight(onePhys)

    borders[3] = MakeEdge()
    borders[3]:SetPoint("TOPLEFT", borders[1], "BOTTOMLEFT")
    borders[3]:SetPoint("BOTTOMLEFT", borders[2], "TOPLEFT")
    borders[3]:SetWidth(onePhys)

    borders[4] = MakeEdge()
    borders[4]:SetPoint("TOPRIGHT", borders[1], "BOTTOMRIGHT")
    borders[4]:SetPoint("BOTTOMRIGHT", borders[2], "TOPRIGHT")
    borders[4]:SetWidth(onePhys)

    return borders
end

local function ResolveColor(tbl)
    return tbl.r, tbl.g, tbl.b, tbl.a
end

-- -------------------------------------------------------------------------------
-- Create a KrysioUI popup (dimmer + panel)
-- Returns: { dimmer, panel }
-- -------------------------------------------------------------------------------
function KUI:_CreatePopup()
    local FONT = GetFont()
    local popupScale = 1
    local PP = {
        Size = function(obj, w, h) obj:SetSize(w, h) end,
        Point = function(obj, ...) obj:SetPoint(...) end,
    }

    -- Dimmer
    local dimmer = CreateFrame("Frame", "KUIDimmer", UIParent)
    dimmer:SetFrameStrata("FULLSCREEN_DIALOG")
    dimmer:SetAllPoints(UIParent)
    dimmer:EnableMouse(true)
    dimmer:EnableMouseWheel(true)
    dimmer:SetScript("OnMouseWheel", function() end)
    dimmer:SetScale(popupScale)
    dimmer:Hide()  -- starts hidden; _ShowPopup shows it when fully built

    local dimTex = dimmer:CreateTexture(nil, "BACKGROUND")
    dimTex:SetAllPoints()
    dimTex:SetColorTexture(0, 0, 0, 0.35)

    -- Panel
    local panel = CreateFrame("Frame", "KUIPopup", dimmer)
    panel:SetScale(popupScale)
    panel:SetFrameStrata("FULLSCREEN_DIALOG")
    panel:SetFrameLevel(dimmer:GetFrameLevel() + 10)
    panel:EnableMouse(true)
    panel:EnableKeyboard(true)

    -- Close on Escape
    panel:SetScript("OnKeyDown", function(self, key)
        self:SetPropagateKeyboardInput(key ~= "ESCAPE")
        if key == "ESCAPE" then
            local onClose = self._onClose
            if onClose then onClose() end
            dimmer:Hide()
        end
    end)

    -- Background
    local bg = panel:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 1)

    -- Border
    local brd = self:MakeBorder(panel, 1, 1, 1, 0.15, PP)

    -- Title
    local title = panel:CreateFontString(nil, "OVERLAY")
    title:SetFont(FONT, 20, "")
    title:SetTextColor(1, 1, 1, 1)
    panel._title = title

    return {
        dimmer = dimmer,
        panel = panel,
        font = FONT,
        pp = PP,
    }
end

-- -------------------------------------------------------------------------------
-- Show a simple popup (for changelog, confirmations, etc.)
-- options: { title, width, height, scrollable, text, buttons[] }
-- button: { text, primary, action }
-- -------------------------------------------------------------------------------
function KUI:_ShowPopup(options)
    if not options then return end
    local ctx = self:_CreatePopup()
    local dimmer = ctx.dimmer
    local panel = ctx.panel
    local FONT = ctx.font
    local PP = ctx.pp

    local W = options.width or 400
    local H = options.height or 300
    PP.Size(panel, W, H)
    panel:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

    -- Title
    panel._title:SetText(options.title or "")
    PP.Point(panel._title, "TOP", panel, "TOP", 0, -20)

    -- Scrollable content or static text
    if options.scrollable then
        -- ScrollFrame
        local sf = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
        sf:SetPoint("TOPLEFT", panel, "TOPLEFT", 25, -50)
        sf:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -30, -80)

        local content = CreateFrame("Frame", nil, sf)
        sf:SetScrollChild(content)

        local text = content:CreateFontString(nil, "OVERLAY")
        text:SetFont(FONT, 13, "")
        text:SetTextColor(1, 1, 1, 0.8)
        text:SetJustifyH("LEFT")
        text:SetWidth(W - 80)
        text:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
        text:SetText(options.text or "")

        -- Adjust content height based on text (already set above)
        local wrappedH = text:GetStringHeight() or 20
        content:SetSize(W - 80, wrappedH + 40)
        sf:SetScrollChild(content)
    else
        local text = panel:CreateFontString(nil, "OVERLAY")
        text:SetFont(FONT, 13, "")
        text:SetTextColor(1, 1, 1, 0.8)
        text:SetWidth(W - 60)
        text:SetJustifyH("CENTER")
        text:SetWordWrap(true)
        text:SetPoint("TOP", panel._title, "BOTTOM", 0, -20)
        text:SetText(options.text or "")
    end

    -- Buttons
    if options.buttons then
        local btnCount = #options.buttons
        local btnW = math.min(200, (W - 40) / btnCount - 8)
        local btnH = 36
        local totalW = btnCount * btnW + (btnCount - 1) * 8
        local startX = -(totalW / 2)

        for i, btnDef in ipairs(options.buttons) do
            local isPrimary = btnDef.primary
            local r, g, b = C.PURPLE.r, C.PURPLE.g, C.PURPLE.b

            local btn = CreateFrame("Button", nil, panel)
            btn:SetFrameLevel(panel:GetFrameLevel() + 2)
            PP.Size(btn, btnW, btnH)
            btn:SetPoint("BOTTOM", panel, "BOTTOM", startX + (i - 1) * (btnW + 8) + btnW / 2, 30)

            local bbg = btn:CreateTexture(nil, "BACKGROUND")
            bbg:SetAllPoints()
            bbg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)

            local brd
            if isPrimary then
                brd = self:MakeBorder(btn, r, g, b, 0.9, PP)
            else
                brd = self:MakeBorder(btn, 1, 1, 1, 0.35, PP)
            end

            local lbl = btn:CreateFontString(nil, "OVERLAY")
            lbl:SetFont(FONT, 14, "")
            lbl:SetPoint("CENTER", btn, "CENTER", 0, 0)
            lbl:SetTextColor(r, g, b, isPrimary and 0.9 or 0.55)
            lbl:SetText(btnDef.text)

            btn:SetScript("OnEnter", function()
                lbl:SetTextColor(r, g, b, 1)
                if isPrimary then
                    for _, edge in ipairs(brd) do edge:SetColorTexture(r, g, b, 1) end
                else
                    for _, edge in ipairs(brd) do edge:SetColorTexture(1, 1, 1, 0.6) end
                end
            end)
            btn:SetScript("OnLeave", function()
                lbl:SetTextColor(r, g, b, isPrimary and 0.9 or 0.55)
                if isPrimary then
                    for _, edge in ipairs(brd) do edge:SetColorTexture(r, g, b, 0.9) end
                else
                    for _, edge in ipairs(brd) do edge:SetColorTexture(1, 1, 1, 0.35) end
                end
            end)
            btn:SetScript("OnClick", function()
                if btnDef.action then btnDef.action() end
                dimmer:Hide()
            end)
        end
    end

    dimmer:Show()
end

-- -------------------------------------------------------------------------------
-- Step wizard helpers
-- -------------------------------------------------------------------------------
function KUI:_MakeStepButton(panel, label, r, g, b, primary, onClick)
    local PP = { Size = function(obj, w, h) obj:SetSize(w, h) end, Point = function(obj, ...) obj:SetPoint(...) end }
    local FONT = GetFont()
    local btnW, btnH = 160, 30
    local btn = CreateFrame("Button", nil, panel)
    btn:SetFrameLevel(panel:GetFrameLevel() + 2)
    PP.Size(btn, btnW, btnH)
    btn:SetPoint("BOTTOM", panel, "BOTTOM", 0, 36)

    local bbg = btn:CreateTexture(nil, "BACKGROUND")
    bbg:SetAllPoints()
    bbg:SetColorTexture(C.PANEL_BG.r, C.PANEL_BG.g, C.PANEL_BG.b, 0.92)

    self:MakeBorder(btn, r, g, b, primary and 0.9 or 0.35, PP)

    local lbl = btn:CreateFontString(nil, "OVERLAY")
    lbl:SetFont(FONT, 14, "")
    lbl:SetPoint("CENTER")
    lbl:SetTextColor(r, g, b, primary and 0.9 or 0.55)
    lbl:SetText(label)

    btn:SetScript("OnEnter", function()
        lbl:SetTextColor(r, g, b, 1)
    end)
    btn:SetScript("OnLeave", function()
        lbl:SetTextColor(r, g, b, primary and 0.9 or 0.55)
    end)
    btn:SetScript("OnClick", onClick)

    return btn
end

-- Forward declarations for Steps.lua
KUI._CreatePopup = KUI._CreatePopup
KUI._ShowPopup = KUI._ShowPopup