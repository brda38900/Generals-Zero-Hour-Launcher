

```markdown
<div align="center">

# 🎮 C&C Generals Zero Hour Launcher

### Professional Game Launcher for Command & Conquer: Generals - Zero Hour

[![Version](https://img.shields.io/badge/Version-2.4.0-blue?style=for-the-badge)](https://github.com/yourusername/zh-launcher/releases)
[![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v2.0+-green?style=for-the-badge&logo=autohotkey)](https://www.autohotkey.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows-0078D6?style=for-the-badge&logo=windows)](https://www.microsoft.com/windows)

<img src="https://img.shields.io/badge/Made%20with-❤️-red?style=for-the-badge" alt="Made with Love">

---

**A modern, lightweight, and feature-rich launcher for C&C Generals Zero Hour**
**with automatic game detection, tool management, and multi-language support.**

[📥 Download](#-installation) •
[✨ Features](#-features) •
[📖 Usage](#-usage) •
[🛠️ Tools](#️-tools-management) •
[❓ FAQ](#-faq) •
[💬 Support](#-support)

---

</div>

## 📸 Screenshots

<div align="center">

| Dark Theme 🌙 | Light Theme ☀️ |
|:-:|:-:|
| ![Dark Theme](screenshots/dark_theme.png) | ![Light Theme](screenshots/light_theme.png) |

</div>

---

## ✨ Features

### 🚀 Core Features
| Feature | Description |
|---------|-------------|
| 🌐 **Online Mode** | Launch Generals Online (multiplayer) with one click |
| 🖥️ **Windowed Mode** | Run the game in windowed mode with GenTool |
| 🔍 **Auto Detection** | Automatically finds your game installation |
| ⚡ **Fast Launch** | Optimized for instant game startup |

### 🎨 User Interface
| Feature | Description |
|---------|-------------|
| 🌙 **Dark Theme** | Professional dark theme inspired by Discord & GitHub |
| ☀️ **Light Theme** | Clean and modern light theme |
| 🔄 **Auto Theme** | Automatically matches your Windows theme |
| 🌐 **Multi-Language** | Full support for English and Arabic |

### 🛠️ Tool Management
| Feature | Description |
|---------|-------------|
| 🔧 **GenTool** | Enable, disable, or download GenTool v8.9 |
| 🎨 **DXWrapper** | GPU fix for black screen & reduced settings |
| 📂 **Folder Access** | Quick access to game directory |

### 🔒 Smart Features
| Feature | Description |
|---------|-------------|
| 🔎 **Registry Search** | Searches Windows registry for game path |
| 🎮 **Steam Detection** | Detects Steam installations automatically |
| 📁 **Deep Search** | Scans all drives with smart folder filtering |
| 💾 **Auto Save** | Remembers your settings and preferences |

---

## 📋 Requirements

| Requirement | Details |
|-------------|---------|
| **OS** | Windows 7 / 8 / 10 / 11 |
| **Runtime** | AutoHotkey v2.0+ (not needed for .exe version) |
| **Game** | C&C Generals Zero Hour (any version) |
| **Internet** | Required only for downloading tools |
| **Disk Space** | ~2 MB for the launcher |

---

## 📥 Installation

### Method 1: Download Pre-built EXE (Recommended)

1. Go to the [**Releases**](https://github.com/yourusername/zh-launcher/releases) page
2. Download the latest `ZHLauncher.exe`
3. Place it anywhere on your computer
4. Run the launcher — it will find your game automatically!

### Method 2: Run from Source

1. Install [AutoHotkey v2.0+](https://www.autohotkey.com/)
2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/zh-launcher.git
   ```
3. Run `ZHLauncher.ahk`

### Method 3: Build from Source

