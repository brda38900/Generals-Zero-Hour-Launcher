; ══════════════════════════════════════════════════════════════════════════════
; 🎮 C&C Generals Zero Hour Launcher
; ══════════════════════════════════════════════════════════════════════════════
; Version: 2.4.0
; Author: Abdulrahman
; AutoHotkey Version: v2.0+
; Features: Professional UI, Fast Launch, Run as Admin, Optimized Search
; ══════════════════════════════════════════════════════════════════════════════

#Requires AutoHotkey v2.0
#SingleInstance Force

; ⚡ Speed up execution
SetControlDelay(-1)
SetWinDelay(-1)

; ══════════════════════════════════════════════════════════════════════════════
;                         ⭐ Auto Run as Administrator
; ══════════════════════════════════════════════════════════════════════════════

if !A_IsAdmin {
    try {
        Run('*RunAs "' . A_ScriptFullPath . '"')
        ExitApp()
    }
}

; ══════════════════════════════════════════════════════════════════════════════
;                         ⭐ Application Settings
; ══════════════════════════════════════════════════════════════════════════════

APP_NAME := "C&C Generals Zero Hour Launcher"
APP_VERSION := "2.4.0"
DEVELOPER := "Abdulrahman"
DISCORD_USERNAME := "abdulrahman2023.1"
DISCORD_SUPPORT := "https://discord.com/channels/925092720538689536/1279438595190558853"

URL_GENTOOL := "https://github.com/brda38900/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/download/GenTool_v8.9/GenTool_v8.9.zip"
URL_DXWRAPPER_GPU := "https://github.com/brda38900/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/download/dxwrapper_GPU/dxwrapper_GPU.Fix.Black.Screen.zip"
URL_DXWRAPPER_REDUCE := "https://github.com/brda38900/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/download/dxwrapper_GPU/dxwrapper.to.reduce.settings.zip"

CONFIG_FILE := A_ScriptDir "\config.ini"

GamePath := ""
CurrentLang := "en"
CurrentTheme := "auto"
CachedTheme := ""
FirstRun := true
MainGui := ""

; ══════════════════════════════════════════════════════════════════════════════
;                         🔍 Optimized Search Settings
; ══════════════════════════════════════════════════════════════════════════════

SKIP_FOLDERS := Map(
    "windows", 1, "programdata", 1, "$recycle.bin", 1,
    "system volume information", 1, "recovery", 1,
    "appdata", 1, "temp", 1, "tmp", 1, "cache", 1,
    "node_modules", 1, ".git", 1, "drivers", 1,
    "microsoft", 1, "nvidia", 1, "amd", 1, "intel", 1
)

GAME_KEYWORDS := Map(
    "command", 1, "conquer", 1, "generals", 1,
    "zero", 1, "hour", 1, "ea", 1, "games", 1, 
    "mechanics", 1, "origin", 1, "steam", 1
)

; ══════════════════════════════════════════════════════════════════════════════
;                         🎨 Enhanced Theme System
; ══════════════════════════════════════════════════════════════════════════════

THEMES := Map()

; Professional Dark Theme (Inspired by Discord/GitHub)
THEMES["dark"] := Map(
    ; Backgrounds
    "bg_primary", "0d1117",
    "bg_secondary", "161b22",
    "bg_tertiary", "21262d",
    "bg_header", "010409",
    "bg_card", "1c2128",
    "bg_hover", "292e36",
    "bg_button", "238636",
    "bg_button_hover", "2ea043",
    "bg_button_secondary", "373e47",
    "bg_button_danger", "da3633",
    
    ; Primary Colors
    "accent", "58a6ff",
    "accent_hover", "79b8ff",
    "success", "3fb950",
    "warning", "d29922",
    "error", "f85149",
    "info", "58a6ff",
    
    ; Text
    "text_primary", "f0f6fc",
    "text_secondary", "8b949e",
    "text_muted", "6e7681",
    "text_link", "58a6ff",
    "text_button", "ffffff",
    
    ; Borders
    "border", "30363d",
    "border_light", "21262d",
    "border_accent", "388bfd",
    
    ; Effects
    "shadow", "000000",
    "gradient_start", "161b22",
    "gradient_end", "0d1117"
)

; Professional Light Theme
THEMES["light"] := Map(
    ; Backgrounds
    "bg_primary", "ffffff",
    "bg_secondary", "f6f8fa",
    "bg_tertiary", "eaeef2",
    "bg_header", "f0f3f6",
    "bg_card", "ffffff",
    "bg_hover", "f3f4f6",
    "bg_button", "1f883d",
    "bg_button_hover", "2c974b",
    "bg_button_secondary", "e9ecef",
    "bg_button_danger", "cf222e",
    
    ; Primary Colors
    "accent", "0969da",
    "accent_hover", "0550ae",
    "success", "1a7f37",
    "warning", "9a6700",
    "error", "cf222e",
    "info", "0969da",
    
    ; Text
    "text_primary", "1f2328",
    "text_secondary", "656d76",
    "text_muted", "8c959f",
    "text_link", "0969da",
    "text_button", "ffffff",
    
    ; Borders
    "border", "d0d7de",
    "border_light", "e6e8eb",
    "border_accent", "0969da",
    
    ; Effects
    "shadow", "d0d7de",
    "gradient_start", "f6f8fa",
    "gradient_end", "ffffff"
)

GetTheme(key) {
    global THEMES, CurrentTheme, CachedTheme
    
    if (CachedTheme = "") {
        if (CurrentTheme = "auto")
            CachedTheme := IsSystemDarkMode() ? "dark" : "light"
        else
            CachedTheme := CurrentTheme
    }
    
    return THEMES[CachedTheme].Has(key) ? THEMES[CachedTheme][key] : "ffffff"
}

RefreshThemeCache() {
    global CachedTheme
    CachedTheme := ""
}

