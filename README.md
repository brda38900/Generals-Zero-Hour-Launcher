<div dir="rtl">

# 📝 ملف README.md

</div>

```markdown
<div align="center">

# 🎮 C&C Generals Zero Hour Launcher

### Professional Game Launcher for Command & Conquer: Generals - Zero Hour

![Version](https://img.shields.io/badge/Version-2.4.0-blue?style=for-the-badge)
![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v2.0+-green?style=for-the-badge&logo=autohotkey)
![Platform](https://img.shields.io/badge/Platform-Windows-0078D6?style=for-the-badge&logo=windows)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

<br>

<img src="https://img.shields.io/badge/Made%20with-❤️-red?style=for-the-badge" alt="Made with Love">

**A feature-rich, professional launcher for C&C Generals: Zero Hour with automatic game detection, theme support, and integrated tool management.**

[🚀 Download](#-installation) • [📖 Features](#-features) • [🛠️ Usage](#️-usage) • [💬 Support](#-support)

---

</div>

## 📸 Overview

A modern, lightweight launcher built with AutoHotkey v2 that simplifies launching and managing **Command & Conquer: Generals - Zero Hour**. It features automatic game path detection, GenTool/DXWrapper integration, bilingual support (English/Arabic), and a professional dark/light theme system.

---

## ✨ Features

### 🚀 Launch Modes
| Mode | Description |
|------|-------------|
| **🌐 Generals Online** | Launch the game via `GeneralsOnlineZH.exe` for online multiplayer (auto-disables GenTool) |
| **🖥️ Windowed Mode** | Launch with `-win` flag using `Generals.exe` (auto-enables GenTool + EdgeScroller) |

### 🔍 Smart Game Detection
The launcher uses a **multi-layered search strategy** to automatically find your game installation:

1. **Registry Search** — Scans Windows Registry for EA Games / Origin install paths
2. **Steam Detection** — Checks Steam library folders and common game directories
3. **Common Paths** — Scans well-known installation directories across all drives
4. **Deep Search** — Performs an intelligent recursive search (up to 3 levels deep) with keyword-based folder filtering

> ⚡ The search uses an optimized skip-list to avoid scanning system folders like `Windows`, `$Recycle.Bin`, `node_modules`, etc.

### 🔧 Integrated Tools

#### GenTool v8.9
- ✅ One-click **enable/disable** (renames `d3d8.dll` ↔ `d3d8-.dll`)
- 📥 **Auto-download** from GitHub releases if not installed
- 🔄 Automatically managed based on launch mode

#### DXWrapper
- 🎮 **GPU Fix Black Screen** — Fixes black screen issues on modern GPUs
- ⚡ **Reduce Settings** — Reduces graphical settings for better performance
- ✅ One-click **enable/disable** (renames `dxwrapper.dll` ↔ `dxwrapper-.dll`)
- 📥 **Auto-download** with type selection dialog
- ⚠️ Note: DXWrapper only works with Generals Online

### 🎨 Theme System
| Theme | Description |
|-------|-------------|
| **🔄 Auto** | Follows Windows system theme (dark/light) |
| **🌙 Dark** | Professional dark theme inspired by GitHub/Discord |
| **☀️ Light** | Clean light theme for daytime use |

### 🌐 Bilingual Support
- **English** 🇬🇧
- **Arabic** 🇸🇦

Switch languages instantly from the menu bar — the entire UI rebuilds in the selected language.

### ⚙️ Additional Features
- 🛡️ **Auto-elevate to Administrator** — Required for game compatibility
- 💾 **Persistent Configuration** — Saves settings to `config.ini` (game path, language, theme)
- 📂 **Quick Folder Access** — Open game directory directly from the launcher
- 🔔 **Toast Notifications** — Non-intrusive tooltip notifications for all actions
- 🖱️ **Clickable Status Bar** — Click the path display to change game location

---

## 📋 Requirements

- **Operating System:** Windows 7 / 8 / 10 / 11
- **Runtime:** [AutoHotkey v2.0+](https://www.autohotkey.com/) (if running from source `.ahk`)
- **Game:** Command & Conquer: Generals - Zero Hour (any version)
- **Permissions:** Administrator privileges (auto-requested on launch)

---

## 🚀 Installation

### Option 1: Pre-compiled Executable (Recommended)
1. Go to the [**Releases**](../../releases) page
2. Download the latest `.exe` file
3. Place it anywhere on your system
4. Double-click to run — the launcher will auto-detect your game!

### Option 2: Run from Source
1. Install [AutoHotkey v2.0+](https://www.autohotkey.com/)
2. Clone this repository:
   ```bash
   git clone https://github.com/brda38900/Additional-content-in-Command-Conquer-Generals-Zero-Hour.git
   ```
3. Run the `.ahk` script:
   ```
   Double-click the .ahk file
   ```

---

## 🛠️ Usage

### First Launch
1. **Run the launcher** — it will automatically search for the game
2. If auto-detection fails, you'll be prompted to **manually select** the game folder
3. Select the folder containing `Generals.exe`

### Launching the Game

#### 🌐 Online Mode
```
Click "Run Generals Online" → Launches GeneralsOnlineZH.exe
```
- Automatically **disables GenTool** (not compatible with online play)
- Requires `GeneralsOnlineZH.exe` in the game directory

#### 🖥️ Windowed Mode
```
Click "Run Windowed Mode" → Launches Generals.exe -win
```
- Automatically **enables GenTool** (required for windowed mode)
- Launches **EdgeScroller** if available
- If GenTool is missing, offers to download it automatically

### Managing Tools

#### GenTool
```
Click "🔧 GenTool" button → Context menu appears
  ├── ✅ Enable GenTool
  ├── 🚫 Disable GenTool
  └── 📥 Download GenTool
