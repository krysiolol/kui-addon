# KrysioUI

A clean, lightweight World of Warcraft UI profile installation suite inspired by modern minimialist addon managers. Designed for **1440p** resolution.

## Requirements

- [EllesmereUI](https://www.curseforge.com/wow/addons/ellesmereui) (required — UI framework)
- [BigWigs](https://www.curseforge.com/wow/addons/bigwigs) / LittleWigs (recommended — boss mods)
- [Cooldown Manager](https://www.curseforge.com/wow/addons/cooldown-manager) (optional — CDM profiles)

## Installation

1. Download the latest release from [CurseForge](https://www.curseforge.com/wow/addons/krysio-ui) or [Wago](https://addons.wago.io/addons/krysio-ui)
2. Extract to `World of Warcraft\_retail_\Interface\AddOns\`
3. Make sure `KrysioUI` appears in your addon list
4. Configure EllesmereUI first, then type `/kui` to launch the installer

## Usage

Type `/kui` or `/krysio` to open the installer wizard:

- **Step 1**: Welcome — resolution check and mode selection
- **Step 2**: Select modules to install (EllesmereUI, BigWigs, Cooldown Manager, Edit Mode)
- **Step 3**: Import profiles — the wizard handles everything
- **Step 4**: Reload UI to apply changes

The slash commands also include `/kui reset` to clear saved settings and `/kui version` to display the current version.

## Supported Modules

| Module | Description |
|--------|-------------|
| EllesmereUI | Global settings, per-character profiles (1080p / 1440p) |
| BigWigs | Boss mod profiles (1080p / 1440p) |
| Cooldown Manager | Per-specialization CDM layouts |
| Edit Mode | Custom Edit Mode layout |

## Design

- **Theme**: Dark purple palette (`#A626E6` accent)
- **Resolution**: Optimized for 1440p — 1080p supported with a warning
- **Standalone**: No external dependencies beyond the required addons
- **Localization**: English and Spanish (auto-detected)

## Development

### File Structure

```
KrysioUI/
├── Core/
│   ├── Init.lua             — Core setup, version checks
│   ├── Locale.lua           — Localization loader
│   ├── Colors.lua           — Color definitions
│   ├── ProfileManager.lua   — Profile import/export
│   ├── Minimap.lua          — Minimap button
│   ├── SlashCommands.lua    — Slash command handler
│   └── Installer/
│       ├── Wizard.lua       — Installer entry point
│       └── Steps.lua        — Wizard step pages
├── Modules/
│   ├── Template.lua         — Module registration template
│   ├── EllesmereUI.lua      — EllesmereUI profile import
│   ├── BigWigs.lua          — BigWigs profile import
│   ├── CooldownManager.lua  — CDM layout import
│   └── EditMode.lua         — Edit Mode layout import
├── Data/
│   ├── EllesmereUI.lua      — EllesmereUI profile strings
│   ├── BigWigs.lua          — BigWigs profile strings
│   ├── CooldownManager.lua  — CDM layout strings
│   └── EditMode.lua         — Edit Mode layout string
├── Locales/
│   ├── enUS.lua             — English localizations
│   └── esES.lua             — Spanish localizations
├── media/
│   └── icon.png             — Addon icon
├── KrysioUI.toc             — Addon table of contents
└── Libraries/               — Embedded libraries
```

### Adding a New Module

1. Register the module in `Core/Init.lua` via `KUI:RegisterModule()`
2. Create `Data/MyModule.lua` with profile strings
3. Create `Modules/MyModule.lua` with import logic
4. Add locale strings in `Locales/enUS.lua` and `Locales/esES.lua`

### Updating Profiles

To update profile data (e.g. new CDM layout adjustments):
1. Export from the game using the relevant addon's export feature
2. Update the corresponding file in `Data/`
3. Bump the module version in its `manifestKey`

## License

MIT © 2026 Alberto