IsSystemDarkMode() {
    try {
        return RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", "AppsUseLightTheme") = 0
    }
    return true
}

IsDarkTheme() {
    global CachedTheme, CurrentTheme
    if (CachedTheme = "") {
        if (CurrentTheme = "auto")
            return IsSystemDarkMode()
        return CurrentTheme = "dark"
    }
    return CachedTheme = "dark"
}

; ══════════════════════════════════════════════════════════════════════════════
;                              Translation System
; ══════════════════════════════════════════════════════════════════════════════

LANG := Map()

LANG["ar"] := Map(
    "app_title", "C&C Generals Zero Hour",
    "app_subtitle", "مُشغّل احترافي",
    "btn_online", "🌐  تشغيل Generals Online",
    "btn_windowed", "🖥️  تشغيل Windowed Mode",
    "btn_gentool", "🔧 GenTool",
    "btn_dxwrapper", "🎨 DXWrapper",
    "btn_open_folder", "📂 فتح المجلد",
    "menu_file", "📁 ملف",
    "menu_search", "🔍 بحث تلقائي",
    "menu_select", "📂 اختيار المسار",
    "menu_open_folder", "📁 فتح مجلد اللعبة",
    "menu_exit", "❌ خروج",
    "menu_tools", "🛠️ أدوات",
    "menu_settings", "⚙️ الإعدادات",
    "menu_theme", "🎨 المظهر",
    "menu_theme_auto", "🔄 تلقائي",
    "menu_theme_dark", "🌙 داكن",
    "menu_theme_light", "☀️ فاتح",
    "menu_enable_gentool", "✅ تفعيل GenTool",
    "menu_disable_gentool", "🚫 تعطيل GenTool",
    "menu_download_gentool", "📥 تحميل GenTool",
    "menu_enable_dx", "✅ تفعيل DXWrapper",
    "menu_disable_dx", "🚫 تعطيل DXWrapper",
    "menu_download_dx_gpu", "🎮 GPU Fix Black Screen",
    "menu_download_dx_reduce", "⚡ Reduce Settings",
    "status_no_path", "⚠️ اضغط هنا لتحديد مسار اللعبة",
    "status_ready", "✅ جاهز",
    "status_gentool_on", "🔧 GenTool ✓",
    "status_gentool_off", "🔧 GenTool ✗",
    "status_dx_on", "🎨 DXWrapper ✓",
    "status_dx_off", "🎨 DXWrapper ✗",
    "msg_success", "✅ تم",
    "msg_error", "❌ خطأ",
    "msg_found", "✅ تم العثور على اللعبة!",
    "msg_not_found", "❌ لم يتم العثور على اللعبة",
    "msg_select_folder", "📂 اختر مجلد اللعبة",
    "msg_invalid_folder", "⚠️ المجلد غير صحيح!",
    "msg_downloading", "⏳ جاري التحميل...",
    "msg_download_done", "✅ تم التحميل!",
    "msg_enabled", "✅ تم التفعيل!",
    "msg_disabled", "🚫 تم التعطيل!",
    "msg_select_path_first", "⚠️ حدد مسار اللعبة أولاً!",
    "msg_online_not_found", "❌ GeneralsOnlineZH.exe غير موجود!",
    "msg_dxwrapper_note", "⚠️ DXWrapper يعمل فقط مع Generals Online",
    "msg_choose_dxwrapper", "🎨 اختر نوع DXWrapper:",
    "btn_dx_gpu", "🎮 GPU Fix Black Screen",
    "btn_dx_reduce", "⚡ Reduce Settings",
    "btn_cancel", "❌ إلغاء",
    "msg_gentool_needed", "🔧 GenTool مطلوب - تحميل؟",
    "msg_copied", "📋 تم النسخ!",
    "msg_searching", "🔍 جاري البحث...",
    "about_title", "ℹ️ حول",
    "about_version", "الإصدار",
    "about_developer", "المطور",
    "about_support", "الدعم",
    "btn_close", "إغلاق",
    "btn_copy", "📋 نسخ",
    "btn_open_support", "💬 فتح قناة الدعم",
    "section_launch", "🚀 تشغيل اللعبة",
    "section_tools", "🛠️ الأدوات"
)

LANG["en"] := Map(
    "app_title", "C&C Generals Zero Hour",
    "app_subtitle", "Professional Launcher",
    "btn_online", "🌐  Run Generals Online",
    "btn_windowed", "🖥️  Run Windowed Mode",
    "btn_gentool", "🔧 GenTool",
    "btn_dxwrapper", "🎨 DXWrapper",
    "btn_open_folder", "📂 Open Folder",
    "menu_file", "📁 File",
    "menu_search", "🔍 Auto Search",
    "menu_select", "📂 Select Path",
    "menu_open_folder", "📁 Open Game Folder",
    "menu_exit", "❌ Exit",
    "menu_tools", "🛠️ Tools",
    "menu_settings", "⚙️ Settings",
    "menu_theme", "🎨 Theme",
    "menu_theme_auto", "🔄 Auto",
    "menu_theme_dark", "🌙 Dark",
    "menu_theme_light", "☀️ Light",
    "menu_enable_gentool", "✅ Enable GenTool",
    "menu_disable_gentool", "🚫 Disable GenTool",
    "menu_download_gentool", "📥 Download GenTool",
    "menu_enable_dx", "✅ Enable DXWrapper",
    "menu_disable_dx", "🚫 Disable DXWrapper",
    "menu_download_dx_gpu", "🎮 GPU Fix Black Screen",
    "menu_download_dx_reduce", "⚡ Reduce Settings",
    "status_no_path", "⚠️ Click to select game path",
    "status_ready", "✅ Ready",
    "status_gentool_on", "🔧 GenTool ✓",
    "status_gentool_off", "🔧 GenTool ✗",
    "status_dx_on", "🎨 DXWrapper ✓",
    "status_dx_off", "🎨 DXWrapper ✗",
    "msg_success", "✅ Done",
    "msg_error", "❌ Error",
    "msg_found", "✅ Game found!",
    "msg_not_found", "❌ Game not found",
    "msg_select_folder", "📂 Select game folder",
    "msg_invalid_folder", "⚠️ Invalid folder!",
    "msg_downloading", "⏳ Downloading...",
    "msg_download_done", "✅ Downloaded!",
    "msg_enabled", "✅ Enabled!",
    "msg_disabled", "🚫 Disabled!",
    "msg_select_path_first", "⚠️ Select game path first!",
    "msg_online_not_found", "❌ GeneralsOnlineZH.exe not found!",
    "msg_dxwrapper_note", "⚠️ DXWrapper only works with Generals Online",
    "msg_choose_dxwrapper", "🎨 Choose DXWrapper type:",
    "btn_dx_gpu", "🎮 GPU Fix Black Screen",
    "btn_dx_reduce", "⚡ Reduce Settings",
    "btn_cancel", "❌ Cancel",
    "msg_gentool_needed", "🔧 GenTool required - Download?",
    "msg_copied", "📋 Copied!",
    "msg_searching", "🔍 Searching...",
    "about_title", "ℹ️ About",
    "about_version", "Version",
    "about_developer", "Developer",
    "about_support", "Support",
    "btn_close", "Close",
    "btn_copy", "📋 Copy",
    "btn_open_support", "💬 Open Support Channel",
    "section_launch", "🚀 Launch Game",
    "section_tools", "🛠️ Tools"
)