```

#### DXWrapper
```
Click "🎨 DXWrapper" button → Context menu appears
  ├── ✅ Enable DXWrapper
  ├── 🚫 Disable DXWrapper
  ├── 🎮 Download GPU Fix
  └── ⚡ Download Reduce Settings
```

### Changing Settings

| Setting | How to Change |
|---------|--------------|
| **Theme** | Menu Bar → ⚙️ Settings → 🎨 Theme → Select theme |
| **Language** | Menu Bar → 🌐 English / عربي |
| **Game Path** | Menu Bar → 📁 File → 📂 Select Path |
| **Auto Search** | Menu Bar → 📁 File → 🔍 Auto Search |

---

## 📁 Project Structure

```
📦 Project Root
├── 🎮 Launcher.ahk          # Main launcher script
├── ⚙️ config.ini             # Auto-generated settings file
└── 📖 README.md              # This file
```

### Config File Format (`config.ini`)
```ini
[Settings]
GamePath=D:\Games\Command and Conquer Generals Zero Hour
Language=en
Theme=auto
FirstRun=0
```

---

## 🔧 How It Works

### Architecture Overview

```
┌─────────────────────────────────────────┐
│              Main()                      │
│  ├── LoadConfig()                        │
│  ├── SearchGame() [if no saved path]     │
│  │   ├── SearchGameInRegistry()          │
│  │   ├── SearchGameInSteam()             │
│  │   ├── SearchGameInCommonPaths()       │
│  │   └── SearchGameDeep()               │
│  ├── CreateMainGui()                     │
│  │   ├── Header Section                  │
│  │   ├── Status Section                  │
│  │   ├── Launch Buttons                  │
│  │   ├── Tool Buttons                    │
│  │   └── Footer                          │
│  └── AskForPath() [if still no path]     │
└─────────────────────────────────────────┘
```

### GenTool Toggle Mechanism
```
Enable:  d3d8-.dll  →  d3d8.dll   (rename)
Disable: d3d8.dll   →  d3d8-.dll  (rename)
```

### DXWrapper Toggle Mechanism
```
Enable:  dxwrapper-.dll  →  dxwrapper.dll   (rename)
Disable: dxwrapper.dll   →  dxwrapper-.dll  (rename)
```

---

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| **Game not found automatically** | Use `📁 File → 📂 Select Path` to manually browse |
| **"GeneralsOnlineZH.exe not found"** | Make sure Generals Online is installed in the game folder |
| **GenTool won't enable** | Click `📥 Download GenTool` to install it |
| **Black screen on launch** | Install DXWrapper (GPU Fix) via the launcher |
| **Launcher doesn't start** | Right-click → Run as Administrator |
| **Settings not saving** | Ensure write permissions in the launcher's directory |

---

## 📥 Downloads (Integrated)

The launcher can automatically download and install these tools:

| Tool | Description | Source |
|------|-------------|--------|
| **GenTool v8.9** | Game enhancement tool for windowed mode | [GitHub Release](https://github.com/brda38900/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/tag/GenTool_v8.9) |
| **DXWrapper GPU Fix** | Fixes black screen on modern GPUs | [GitHub Release](https://github.com/brda38900/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/tag/dxwrapper_GPU) |
| **DXWrapper Reduce** | Reduces settings for performance | [GitHub Release](https://github.com/brda38900/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/tag/dxwrapper_GPU) |

---

## 💬 Support

Need help? Have a suggestion?

- **Discord:** `abdulrahman2023.1`
- **Support Channel:** [Open Discord Support](https://discord.com/channels/925092720538689536/1279438595190558853)

---

## 🗺️ Roadmap

- [ ] Custom resolution settings
- [ ] Mod manager integration
- [ ] Game replay manager
- [ ] Auto-update checker for the launcher
- [ ] More language translations

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 Credits

- **Developer:** Abdulrahman
- **Game:** Command & Conquer: Generals - Zero Hour © Electronic Arts
- **GenTool:** Third-party game enhancement tool
- **DXWrapper:** DirectX wrapper for compatibility fixes
- **Built with:** [AutoHotkey v2](https://www.autohotkey.com/)

---

<div align="center">

**⭐ If this launcher helped you, consider giving it a star! ⭐**

Made with ❤️ by **Abdulrahman**

</div>
```

---

<div dir="rtl">

## ✅ الملف يشمل:

1. **عنوان وبادجات** احترافية بأيقونات
2. **قائمة الميزات** كاملة ومفصلة بجداول
3. **طريقة التثبيت** (ملف تنفيذي أو من المصدر)
4. **شرح الاستخدام** خطوة بخطوة
5. **هيكلية المشروع** مع شرح الملفات
6. **كيف يعمل البرنامج** (Architecture Overview)
7. **حل المشاكل** (Troubleshooting) بجدول
8. **روابط التحميلات** المدمجة
9. **معلومات الدعم** (Discord)
10. **خارطة الطريق** المستقبلية (Roadmap)
11. **الرخصة والشكر**

</div>
