-------------------------------------------------------------------------------
--  KrysioUI\Locales\esES.lua
--  Spanish (Spain) localization
-------------------------------------------------------------------------------

local KUI = _G.KrysioUI
if not KUI then return end

KUI:RegisterLocale("esES", {
    -- General UI
    CLOSE                   = "Cerrar",
    BACK                    = "Atrás",
    NEXT                    = "Siguiente",
    RELOAD_UI               = "Recargar UI",
    RELOADING               = "Recargando UI...",
    INSTALL                 = "Instalar",
    LOAD                    = "Cargar",
    IMPORT                  = "Importar",

    -- Welcome / Intro
    WELCOME_TITLE           = "¡Bienvenido a KrysioUI!",
    WELCOME_DESC            = "Este asistente importará mi configuración completa de UI para %s.\nElige qué módulos instalar en el siguiente paso.",
    WELCOME_HELP            = "Escribe %s para ver la lista de comandos en cualquier momento.",
    RES_WARNING_TITLE       = "Aviso de Resolución",
    RES_WARNING_DESC        = "KrysioUI está diseñada y probada para %s.\n\nEstás usando %s, que no tiene soporte oficial.\n\nPuedes instalarla y usarla igual — los perfiles se aplicarán. Quizás necesites ajustar manualmente algunas posiciones y escalas para que encajen en tu pantalla.\n\n|cffff8800No hay soporte para 1080p.|r",
    UPDATE_TITLE            = "Actualización de KrysioUI",
    UPDATE_DESC             = "Este asistente actualizará tus perfiles de UI a la última versión.",
    LOAD_TITLE              = "Cargar Perfiles",
    LOAD_DESC               = "Esto aplicará tus perfiles de KrysioUI existentes a este personaje sin reimportar.",

    -- Step titles
    STEP_INTRO_TITLE        = "Introducción",
    STEP_SELECTION_TITLE    = "Selección",
    STEP_IMPORT_TITLE       = "Importar",
    STEP_FINISH_TITLE       = "Finalizar",
    STEP_OF                 = "Paso %d de %d",

    -- Module selection
    SELECTION_TITLE         = "Selecciona Módulos a Instalar",
    CHECK_ALL               = "Seleccionar Todo",
    UNCHECK_ALL             = "Deseleccionar Todo",
    ADDON_NOT_FOUND         = "(no detectado)",
    NO_MODULES_SELECTED     = "No hay módulos seleccionados. Selecciona al menos uno para continuar.",
    ADDON_NOT_DETECTED_SKIP = "addon no encontrado — omitido",
    ALREADY_CURRENT         = "ya está actualizado (v%s) — omitido",

    -- Import progress
    IMPORTING_TITLE         = "Importando perfiles...",
    IMPORT_CHECKING_TITLE   = "Revisando perfiles...",
    IMPORT_STARTING         = "Iniciando importación...",
    IMPORTING               = "Importando %s...",
    IMPORT_COMPLETE         = "¡Todos los perfiles importados correctamente!",
    IMPORT_COMPLETE_WARN    = "Importación completada con algunos errores. Revisa los detalles arriba.",
    IMPORT_COMPLETE_NONE    = "Todos los perfiles ya están actualizados — no hay nada que importar.",
    IMPORT_COMPLETE_NOADDON = "No se detectaron addons compatibles.",
    IMPORT_COMPLETE_MIXED   = "%d importados — %d ya actualizados.",
    IMPORT_RESULT_LINE      = "importados: %d | actuales: %d | omitidos: %d | errores: %d",

    -- Finish
    FINISH_TITLE            = "¡Instalación Completa!",
    FINISH_DESC             = "Tus perfiles han sido importados. Haz clic en 'Recargar UI' para aplicar todos los cambios.",
    FINISH_TITLE_NONE       = "Nada que Actualizar",
    FINISH_DESC_NONE        = "Todos los perfiles ya están actualizados.",
    FINISH_TITLE_NOADDON    = "Sin Addons Detectados",
    FINISH_DESC_NOADDON     = "Instala los addons necesarios primero y ejecuta el instalador de nuevo.",

    -- Module strings
    ELLESMEREUI_DESC        = "Paquete completo de perfiles EllesmereUI (Barras de Acción, Placas, Marcos de Unidad, CDM y más)",
    BIGWIGS_DESC            = "Perfil de BigWigs con configuraciones de temporizadores y jefes",
    EDITMODE_NAME           = "Modo Edición",
    EDITMODE_DESC           = "Diseño de Modo Edición de Blizzard para marcos de unidad y HUD",
    CDM_NAME                = "Gestor de Reutilización",
    CDM_DESC                = "Diseños del Gestor de Reutilización de Blizzard (específicos por clase)",

    -- Status
    STATUS_INSTALLED        = "v%s — instalado",
    STATUS_OUTDATED         = "v%s → actualización disponible (v%s)",
    STATUS_MISSING          = "no importado aún",
    NEVER_IMPORTED          = "nunca importado",
    ALL_UPDATED             = "¡Todos los módulos están actualizados!",
    MODULE_OUTDATED         = "%s: instalado %s, último %s",
    UPDATES_AVAILABLE       = "|cffffd700Actualizaciones disponibles para %d módulo(s).|r",
    TYPE_STATUS             = "Escribe |cffa626e6/kui status|r para más detalles.",

    -- BigWigs
    BIGWIGS_IMPORTED        = "¡Perfil de BigWigs importado correctamente!",
    BIGWIGS_API_MISSING     = "API de BigWigs no disponible.",
    BIGWIGS_ALREADY_ACTIVE  = "El perfil de BigWigs ya está activo.",
    BIGWIGS_PROFILE_LOADED  = "Perfil de BigWigs cargado.",

    -- Edit Mode
    EDITMODE_IMPORTED       = "¡Diseño de Modo Edición importado y activado!",
    EDITMODE_NOT_FOUND      = "Diseño de Modo Edición de KrysioUI no encontrado. Impórtalo primero.",
    EDITMODE_ACTIVATED      = "Diseño de Modo Edición de KrysioUI activado.",

    -- Cooldown Manager
    CDM_IMPORTED_SPEC       = "Diseño CDM importado: %s",
    CDM_IMPORTED_COUNT      = "%d diseños de CDM importados.",
    CDM_NO_DATA             = "No hay datos de perfil del Gestor de Reutilización.",
    CDM_SPEC_NOT_DETECTED   = "No se pudo detectar la clase/especialización actual.",
    CDM_ACTIVATED           = "Diseño CDM activado: %s",
    CDM_ACTIVATED_SPEC      = "Diseño CDM activado para tu espec actual!",
    CDM_NO_LAYOUT           = "No se encontró un diseño CDM para tu especialización actual.",
    CDM_SELECT_TITLE        = "Seleccionar Diseños CDM",
    CDM_SELECT_DESC         = "Elige qué especializaciones importar — solo se muestra tu clase actual.",
    CDM_SKIP                = "CooldownManager fue deseleccionado — saltando este paso.",
    CDM_CLASS_NOT_DETECTED  = "No se pudo detectar tu clase y especialización actual.",
    CDM_NO_PROFILES         = "No se encontraron diseños CDM para tu clase en el archivo de datos.",
    CDM_NO_SELECTION        = "Selecciona al menos una especialización para continuar.",
    CDM_NO_STRING           = "sin datos de diseño",
    CDM_HAS_STRING          = "listo para importar",
    CDM_SELECTED_COUNT      = "%d diseño(s) CDM seleccionados",
    CDM_BTN_IMPORT          = "Importar",
    IMPORTING_SHORT         = "Importando...",
    STATUS_DONE             = "Listo",
    STATUS_FAILED           = "Falló",
    CDM_HANDLED_STEP2       = "CDM — ya procesado en el paso anterior",

    -- EllesmereUI
    EUI_IMPORTED            = "Perfiles EllesmereUI importados: %s",
    EUI_IMPORT_ERRORS       = "Errores de importación EllesmereUI: %s",
    EUI_GLOBAL_IMPORTED     = "Configuración global de EllesmereUI importada.",
    EUI_NOT_LOADED          = "EllesmereUI no está cargado.",
    EUI_PROFILES_READY      = "Los perfiles de EllesmereUI están listos.",

    -- Errors
    NO_PROFILE_DATA         = "No hay datos de perfil para %s.",
    IMPORT_CANCELLED        = "Importación de %s cancelada por el usuario.",
    MODULE_IMPL_MISSING     = "Falta la implementación del módulo para %s.",
    MODULE_NOT_FOUND        = "Módulo no encontrado: %s",
    MODULE_NO_IMPORT        = "El módulo %s no tiene función de importación.",
    MODULE_IMPORTED         = "¡%s importado correctamente!",
    MODULE_LOADED           = "Perfil de %s cargado.",
    MODULE_ALREADY_INSTALLED = "%s ya está instalado (v%s).",
    MODULE_NOT_INSTALLED    = "%s no está instalado.",

    -- Slash commands
    HELP_HEADER             = "--- Comandos de KrysioUI ---",
    HELP_INSTALL            = "/kui install — Abre el asistente de instalación completo",
    HELP_UPDATE             = "/kui update — Actualiza perfiles desactualizados",
    HELP_LOAD               = "/kui load — Carga perfiles para este personaje",
    HELP_STATUS             = "/kui status — Muestra el estado de instalación de módulos",
    HELP_CHECK              = "/kui check — Busca actualizaciones",
    HELP_CHANGELOG          = "/kui changelog — Ver el registro de cambios",
    HELP_HELP               = "/kui help — Muestra esta ayuda",
    UNKNOWN_COMMAND         = "Comando desconocido: %s",
    TYPE_HELP               = "Escribe /kui help para ver los comandos disponibles.",

    -- Misc
    INSTALLER_NOT_READY     = "El instalador aún no está listo.",
    CHANGELOG_NOT_READY     = "Visor de cambios no disponible.",
    CANT_OPEN_IN_COMBAT     = "No puedes abrir KrysioUI durante el combate.",
    CHANGELOG_TITLE         = "Registro de Cambios de KrysioUI",
    NEW_CHANGELOG           = "|cffa626e6¡Nuevo en KrysioUI!|r Revisa el registro de cambios para ver las novedades.",
    TYPE_CHANGELOG          = "Escribe /kui changelog para verlo.",
    MINIMAP_TOOLTIP         = "Instalador de Perfiles KrysioUI",
    LEFT_CLICK_INSTALL       = "Clic izquierdo: Abrir instalador",
    RIGHT_CLICK_INSTALL      = "Clic derecho: Abrir instalador",
})