Tr(key) {
    global LANG, CurrentLang
    return LANG[CurrentLang].Has(key) ? LANG[CurrentLang][key] : key
}

; ══════════════════════════════════════════════════════════════════════════════
;                              Settings Management
; ══════════════════════════════════════════════════════════════════════════════

LoadConfig() {
    global GamePath, CurrentLang, CurrentTheme, FirstRun, CONFIG_FILE
    
    if !FileExist(CONFIG_FILE)
        return
    
    try {
        GamePath := IniRead(CONFIG_FILE, "Settings", "GamePath", "")
        CurrentLang := IniRead(CONFIG_FILE, "Settings", "Language", "ar")
        CurrentTheme := IniRead(CONFIG_FILE, "Settings", "Theme", "auto")
        FirstRun := IniRead(CONFIG_FILE, "Settings", "FirstRun", "1") = "1"
        
        if (GamePath != "" && !IsValidGameFolder(GamePath))
            GamePath := ""
    }
}

SaveConfig() {
    global GamePath, CurrentLang, CurrentTheme, FirstRun, CONFIG_FILE
    
    try {
        IniWrite(GamePath, CONFIG_FILE, "Settings", "GamePath")
        IniWrite(CurrentLang, CONFIG_FILE, "Settings", "Language")
        IniWrite(CurrentTheme, CONFIG_FILE, "Settings", "Theme")
        IniWrite(FirstRun ? "1" : "0", CONFIG_FILE, "Settings", "FirstRun")
    }
}

; ══════════════════════════════════════════════════════════════════════════════
;                              Quick Notifications
; ══════════════════════════════════════════════════════════════════════════════

ShowNotification(message, type := "info") {
    ToolTip(message)
    SetTimer(() => ToolTip(), -2500)
}

; ══════════════════════════════════════════════════════════════════════════════
;                              File Extraction
; ══════════════════════════════════════════════════════════════════════════════

ExtractZip(zipPath, destPath) {
    try {
        if !DirExist(destPath)
            DirCreate(destPath)
        psScript := "Expand-Archive -Path '" . zipPath . "' -DestinationPath '" . destPath . "' -Force"
        RunWait('powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "' . psScript . '"',, "Hide")
        return true
    }
    return false
}

; ══════════════════════════════════════════════════════════════════════════════
;                    🔍 Enhanced Game Search
; ══════════════════════════════════════════════════════════════════════════════

GetDrives() {
    drives := []
    for letter in ["C", "D", "E", "F", "G", "H", "I", "J"] {
        drive := letter ":\"
        if DirExist(drive)
            drives.Push(drive)
    }
    return drives
}

IsValidGameFolder(path) {
    if (path = "" || !DirExist(path))
        return false
    return FileExist(path "\Generals.exe")
}

GetFolderName(path) {
    SplitPath(path, &name)
    return name
}

