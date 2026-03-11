; ══════════════════════════════════════════════════════════════════════════════
; 🎮 C&C Generals Zero Hour Launcher
; ══════════════════════════════════════════════════════════════════════════════
; Version: 3.0.0
; Author: ReizanTech
; AutoHotkey Version: v2.0+
; Features: Professional UI, Fast Launch, Run as Admin, Optimized Search
; ══════════════════════════════════════════════════════════════════════════════

#Requires AutoHotkey v2.0
#SingleInstance Off

; ⚡ Speed up execution
SetControlDelay(-1)
SetWinDelay(-1)

; ══════════════════════════════════════════════════════════════════════════════
;                         ⭐ Smart Single Instance Wake-Up
; ══════════════════════════════════════════════════════════════════════════════

DetectHiddenWindows(true)
prevIds := WinGetList(A_ScriptFullPath " ahk_class AutoHotkey")
for id in prevIds {
    if (id != A_ScriptHwnd) {
        ; Send double-click message via custom Tray channel 0x404
        PostMessage(0x404, 0, 0x203,, "ahk_id " id)
        ExitApp()
    }
}
DetectHiddenWindows(false)

; ══════════════════════════════════════════════════════════════════════════════
;                         ⭐ Auto Run as Administrator
; ══════════════════════════════════════════════════════════════════════════════

if !A_IsAdmin {
    try {
        Run('*RunAs "' . A_ScriptFullPath . '"')
        ExitApp()
    } catch {
        MsgBox("تعذّر تشغيل البرنامج كمسؤول.`nجرب تشغيله يدوياً: كليك يمين ← تشغيل كمسؤول.", "خطأ", "Icon!")
        ExitApp()
    }
}

; Allow Standard User instances to send us the Wake-Up message (0x404)
DllCall("ChangeWindowMessageFilterEx", "Ptr", A_ScriptHwnd, "UInt", 0x404, "UInt", 1, "Ptr", 0)

; ══════════════════════════════════════════════════════════════════════════════
;                         ⭐ Application Settings
; ══════════════════════════════════════════════════════════════════════════════

APP_NAME := "C&C Generals Zero Hour Launcher"
APP_VERSION := "3.0.0"
DEVELOPER := "ReizanTech"
DISCORD_USERNAME := "reizanx"
DISCORD_SUPPORT := "https://discord.com/channels/925092720538689536/1279438595190558853"

URL_GENTOOL := "https://github.com/ReizanTech/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/download/GenTool_v8.9/GenTool_v8.9.zip"
URL_DXWRAPPER_GPU := "https://github.com/ReizanTech/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/download/dxwrapper_GPU/dxwrapper_GPU.Fix.Black.Screen.zip"
URL_DXWRAPPER_REDUCE := "https://github.com/ReizanTech/Additional-content-in-Command-Conquer-Generals-Zero-Hour/releases/download/dxwrapper_GPU/dxwrapper.to.reduce.settings.zip"

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

; 🎖️ Dark Theme — Military Tactical (from launcher_ultimate.html)
THEMES["dark"] := Map(
    ; Backgrounds
    "bg_primary", "0f1209",       ; --deep
    "bg_secondary", "141a0e",     ; --surface
    "bg_tertiary", "1b2314",      ; --raised
    "bg_header", "0b0d0a",        ; --ink
    "bg_card", "141a0e",          ; --surface
    "bg_hover", "232e18",         ; --edge
    
    ; Buttons
    "bg_button", "141a0e",        ; --surface (default button bg in HTML)
    "bg_button_hover", "1b2314",  ; --raised (hover button bg in HTML)
    "bg_button_secondary", "101209", 
    "bg_button_danger", "d03020", ; --red
    
    ; Primary Colors
    "accent", "a8d040",           ; --glow
    "accent_hover", "d4e8a0",     ; --bright
    "success", "a8d040",          ; --glow
    "warning", "e8a020",          ; --amber
    "error", "d03020",            ; --red
    "info", "8aaa60",             ; --body
    
    ; Text
    "text_primary", "b8d080",     ; --head
    "text_secondary", "8aaa60",   ; --body
    "text_muted", "5a7040",       ; --muted
    "text_link", "a8d040",        ; --glow
    "text_button", "d4e8a0",      ; --bright
    
    ; Borders
    "border", "232e18",           ; --edge
    "border_light", "2c3a1e",     ; --wire
    "border_accent", "a8d040",    ; --glow
    
    ; Effects
    "shadow", "000000",
    "gradient_start", "141a0e",
    "gradient_end", "0b0d0a"
)

; ☀️ Light Theme — Desert Command
THEMES["light"] := Map(
    ; Backgrounds — warm sand/khaki
    "bg_primary", "e8e0d0",
    "bg_secondary", "d8d0c0",
    "bg_tertiary", "c8c0b0",
    "bg_header", "ddd5c5",
    "bg_card", "e0d8c8",
    "bg_hover", "d0c8b8",
    "bg_button", "506830",
    "bg_button_hover", "607838",
    "bg_button_secondary", "b8b0a0",
    "bg_button_danger", "b02020",
    
    ; Primary Colors — army green
    "accent", "4a5a30",
    "accent_hover", "3a4a20",
    "success", "3a6a20",
    "warning", "b88010",
    "error", "b02020",
    "info", "4a5a30",
    
    ; Text — dark olive
    "text_primary", "1a2010",
    "text_secondary", "3a4830",
    "text_muted", "6a7860",
    "text_link", "4a5a30",
    "text_button", "f0f4e8",
    
    ; Borders — warm olive
    "border", "a0987a",
    "border_light", "c0b8a0",
    "border_accent", "4a5a30",
    
    ; Effects
    "shadow", "8a8070",
    "gradient_start", "d8d0c0",
    "gradient_end", "e8e0d0"
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
    "msg_removed", "تم الحذف",
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
    "section_tools", "🛠️ الأدوات",
    "title_online", "RUN GENERALS ONLINE",
    "sub_online", "لعب جماعي — عبر الإنترنت",
    "title_windowed", "RUN Generals Zero Hour Windowed",
    "sub_windowed", "مهمات محلية / اللعب الفردي",
    "lbl_launch", "عمليات التشغيل",
    "lbl_tools", "الأدوات الميدانية",
    "lbl_active_enh", "// الإضافات النشطة",
    "lbl_get_dx", "// تحميل Dxwrapper",
    "desc_gentool", "أداة تحسين اللعب",
    "desc_dxwrapper", "مكتبة تحسين الرسوميات",
    "lbl_ticker", "◈ عملية ساعة الصفر — جميع الوحدات مستعدة • مشغل اللعبة الإصدار",
    "btn_remove", "حذف",
    "btn_get", "↓ تحميل",
    "btn_enable", "تفعيل",
    "btn_disable", "تعطيل"
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
    "msg_removed", "Module removed",
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
    "section_tools", "🛠️ Tools",
    "title_online", "RUN GENERALS ONLINE",
    "sub_online", "MULTIPLAYER — ONLINE WARFARE",
    "title_windowed", "RUN Generals Zero Hour Windowed",
    "sub_windowed", "SKIRMISH / CAMPAIGN — LOCAL MISSION",
    "lbl_launch", "LAUNCH OPERATIONS",
    "lbl_tools", "FIELD TOOLS",
    "lbl_active_enh", "// ACTIVE ENHANCEMENTS",
    "lbl_get_dx", "// GET Dxwrapper",
    "desc_gentool", "Gameplay Optimization Tool",
    "desc_dxwrapper", "Graphics API wrapper",
    "lbl_ticker", "◈ OPERATION ZERO HOUR — ALL UNITS STAND BY • COMMAND & CONQUER GENERALS LAUNCHER v",
    "btn_remove", "REMOVE",
    "btn_get", "↓ GET",
    "btn_enable", "Enable",
    "btn_disable", "Disable"
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
    } catch {
        GamePath := ""
        CurrentLang := "ar"
        CurrentTheme := "auto"
        FirstRun := true
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
    duration := (type = "error") ? 4000 : (type = "warning") ? 3000 : 2500
    ToolTip(message)
    SetTimer(() => ToolTip(), -duration)
}

; ══════════════════════════════════════════════════════════════════════════════
;                              File Extraction
; ══════════════════════════════════════════════════════════════════════════════