1. Install [AutoHotkey v2.0+](https://www.autohotkey.com/)
2. Open **Ahk2Exe** (included with AutoHotkey)
3. Select `ZHLauncher.ahk` as source
4. Choose output path
5. Click **Convert**

---

## 📖 Usage

### 🎯 First Launch

```
1. Run ZHLauncher.exe
2. The launcher automatically searches for your game
3. If not found, you'll be prompted to select the game folder
4. Choose the folder containing "Generals.exe"
5. Done! You're ready to play
```

### 🌐 Play Online (Generals Online)

```
1. Click "🌐 Run Generals Online"
2. GenTool is automatically disabled (not compatible)
3. The game launches with online multiplayer support
4. The launcher closes automatically
```

### 🖥️ Play Windowed Mode

```
1. Click "🖥️ Run Windowed Mode"
2. GenTool is automatically enabled (required)
3. EdgeScroller starts automatically (if available)
4. The game launches in windowed mode
5. The launcher closes automatically
```

### 🔄 Change Game Path

| Method | Steps |
|--------|-------|
| **Auto Search** | Menu → 📁 File → 🔍 Auto Search |
| **Manual Select** | Menu → 📁 File → 📂 Select Path |
| **Click Status** | Click the path text in the status bar |

---

## 🛠️ Tools Management

### 🔧 GenTool v8.9

GenTool enables windowed mode and additional features for Generals Zero Hour.

| Action | How To |
|--------|--------|
| **Enable** | Click 🔧 GenTool → ✅ Enable GenTool |
| **Disable** | Click 🔧 GenTool → 🚫 Disable GenTool |
| **Download** | Click 🔧 GenTool → 📥 Download GenTool |

> **Note:** GenTool is automatically managed when launching the game.
> - **Online Mode** → GenTool is disabled
> - **Windowed Mode** → GenTool is enabled

### 🎨 DXWrapper

DXWrapper fixes graphics issues with Generals Online.

| Version | Purpose |
|---------|---------|
| 🎮 **GPU Fix** | Fixes black screen issues on modern GPUs |
| ⚡ **Reduce Settings** | Reduces graphics settings for better performance |

| Action | How To |
|--------|--------|
| **Enable** | Click 🎨 DXWrapper → ✅ Enable DXWrapper |
| **Disable** | Click 🎨 DXWrapper → 🚫 Disable DXWrapper |
| **Download GPU** | Click 🎨 DXWrapper → 🎮 GPU Fix Black Screen |
| **Download Reduce** | Click 🎨 DXWrapper → ⚡ Reduce Settings |

> ⚠️ **Important:** DXWrapper only works with Generals Online mode.

---

## 🎨 Themes

The launcher supports three theme modes:

| Theme | Description |
|-------|-------------|
| 🔄 **Auto** | Follows your Windows system theme |
| 🌙 **Dark** | Professional dark theme (GitHub-inspired) |
| ☀️ **Light** | Clean light theme |

**Change theme:** Menu → ⚙️ Settings → 🎨 Theme

---

## 🌐 Languages

| Language | Status |
|----------|--------|
| 🇺🇸 English | ✅ Full Support |
| 🇸🇦 العربية | ✅ Full Support |

**Change language:** Click `🌐 English` or `🌐 عربي` in the menu bar.

---

## 📁 Project Structure

```
zh-launcher/
├── 📄 ZHLauncher.ahk          # Main source code
├── 📄 ZHLauncher.exe           # Compiled executable
├── 📄 config.ini               # Auto-generated settings (after first run)
├── 📄 README.md                # This file
├── 📄 LICENSE                  # MIT License
└── 📁 screenshots/             # Screenshots for documentation
    ├── 🖼️ dark_theme.png
    └── 🖼️ light_theme.png
```

---

## ⚙️ Configuration

Settings are stored in `config.ini` (auto-generated):

```ini
[Settings]
GamePath=C:\Games\Command and Conquer Generals Zero Hour
Language=en
Theme=auto
FirstRun=0
```

| Setting | Values | Default |
|---------|--------|---------|
| `GamePath` | Any valid path | Auto-detected |
| `Language` | `en`, `ar` | `en` |
| `Theme` | `auto`, `dark`, `light` | `auto` |
| `FirstRun` | `0`, `1` | `1` |

---

## 🔍 Auto Detection

The launcher searches for the game in this order:

```
1️⃣ Windows Registry
   └── EA Games registry keys

2️⃣ Steam
   └── steamapps/common/

3️⃣ Common Paths
   ├── EA Games/
   ├── Origin Games/
   ├── R.G. Mechanics/
   ├── Program Files (x86)/
   └── Games/

4️⃣ Deep Search
   └── Scans all drives (smart filtering, max depth: 3)
```

### Smart Search Features
- ⏭️ Skips system folders (Windows, ProgramData, etc.)
- 🎯 Prioritizes game-related folder names
- 🔄 Avoids duplicate folder scanning
- ⚡ Optimized for speed with keyword filtering

---

## ❓ FAQ

<details>
<summary><b>🔴 Antivirus flags the launcher as malicious</b></summary>

This is a **false positive**. The launcher is built with AutoHotkey which can trigger antivirus alerts because:
- It packages a script interpreter inside an EXE
- It downloads files from the internet (tool downloads)
- It modifies DLL files (enabling/disabling tools)
- It reads Windows registry (game detection)

**Solutions:**
1. Add the launcher to your antivirus exclusion list
2. Download and run from source code instead
3. Verify the source code yourself — it's fully open source!

You can verify the file on [VirusTotal](https://www.virustotal.com).
</details>

<details>
<summary><b>🔴 Game not found automatically</b></summary>

1. Click **📁 File → 📂 Select Path**
2. Navigate to your game folder
3. Select the folder that contains `Generals.exe`
4. The path should look like:
   ```
   C:\EA Games\Command and Conquer Generals Zero Hour
   ```
</details>

<details>
<summary><b>🔴 Generals Online doesn't launch</b></summary>

- Make sure `GeneralsOnlineZH.exe` exists in your game folder
- Download Generals Online from the official source
- Try running as administrator
</details>

<details>
<summary><b>🔴 Windowed mode doesn't work</b></summary>

- GenTool is required for windowed mode
- Click **🔧 GenTool → 📥 Download GenTool** to install it
- Make sure `d3d8.dll` exists in your game folder
</details>

<details>
<summary><b>🔴 Black screen when playing</b></summary>

- Download DXWrapper GPU Fix:
  **🎨 DXWrapper → 🎮 GPU Fix Black Screen**
- This fixes compatibility issues with modern graphics cards
</details>

<details>
<summary><b>🔴 Game runs slowly</b></summary>

- Download DXWrapper Reduce Settings:
  **🎨 DXWrapper → ⚡ Reduce Settings**
- This optimizes graphics settings for better performance
</details>

---

## 🔧 Building from Source

### Prerequisites
- [AutoHotkey v2.0+](https://www.autohotkey.com/)
- Windows 7 or later

### Compile to EXE

```bash
# Using Ahk2Exe (GUI)
1. Open Ahk2Exe (included with AutoHotkey)
2. Source: ZHLauncher.ahk
3. Destination: ZHLauncher.exe
4. Base File: Unicode 64-bit
5. Click Convert

# Using Command Line
Ahk2Exe.exe /in "ZHLauncher.ahk" /out "ZHLauncher.exe" /base "AutoHotkey64.exe"
```

### Reducing Antivirus False Positives
```
✅ Do NOT use UPX compression
✅ Add version info and icon
✅ Sign the executable (see signing guide below)
```

---

## 📜 Changelog

### v2.4.0 (Latest)
- ✨ Professional UI with Dark/Light themes
- 🌐 Multi-language support (English & Arabic)
- 🔍 Enhanced auto-detection with smart search
- 🎨 DXWrapper support with GPU Fix & Reduce Settings
- ⚡ Optimized performance and faster startup
- 🔧 Improved GenTool management
- 📂 Quick folder access button

### v2.3.0
- 🎨 Added theme system
- 🌐 Added language switching
- 🔍 Improved game search algorithm

### v2.2.0
- 🔧 Added GenTool auto-management
- 🎨 Added DXWrapper support
- 📂 Added folder access

### v2.1.0
- 🖥️ Added windowed mode support
- ⚡ Added EdgeScroller auto-start

### v2.0.0
- 🚀 Initial release with online mode support

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit** your changes
   ```bash
   git commit -m "Add amazing feature"
   ```
4. **Push** to the branch
   ```bash
   git push origin feature/amazing-feature
   ```
5. Open a **Pull Request**

### Ideas for Contributions
- [ ] 🌐 Add more languages (French, German, etc.)
- [ ] 🎨 Add more themes
- [ ] 🔧 Add more tool integrations
- [ ] 📊 Add game statistics tracking
- [ ] 🗺️ Add map manager

---

## 💬 Support

Need help? Have suggestions?

| Channel | Link |
|---------|------|
| 💬 **Discord** | [Support Channel](https://discord.com/channels/925092720538689536/1279438595190558853) |
| 👤 **Discord User** | `abdulrahman2023.1` |
| 🐛 **Bug Reports** | [GitHub Issues](https://github.com/yourusername/zh-launcher/issues) |

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Abdulrahman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## ⭐ Star History

If you find this project useful, please consider giving it a ⭐!

---

<div align="center">

### Made with ❤️ by Abdulrahman

**C&C Generals Zero Hour Launcher** — Play your favorite game with ease!

[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github)](https://github.com/yourusername)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.com/channels/925092720538689536/1279438595190558853)

</div>
```

---

## 📝 ملاحظات مهمة

غيّر هذه الأشياء قبل الاستخدام:

```
1. yourusername  → اسم حسابك على GitHub
2. أضف صور في مجلد screenshots/
   - dark_theme.png
   - light_theme.png
3. حدّث روابط GitHub Issues و Repository
```

### لأخذ Screenshots:

```
1. شغّل التطبيق
2. اضغط Win + Shift + S
3. التقط صورة
4. احفظها في مجلد screenshots/
```