SearchGameInRegistry() {
    regPaths := [
        "SOFTWARE\WOW6432Node\Electronic Arts\EA Games\Command and Conquer Generals Zero Hour",
        "SOFTWARE\Electronic Arts\EA Games\Command and Conquer Generals Zero Hour",
        "SOFTWARE\WOW6432Node\EA Games\Command and Conquer Generals Zero Hour",
        "SOFTWARE\EA Games\Command and Conquer Generals Zero Hour"
    ]
    
    valueNames := ["InstallPath", "Install Dir", "GameDir", "Path"]
    
    for regPath in regPaths {
        for valueName in valueNames {
            try {
                path := RegRead("HKEY_LOCAL_MACHINE\" . regPath, valueName)
                if (path != "") {
                    path := RTrim(path, "\")
                    
                    if IsValidGameFolder(path)
                        return path
                    
                    subPath := path "\Command and Conquer Generals Zero Hour"
                    if IsValidGameFolder(subPath)
                        return subPath
                }
            }
        }
    }
    return ""
}

SearchGameInSteam() {
    steamPath := ""
    
    steamRegPaths := [
        "SOFTWARE\WOW6432Node\Valve\Steam",
        "SOFTWARE\Valve\Steam"
    ]
    
    for regPath in steamRegPaths {
        try {
            steamPath := RegRead("HKEY_LOCAL_MACHINE\" . regPath, "InstallPath")
            if (steamPath != "" && DirExist(steamPath))
                break
        }
    }
    
    if (steamPath = "") {
        drives := GetDrives()
        steamFolders := ["Steam", "Program Files (x86)\Steam", "Program Files\Steam"]
        
        for drive in drives {
            for folder in steamFolders {
                testPath := drive . folder
                if DirExist(testPath) {
                    steamPath := testPath
                    break 2
                }
            }
        }
    }
    
    if (steamPath = "")
        return ""
    
    steamGameNames := [
        "Command & Conquer Generals - Zero Hour",
        "Command and Conquer Generals Zero Hour",
        "Command & Conquer Generals Zero Hour"
    ]
    
    commonFolder := steamPath "\steamapps\common"
    if DirExist(commonFolder) {
        for gameName in steamGameNames {
            gamePath := commonFolder "\" . gameName
            if IsValidGameFolder(gamePath)
                return gamePath
        }
    }
    
    return ""
}

SearchGameInCommonPaths() {
    drives := GetDrives()
    
    patterns := [
        "EA Games\Command and Conquer Generals Zero Hour\Command and Conquer Generals Zero Hour",
        "Program Files (x86)\EA Games\Command and Conquer Generals Zero Hour\Command and Conquer Generals Zero Hour",
        "Program Files\EA Games\Command and Conquer Generals Zero Hour\Command and Conquer Generals Zero Hour",
        "Games\Command and Conquer Generals Zero Hour\Command and Conquer Generals Zero Hour",
        "EA Games\Command and Conquer Generals Zero Hour",
        "Games\Command and Conquer Generals Zero Hour",
        "R.G. Mechanics\Command and Conquer - Generals\Command and Conquer Generals Zero Hour",
        "Games\R.G. Mechanics\Command and Conquer - Generals\Command and Conquer Generals Zero Hour",
        "Program Files (x86)\Origin Games\Command and Conquer Generals Zero Hour\Command and Conquer Generals Zero Hour",
        "Program Files (x86)\Origin Games\Command and Conquer Generals Zero Hour",
        "Origin Games\Command and Conquer Generals Zero Hour\Command and Conquer Generals Zero Hour",
        "Origin Games\Command and Conquer Generals Zero Hour",
        "Command and Conquer Generals Zero Hour\Command and Conquer Generals Zero Hour",
        "Command and Conquer Generals Zero Hour",
        "Generals Zero Hour",
        "Games\Generals Zero Hour"
    ]
    
    for drive in drives {
        for pattern in patterns {
            path := drive . pattern
            if IsValidGameFolder(path)
                return path
        }
    }
    
    return ""
}

SearchGameDeep(maxDepth := 3) {
    global SKIP_FOLDERS, GAME_KEYWORDS
    
    drives := GetDrives()
    visitedFolders := Map()
    
    for drive in drives {
        result := SearchInFolder(drive, 0, maxDepth, visitedFolders)
        if (result != "")
            return result
    }
    
    return ""
}

SearchInFolder(folder, currentDepth, maxDepth, visitedFolders) {
    global SKIP_FOLDERS, GAME_KEYWORDS
    
    if (currentDepth >= maxDepth)
        return ""
    
    if !DirExist(folder)
        return ""
    
    folderLower := StrLower(folder)
    if visitedFolders.Has(folderLower)
        return ""
    visitedFolders[folderLower] := 1
    
    folderName := StrLower(GetFolderName(folder))
    
    if (folderName = "" || SKIP_FOLDERS.Has(folderName))
        return ""
    
    if (SubStr(folderName, 1, 1) = "." || SubStr(folderName, 1, 1) = "$")
        return ""
    
    if (currentDepth >= 2) {
        hasKeyword := false
        for keyword, _ in GAME_KEYWORDS {
            if InStr(folderName, keyword) {
                hasKeyword := true
                break
            }
        }
        if !hasKeyword
            return ""
    }
    
    if (folderName = "command and conquer generals zero hour") {
        innerPath := folder "\Command and Conquer Generals Zero Hour"
        if IsValidGameFolder(innerPath)
            return innerPath
        if IsValidGameFolder(folder)
            return folder
    }
    
    if (folderName = "command and conquer - generals") {
        innerPath := folder "\Command and Conquer Generals Zero Hour"
        if IsValidGameFolder(innerPath)
            return innerPath
    }
    
    if (folderName = "command & conquer generals - zero hour") {
        if IsValidGameFolder(folder)
            return folder
    }
    
    try {
        Loop Files, folder "\*", "D" {
            entryName := StrLower(A_LoopFileName)
            
            if SKIP_FOLDERS.Has(entryName)
                continue
            
            if (SubStr(entryName, 1, 1) = "." || SubStr(entryName, 1, 1) = "$")
                continue
            
            result := SearchInFolder(A_LoopFileFullPath, currentDepth + 1, maxDepth, visitedFolders)
            if (result != "")
                return result
        }
    }
    
    return ""
}

SearchGame() {
    global GamePath
    
    path := SearchGameInRegistry()
    if (path != "") {
        GamePath := path
        SaveConfig()
        return true
    }
    
    path := SearchGameInSteam()
    if (path != "") {
        GamePath := path
        SaveConfig()
        return true
    }
    
    path := SearchGameInCommonPaths()
    if (path != "") {
        GamePath := path
        SaveConfig()
        return true
    }
    
    path := SearchGameDeep(3)
    if (path != "") {
        GamePath := path
        SaveConfig()
        return true
    }
    
    return false
}

; ══════════════════════════════════════════════════════════════════════════════
;                              GenTool Functions
; ══════════════════════════════════════════════════════════════════════════════

IsGenToolEnabled() {
    global GamePath
    return (GamePath != "" && FileExist(GamePath "\d3d8.dll"))
}

EnableGenToolSilent() {
    global GamePath
    
    if (GamePath = "")
        return false
    
    active := GamePath "\d3d8.dll"
    disabled := GamePath "\d3d8-.dll"
    
    if FileExist(active)
        return true
    
    if FileExist(disabled) {
        try {
            FileMove(disabled, active, 1)
            return true
        }
    }
    
    return false
}

DisableGenToolSilent() {
    global GamePath
    
    if (GamePath = "")
        return
    
    active := GamePath "\d3d8.dll"
    disabled := GamePath "\d3d8-.dll"
    
    if FileExist(active) {
        try {
            if FileExist(disabled)
                FileDelete(disabled)
            FileMove(active, disabled, 1)
        }
    }
}

EnableGenTool() {
    global GamePath
    
    if (GamePath = "") {
        ShowNotification(Tr("msg_select_path_first"), "warning")
        return false
    }
    
    if EnableGenToolSilent() {
        ShowNotification(Tr("msg_enabled"), "success")
        UpdateStatus()
        return true
    }
    
    result := MsgBox(Tr("msg_gentool_needed"), APP_NAME, "YesNo Icon?")
    if (result = "Yes")
        return DownloadGenTool()
    
    return false
}

DisableGenTool() {
    global GamePath
    DisableGenToolSilent()
    ShowNotification(Tr("msg_disabled"), "success")
    UpdateStatus()
}

DownloadGenTool() {
    global GamePath, URL_GENTOOL
    
    if (GamePath = "")
        return false
    
    zipFile := A_Temp "\GenTool.zip"
    
    try {
        ToolTip(Tr("msg_downloading"))
        Download(URL_GENTOOL, zipFile)
        ExtractZip(zipFile, GamePath)
        if FileExist(zipFile)
            FileDelete(zipFile)
        ToolTip()
        ShowNotification(Tr("msg_download_done"), "success")
        UpdateStatus()
        return true
    } catch {
        ToolTip()
        return false
    }
}

; ══════════════════════════════════════════════════════════════════════════════
;                              DXWrapper Functions
; ══════════════════════════════════════════════════════════════════════════════

IsDXWrapperEnabled() {
    global GamePath
    return (GamePath != "" && FileExist(GamePath "\dxwrapper.dll"))
}

EnableDXWrapper() {
    global GamePath
    
    if (GamePath = "") {
        ShowNotification(Tr("msg_select_path_first"), "warning")
        return false
    }
    
    active := GamePath "\dxwrapper.dll"
    disabled := GamePath "\dxwrapper-.dll"
    
    if FileExist(active) {
        ShowNotification(Tr("msg_enabled"), "success")
        return true
    }
    
    if FileExist(disabled) {
        try {
            FileMove(disabled, active, 1)
            ShowNotification(Tr("msg_enabled"), "success")
            UpdateStatus()
            return true
        }
    }
    
    ShowDXWrapperDialog()
    return true
}

DisableDXWrapper() {
    global GamePath
    
    if (GamePath = "")
        return
    
    active := GamePath "\dxwrapper.dll"
    disabled := GamePath "\dxwrapper-.dll"
    
    if FileExist(active) {
        try {
            if FileExist(disabled)
                FileDelete(disabled)
            FileMove(active, disabled, 1)
        }
    }
    
    ShowNotification(Tr("msg_disabled"), "success")
    UpdateStatus()
}

ShowDXWrapperDialog() {
    dxGui := Gui("+AlwaysOnTop -MinimizeBox -MaximizeBox +Owner", "DXWrapper")
    dxGui.BackColor := GetTheme("bg_primary")
    dxGui.MarginX := 0
    dxGui.MarginY := 0
    
    ; Header
    dxGui.AddText("x0 y0 w380 h50 Background" . GetTheme("bg_header"))
    dxGui.SetFont("s16 Bold c" . GetTheme("accent"), "Segoe UI")
    dxGui.AddText("x20 y12 w340 BackgroundTrans", "🎨 DXWrapper")
    
    ; Warning
    dxGui.AddText("x0 y50 w380 h40 Background" . GetTheme("bg_tertiary"))
    dxGui.SetFont("s9 c" . GetTheme("warning"), "Segoe UI")
    dxGui.AddText("x20 y60 w340 BackgroundTrans Center", Tr("msg_dxwrapper_note"))
    
    ; Buttons Container
    dxGui.AddText("x0 y90 w380 h140 Background" . GetTheme("bg_secondary"))
    
    dxGui.SetFont("s11 Bold c" . GetTheme("text_button"), "Segoe UI")
    
    ; GPU Button
    btnGPU := dxGui.AddButton("x20 y105 w340 h50", Tr("btn_dx_gpu"))
    btnGPU.OnEvent("Click", (*) => (dxGui.Destroy(), DownloadDXWrapper("gpu")))
    
    ; Reduce Button
    btnReduce := dxGui.AddButton("x20 y+10 w340 h50", Tr("btn_dx_reduce"))
    btnReduce.OnEvent("Click", (*) => (dxGui.Destroy(), DownloadDXWrapper("reduce")))
    
    ; Footer
    dxGui.AddText("x0 y230 w380 h45 Background" . GetTheme("bg_tertiary"))
    dxGui.SetFont("s10 c" . GetTheme("text_muted"), "Segoe UI")
    btnCancel := dxGui.AddButton("x20 y238 w340 h30", Tr("btn_cancel"))
    btnCancel.OnEvent("Click", (*) => dxGui.Destroy())
    
    dxGui.Show("w380 h275")
}

DownloadDXWrapper(dxType := "gpu") {
    global GamePath, URL_DXWRAPPER_GPU, URL_DXWRAPPER_REDUCE
    
    if (GamePath = "")
        return false
    
    downloadUrl := (dxType = "gpu") ? URL_DXWRAPPER_GPU : URL_DXWRAPPER_REDUCE
    zipFile := A_Temp "\dxwrapper.zip"
    
    try {
        ToolTip(Tr("msg_downloading"))
        Download(downloadUrl, zipFile)
        ExtractZip(zipFile, GamePath)
        if FileExist(zipFile)
            FileDelete(zipFile)
        ToolTip()
        ShowNotification(Tr("msg_download_done"), "success")
        UpdateStatus()
        return true
    } catch {
        ToolTip()
        return false
    }
}

; ══════════════════════════════════════════════════════════════════════════════
;                    ⚡ Launch Game
; ══════════════════════════════════════════════════════════════════════════════

RunGeneralsOnline() {
    global GamePath
    
    exePath := GamePath "\GeneralsOnlineZH.exe"
    
    if !FileExist(exePath) {
        ShowNotification(GamePath = "" ? Tr("msg_select_path_first") : Tr("msg_online_not_found"), "warning")
        return
    }
    
    DisableGenToolSilent()
    Run(exePath, GamePath)
    ExitApp()
}

RunGeneralsWindowed() {
    global GamePath
    
    exePath := GamePath "\Generals.exe"
    
    if !FileExist(exePath) {
        ShowNotification(Tr("msg_select_path_first"), "warning")
        return
    }
    
    if !EnableGenToolSilent() {
        if MsgBox(Tr("msg_gentool_needed"), APP_NAME, "YesNo Icon?") = "Yes" {
            if !DownloadGenTool()
                return
        } else {
            return
        }
    }
    
    edgeScroller := GamePath "\EdgeScroller.exe"
    if FileExist(edgeScroller) {
        if !ProcessExist("EdgeScroller.exe")
            Run(edgeScroller, GamePath)
    }
    
    Run('"' . exePath . '" -win', GamePath)
    ExitApp()
}

OpenGameFolder() {
    global GamePath
    
    if (GamePath = "") {
        ShowNotification(Tr("msg_select_path_first"), "warning")
        return
    }
    
    Run("explorer.exe " . GamePath)
}

; ══════════════════════════════════════════════════════════════════════════════
;                         🎨 Enhanced Graphical User Interface
; ══════════════════════════════════════════════════════════════════════════════

CreateMainGui() {
    global MainGui, GamePath, CurrentLang, CurrentTheme, APP_NAME, APP_VERSION
    
    ; Create the window
    MainGui := Gui("-MaximizeBox +MinimizeBox", APP_NAME)
    MainGui.BackColor := GetTheme("bg_primary")
    MainGui.MarginX := 0
    MainGui.MarginY := 0
    
    ; Menu bar
    myMenuBar := CreateMenuBar()
    MainGui.MenuBar := myMenuBar
    
    ; ═══════════════════════════════════════════════════════════════════════
    ; Header Section - Main Title
    ; ═══════════════════════════════════════════════════════════════════════
    
    MainGui.AddText("x0 y0 w560 h90 Background" . GetTheme("bg_header"))
    
    ; Game icon
    MainGui.SetFont("s40", "Segoe UI")
    MainGui.AddText("x20 y15 w60 c" . GetTheme("accent") . " BackgroundTrans", "🎮")
    
    ; Title
    MainGui.SetFont("s22 Bold c" . GetTheme("text_primary"), "Segoe UI")
    MainGui.AddText("x85 y18 w450 BackgroundTrans", Tr("app_title"))
    
    ; Subtitle and version
    MainGui.SetFont("s10 c" . GetTheme("text_muted"), "Segoe UI")
    MainGui.AddText("x85 y52 w450 BackgroundTrans", Tr("app_subtitle") . "  •  v" . APP_VERSION)
    
    ; ═══════════════════════════════════════════════════════════════════════
    ; Status Section - Path Status
    ; ═══════════════════════════════════════════════════════════════════════
    
    MainGui.AddText("x15 y100 w530 h60 Background" . GetTheme("bg_card"))
    
    ; Path
    MainGui.SetFont("s9 c" . GetTheme("accent"), "Consolas")
    pathText := MainGui.AddText("x25 y112 w510 h20 vStatusPath BackgroundTrans", GetStatusText())
    pathText.OnEvent("Click", (*) => MenuSelectPath())
    
    ; Tools status
    MainGui.SetFont("s10 c" . GetTheme("text_secondary"), "Segoe UI")
    MainGui.AddText("x25 y134 w510 h20 vStatusTools BackgroundTrans Center", GetToolsStatus())
    
    ; ═══════════════════════════════════════════════════════════════════════
    ; Launch Section - Launch Buttons
    ; ═══════════════════════════════════════════════════════════════════════
    
    ; Section title
    MainGui.SetFont("s11 Bold c" . GetTheme("text_muted"), "Segoe UI")
    MainGui.AddText("x20 y172 w200 BackgroundTrans", Tr("section_launch"))
    
    ; Separator line
    MainGui.AddText("x20 y195 w520 h1 Background" . GetTheme("border"))
    
    ; Online button
    MainGui.SetFont("s14 Bold c" . GetTheme("text_button"), "Segoe UI")
    btnOnline := MainGui.AddButton("x15 y205 w530 h55", Tr("btn_online"))
    btnOnline.OnEvent("Click", (*) => RunGeneralsOnline())
    SetButtonColor(btnOnline, GetTheme("bg_button"))
    
    ; Windowed button
    btnWindowed := MainGui.AddButton("x15 y+8 w530 h55", Tr("btn_windowed"))
    btnWindowed.OnEvent("Click", (*) => RunGeneralsWindowed())
    SetButtonColor(btnWindowed, GetTheme("bg_button_secondary"))
    
    ; ═══════════════════════════════════════════════════════════════════════
    ; Tools Section - Tool Buttons
    ; ═══════════════════════════════════════════════════════════════════════
    
    ; Section title
    MainGui.SetFont("s11 Bold c" . GetTheme("text_muted"), "Segoe UI")
    MainGui.AddText("x20 y335 w200 BackgroundTrans", Tr("section_tools"))
    
    ; Separator line
    MainGui.AddText("x20 y358 w520 h1 Background" . GetTheme("border"))
    
    ; Tool buttons
    MainGui.SetFont("s11 Bold c" . GetTheme("text_primary"), "Segoe UI")
    
    btnGenTool := MainGui.AddButton("x15 y368 w172 h48", Tr("btn_gentool"))
    btnGenTool.OnEvent("Click", (*) => ShowGenToolMenu())
    
    btnDXWrapper := MainGui.AddButton("x+8 yp w172 h48", Tr("btn_dxwrapper"))
    btnDXWrapper.OnEvent("Click", (*) => ShowDXWrapperMenu())
    
    btnFolder := MainGui.AddButton("x+8 yp w172 h48", Tr("btn_open_folder"))
    btnFolder.OnEvent("Click", (*) => OpenGameFolder())
    
    ; ═══════════════════════════════════════════════════════════════════════
    ; Footer Section
    ; ═══════════════════════════════════════════════════════════════════════
    
    MainGui.AddText("x0 y430 w560 h1 Background" . GetTheme("border"))
    
    MainGui.AddText("x0 y431 w560 h35 Background" . GetTheme("bg_secondary"))
    
    MainGui.SetFont("s9 c" . GetTheme("text_muted"), "Segoe UI")
    MainGui.AddText("x15 y440 w530 Center BackgroundTrans", "Made with ❤️ by " . DEVELOPER . "  •  " . DISCORD_USERNAME)
    
    ; ═══════════════════════════════════════════════════════════════════════
    
    MainGui.OnEvent("Close", (*) => ExitApp())
    MainGui.Show("w560 h466")
}

; Function to color buttons (limited in AHK v2)
SetButtonColor(btn, color) {
    ; Note: AHK v2 does not fully support direct button coloring
    ; External libraries can be used for this
}

CreateMenuBar() {
    global CurrentLang, CurrentTheme
    
    myMenuBar := MenuBar()
    
    ; File
    fileMenu := Menu()
    fileMenu.Add(Tr("menu_search"), (*) => MenuSearchGame())
    fileMenu.Add(Tr("menu_select"), (*) => MenuSelectPath())
    fileMenu.Add(Tr("menu_open_folder"), (*) => OpenGameFolder())
    fileMenu.Add()
    fileMenu.Add(Tr("menu_exit"), (*) => ExitApp())
    myMenuBar.Add(Tr("menu_file"), fileMenu)
    
    ; Tools
    toolsMenu := Menu()
    
    genToolMenu := Menu()
    genToolMenu.Add(Tr("menu_enable_gentool"), (*) => (EnableGenTool(), UpdateStatus()))
    genToolMenu.Add(Tr("menu_disable_gentool"), (*) => (DisableGenTool(), UpdateStatus()))
    genToolMenu.Add()
    genToolMenu.Add(Tr("menu_download_gentool"), (*) => DownloadGenTool())
    toolsMenu.Add("🔧 GenTool", genToolMenu)
    
    dxMenu := Menu()
    dxMenu.Add(Tr("menu_enable_dx"), (*) => (EnableDXWrapper(), UpdateStatus()))
    dxMenu.Add(Tr("menu_disable_dx"), (*) => (DisableDXWrapper(), UpdateStatus()))
    dxMenu.Add()
    dxMenu.Add(Tr("menu_download_dx_gpu"), (*) => DownloadDXWrapper("gpu"))
    dxMenu.Add(Tr("menu_download_dx_reduce"), (*) => DownloadDXWrapper("reduce"))
    toolsMenu.Add("🎨 DXWrapper", dxMenu)
    
    myMenuBar.Add(Tr("menu_tools"), toolsMenu)
    
    ; Settings
    settingsMenu := Menu()
    
    themeMenu := Menu()
    themeMenu.Add(Tr("menu_theme_auto") . (CurrentTheme = "auto" ? " ●" : ""), (*) => ChangeTheme("auto"))
    themeMenu.Add(Tr("menu_theme_dark") . (CurrentTheme = "dark" ? " ●" : ""), (*) => ChangeTheme("dark"))
    themeMenu.Add(Tr("menu_theme_light") . (CurrentTheme = "light" ? " ●" : ""), (*) => ChangeTheme("light"))
    settingsMenu.Add(Tr("menu_theme"), themeMenu)
    
    myMenuBar.Add(Tr("menu_settings"), settingsMenu)
    
    ; Language
    if (CurrentLang = "ar")
        myMenuBar.Add("🌐 English", (*) => ChangeLanguage("en"))
    else
        myMenuBar.Add("🌐 عربي", (*) => ChangeLanguage("ar"))
    
    ; About
    myMenuBar.Add("ℹ️", (*) => ShowAboutDialog())
    
    return myMenuBar
}

ShowAboutDialog() {
    global DISCORD_USERNAME, DISCORD_SUPPORT, APP_NAME, APP_VERSION, DEVELOPER
    
    aboutGui := Gui("+AlwaysOnTop -MinimizeBox -MaximizeBox +Owner", Tr("about_title"))
    aboutGui.BackColor := GetTheme("bg_primary")
    aboutGui.MarginX := 0
    aboutGui.MarginY := 0
    
    ; Header
    aboutGui.AddText("x0 y0 w400 h80 Background" . GetTheme("bg_header"))
    
    aboutGui.SetFont("s44", "Segoe UI")
    aboutGui.AddText("x0 y15 w400 Center c" . GetTheme("accent") . " BackgroundTrans", "🎮")
    
    ; App Info
    aboutGui.AddText("x0 y80 w400 h100 Background" . GetTheme("bg_secondary"))
    
    aboutGui.SetFont("s16 Bold c" . GetTheme("text_primary"), "Segoe UI")
    aboutGui.AddText("x0 y90 w400 Center BackgroundTrans", APP_NAME)
    
    aboutGui.SetFont("s11 c" . GetTheme("text_secondary"), "Segoe UI")
    aboutGui.AddText("x0 y118 w400 Center BackgroundTrans", Tr("about_version") . ": " . APP_VERSION)
    
    aboutGui.SetFont("s10 c" . GetTheme("text_muted"), "Segoe UI")
    aboutGui.AddText("x0 y145 w400 Center BackgroundTrans", Tr("about_developer") . ": " . DEVELOPER)
    
    ; Discord Section
    aboutGui.AddText("x0 y180 w400 h70 Background" . GetTheme("bg_card"))
    
    aboutGui.SetFont("s10 c" . GetTheme("text_primary"), "Segoe UI")
    aboutGui.AddText("x20 y195 w260 BackgroundTrans", "Discord: " . DISCORD_USERNAME)
    
    aboutGui.SetFont("s9 Bold", "Segoe UI")
    btnCopy := aboutGui.AddButton("x290 y192 w90 h28", Tr("btn_copy"))
    btnCopy.OnEvent("Click", (*) => (A_Clipboard := DISCORD_USERNAME, ShowNotification(Tr("msg_copied"))))
    
    ; Support Button
    aboutGui.SetFont("s10 Bold c" . GetTheme("text_button"), "Segoe UI")
    btnSupport := aboutGui.AddButton("x20 y260 w360 h40", Tr("btn_open_support"))
    btnSupport.OnEvent("Click", (*) => Run(DISCORD_SUPPORT))
    
    ; Close Button
    aboutGui.SetFont("s10 c" . GetTheme("text_muted"), "Segoe UI")
    btnClose := aboutGui.AddButton("x20 y310 w360 h35", Tr("btn_close"))
    btnClose.OnEvent("Click", (*) => aboutGui.Destroy())
    
    aboutGui.Show("w400 h360")
}

; ══════════════════════════════════════════════════════════════════════════════
;                              Helper Functions
; ══════════════════════════════════════════════════════════════════════════════

GetStatusText() {
    global GamePath
    if (GamePath = "")
        return Tr("status_no_path")
    
    displayPath := GamePath
    if (StrLen(displayPath) > 65)
        displayPath := "..." . SubStr(displayPath, -62)
    
    return "📂 " . displayPath
}

GetToolsStatus() {
    global GamePath
    
    if (GamePath = "")
        return ""
    
    gen := IsGenToolEnabled() ? Tr("status_gentool_on") : Tr("status_gentool_off")
    dx := IsDXWrapperEnabled() ? Tr("status_dx_on") : Tr("status_dx_off")
    
    return gen . "   •   " . dx . "   •   " . Tr("status_ready")
}

UpdateStatus() {
    global MainGui
    try {
        MainGui["StatusPath"].Text := GetStatusText()
        MainGui["StatusTools"].Text := GetToolsStatus()
    }
}

ShowGenToolMenu() {
    m := Menu()
    m.Add(Tr("menu_enable_gentool"), (*) => (EnableGenTool(), UpdateStatus()))
    m.Add(Tr("menu_disable_gentool"), (*) => (DisableGenTool(), UpdateStatus()))
    m.Add()
    m.Add(Tr("menu_download_gentool"), (*) => DownloadGenTool())
    m.Show()
}

ShowDXWrapperMenu() {
    m := Menu()
    m.Add(Tr("menu_enable_dx"), (*) => (EnableDXWrapper(), UpdateStatus()))
    m.Add(Tr("menu_disable_dx"), (*) => (DisableDXWrapper(), UpdateStatus()))
    m.Add()
    m.Add(Tr("menu_download_dx_gpu"), (*) => DownloadDXWrapper("gpu"))
    m.Add(Tr("menu_download_dx_reduce"), (*) => DownloadDXWrapper("reduce"))
    m.Show()
}

MenuSearchGame() {
    global GamePath
    
    ToolTip(Tr("msg_searching"))
    
    if SearchGame() {
        ToolTip()
        ShowNotification(Tr("msg_found"), "success")
        UpdateStatus()
    } else {
        ToolTip()
        result := MsgBox(Tr("msg_not_found") . "`n`n" . Tr("msg_select_folder") . "?", APP_NAME, "YesNo Icon?")
        if (result = "Yes")
            MenuSelectPath()
    }
}

MenuSelectPath() {
    global GamePath
    
    folder := DirSelect("*" (GamePath != "" ? GamePath : A_ProgramFiles), 3, Tr("msg_select_folder"))
    
    if (folder != "") {
        if IsValidGameFolder(folder) {
            GamePath := folder
            SaveConfig()
            UpdateStatus()
            ShowNotification(Tr("msg_found"), "success")
        } else {
            MsgBox(Tr("msg_invalid_folder"), Tr("msg_error"), "Icon!")
        }
    }
}

ChangeLanguage(lang) {
    global CurrentLang, MainGui
    CurrentLang := lang
    SaveConfig()
    RefreshThemeCache()
    MainGui.Destroy()
    CreateMainGui()
}

ChangeTheme(theme) {
    global CurrentTheme, MainGui
    CurrentTheme := theme
    SaveConfig()
    RefreshThemeCache()
    MainGui.Destroy()
    CreateMainGui()
}

; ══════════════════════════════════════════════════════════════════════════════
;                              Startup
; ══════════════════════════════════════════════════════════════════════════════

Main() {
    global GamePath, FirstRun
    
    LoadConfig()
    
    if (GamePath = "")
        SearchGame()
    
    CreateMainGui()
    
    if (GamePath = "")
        SetTimer(AskForPath, -500)
}

AskForPath() {
    result := MsgBox(Tr("msg_not_found") . "`n`n" . Tr("msg_select_folder") . "?", APP_NAME, "YesNo Icon?")
    if (result = "Yes")
        MenuSelectPath()
}

Main()