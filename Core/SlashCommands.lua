-------------------------------------------------------------------------------
--  KrysioUI\Core\SlashCommands.lua
--  Slash commands: /krysio, /kui
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI

local function HandleSlash(input)
    -- Trim and lowercase
    input = input and input:trim():lower() or ""

    if input == "" or input == "install" or input == "i" then
        -- Open the full installation wizard
        if KUI.OpenInstaller then
            KUI:OpenInstaller("install")
        else
            KUI:Print(L("INSTALLER_NOT_READY"))
        end

    elseif input == "update" or input == "u" then
        -- Open update-only wizard
        if KUI.OpenInstaller then
            KUI:OpenInstaller("update")
        else
            KUI:Print(L("INSTALLER_NOT_READY"))
        end

    elseif input == "load" or input == "l" then
        -- Load profiles without re-importing
        if KUI.OpenInstaller then
            KUI:OpenInstaller("load")
        else
            KUI:Print(L("INSTALLER_NOT_READY"))
        end

    elseif input == "status" or input == "s" then
        -- Check update status for all modules
        KUI:RefreshModuleStatuses()
        local modules = KUI:GetAllModules()
        local hasIssues = false

        -- Resolution notice
        if not KUI:IsDesignedResolution() then
            KUI:Print("|cffff8800" .. L("RES_WARNING_TITLE") .. "|r")
            KUI:Print(L("RES_WARNING_DESC", KUI.DESIGNED_RESOLUTION, KUI:GetResolution()))
            KUI:Print(" ")
        end

        for _, mod in ipairs(modules) do
            local status = mod.status or "missing"
            local icon = KUI.STATUS_ICONS[status:upper()] or ""
            local installed = KUI:GetInstalledVersion(mod.manifestKey) or L("NEVER_IMPORTED")
            local manifest = KUI:GetManifestVersion(mod.manifestKey) or "-"

            if status == "outdated" then
                KUI:Print(icon .. " " .. mod.name .. ": " .. L("STATUS_OUTDATED", installed, manifest))
                hasIssues = true
            elseif status == "missing" then
                KUI:Print(icon .. " " .. mod.name .. ": " .. L("STATUS_MISSING"))
                hasIssues = true
            else
                KUI:Print(icon .. " " .. mod.name .. ": " .. L("STATUS_INSTALLED", installed))
            end
        end

        if not hasIssues then
            KUI:Print(L("ALL_UPDATED"))
        end

    elseif input == "check" or input == "c" then
        -- Force update check with verbose output
        KUI:CheckForUpdates(true)

    elseif input == "changelog" or input == "cl" then
        -- Open changelog viewer
        if KUI.ShowChangelog then
            KUI:ShowChangelog()
        else
            KUI:Print(L("CHANGELOG_NOT_READY"))
        end

    elseif input == "help" or input == "h" or input == "?" then
        KUI:Print(L("HELP_HEADER"))
        KUI:Print(L("HELP_INSTALL"))
        KUI:Print(L("HELP_UPDATE"))
        KUI:Print(L("HELP_LOAD"))
        KUI:Print(L("HELP_STATUS"))
        KUI:Print(L("HELP_CHECK"))
        KUI:Print(L("HELP_CHANGELOG"))
        KUI:Print(L("HELP_HELP"))

    else
        KUI:Print(L("UNKNOWN_COMMAND", input))
        KUI:Print(L("TYPE_HELP"))
    end
end

-- Register slash commands
_G.SLASH_KRYSOIOUI1 = "/krysio"
_G.SLASH_KRYSOIOUI2 = "/kui"
_G.SlashCmdList["KRYSOIOUI"] = HandleSlash