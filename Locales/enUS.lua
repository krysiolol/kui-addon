-------------------------------------------------------------------------------
--  KrysioUI\Locales\enUS.lua
--  English (US) localization — base language, always complete
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI:RegisterLocale("enUS", {
    -- General UI
    CLOSE                   = "Close",
    BACK                    = "Back",
    NEXT                    = "Next",
    RELOAD_UI               = "Reload UI",
    RELOADING               = "Reloading UI...",
    INSTALL                 = "Install",
    LOAD                    = "Load",
    IMPORT                  = "Import",

    -- Welcome / Intro
    WELCOME_TITLE           = "Welcome to KrysioUI!",
    WELCOME_DESC            = "This wizard will import my complete UI setup for %s.\nChoose which modules to install in the next step.",
    WELCOME_HELP            = "Type %s for a list of commands at any time.",
    RES_WARNING_TITLE       = "Resolution Notice",
    RES_WARNING_DESC        = "KrysioUI is designed and tested for %s.\n\nYou are running at %s, which is not officially supported.\n\nYou can still install and use it — profiles will be applied. You may need to manually adjust some positions and scale to fit your screen.\n\n|cffff8800No 1080p support is provided.|r",
    UPDATE_TITLE            = "KrysioUI Update",
    UPDATE_DESC             = "This wizard will update your UI profiles to the latest version.",
    LOAD_TITLE              = "Load Profiles",
    LOAD_DESC               = "This will apply your existing KrysioUI profiles to this character without re-importing.",

    -- Step titles
    STEP_INTRO_TITLE        = "Introduction",
    STEP_SELECTION_TITLE    = "Selection",
    STEP_IMPORT_TITLE       = "Import",
    STEP_FINISH_TITLE       = "Finish",
    STEP_OF                 = "Step %d of %d",

    -- Module selection
    SELECTION_TITLE         = "Select Modules to Install",
    CHECK_ALL               = "Check All",
    UNCHECK_ALL             = "Uncheck All",
    ADDON_NOT_FOUND         = "(not detected)",
    NO_MODULES_SELECTED     = "No modules selected. Select at least one module to proceed.",
    ADDON_NOT_DETECTED_SKIP = "addon not loaded — skipped",
    ALREADY_CURRENT         = "already up to date (v%s) — skipped",

    -- Import progress
    IMPORTING_TITLE         = "Importing Profiles...",
    IMPORT_CHECKING_TITLE   = "Checking Profiles...",
    IMPORT_STARTING         = "Starting import...",
    IMPORTING               = "Importing %s...",
    IMPORT_COMPLETE         = "All profiles imported successfully!",
    IMPORT_COMPLETE_WARN    = "Import completed with some errors. Check above for details.",
    IMPORT_COMPLETE_NONE    = "All profiles are already up to date — nothing to import.",
    IMPORT_COMPLETE_NOADDON = "No supported addons were detected.",
    IMPORT_COMPLETE_MIXED   = "%d imported — %d already up to date.",
    IMPORT_RESULT_LINE      = "imported: %d | up to date: %d | skipped: %d | errors: %d",

    -- Finish
    FINISH_TITLE            = "Installation Complete!",
    FINISH_DESC             = "Your profiles have been imported. Click Reload UI to apply all changes.",
    FINISH_TITLE_NONE       = "Nothing to Update",
    FINISH_DESC_NONE        = "All profiles are already up to date.",
    FINISH_TITLE_NOADDON    = "No Addons Detected",
    FINISH_DESC_NOADDON     = "Install the required addons first and run the installer again.",

    -- Module strings
    ELLESMEREUI_DESC        = "Complete EllesmereUI profile suite (Action Bars, Nameplates, Unit Frames, CDM, and more)",
    BIGWIGS_DESC            = "BigWigs boss mod profile and timer settings",
    EDITMODE_NAME           = "Edit Mode",
    EDITMODE_DESC           = "Blizzard Edit Mode layout for unit frames and HUD elements",
    CDM_NAME                = "Cooldown Manager",
    CDM_DESC                = "Blizzard Cooldown Manager layouts (class-specific)",

    -- Status
    STATUS_INSTALLED        = "v%s — installed",
    STATUS_OUTDATED         = "v%s → update available (v%s)",
    STATUS_MISSING          = "not imported yet",
    NEVER_IMPORTED          = "never imported",
    ALL_UPDATED             = "All modules are up to date!",
    MODULE_OUTDATED         = "%s: installed %s, latest %s",
    UPDATES_AVAILABLE       = "|cffffd700Updates available for %d module(s).|r",
    TYPE_STATUS             = "Type |cffa626e6/kui status|r for details.",

    -- BigWigs
    BIGWIGS_IMPORTED        = "BigWigs profile imported successfully!",
    BIGWIGS_API_MISSING     = "BigWigs API not available.",
    BIGWIGS_ALREADY_ACTIVE  = "BigWigs profile is already active.",
    BIGWIGS_PROFILE_LOADED  = "BigWigs profile loaded.",

    -- Edit Mode
    EDITMODE_IMPORTED       = "Edit Mode layout imported and activated!",
    EDITMODE_NOT_FOUND      = "KrysioUI Edit Mode layout not found. Import it first.",
    EDITMODE_ACTIVATED      = "KrysioUI Edit Mode layout activated.",

    -- Cooldown Manager
    CDM_IMPORTED_SPEC       = "CDM layout imported: %s",
    CDM_IMPORTED_COUNT      = "Imported %d CDM layouts.",
    CDM_NO_DATA             = "No Cooldown Manager profile data available.",
    CDM_SPEC_NOT_DETECTED   = "Could not detect current class/spec.",
    CDM_ACTIVATED           = "CDM layout activated: %s",
    CDM_ACTIVATED_SPEC      = "CDM layout activated for your current spec!",
    CDM_NO_LAYOUT           = "No CDM layout found for your current spec.",
    CDM_SELECT_TITLE        = "Select CDM Layouts",
    CDM_SELECT_DESC         = "Choose which specializations to import — only your current class is shown.",
    CDM_SKIP                = "CooldownManager was deselected — skipping this step.",
    CDM_CLASS_NOT_DETECTED  = "Could not detect your current class and specialization.",
    CDM_NO_PROFILES         = "No CDM profiles found for your class in the data file.",
    CDM_NO_SELECTION        = "Select at least one specialization to proceed.",
    CDM_NO_STRING           = "no layout data",
    CDM_HAS_STRING          = "ready to import",
    CDM_SELECTED_COUNT      = "%d CDM layout(s) selected",
    CDM_BTN_IMPORT          = "Import",
    IMPORTING_SHORT         = "Importing...",
    STATUS_DONE             = "Done",
    STATUS_FAILED           = "Failed",
    CDM_HANDLED_STEP2       = "CDM — already processed in previous step",

    -- EllesmereUI
    EUI_IMPORTED            = "EllesmereUI profiles imported: %s",
    EUI_IMPORT_ERRORS       = "EllesmereUI import errors: %s",
    EUI_GLOBAL_IMPORTED     = "EllesmereUI global settings imported.",
    EUI_NOT_LOADED          = "EllesmereUI not loaded.",
    EUI_PROFILES_READY      = "EllesmereUI profiles are ready.",

    -- Errors
    NO_PROFILE_DATA         = "No profile data for %s.",
    IMPORT_CANCELLED        = "%s import cancelled by user.",
    MODULE_IMPL_MISSING     = "Module implementation missing for %s.",
    MODULE_NOT_FOUND        = "Module not found: %s",
    MODULE_NO_IMPORT        = "Module %s has no import function.",
    MODULE_IMPORTED         = "%s imported successfully!",
    MODULE_LOADED           = "%s profile loaded.",
    MODULE_ALREADY_INSTALLED = "%s is already installed (v%s).",
    MODULE_NOT_INSTALLED    = "%s is not installed.",

    -- Slash commands
    HELP_HEADER             = "--- KrysioUI Commands ---",
    HELP_INSTALL            = "/kui install — Open the full installation wizard",
    HELP_UPDATE             = "/kui update — Update out-of-date profiles",
    HELP_LOAD               = "/kui load — Load profiles for this character",
    HELP_STATUS             = "/kui status — Show module installation status",
    HELP_CHECK              = "/kui check — Check for updates",
    HELP_CHANGELOG          = "/kui changelog — View the changelog",
    HELP_HELP               = "/kui help — Show this help",
    UNKNOWN_COMMAND         = "Unknown command: %s",
    TYPE_HELP               = "Type /kui help for available commands.",

    -- Misc
    INSTALLER_NOT_READY     = "Installer is not ready yet.",
    CHANGELOG_NOT_READY     = "Changelog viewer not available.",
    CANT_OPEN_IN_COMBAT     = "Cannot open KrysioUI during combat.",
    CHANGELOG_TITLE         = "KrysioUI Changelog",
    NEW_CHANGELOG           = "|cffa626e6New in KrysioUI!|r Check out the changelog to see what's new.",
    TYPE_CHANGELOG          = "Type /kui changelog to view.",
    MINIMAP_TOOLTIP         = "KrysioUI Profile Installer",
    LEFT_CLICK_INSTALL       = "Left-click: Open installer",
    RIGHT_CLICK_INSTALL      = "Right-click: Open installer",
})