ExtractZip(zipPath, destPath) {
    ; استخراج في مجلد مؤقت أولاً ثم نقل الملفات مباشرة لـ destPath
    tempExtract := A_Temp "\ZH_Extract_" . A_TickCount
    
    try {
        if !DirExist(destPath)
            DirCreate(destPath)
        if !DirExist(tempExtract)
            DirCreate(tempExtract)
            
        safeZip  := StrReplace(zipPath,     '"', '`"')
        safeTemp := StrReplace(tempExtract, '"', '`"')
        psScript := 'Expand-Archive -Path "' . safeZip . '" -DestinationPath "' . safeTemp . '" -Force'
        exitCode := RunWait('powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "' . psScript . '"',, "Hide")
        
        if (exitCode != 0) {
            try DirDelete(tempExtract, true)
            return false
        }
        
        ; تحديد مصدر الملفات — مباشر أم داخل مجلد فرعي؟
        sourceDir := tempExtract
        subDirs := []
        Loop Files, tempExtract "\*", "D"
            subDirs.Push(A_LoopFileFullPath)
        
        ; إذا يوجد مجلد فرعي واحد فقط ولا DLL مباشر → الملفات بداخله
        if (subDirs.Length = 1 && !FileExist(tempExtract "\*.dll"))
            sourceDir := subDirs[1]
        
        ; نسخ كل الملفات مباشرةً إلى destPath
        Loop Files, sourceDir "\*.*", "F" {
            try FileCopy(A_LoopFileFullPath, destPath "\" . A_LoopFileName, 1)
        }
        
        try DirDelete(tempExtract, true)  ; تنظيف
        return true
        
    } catch {
        try DirDelete(tempExtract, true)
        return false
    }
}

; ══════════════════════════════════════════════════════════════════════════════
;                    🔍 Enhanced Game Search
; ══════════════════════════════════════════════════════════════════════════════

GetDrives() {
    drives := []
    for letter in ["C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] {
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
        foundSteam := false
        
        for drive in drives {
            if foundSteam
                break
            for folder in steamFolders {
                testPath := drive . folder
                if DirExist(testPath) {
                    steamPath := testPath
                    foundSteam := true
                    break
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

SearchGameDeep(maxDepth := 3, maxVisit := 2000) {
    global SKIP_FOLDERS, GAME_KEYWORDS
    
    drives := GetDrives()
    visitedFolders := Map()
    
    for drive in drives {
        result := SearchInFolder(drive, 0, maxDepth, maxVisit, visitedFolders)
        if (result != "")
            return result
    }
    
    return ""
}

SearchInFolder(folder, currentDepth, maxDepth, maxVisit, visitedFolders) {
    global SKIP_FOLDERS, GAME_KEYWORDS
    
    if (visitedFolders.Count >= maxVisit)
        return ""
    
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
            
            result := SearchInFolder(A_LoopFileFullPath, currentDepth + 1, maxDepth, maxVisit, visitedFolders)
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

DeleteGenTool() {
    global GamePath
    if (GamePath = "")
        return
    try {
        if FileExist(GamePath "\d3d8.dll")
            FileDelete(GamePath "\d3d8.dll")
        if FileExist(GamePath "\d3d8-.dll")
            FileDelete(GamePath "\d3d8-.dll")
    }
    ShowNotification(Tr("msg_removed"), "success")
    UpdateStatus()
}

; ══════════════════════════════════════════════════════════════════════════════
;                         📥 Download Progress Window
; ══════════════════════════════════════════════════════════════════════════════

ShowDownloadProgress(title) {
    global ProgressGui, ProgressBar, ProgressLabel
    
    ProgressGui := Gui("+AlwaysOnTop -MinimizeBox -MaximizeBox -SysMenu +Owner", title)
    ProgressGui.BackColor := GetTheme("bg_primary")
    ProgressGui.MarginX := 20
    ProgressGui.MarginY := 15
    
    ; Header
    ProgressGui.AddText("x0 y0 w360 h45 Background" . GetTheme("bg_header"))
    ProgressGui.SetFont("s12 Bold c" . GetTheme("text_primary"), "Segoe UI")
    ProgressGui.AddText("x15 y12 w330 BackgroundTrans", "📥 " . title)
    
    ; Label
    ProgressGui.SetFont("s9 c" . GetTheme("text_secondary"), "Segoe UI")
    ProgressLabel := ProgressGui.AddText("x15 y55 w330 vProgressLabel", Tr("msg_downloading"))
    
    ; ProgressBar
    ProgressBar := ProgressGui.AddProgress("x15 y75 w330 h20 vProgressBar Range0-100 c" . GetTheme("accent"))
    if IsDarkTheme()
        ApplyDarkMode(ProgressBar.Hwnd)
    
    ; Percentage
    ProgressGui.SetFont("s9 c" . GetTheme("text_muted"), "Segoe UI")
    ProgressGui.AddText("x15 y100 w330 Center vProgressPct", "0%")
    
    ProgressGui.Show("w360 h125")
    
    if IsDarkTheme()
        ApplyDarkModeToWindow(ProgressGui.Hwnd)
    
    return ProgressGui
}

UpdateDownloadProgress(pct, label := "") {
    global ProgressGui, ProgressBar
    try {
        ProgressBar.Value := pct
        ProgressGui["ProgressPct"].Text := pct . "%"
        if (label != "")
            ProgressGui["ProgressLabel"].Text := label
    }
}

CloseDownloadProgress() {
    global ProgressGui
    try ProgressGui.Destroy()
}

DownloadGenTool() {
    global GamePath, URL_GENTOOL
    
    if (GamePath = "")
        return false
    
    zipFile := A_Temp "\GenTool.zip"
    pg := ShowDownloadProgress("GenTool v8.9")
    
    try {
        UpdateDownloadProgress(10, Tr("msg_downloading"))
        Download(URL_GENTOOL, zipFile)
        
        if (!FileExist(zipFile) || FileGetSize(zipFile) < 10240) {
            CloseDownloadProgress()
            ShowNotification("❌ " . Tr("msg_error") . " — Download failed", "error")
            return false
        }
        
        UpdateDownloadProgress(70, "📦 Extracting...")
        if !ExtractZip(zipFile, GamePath) {
            CloseDownloadProgress()
            ShowNotification("❌ " . Tr("msg_error") . " — Extraction failed", "error")
            return false
        }
        UpdateDownloadProgress(95, "🧹 Cleaning up...")
        if FileExist(zipFile)
            FileDelete(zipFile)
        UpdateDownloadProgress(100, Tr("msg_download_done"))
        Sleep(600)
        CloseDownloadProgress()
        ShowNotification(Tr("msg_download_done"), "success")
        UpdateStatus()
        return true
    } catch {
        CloseDownloadProgress()
        ShowNotification(Tr("msg_error"), "error")
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
    
    if !FileExist(active) {
        ShowNotification(Tr("msg_disabled"), "success")
        return
    }
    
    try {
        if FileExist(disabled)
            FileDelete(disabled)
        FileMove(active, disabled, 1)
    }
    
    ShowNotification(Tr("msg_disabled"), "success")
    UpdateStatus()
}

DeleteDXWrapper() {
    global GamePath
    if (GamePath = "")
        return
    try {
        if FileExist(GamePath "\dxwrapper.dll")
            FileDelete(GamePath "\dxwrapper.dll")
        if FileExist(GamePath "\dxwrapper-.dll")
            FileDelete(GamePath "\dxwrapper-.dll")
        if FileExist(GamePath "\dxwrapper.ini")
            FileDelete(GamePath "\dxwrapper.ini")
        if FileExist(GamePath "\dxwrapper-.ini")
            FileDelete(GamePath "\dxwrapper-.ini")
        ; Any additional files the user mentions can be added here later
    }
    ShowNotification(Tr("msg_removed"), "success")
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
    
    ; GPU Button — green
    btnGPU := dxGui.AddButton("x20 y105 w340 h50", Tr("btn_dx_gpu"))
    btnGPU.OnEvent("Click", (*) => (dxGui.Destroy(), DownloadDXWrapper("gpu")))
    SetButtonColor(btnGPU, GetTheme("bg_button"), GetTheme("text_button"))
    if IsDarkTheme()
        ApplyDarkMode(btnGPU.Hwnd)
    
    ; Reduce Button — secondary
    btnReduce := dxGui.AddButton("x20 y+10 w340 h50", Tr("btn_dx_reduce"))
    btnReduce.OnEvent("Click", (*) => (dxGui.Destroy(), DownloadDXWrapper("reduce")))
    SetButtonColor(btnReduce, GetTheme("bg_button_secondary"), GetTheme("text_primary"))
    if IsDarkTheme()
        ApplyDarkMode(btnReduce.Hwnd)
    
    ; Footer
    dxGui.AddText("x0 y230 w380 h45 Background" . GetTheme("bg_tertiary"))
    dxGui.SetFont("s10 c" . GetTheme("text_muted"), "Segoe UI")
    btnCancel := dxGui.AddButton("x20 y238 w340 h30", Tr("btn_cancel"))
    btnCancel.OnEvent("Click", (*) => dxGui.Destroy())
    SetButtonColor(btnCancel, GetTheme("bg_tertiary"), GetTheme("text_muted"))
    if IsDarkTheme()
        ApplyDarkMode(btnCancel.Hwnd)
    
    dxGui.Show("w380 h275")
    
    ; Dark Mode on the dialog window
    if IsDarkTheme()
        ApplyDarkModeToWindow(dxGui.Hwnd)
}

DownloadDXWrapper(dxType := "gpu") {
    global GamePath, URL_DXWRAPPER_GPU, URL_DXWRAPPER_REDUCE
    
    if (GamePath = "")
        return false
    
    downloadUrl := (dxType = "gpu") ? URL_DXWRAPPER_GPU : URL_DXWRAPPER_REDUCE
    zipFile := A_Temp "\dxwrapper.zip"
    title := (dxType = "gpu") ? "DXWrapper — GPU Fix" : "DXWrapper — Reduce Settings"
    pg := ShowDownloadProgress(title)
    
    try {
        UpdateDownloadProgress(10, Tr("msg_downloading"))
        Download(downloadUrl, zipFile)
        
        if (!FileExist(zipFile) || FileGetSize(zipFile) < 10240) {
            CloseDownloadProgress()
            ShowNotification("❌ " . Tr("msg_error") . " — Download failed", "error")
            return false
        }
        
        UpdateDownloadProgress(70, "📦 Extracting...")
        
        ; Before extracting, delete existing DLLs so they don't block
        if FileExist(GamePath "\dxwrapper.dll")
            FileDelete(GamePath "\dxwrapper.dll")
        if FileExist(GamePath "\dxwrapper-.dll")
            FileDelete(GamePath "\dxwrapper-.dll")
            
        if !ExtractZip(zipFile, GamePath) {
            CloseDownloadProgress()
            ShowNotification("❌ " . Tr("msg_error") . " — Extraction failed", "error")
            return false
        }
        
        UpdateDownloadProgress(95, "🧹 Cleaning up...")
        if FileExist(zipFile)
            FileDelete(zipFile)
            
        ; The extracted file might be named dxwrapper.dll or dxwrapper-.dll depending on the zip contents
        ; We force it to auto-enable by ensuring it's named dxwrapper.dll
        if FileExist(GamePath "\dxwrapper-.dll")
            FileMove(GamePath "\dxwrapper-.dll", GamePath "\dxwrapper.dll", 1)
            
        UpdateDownloadProgress(100, Tr("msg_download_done"))
        Sleep(600)
        CloseDownloadProgress()
        ShowNotification(Tr("msg_download_done"), "success")
        UpdateStatus()
        return true
    } catch {
        CloseDownloadProgress()
        ShowNotification(Tr("msg_error"), "error")
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
    try {
        Run(exePath, GamePath)
        ExitApp()
    } catch as e {
        ShowNotification("❌ Launch failed: " . e.Message, "error")
    }
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
            try Run(edgeScroller, GamePath)
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
    
    ; Menu bar removed to clean up UI
    
    ; ═══════════════════════════════════════════════════════════════════════
    ; Zone A: Top Status Strip (y: 0 - 25)
    ; ═══════════════════════════════════════════════════════════════════════
    MainGui.AddText("x0 y0 w680 h25 Background" . GetTheme("bg_header"))
    MainGui.AddText("x0 y25 w680 h1 Background" . GetTheme("border"))
    
    ; Left side status
    MainGui.SetFont("s9 c" . GetTheme("accent"), "Segoe UI")
    MainGui.AddText("x15 y4 w12 BackgroundTrans", "●")
    
    ; Menu and status items removed per user request

    ; ═══════════════════════════════════════════════════════════════════════
    ; Zone B: Cinematic Header (y: 0 - 94)
    ; ═══════════════════════════════════════════════════════════════════════
    MainGui.AddText("x0 y0 w680 h94 Background" . GetTheme("bg_secondary"))
    MainGui.AddText("x0 y94 w680 h1 Background" . GetTheme("border"))
    
    ; Emblem ring — Tactical Star
    MainGui.AddText("x26 y16 w60 h60 Background" . GetTheme("bg_primary"))
    MainGui.AddText("x26 y16 w60 h1 Background" . GetTheme("accent"))
    MainGui.AddText("x26 y75 w60 h1 Background" . GetTheme("accent"))
    MainGui.AddText("x26 y16 w1 h60 Background" . GetTheme("accent"))
    MainGui.AddText("x85 y16 w1 h60 Background" . GetTheme("accent"))
    MainGui.SetFont("s28 Bold", "Segoe UI")
    MainGui.AddText("x30 y22 w52 h52 c" . GetTheme("accent") . " BackgroundTrans Center", "⚔️")
    
    ; Title Block
    MainGui.SetFont("s8 Norm c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x105 y14 w300 BackgroundTrans", "COMMAND && CONQUER // OFFICIAL LAUNCHER")
    
    MainGui.SetFont("s26 Bold c" . GetTheme("text_primary"), "Impact")
    MainGui.AddText("x103 y28 w150 h40 BackgroundTrans", "GENERALS")
    MainGui.SetFont("s26 Bold c" . GetTheme("accent"), "Impact")
    MainGui.AddText("x260 y28 w180 h40 BackgroundTrans", "ZERO HOUR")
    
    MainGui.SetFont("s8 Bold c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x105 y73 w250 h15 BackgroundTrans", "WAR IS COMING. CHOOSE YOUR SIDE.")
    
    ; Badges
    MainGui.SetFont("s8 Bold c" . GetTheme("accent"), "Consolas")
    MainGui.AddText("x460 y71 w55 h18 Background" . GetTheme("bg_primary") . " +0x200 Border Center", "● READY")
    MainGui.AddText("x520 y71 w45 h18 Background" . GetTheme("bg_primary") . " +0x200 Border Center", "v" . APP_VERSION)
    
    ; Radar Side Widget removed per user request

    ; ═══════════════════════════════════════════════════════════════════════
    ; Zone C: Path Banner (y: 95 - 129)
    ; ═══════════════════════════════════════════════════════════════════════
    
    ; Path Banner
    MainGui.AddText("x0 y95 w680 h34 Background" . GetTheme("bg_header"))
    MainGui.AddText("x0 y129 w680 h1 Background" . GetTheme("border"))
    MainGui.AddText("x0 y95 w3 h34 Background" . GetTheme("warning")) ; left amber bar
    
    MainGui.SetFont("s9 Bold c" . GetTheme("warning"), "Consolas")
    MainGui.AddText("x20 y105 w100 BackgroundTrans", "⚠ GAME PATH //")
    
    MainGui.SetFont("s9 c" . GetTheme("warning"), "Consolas")
    pathText := MainGui.AddText("x130 y105 w440 h20 BackgroundTrans", GetStatusText())
    pathText.OnEvent("Click", (*) => MenuSelectPath())
    MainGui.AddText("x565 y105 w20 BackgroundTrans", "▸")

    ; Language Button
    MainGui.SetFont("s9 Bold c" . GetTheme("text_muted"), "Consolas")
    LangBtn := MainGui.AddText("x590 y105 w80 h20 BackgroundTrans", (CurrentLang = "ar" ? "🌐 English" : "🌐 عربي"))
    LangBtn.OnEvent("Click", (*) => ChangeLanguage(CurrentLang = "ar" ? "en" : "ar"))

    ; ═══════════════════════════════════════════════════════════════════════
    ; Zone D: Ticker (y: 181 - 205)
    ; ═══════════════════════════════════════════════════════════════════════
    MainGui.AddText("x0 y130 w680 h24 Background" . GetTheme("bg_header"))
    MainGui.AddText("x0 y154 w680 h1 Background" . GetTheme("border"))
    MainGui.SetFont("s8 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x20 y136 w640 h15 BackgroundTrans", Tr("lbl_ticker") . " " . APP_VERSION)

    ; ═══════════════════════════════════════════════════════════════════════
    ; Zone E: Main Body Grid (y: 206 - 570)
    ; ═══════════════════════════════════════════════════════════════════════
    
    ; Left Column Divider
    MainGui.AddText("x465 y155 w1 h364 Background" . GetTheme("border"))
    
    ; --- LEFT PANEL (Combat Operations) ---
    MainGui.SetFont("s9 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x20 y174 w150 BackgroundTrans", Tr("lbl_launch"))
    MainGui.AddText("x160 y180 w285 h1 Background" . GetTheme("border_light"))
    
    ; Online Button (Massive)
    btnOnline := MainGui.AddButton("x20 y204 w425 h85", "")
    btnOnline.OnEvent("Click", (*) => RunGeneralsOnline())
    SetButtonColor(btnOnline, GetTheme("bg_secondary"), GetTheme("text_button"), Map("title", Tr("title_online"), "subtitle", Tr("sub_online"), "icon", "🌐", "rightIcon", "▶", "tacticalLeftBar", true))
    if IsDarkTheme()
        ApplyDarkMode(btnOnline.Hwnd)
        
    ; Windowed Button (Massive)
    btnWindowed := MainGui.AddButton("x20 y299 w425 h85", "")
    btnWindowed.OnEvent("Click", (*) => RunGeneralsWindowed())
    SetButtonColor(btnWindowed, GetTheme("bg_secondary"), GetTheme("text_button"), Map("title", Tr("title_windowed"), "subtitle", Tr("sub_windowed"), "icon", "🖥️", "rightIcon", "▶", "tacticalLeftBar", true))
    if IsDarkTheme()
        ApplyDarkMode(btnWindowed.Hwnd)
        
    ; Tools Divider
    MainGui.SetFont("s9 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x20 y414 w120 BackgroundTrans", Tr("lbl_tools"))
    MainGui.AddText("x115 y420 w330 h1 Background" . GetTheme("border_light"))
    
    ; Tool Buttons
    btnGenTool := MainGui.AddButton("x20 y444 w135 h45", "")
    btnGenTool.OnEvent("Click", (*) => ShowGenToolMenu())
    SetButtonColor(btnGenTool, GetTheme("bg_secondary"), GetTheme("text_muted"), Map("isToolBtn", true, "icon", "🔧", "title", Tr("btn_gentool")))
    if IsDarkTheme()
        ApplyDarkMode(btnGenTool.Hwnd)
        
    btnDXWrapper := MainGui.AddButton("x165 y444 w135 h45", "")
    btnDXWrapper.OnEvent("Click", (*) => ShowDXWrapperMenu())
    SetButtonColor(btnDXWrapper, GetTheme("bg_secondary"), GetTheme("text_muted"), Map("isToolBtn", true, "icon", "🎨", "title", Tr("btn_dxwrapper")))
    if IsDarkTheme()
        ApplyDarkMode(btnDXWrapper.Hwnd)
        
    btnFolder := MainGui.AddButton("x310 y444 w135 h45", "")
    btnFolder.OnEvent("Click", (*) => OpenGameFolder())
    SetButtonColor(btnFolder, GetTheme("bg_secondary"), GetTheme("text_muted"), Map("isToolBtn", true, "icon", "📂", "title", Tr("btn_open_folder")))
    if IsDarkTheme()
        ApplyDarkMode(btnFolder.Hwnd)
        
    ; --- RIGHT PANEL (Modules) ---
    MainGui.AddText("x466 y155 w214 h364 Background" . GetTheme("bg_header")) ; Slightly darker bg for the right panel

    MainGui.SetFont("s9 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x480 y174 w180 BackgroundTrans", Tr("lbl_active_enh"))
    
    ; Module Card 1: GenTool
    genToolOn := IsGenToolEnabled()
    MainGui.AddText("x480 y199 w185 h105 Background" . GetTheme("bg_secondary"))
    MainGui.AddText("x480 y199 w185 h1 Background" . GetTheme("border"))
    MainGui.AddText("x480 y303 w185 h1 Background" . GetTheme("border"))
    MainGui.AddText("x480 y199 w1 h105 Background" . GetTheme("border"))
    MainGui.AddText("x664 y199 w1 h105 Background" . GetTheme("border"))
    MainGui.AddText("x480 y199 w2 h105 Background" . (genToolOn ? GetTheme("success") : GetTheme("text_muted")))
    
    MainGui.SetFont("s10 Bold c" . (genToolOn ? GetTheme("text_primary") : GetTheme("text_muted")), "Consolas")
    MainGui.AddText("x490 y209 w90 BackgroundTrans", "🔧 GENTOOL")
    
    ; Toggle Switch GenTool
    switchX := 630, switchY := 209, switchW := 28, switchH := 14
    if genToolOn {
        MainGui.SetFont("s14 c" . GetTheme("success"), "Arial")
        MainGui.AddText("x" . (switchX+14) . " y" . (switchY-4) . " w14 h18 BackgroundTrans", "●")
    } else {
        MainGui.SetFont("s14 c" . GetTheme("text_muted"), "Arial")
        MainGui.AddText("x" . (switchX+1) . " y" . (switchY-4) . " w14 h18 BackgroundTrans", "●")
    }
    btnToggleGenTool := MainGui.AddText("x" . switchX . " y" . switchY . " w" . switchW . " h" . switchH . " BackgroundTrans", "")
    btnToggleGenTool.OnEvent("Click", (*) => (genToolOn ? DisableGenTool() : EnableGenTool()))

    MainGui.SetFont("s8 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x490 y229 w160 BackgroundTrans", Tr("desc_gentool"))
    
    MainGui.SetFont("s12 c" . (genToolOn ? GetTheme("success") : GetTheme("text_muted")), "Arial")
    MainGui.AddText("x490 y241 w10 h15 BackgroundTrans", "•")
    MainGui.SetFont("s8 c" . (genToolOn ? GetTheme("success") : GetTheme("text_muted")), "Consolas")
    MainGui.AddText("x502 y245 w100 BackgroundTrans", genToolOn ? "LOADED" : "STANDBY")
    
    btnFixes := MainGui.AddButton("x486 y267 w55 h25", "")
    btnFixes.OnEvent("Click", (*) => (genToolOn ? DisableGenTool() : EnableGenTool()))
    SetButtonColor(btnFixes, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", genToolOn ? Tr("btn_disable") : Tr("btn_enable"), "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnFixes.Hwnd)
        
    btnKillGT := MainGui.AddButton("x546 y267 w50 h25", "")
    btnKillGT.OnEvent("Click", (*) => DeleteGenTool())
    SetButtonColor(btnKillGT, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", Tr("btn_remove"), "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnKillGT.Hwnd)
        
    btnMaps := MainGui.AddButton("x601 y267 w55 h25", "")
    btnMaps.OnEvent("Click", (*) => DownloadGenTool())
    SetButtonColor(btnMaps, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", Tr("btn_get"), "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnMaps.Hwnd)

    ; Module Card 2: DXWrapper
    dxOn := IsDXWrapperEnabled()

    ; Determine which DXWrapper is installed for dynamic status text
    dxDescText := Tr("desc_dxwrapper")
    dxStatusText := "STANDBY"
    
    ; Logic to check whether we have the GPU Fix or Reduce Settings
    ; Reduce Settings: dxwrapper.dll is ~8,104,960 bytes, ini is ~338 bytes
    ; GPU Fix: dxwrapper.dll is ~8,120,320 bytes, ini is ~121 bytes
    
    installedType := "UNKNOWN"
    if FileExist(GamePath . "\dxwrapper.dll") {
        try {
            if FileExist(GamePath . "\dxwrapper.ini") {
                iniSize := FileGetSize(GamePath . "\dxwrapper.ini")
                installedType := (iniSize > 200) ? "REDUCE" : "GPU"
            } else {
                dllSize := FileGetSize(GamePath . "\dxwrapper.dll")
                installedType := (dllSize < 8110000) ? "REDUCE" : "GPU"
            }
        } catch {
            installedType := "UNKNOWN"
        }
    } else if FileExist(GamePath . "\dxwrapper-.dll") {
        try {
            if FileExist(GamePath . "\dxwrapper.ini") {
                iniSize := FileGetSize(GamePath . "\dxwrapper.ini")
                installedType := (iniSize > 200) ? "REDUCE" : "GPU"
            } else {
                dllSize := FileGetSize(GamePath . "\dxwrapper-.dll")
                installedType := (dllSize < 8110000) ? "REDUCE" : "GPU"
            }
        } catch {
            installedType := "UNKNOWN"
        }
    }
    
    if (installedType = "REDUCE") {
        dxStatusText := dxOn ? "LOADED" : "STANDBY"
        dxDescText := "Reduce Settings"
    } else if (installedType = "GPU") {
        dxStatusText := dxOn ? "LOADED" : "STANDBY"
        dxDescText := "GPU Fix - Black Screen"
    } else if (installedType = "UNKNOWN" && (FileExist(GamePath . "\dxwrapper.dll") || FileExist(GamePath . "\dxwrapper-.dll"))) {
        dxStatusText := dxOn ? "LOADED" : "STANDBY"
    }
    
    
    MainGui.AddText("x480 y314 w185 h105 Background" . GetTheme("bg_secondary"))
    MainGui.AddText("x480 y314 w185 h1 Background" . GetTheme("border"))
    MainGui.AddText("x480 y418 w185 h1 Background" . GetTheme("border"))
    MainGui.AddText("x480 y314 w1 h105 Background" . GetTheme("border"))
    MainGui.AddText("x664 y314 w1 h105 Background" . GetTheme("border"))
    MainGui.AddText("x480 y314 w2 h105 Background" . (dxOn ? GetTheme("success") : GetTheme("text_muted")))
    
    MainGui.SetFont("s10 Bold c" . (dxOn ? GetTheme("text_primary") : GetTheme("text_muted")), "Consolas")
    MainGui.AddText("x490 y324 w90 BackgroundTrans", "🎨 Dxwrapper")
    switchX := 630 ; align DX toggle to the same X axis
    switchY2 := 324
    if dxOn {
        MainGui.SetFont("s14 c" . GetTheme("success"), "Arial")
        MainGui.AddText("x" . (switchX+14) . " y" . (switchY2-4) . " w14 h18 BackgroundTrans", "●")
    } else {
        MainGui.SetFont("s14 c" . GetTheme("text_muted"), "Arial")
        MainGui.AddText("x" . (switchX+1) . " y" . (switchY2-4) . " w14 h18 BackgroundTrans", "●")
    }
    btnToggleDX := MainGui.AddText("x" . switchX . " y" . switchY2 . " w" . switchW . " h" . switchH . " BackgroundTrans", "")
    btnToggleDX.OnEvent("Click", (*) => (dxOn ? DisableDXWrapper() : EnableDXWrapper()))

    MainGui.SetFont("s8 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x490 y344 w160 h15 BackgroundTrans", dxDescText)
    
    MainGui.SetFont("s12 c" . (dxOn ? GetTheme("success") : GetTheme("text_muted")), "Arial")
    MainGui.AddText("x490 y356 w10 h15 BackgroundTrans", "•")
    MainGui.SetFont("s8 c" . (dxOn ? GetTheme("success") : GetTheme("text_muted")), "Consolas")
    MainGui.AddText("x502 y360 w160 h15 BackgroundTrans", dxStatusText)
    
    btnDXE := MainGui.AddButton("x486 y382 w55 h25", "")
    btnDXE.OnEvent("Click", (*) => (dxOn ? DisableDXWrapper() : EnableDXWrapper()))
    SetButtonColor(btnDXE, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", dxOn ? Tr("btn_disable") : Tr("btn_enable"), "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnDXE.Hwnd)
        
    btnKillDX := MainGui.AddButton("x546 y382 w50 h25", "")
    btnKillDX.OnEvent("Click", (*) => DeleteDXWrapper())
    SetButtonColor(btnKillDX, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", Tr("btn_remove"), "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnKillDX.Hwnd)
        
    btnGetDX := MainGui.AddButton("x601 y382 w55 h25", "")
    btnGetDX.OnEvent("Click", (*) => ShowDXWrapperDialog())
    SetButtonColor(btnGetDX, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", Tr("btn_get"), "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnGetDX.Hwnd)

    ; Supply Drop
    MainGui.SetFont("s9 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x480 y429 w180 BackgroundTrans", Tr("lbl_get_dx"))
    
    btnBlackScreen := MainGui.AddButton("x480 y449 w185 h28", "")
    btnBlackScreen.OnEvent("Click", (*) => DownloadDXWrapper("gpu"))
    SetButtonColor(btnBlackScreen, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", "🎮 GPU Fix — Black Screen", "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnBlackScreen.Hwnd)
        
    btnPerfSets := MainGui.AddButton("x480 y481 w185 h28", "")
    btnPerfSets.OnEvent("Click", (*) => DownloadDXWrapper("reduce"))
    SetButtonColor(btnPerfSets, GetTheme("bg_tertiary"), GetTheme("text_muted"), Map("title", "⚡ Reduce Settings", "isSmall", true))
    if IsDarkTheme()
        ApplyDarkMode(btnPerfSets.Hwnd)

    ; ═══════════════════════════════════════════════════════════════════════
    ; Zone F: Status Footer (y: 571 - 620)
    ; ═══════════════════════════════════════════════════════════════════════
    
    MainGui.AddText("x0 y520 w680 h49 Background" . GetTheme("bg_header"))
    MainGui.AddText("x0 y520 w680 h1 Background" . GetTheme("border"))
    
    MainGui.SetFont("s10 c" . (genToolOn ? GetTheme("success") : GetTheme("text_muted")), "Arial")
    MainGui.AddText("x20 y535 w15 h20 BackgroundTrans", "●")
    MainGui.SetFont("s9 c" . (genToolOn ? GetTheme("success") : GetTheme("text_muted")), "Consolas")
    MainGui.AddText("x35 y537 w100 BackgroundTrans", "GENTOOL " . (genToolOn ? "✓" : "✗"))
    
    MainGui.SetFont("s10 c" . GetTheme("border"), "Arial")
    MainGui.AddText("x140 y536 w15 h20 BackgroundTrans", "|")
    
    MainGui.SetFont("s10 c" . (dxOn ? GetTheme("success") : GetTheme("text_muted")), "Arial")
    MainGui.AddText("x160 y535 w15 h20 BackgroundTrans", "●")
    MainGui.SetFont("s9 c" . (dxOn ? GetTheme("success") : GetTheme("text_muted")), "Consolas")
    MainGui.AddText("x175 y537 w100 BackgroundTrans", "DXWRAP " . (dxOn ? "✓" : "✗"))
    
    MainGui.SetFont("s10 c" . GetTheme("border"), "Arial")
    MainGui.AddText("x260 y536 w15 h20 BackgroundTrans", "|")
    
    MainGui.SetFont("s10 c" . GetTheme("success"), "Arial")
    MainGui.AddText("x280 y535 w15 h20 BackgroundTrans", "●")
    MainGui.SetFont("s9 c" . GetTheme("success"), "Consolas")
    MainGui.AddText("x295 y537 w100 BackgroundTrans", "READY")
    
    MainGui.SetFont("s9 c" . GetTheme("text_muted"), "Consolas")
    MainGui.AddText("x440 y537 w220 BackgroundTrans Right", "DISCORD: reizanx")
    
    ; ═══════════════════════════════════════════════════════════════════════
    
    MainGui.OnEvent("Close", (*) => MainGui.Hide())
    MainGui.Show("w680 h569")
    
    ; Apply Dark Mode to the window title bar
    if IsDarkTheme()
        ApplyDarkModeToWindow(MainGui.Hwnd)
}

; ══════════════════════════════════════════════════════════════════════════════
;                   Button Color System (BS_OWNERDRAW + WM_DRAWITEM)
; ══════════════════════════════════════════════════════════════════════════════

; Global map: HWND (integer) -> {brush, hoverBrush, bg, hoverBg, txt, border}
global ButtonColorMap := Map()
global ButtonColorHooked := false
global HoveredButtonHwnd := 0

; Register a button for Owner-Draw coloring
SetButtonColor(btn, bgColor, textColor := "ffffff", options := "") {
    global ButtonColorMap, ButtonColorHooked
    
    if (options = "")
        options := Map()
        
    bgRGB  := ColorHexToRGB(bgColor)
    txtRGB := ColorHexToRGB(textColor)
    hBrush := DllCall("CreateSolidBrush", "UInt", bgRGB, "Ptr")
    
    ; Calculate hover color (lighten by ~25)
    r := bgRGB & 0xFF
    g := (bgRGB >> 8) & 0xFF
    b := (bgRGB >> 16) & 0xFF
    hoverR := Min(r + 25, 255)
    hoverG := Min(g + 25, 255)
    hoverB := Min(b + 25, 255)
    hoverRGB := (hoverB << 16) | (hoverG << 8) | hoverR
    hoverBrush := DllCall("CreateSolidBrush", "UInt", hoverRGB, "Ptr")
    
    ; Border color (slightly lighter than hover)
    borderR := Min(r + 45, 255)
    borderG := Min(g + 45, 255)
    borderB := Min(b + 45, 255)
    borderRGB := (borderB << 16) | (borderG << 8) | borderR
    
    ; Store by HWND integer
    btnHwnd := btn.Hwnd
    ButtonColorMap[btnHwnd] := {
        brush: hBrush,
        hoverBrush: hoverBrush,
        bg: bgRGB,
        hoverBg: hoverRGB,
        txt: txtRGB,
        border: borderRGB,
        opts: options
    }
    
    ; Convert button to Owner-Draw style (BS_OWNERDRAW = 0xB)
    style := DllCall("GetWindowLong", "Ptr", btnHwnd, "Int", -16, "Int")
    newStyle := (style & ~0xF) | 0xB
    DllCall("SetWindowLong", "Ptr", btnHwnd, "Int", -16, "Int", newStyle)
    
    ; Force redraw
    DllCall("InvalidateRect", "Ptr", btnHwnd, "Ptr", 0, "Int", 1)
    
    ; Hook WM_DRAWITEM + start hover timer only once
    if !ButtonColorHooked {
        OnMessage(0x002B, HandleDrawItem)
        SetTimer(CheckButtonHover, 50)
        ButtonColorHooked := true
    }
}

; Timer to track mouse hover over buttons
CheckButtonHover() {
    global ButtonColorMap, HoveredButtonHwnd
    if (ButtonColorMap.Count = 0)
        return
    
    try {
        MouseGetPos(,, &winHwnd, &ctrlHwnd, 2)  ; 2 = return HWND
    } catch {
        return
    }
    
    newHover := 0
    if ButtonColorMap.Has(ctrlHwnd)
        newHover := ctrlHwnd
    
    if (newHover != HoveredButtonHwnd) {
        oldHover := HoveredButtonHwnd
        HoveredButtonHwnd := newHover
        if (oldHover)
            try DllCall("InvalidateRect", "Ptr", oldHover, "Ptr", 0, "Int", 1)
        if (newHover)
            try DllCall("InvalidateRect", "Ptr", newHover, "Ptr", 0, "Int", 1)
    }
}

; Global handler for WM_DRAWITEM (0x002B)
HandleDrawItem(wParam, lParam, msg, hwnd) {
    global ButtonColorMap, HoveredButtonHwnd
    
    ; Read DRAWITEMSTRUCT — offsets differ on 32/64-bit
    if (A_PtrSize = 8) {
        itemState := NumGet(lParam, 16, "UInt")
        hwndItem  := NumGet(lParam, 24, "Ptr")
        hDC       := NumGet(lParam, 32, "Ptr")
        rectOff   := 40
    } else {
        itemState := NumGet(lParam, 16, "UInt")
        hwndItem  := NumGet(lParam, 20, "Ptr")
        hDC       := NumGet(lParam, 24, "Ptr")
        rectOff   := 28
    }
    
    ; Only handle buttons we registered
    if !ButtonColorMap.Has(hwndItem)
        return
    
    info := ButtonColorMap[hwndItem]
    
    ; Determine state: pressed > hover > normal
    isPressed := (itemState & 0x0001)  ; ODS_SELECTED
    isHovered := (hwndItem = HoveredButtonHwnd)
    
    if isPressed {
        fillBrush := info.brush
    } else if isHovered {
        fillBrush := info.hoverBrush
    } else {
        fillBrush := info.brush
    }
    
    ; Read rcItem (RECT: left, top, right, bottom — each 4 bytes)
    left   := NumGet(lParam, rectOff,      "Int")
    top    := NumGet(lParam, rectOff + 4,   "Int")
    right  := NumGet(lParam, rectOff + 8,   "Int")
    bottom := NumGet(lParam, rectOff + 12,  "Int")
    
    ; 1. Fill background
    DllCall("FillRect", "Ptr", hDC, "Ptr", lParam + rectOff, "Ptr", fillBrush)
    
    ; 2. Draw subtle border
    hPen := DllCall("CreatePen", "Int", 0, "Int", 1, "UInt", info.border, "Ptr")
    oldPen := DllCall("SelectObject", "Ptr", hDC, "Ptr", hPen, "Ptr")
    
    ; Top
    DllCall("MoveToEx", "Ptr", hDC, "Int", left, "Int", top, "Ptr", 0)
    DllCall("LineTo",   "Ptr", hDC, "Int", right, "Int", top)
    ; Right
    DllCall("MoveToEx", "Ptr", hDC, "Int", right - 1, "Int", top, "Ptr", 0)
    DllCall("LineTo",   "Ptr", hDC, "Int", right - 1, "Int", bottom)
    ; Bottom
    DllCall("MoveToEx", "Ptr", hDC, "Int", left, "Int", bottom - 1, "Ptr", 0)
    DllCall("LineTo",   "Ptr", hDC, "Int", right, "Int", bottom - 1)
    ; Left
    DllCall("MoveToEx", "Ptr", hDC, "Int", left, "Int", top, "Ptr", 0)
    DllCall("LineTo",   "Ptr", hDC, "Int", left, "Int", bottom)
    
    DllCall("SelectObject", "Ptr", hDC, "Ptr", oldPen)
    DllCall("DeleteObject", "Ptr", hPen)
    
    ; 3. Draw text and icons
    DllCall("SetBkMode",    "Ptr", hDC, "Int", 1)  ; TRANSPARENT
    DllCall("SetTextColor",  "Ptr", hDC, "UInt", info.txt)
    
    ; Select Font
    hFont := DllCall("SendMessageW", "Ptr", hwndItem, "UInt", 0x31, "Ptr", 0, "Ptr", 0, "Ptr")  ; WM_GETFONT
    oldFont := 0
    if (hFont)
        oldFont := DllCall("SelectObject", "Ptr", hDC, "Ptr", hFont, "Ptr")
    
    opts := info.opts
    hasOpts := opts.Count > 0
    
    ; Create standard RECT
    rcText := Buffer(16)
    NumPut("Int", left + 2,  rcText, 0)
    NumPut("Int", top + 2,   rcText, 4)
    NumPut("Int", right - 2, rcText, 8)
    NumPut("Int", bottom - 2, rcText, 12)
    
    if (!hasOpts) {
        ; Standard single centered text
        textLen := DllCall("GetWindowTextLengthW", "Ptr", hwndItem, "Int")
        textBuf := Buffer((textLen + 1) * 2)
        DllCall("GetWindowTextW", "Ptr", hwndItem, "Ptr", textBuf, "Int", textLen + 1)
        DllCall("DrawTextW", "Ptr", hDC, "Ptr", textBuf, "Int", textLen, "Ptr", rcText, "UInt", 37) ; 37 = CENTER|VCENTER|SINGLELINE
    } else {
        ; Complex Layout
        btnWidth := right - left
        btnHeight := bottom - top
        
        isTool := opts.Has("isToolBtn") && opts["isToolBtn"]
        
        if (isTool) {
            ; Icon on top, title below
            if opts.Has("icon") {
                iconBuf := Buffer(StrPut(opts["icon"], "UTF-16"))
                StrPut(opts["icon"], iconBuf, "UTF-16")
                
                ; Adjust font size for tool icon
                hIconFont := DllCall("CreateFontW", "Int", 24, "Int", 0, "Int", 0, "Int", 0, "Int", 400, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 1, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0, "WStr", "Segoe UI", "Ptr")
                oldF := DllCall("SelectObject", "Ptr", hDC, "Ptr", hIconFont, "Ptr")
                
                rcIcon := Buffer(16)
                NumPut("Int", left, rcIcon, 0)
                NumPut("Int", top + 2, rcIcon, 4)
                NumPut("Int", right, rcIcon, 8)
                NumPut("Int", top + 28, rcIcon, 12)
                DllCall("DrawTextW", "Ptr", hDC, "Ptr", iconBuf, "Int", -1, "Ptr", rcIcon, "UInt", 37)
                
                DllCall("SelectObject", "Ptr", hDC, "Ptr", oldF, "Ptr")
                DllCall("DeleteObject", "Ptr", hIconFont)
            }
            if opts.Has("title") {
                titleBuf := Buffer(StrPut(opts["title"], "UTF-16"))
                StrPut(opts["title"], titleBuf, "UTF-16")
                
                rcTitle := Buffer(16)
                NumPut("Int", left, rcTitle, 0)
                NumPut("Int", top + 26, rcTitle, 4)
                NumPut("Int", right, rcTitle, 8)
                NumPut("Int", bottom, rcTitle, 12)
                DllCall("DrawTextW", "Ptr", hDC, "Ptr", titleBuf, "Int", -1, "Ptr", rcTitle, "UInt", 37)
            }
        } else {
            ; Ribbon Button layout: Optional Icon left, Title, Optional Subtitle below title
            titleX := opts.Has("icon") ? left + 75 : left + 15
            
            ; If there is ONLY a title (no icon, no subtitle), center it
            isSimpleCenter := !opts.Has("icon") && !opts.Has("subtitle") && !opts.Has("rightIcon")
            
            if opts.Has("icon") {
                iconBuf := Buffer(StrPut(opts["icon"], "UTF-16"))
                StrPut(opts["icon"], iconBuf, "UTF-16")
                
                hIconFont := DllCall("CreateFontW", "Int", 36, "Int", 0, "Int", 0, "Int", 0, "Int", 400, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 1, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0, "WStr", "Segoe UI", "Ptr")
                oldF := DllCall("SelectObject", "Ptr", hDC, "Ptr", hIconFont, "Ptr")
                
                rcIcon := Buffer(16)
                NumPut("Int", left + 20, rcIcon, 0)
                NumPut("Int", top, rcIcon, 4)
                NumPut("Int", left + 70, rcIcon, 8)
                NumPut("Int", bottom, rcIcon, 12)
                DllCall("DrawTextW", "Ptr", hDC, "Ptr", iconBuf, "Int", -1, "Ptr", rcIcon, "UInt", 37)
                
                DllCall("SelectObject", "Ptr", hDC, "Ptr", oldF, "Ptr")
                DllCall("DeleteObject", "Ptr", hIconFont)
            }
            
            if opts.Has("title") {
                titleBuf := Buffer(StrPut(opts["title"], "UTF-16"))
                StrPut(opts["title"], titleBuf, "UTF-16")
                
                rcTitle := Buffer(16)
                if isSimpleCenter {
                    NumPut("Int", left, rcTitle, 0)
                    NumPut("Int", top, rcTitle, 4)
                    NumPut("Int", right, rcTitle, 8)
                    NumPut("Int", bottom, rcTitle, 12)
                    DllCall("DrawTextW", "Ptr", hDC, "Ptr", titleBuf, "Int", -1, "Ptr", rcTitle, "UInt", 37) ; CENTER|VCENTER
                } else {
                    if (btnHeight < 50) {
                        titleTop := opts.Has("subtitle") ? top + 5 : top
                        titleHeight := opts.Has("subtitle") ? top + 25 : bottom
                    } else {
                        titleTop := opts.Has("subtitle") ? top + 15 : top
                        titleHeight := opts.Has("subtitle") ? top + 45 : bottom
                    }
                    NumPut("Int", titleX, rcTitle, 0)
                    NumPut("Int", titleTop, rcTitle, 4)
                    NumPut("Int", right, rcTitle, 8)
                    NumPut("Int", titleHeight, rcTitle, 12)
                    DllCall("DrawTextW", "Ptr", hDC, "Ptr", titleBuf, "Int", -1, "Ptr", rcTitle, "UInt", 36) ; LEFT|VCENTER
                }
            }
            
            if opts.Has("subtitle") {
                subBuf := Buffer(StrPut(opts["subtitle"], "UTF-16"))
                StrPut(opts["subtitle"], subBuf, "UTF-16")
                
                ; Dimmed text color for subtitle
                subRGB := ColorHexToRGB(GetTheme("text_muted"))
                DllCall("SetTextColor", "Ptr", hDC, "UInt", subRGB)
                
                ; Small font for subtitle
                fontSize := (btnHeight < 50) ? 12 : 14
                hSubFont := DllCall("CreateFontW", "Int", fontSize, "Int", 0, "Int", 0, "Int", 0, "Int", 400, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 1, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0, "WStr", "Consolas", "Ptr")
                oldF := DllCall("SelectObject", "Ptr", hDC, "Ptr", hSubFont, "Ptr")
                
                subTop := (btnHeight < 50) ? top + 22 : top + 45
                subBottom := (btnHeight < 50) ? bottom : top + 65
                
                rcSub := Buffer(16)
                NumPut("Int", titleX, rcSub, 0)
                NumPut("Int", subTop, rcSub, 4)
                NumPut("Int", right, rcSub, 8)
                NumPut("Int", subBottom, rcSub, 12)
                DllCall("DrawTextW", "Ptr", hDC, "Ptr", subBuf, "Int", -1, "Ptr", rcSub, "UInt", 36)
                
                DllCall("SelectObject", "Ptr", hDC, "Ptr", oldF, "Ptr")
                DllCall("DeleteObject", "Ptr", hSubFont)
                
                ; Restore main text color
                DllCall("SetTextColor", "Ptr", hDC, "UInt", info.txt)
            }
            
            if opts.Has("rightIcon") {
                modBuf := Buffer(StrPut(opts["rightIcon"], "UTF-16"))
                StrPut(opts["rightIcon"], modBuf, "UTF-16")
                
                subRGB := ColorHexToRGB(GetTheme("text_muted"))
                DllCall("SetTextColor", "Ptr", hDC, "UInt", subRGB)
                
                rcMod := Buffer(16)
                NumPut("Int", right - 40, rcMod, 0)
                NumPut("Int", top, rcMod, 4)
                NumPut("Int", right, rcMod, 8)
                NumPut("Int", bottom, rcMod, 12)
                DllCall("DrawTextW", "Ptr", hDC, "Ptr", modBuf, "Int", -1, "Ptr", rcMod, "UInt", 37)
                
                DllCall("SetTextColor", "Ptr", hDC, "UInt", info.txt)
            }
        }
    }
    
    ; 4. Draw Tactical Hover Left Bar if requested
    if (isHovered && opts.Has("tacticalLeftBar") && opts["tacticalLeftBar"]) {
        accentRGB := ColorHexToRGB(GetTheme("accent"))
        hAccentBrush := DllCall("CreateSolidBrush", "UInt", accentRGB, "Ptr")
        
        rcAccent := Buffer(16)
        NumPut("Int", left, rcAccent, 0)
        NumPut("Int", top, rcAccent, 4)
        NumPut("Int", left + 4, rcAccent, 8) ; 4px wide bar
        NumPut("Int", bottom, rcAccent, 12)
        
        DllCall("FillRect", "Ptr", hDC, "Ptr", rcAccent, "Ptr", hAccentBrush)
        DllCall("DeleteObject", "Ptr", hAccentBrush)
    }

    ; Restore old font
    if (oldFont)
        DllCall("SelectObject", "Ptr", hDC, "Ptr", oldFont)
    
    return 1  ; Tell Windows we handled it
}

; Clear all button colors (call before Gui.Destroy)
ClearButtonColors() {
    global ButtonColorMap, ButtonColorHooked, HoveredButtonHwnd
    for hwnd, info in ButtonColorMap {
        try DllCall("DeleteObject", "Ptr", info.brush)
        try DllCall("DeleteObject", "Ptr", info.hoverBrush)
    }
    ButtonColorMap := Map()
    HoveredButtonHwnd := 0
    if ButtonColorHooked {
        SetTimer(CheckButtonHover, 0)  ; Stop hover timer
        OnMessage(0x002B, HandleDrawItem, 0)  ; Unregister hook
        ButtonColorHooked := false
    }
}

ColorHexToRGB(hex) {
    ; Convert "238636" -> COLORREF (BGR format)
    hex := StrReplace(hex, "#", "")
    r := Integer("0x" . SubStr(hex, 1, 2))
    g := Integer("0x" . SubStr(hex, 3, 2))
    b := Integer("0x" . SubStr(hex, 5, 2))
    return (b << 16) | (g << 8) | r
}

; Apply Dark Mode theme to a single control
ApplyDarkMode(hwnd) {
    DllCall("uxtheme\SetWindowTheme",
        "Ptr", hwnd,
        "Str", "DarkMode_Explorer",
        "Ptr", 0)
}

; Apply Dark Mode to the entire window (title bar + frame)
ApplyDarkModeToWindow(guiHwnd) {
    ; DWMWA_USE_IMMERSIVE_DARK_MODE
    DllCall("dwmapi\DwmSetWindowAttribute",
        "Ptr",  guiHwnd,
        "UInt", 20,
        "Int*", 1,
        "UInt", 4)
    
    ; Dark Mode title bar (fallback for older Windows)
    DllCall("dwmapi\DwmSetWindowAttribute",
        "Ptr",  guiHwnd,
        "UInt", 19,
        "Int*", 1,
        "UInt", 4)
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
    genToolMenu.Add(Tr("menu_enable_gentool"), (*) => EnableGenTool())
    genToolMenu.Add(Tr("menu_disable_gentool"), (*) => DisableGenTool())
    genToolMenu.Add()
    genToolMenu.Add(Tr("menu_download_gentool"), (*) => DownloadGenTool())
    toolsMenu.Add("🔧 GenTool", genToolMenu)
    
    dxMenu := Menu()
    dxMenu.Add(Tr("menu_enable_dx"), (*) => EnableDXWrapper())
    dxMenu.Add(Tr("menu_disable_dx"), (*) => DisableDXWrapper())
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
    SetButtonColor(btnCopy, GetTheme("bg_tertiary"), GetTheme("accent"))
    if IsDarkTheme()
        ApplyDarkMode(btnCopy.Hwnd)
    
    ; Support Button
    aboutGui.SetFont("s10 Bold c" . GetTheme("text_button"), "Segoe UI")
    btnSupport := aboutGui.AddButton("x20 y260 w360 h40", Tr("btn_open_support"))
    btnSupport.OnEvent("Click", (*) => (SubStr(DISCORD_SUPPORT, 1, 8) = "https://" ? Run(DISCORD_SUPPORT) : ""))
    SetButtonColor(btnSupport, GetTheme("bg_button"), GetTheme("text_button"))
    if IsDarkTheme()
        ApplyDarkMode(btnSupport.Hwnd)
    
    ; Close Button
    aboutGui.SetFont("s10 c" . GetTheme("text_muted"), "Segoe UI")
    btnClose := aboutGui.AddButton("x20 y310 w360 h35", Tr("btn_close"))
    btnClose.OnEvent("Click", (*) => aboutGui.Destroy())
    SetButtonColor(btnClose, GetTheme("bg_secondary"), GetTheme("text_muted"))
    if IsDarkTheme()
        ApplyDarkMode(btnClose.Hwnd)
    
    aboutGui.Show("w400 h360")
    
    ; Dark Mode on the About dialog
    if IsDarkTheme()
        ApplyDarkModeToWindow(aboutGui.Hwnd)
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

GetGenToolStatus() => IsGenToolEnabled() ? Tr("status_gentool_on") : Tr("status_gentool_off")
GetDXStatus()      => IsDXWrapperEnabled() ? Tr("status_dx_on") : Tr("status_dx_off")

UpdateStatus() {
    ; Defer the GUI rebuild so the calling function finishes first
    ; This prevents crashes when called from menu callbacks or button events
    SetTimer(DoUpdateStatus, -100)
}

DoUpdateStatus() {
    global MainGui
    try {
        if IsSet(UpdateTrayMenu)
            UpdateTrayMenu()
        RefreshThemeCache()
        ClearButtonColors()
        WinSetTransparent(0, MainGui)
        MainGui.Destroy()
        CreateMainGui()
    }
}

ShowGenToolMenu() {
    m := Menu()
    m.Add(Tr("menu_enable_gentool"), (*) => EnableGenTool())
    m.Add(Tr("menu_disable_gentool"), (*) => DisableGenTool())
    m.Add()
    m.Add(Tr("menu_download_gentool"), (*) => DownloadGenTool())
    m.Show()
}

ShowDXWrapperMenu() {
    m := Menu()
    m.Add(Tr("menu_enable_dx"), (*) => EnableDXWrapper())
    m.Add(Tr("menu_disable_dx"), (*) => DisableDXWrapper())
    m.Add()
    m.Add(Tr("menu_download_dx_gpu"), (*) => DownloadDXWrapper("gpu"))
    m.Add(Tr("menu_download_dx_reduce"), (*) => DownloadDXWrapper("reduce"))
    m.Show()
}

ShowSettingsMenu() {
    global CurrentTheme
    m := Menu()
    m.Add(Tr("menu_theme_auto") . (CurrentTheme = "auto" ? " ●" : ""), (*) => ChangeTheme("auto"))
    m.Add(Tr("menu_theme_dark") . (CurrentTheme = "dark" ? " ●" : ""), (*) => ChangeTheme("dark"))
    m.Add(Tr("menu_theme_light") . (CurrentTheme = "light" ? " ●" : ""), (*) => ChangeTheme("light"))
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
    ClearButtonColors()
    MainGui.Destroy()
    CreateMainGui()
}

ChangeTheme(theme) {
    global CurrentTheme, MainGui
    CurrentTheme := theme
    SaveConfig()
    RefreshThemeCache()
    ClearButtonColors()
    MainGui.Destroy()
    CreateMainGui()
}

; ══════════════════════════════════════════════════════════════════════════════
;                              Startup
; ══════════════════════════════════════════════════════════════════════════════

Main() {
    global GamePath, FirstRun, APP_NAME
    
    LoadConfig()
    
    A_IconTip := APP_NAME
    UpdateTrayMenu()
    OnMessage(0x404, TrayIconClick)
    
    if (GamePath = "")
        SearchGame()
    
    CreateMainGui()
    
    if (GamePath = "")
        SetTimer(AskForPath, -500)
}

UpdateTrayMenu() {
    global APP_NAME
    A_TrayMenu.Delete()
    A_TrayMenu.Add("🎮 " . APP_NAME, (*) => ShowMainGui())
    A_TrayMenu.Add()
    A_TrayMenu.Add("🔧 GenTool: " . (IsGenToolEnabled() ? "ON ✓" : "OFF ✗"), (*) => (IsGenToolEnabled() ? DisableGenTool() : EnableGenTool()))
    A_TrayMenu.Add("🎨 DXWrapper: " . (IsDXWrapperEnabled() ? "ON ✓" : "OFF ✗"), (*) => (IsDXWrapperEnabled() ? DisableDXWrapper() : EnableDXWrapper()))
    A_TrayMenu.Add()
    A_TrayMenu.Add("❌ " . Tr("menu_exit"), (*) => ExitApp())
    A_TrayMenu.Default := "🎮 " . APP_NAME
}

ShowMainGui() {
    global MainGui
    try {
        MainGui.Show()
        WinActivate(MainGui)
    }
}

TrayIconClick(wParam, lParam, msg, hwnd) {
    if (lParam = 0x203)
        ShowMainGui()
}

AskForPath() {
    result := MsgBox(Tr("msg_not_found") . "`n`n" . Tr("msg_select_folder") . "?", APP_NAME, "YesNo Icon?")
    if (result = "Yes")
        MenuSelectPath()
}

Main()