<div align="center">

# 🎮 C&C Generals Zero Hour Launcher

**مُشغّل احترافي | Professional Launcher**

![Version](https://img.shields.io/badge/Version-2.4.0-58a6ff?style=for-the-badge&logo=github)
![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v2.0+-3fb950?style=for-the-badge&logo=autohotkey)
![Platform](https://img.shields.io/badge/Platform-Windows-0078d4?style=for-the-badge&logo=windows)
![License](https://img.shields.io/badge/License-Free-d29922?style=for-the-badge)

*A sleek, feature-rich launcher for Command & Conquer Generals: Zero Hour*

</div>

---

## ✨ Features

| Feature | Description |
|---|---|
| 🌐 **Generals Online** | Launch directly into Generals Online multiplayer |
| 🖥️ **Windowed Mode** | Run the game in a window with GenTool auto-enable |
| 🔧 **GenTool Manager** | Enable, disable, or auto-download GenTool |
| 🎨 **DXWrapper Support** | Fix black screen issues or reduce GPU load |
| 🔍 **Auto Game Detection** | Finds your game automatically (Registry, Steam, common paths) |
| 🌙 **Dark / Light Theme** | Follows system theme or manual override |
| 🌐 **Arabic / English UI** | Full bilingual interface support |
| ⚡ **Admin Auto-Elevate** | Automatically requests admin rights on launch |

---

## 📸 Preview

> The launcher features a professional dark UI inspired by GitHub/Discord aesthetics, with a clean header, status bar, launch buttons, and tool controls.

---

## 🚀 Getting Started

### Requirements
- Windows 10 / 11
- [AutoHotkey v2.0+](https://www.autohotkey.com/)
- Command & Conquer Generals: Zero Hour (installed)

### Installation

1. Download the latest release from the [Releases page](../../releases)
2. Extract the ZIP to any folder
3. Run `GeneralsLauncher.ahk` (requires AutoHotkey v2) **or** run the compiled `.exe`

> The launcher will automatically search for your game installation. If not found, it will prompt you to select the folder manually.

---

## 🔧 Tools

### GenTool
GenTool adds extra features to Zero Hour, required for **Windowed Mode**.

- **Enable** — Activates `d3d8.dll` in the game folder
- **Disable** — Deactivates GenTool without deleting it
- **Download** — Auto-downloads and installs GenTool v8.9

### DXWrapper
Fixes display issues, especially on modern GPUs.

| Version | Use Case |
|---|---|
| 🎮 GPU Fix Black Screen | Fixes black screen on launch with modern graphics cards |
| ⚡ Reduce Settings | Lowers GPU load for better performance |

> ⚠️ DXWrapper only works with **Generals Online**, not the base `Generals.exe`

---

## ⚙️ Configuration

Settings are saved automatically to `config.ini` in the launcher directory:

```ini
[Settings]
GamePath=C:\Games\Command and Conquer Generals Zero Hour
Language=en
Theme=auto
FirstRun=0
```

| Key | Values | Description |
|---|---|---|
| `GamePath` | folder path | Path to game directory containing `Generals.exe` |
| `Language` | `en` / `ar` | UI language |
| `Theme` | `auto` / `dark` / `light` | UI color theme |

---

## 🗂️ Game Search Priority

The launcher searches for your game in this order:

1. **Windows Registry** — Checks EA/Origin install entries
2. **Steam** — Scans Steam library folders
3. **Common Paths** — Checks typical install locations (Program Files, etc.)
4. **Deep Search** — Recursively scans all drives (up to 3 levels deep)

---

## 💬 Support

Need help? Join the Discord support channel:

[![Discord](https://img.shields.io/badge/Discord-Support_Channel-5865f2?style=for-the-badge&logo=discord)](https://discord.com/channels/925092720538689536/1279438595190558853)

**Discord:** `abdulrahman2023.1`

---

## 👨‍💻 Author

Made with ❤️ by **Abdulrahman**

---

<div align="center">

*Built with AutoHotkey v2 — Designed for the C&C community*

</div>
