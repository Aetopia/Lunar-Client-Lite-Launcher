#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
ListLines Off
#SingleInstance, Force
#NoTrayIcon
;File Existence Checks
IfNotExist, Config.ini
	ConfigCreate()
EnvGet, vHomeDrive, HOMEDRIVE
EnvGet, vHomePath, HOMEPATH
UserProfile=% vHomeDrive vHomePath
IfNotExist, %UserProfile%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	LCCheck()	
Resources()
;Language
IniRead, Lang, Config.ini, Language, Language
If (Lang = "English"){
	LangFile=english.txt
	Format=.
}
Else If (Lang = "French"){
	LangFile=french.txt
}
Else If (Lang = "Arabic"){
	LangFile=Arabic.txt
}
Else If (Lang = "Georgian"){
	LangFile=georgian.txt
	Format="'ის"
}
If (Lang = "English"){
	LangUIFile=englishui.txt
}
Else If (Lang = "French"){
	LangUIFile=frenchui.txt
}
Else If (Lang = "Arabic"){
	LangUIFile=arabicui.txt
}
Else If (Lang = "Georgian"){
	LangUIFile=georgianui.txt
}
FileEncoding, UTF-8
FileReadLine, Home, Resources/lang/%LangFile%, 1
FileReadLine, Settings, Resources/lang/%LangFile%, 2
FileReadLine, About, Resources/lang/%LangFile%, 3
FileReadLine, Java, Resources/lang/%LangFile%, 4
FileReadLine, Directory, Resources/lang/%LangFile%, 5
FileReadLine, LaunchOptions, Resources/lang/%LangFile%, 6
FileReadLine, Cosmetics, Resources/lang/%LangFile%, 7
FileReadLine, Executable, Resources/lang/%LangFile%, 8
FileReadLine, SYOJETUWLC, Resources/lang/%LangFile%, 9
FileReadLine, Arguments, Resources/lang/%LangFile%, 10
FileReadLine, LCMB, Resources/lang/%LangFile%, 11
FileReadLine, Aetopia, Resources/lang/%LangFile%, 12
FileReadLine, GitHubRepository, Resources/lang/%LangFile%, 13
FileReadLine, RLCL, Resources/lang/%LangFile%, 14
FileReadLine, Reset, Resources/lang/%LangFile%, 15
FileReadLine, OTLF, Resources/lang/%LangFile%, 16
FileReadLine, Open, Resources/lang/%LangFile%, 17
FileReadLine, Language, Resources/lang/%LangFile%, 18
FileReadLine, Translators, Resources/lang/%LangFile%, 19

;Command Line Arguments
Arguments := ["1.7", "1.8", "1.12", "1.16", "1.17"]
for n, param in A_Args  ; For each parameter:
{
	LauncherMSA()
	IniRead, LauncherVer, Config.ini, LC, Launcher_Version
	If (param=1.7 or param=1.8 or param=1.12 or param=1.16 or param=1.17){
		LCVer=%param%
		If (param=1.7){
			MCAssetIndex=1.7.10
		}
		else {
			MCAssetIndex=%param%
		}	
		IniRead, Path, Config.ini, Paths, %param%_Dir
		Server=%2%
		If (Server = ""){
			Server=
		}
		else {
			Server=--server %2%
		}
	}
	else
	{
		FileReadLine, Error1, Resources/lang/%LangUIFile%, 1
		FileReadLine, Error2, Resources/lang/%LangUIFile%, 2
		FileReadLine, Error3, Resources/lang/%LangUIFile%, 3
		MsgBox, 16, %Error1%, %Error2% "%param%" %Error3%
		ExitApp
	}	
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	IniRead, LCArgs, Config.ini, LC, Arguments
	IniRead, TexturesToggle, Config.ini, LC, Cosmetics
	IniRead, Assets, Config.ini, Minecraft, Assets
	IniRead, LaunchJRE, Config.ini, Minecraft, JRE
	FileCopyDir, %Assets%\indexes, %Path%\assets\indexes, 0
	FileCopyDir, %Assets%\objects, %Path%\assets\objects, 0
	If (TexturesToggle=1) {
		Textures=%UserProfile%\.lunarclient\textures
	}
	Try {
		Run, %LaunchJRE% --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" --add-opens java.base/java.io=ALL-UNNAMED %LCArgs% -Djava.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" -cp "%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-1-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-2-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-3-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-libs.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-prod-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\OptiFine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\vpatcher-prod.jar" com.moonsworth.lunar.patcher.LunarMain --version %LCVer% --accessToken 0 --assetIndex %MCAssetIndex% --userProperties {} --gameDir "%Path%" --texturesDir "%Textures%" --launcherVersion %LauncherVer% %Server% --width 854 --height 480 
	}
	Catch Error
		MsgBox, 16, Launch Error, Lunar Client Lite couldn't launch Lunar Client.`nCheck your specified Java Executable.
	ExitApp
}
Progress=0
;GUI
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Main:Default
Gui, -MaximizeBox -MinimizeBox -Resize
;Colors
FileReadLine, Font, Resources/colors, 1
FileReadLine, Background, Resources/colors, 2
FileReadLine, Control, Resources/colors, 3

Gui, Font, s10 
Gui, Font, c%Font%
Gui, Color, %Background%, %Control%
Gui, Add, Tab3, w490 h385 x6 Top +Background +0x400 -TabStop, %Home%|%Settings%|Java|%About%
Gui, Font, s8
Gui, Add, Picture, x8 y32, Resources/Banner.png
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Tab, 1
Gui, Font, s10
Gui, Add, Picture, x196 y340 w108 h38 gLaunch vLaunchButton, Resources/Launch.png
Gui, Add, Button, x0 y0 w0 h0 gLaunch +default vLaunch
Gui, Font, s8
Gui, Add, DropDownList, x196 y315 w108 h40 vVersionList gVersionWrite c30 r5, 1.7|1.8|1.12|1.16|1.17
VersionRead()


Gui, Tab, 2
IniRead, 17_Path, Config.ini, Paths, 1.7_Dir
IniRead, 18_Path, Config.ini, Paths, 1.8_Dir
IniRead, 112_Path, Config.ini, Paths, 1.12_Dir
IniRead, 116_Path, Config.ini, Paths, 1.16_Dir
IniRead, 117_Path, Config.ini, Paths, 1.17_Dir
IniRead, CosmeticTextures, Config.ini, LC, Cosmetics
Gui, Add, Text,, 1.7 %Directory%
Gui, Add, Edit, w400 h20 v17Dir, %17_Path%
Gui, Add, Text,, 1.8 %Directory%
Gui, Add, Edit, w400 h20 v18Dir, %18_Path%
Gui, Add, Text,, 1.12 %Directory%
Gui, Add, Edit, w400 h20 v112Dir, %112_Path%
Gui, Add, Text,, 1.16 %Directory%
Gui, Add, Edit, w400 h20 v116Dir, %116_Path%
Gui, Add, Text,, 1.17 %Directory%
Gui, Add, Edit, w400 h20 v117Dir, %117_Path%
Gui, Add, Text,, %LaunchOptions%
If (CosmeticTextures = 1){
	Gui, Add, Checkbox, Checked vCosmeticDelayFix, %Cosmetics%
}
Else	 {
	Gui, Add, Checkbox, vCosmeticDelayFix, %Cosmetics%
}
Gui, Add, Picture, x425 y58 w23 h22 g17FolderSelect v17Select, Resources/Edit.png
Gui, Add, Picture, x425 y105 w23 h22 g18FolderSelect v18Select, Resources/Edit.png
Gui, Add, Picture, x425 y152 w23 h22 g112FolderSelect v112Select, Resources/Edit.png
Gui, Add, Picture, x425 y199 w23 h22 g116FolderSelect v116Select, Resources/Edit.png
Gui, Add, Picture, x425 y246 w23 h22 g117FolderSelect v117Select, Resources/Edit.png
Gui, Font, s10
Gui, Add, Picture, x380 y342 w98 h38 vSave gSave, Resources/Save_Settings.png
Gui, Font, s8

Gui, Tab, 3
Gui, Add, Text,, %Executable%
IniRead, GUIJRE, Config.ini, Minecraft, JRE
Gui, Add, Edit, h20 w400 vJRE +ReadOnly, %GUIJRE%
Gui, Add, Text,, %SYOJETUWLC%
Gui, Add, Text,, %Arguments%
Gui, Add, Edit, w400 h250 vArgs -0x1000 +0x4 +Wrap +0x100 +Multi, %GUIArguments%
Gui, Add, Picture, x425 y58 w23 h22 gJRESelect vJRESelect, Resources/Edit.png
Gui, Font, s10
Gui, Add, Picture, x425 y134 w58 h34 gSaveJVMArguments vSaveJVMArguments, Resources/Save_JVMArguments.png
Gui, Font, s8

Gui, Tab, 4 
Gui, Add, Link,, %LCMB% <a href="https://github.com/Aetopia">%Aetopia%</a>
Gui, Add, Link,, %GitHubRepository%: <a href="https://github.com/Aetopia/Lunar-Client-Lite-Launcher">https://github.com/Aetopia/Lunar-Client-Lite-Launcher</a>
Gui, Add, Link,, Couleur Tweaks Tips Discord: <a href="https://dsc.gg/ctt">https://dsc.gg/ctt</a>
Gui, Add, Text,, %Translators%
Gui, Add, Text, w463 0x10
Gui, Add, Text,, %Reset% Lunar Client Lite%Format%
Gui, Add, Button, gReset, %Reset%
Gui, Add, Text,, %OTLF%
Gui, Add, Button, gLogs, %Open%
Gui, Add, Text,, %Language%:
Gui, Add, DropDownList, vLang gLang, Arabic|English|French|Georgian
LangSelect()
Gui, Show, w500 h400, Lunar Client Lite
GuiControl, Focus, Launch
GuiControl, Focus, +default

;Functions
Launch() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}
	GuiControl,, LaunchButton, Resources/Launch_Clicked.png
	Sleep, 75
	GuiControl,, LaunchButton, Resources/Launch.png
	LauncherMSA()
	IniRead, LauncherVer, Config.ini, LC, Launcher_Version
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	IniRead, LCArgs, Config.ini, LC, Arguments
	IniRead, LCVer, Config.ini, LC, Version
	IniRead, MCAssetIndex, Config.ini, Minecraft, AssetIndex
	IniRead, TexturesToggle, Config.ini, LC, Cosmetics
	IniRead, Assets, Config.ini, Minecraft, Assets
	VersionCheck()
	IniRead, PathVersion, Config.ini, LC, Version
	IniRead, LaunchJRE, Config.ini, Minecraft, JRE
	IniRead, Path, Config.ini, Paths, %PathVersion%_Dir
	Gui, Destroy
	FileCopyDir, %Assets%\indexes, %Path%\assets\indexes, 0
	FileCopyDir, %Assets%\objects, %Path%\assets\objects, 0
	If (TexturesToggle=1) {
		Textures=%UserProfile%\.lunarclient\textures
	}
	Try {
		Run, %LaunchJRE% --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" --add-opens java.base/java.io=ALL-UNNAMED %LCArgs% -Djava.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" -cp "%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-1-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-2-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-3-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-libs.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-prod-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\OptiFine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\vpatcher-prod.jar" com.moonsworth.lunar.patcher.LunarMain --version %LCVer% --accessToken 0 --assetIndex %MCAssetIndex% --userProperties {} --gameDir "%Path%" --texturesDir "%Textures%" --launcherVersion %LauncherVer% --width 854 --height 480
		ExitApp
	}
	Catch Error
		FileReadLine, ErrorLCLCMD1, Resources/lang/%LangUIFile%, 4
		FileReadLine, ErrorLCLCMD2, Resources/lang/%LangUIFile%, 5
		MsgBox, 16, Error, %ErrorLCLCMD1%`n%ErrorLCLCMD2%
	ExitApp
	
}

LangSelect(){
IniRead, Lang, Config.ini, Language, Language
If (Lang = "Arabic"){
	GuiControl, Choose, Lang, 1
}	
Else If (Lang = "English"){
	GuiControl, Choose, Lang, 2
}
Else If (Lang = "French"){
	GuiControl, Choose, Lang, 3
}
Else If (Lang = "Georgian"){
	GuiControl, Choose, Lang, 4
}
}

LauncherMSA(){
FileDelete, latest.yml
URLDownloadToFile, https://launcherupdates.lunarclientcdn.com/latest.yml, %A_Temp%\latest.yml
FileReadLine, LauncherYML, %A_Temp%\latest.yml, 1
StringTrimLeft, LauncherVer, LauncherYML, 9
IniWrite, %LauncherVer%, Config.ini, LC, Launcher_Version
}

ConfigCreate() {
	IniWrite, 1.8, Config.ini, LC, Version
	IniWrite, 1.8, Config.ini, Minecraft, AssetIndex
	IniWrite, -Xms3G -Xmx3G -XX:+DisableAttachMechanism, Config.ini, LC, Arguments	
	IniWrite, 1, Config.ini, LC, Cosmetics
	IniWrite, %A_AppData%\.minecraft\assets, Config.ini, Minecraft, Assets
	IniWrite, English, Config.ini, Language, Language
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	Loop, Files, %UserProfile%\.lunarclient\jre\zulu*, D
		IniWrite, %A_LoopFileLongPath%\bin\javaw.exe, Config.ini, Minecraft, JRE
	PathConfig()
}

Lang(){
	GuiControlGet, LangList,, Lang
	IniWrite, %LangList%, Config.ini, Language, Language
	Reload
}

UILang(){
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}
}	

Resources() {
	IfNotExist, %A_WorkingDir%\Resources
		FileCreateDir, %A_WorkingDir%\Resources
	IfNotExist, %A_WorkingDir%\Resources\lang
		FileCreateDir, %A_WorkingDir%\Resources\lang
	IfNotExist, Resources\Banner.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Banner.png, Resources/Banner.png
	IfNotExist, Resources\Edit.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Edit.png, Resources/Edit.png
	IfNotExist, Resources\Edit_Clicked.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Edit_Clicked.png, Resources/Edit_Clicked.png
	IfNotExist, Resources\Launch.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Launch.png, Resources/Launch.png
	IfNotExist, Resources\Launch_Clicked.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Launch_Clicked.png, Resources/Launch_Clicked.png
	IfNotExist, Resources\Save_JVMArguments.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Save_JVMArguments.png, Resources/Save_JVMArguments.png
	IfNotExist, Resources\Save_JVMArguments_Clicked.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Save_JVMArguments_Clicked.png, Resources/Save_JVMArguments_Clicked.png
	IfNotExist, Resources\Save_Settings.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Save_Settings.png, Resources/Save_Settings.png
	IfNotExist, Resources\Save_Settings_Clicked.png
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/Save_Settings_Clicked.png, Resources/Save_Settings_Clicked.png
	IfNotExist, Resources\colors
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/colors, Resources/colors
	IfNotExist, Resources\lang\english.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/english.txt, Resources/lang/english.txt
	IfNotExist, Resources\lang\arabic.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/arabic.txt, Resources/lang/arabic.txt
	IfNotExist, Resources\lang\french.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/french.txt, Resources/lang/french.txt
	IfNotExist, Resources\lang\georgian.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/georgian.txt, Resources/lang/georgian.txt		
	IfNotExist, Resources\lang\englishui.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/englishui.txt, Resources/lang/englishui.txt
	IfNotExist, Resources\lang\arabicui.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/arabicui.txt, Resources/lang/arabicui.txt
	IfNotExist, Resources\lang\frenchui.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/frenchui.txt, Resources/lang/frenchui.txt
	IfNotExist, Resources\lang\georgianui.txt
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Resources/lang/georgianui.txt, Resources/lang/georgianui.txt		
}

VersionWrite() {
	GuiControlGet, UserVersion,, VersionList
	If (UserVersion = 1.7 or UserVersion = 1.8 or UserVersion = 1.12 or UserVersion = 1.16 or UserVersion = 1.17) 
	{
		IniWrite, %UserVersion%, Config.ini, LC, Version
		If (UserVersion = 1.7) {
			IniWrite, 1.7.10, Config.ini, Minecraft, AssetIndex
		}
		Else {
			IniWrite, %UserVersion%, Config.ini, Minecraft, AssetIndex
		}
	}	
	return
}

VersionRead() {
	IniRead, GUIVersion, Config.ini, LC, Version
	If (GUIVersion = 1.7) 
	{
		GuiControl, Choose, VersionList, 1
	}	
	Else If (GUIVersion = 1.8) 
	{
		GuiControl, Choose, VersionList, 2
	}
	Else If (GUIVersion = 1.12) 
	{
		GuiControl, Choose, VersionList, 3
	}
	Else If (GUIVersion = 1.16) 
	{
		GuiControl, Choose, VersionList, 4
	}
	Else If (GUIVersion = 1.17) 
	{
		GuiControl, Choose, VersionList, 5
	}
	return
}

LCCheck() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}
	FileReadLine, ErrorLC1, Resources/lang/%LangUIFile%, 6
	FileReadLine, ErrorLC2, Resources/lang/%LangUIFile%, 7
	FileReadLine, ErrorLC3, Resources/lang/%LangUIFile%, 8
	FileReadLine, ErrorLC4, Resources/lang/%LangUIFile%, 9
	;MsgBox, 16, %ErrorLC1%, %ErrorLC2%`n%ErrorLC3%
	Gui, Install:New
	Gui, -MaximizeBox -MinimizeBox +0x40000
	Gui, Add, Progress, w200 h20 vProgress cGreen, 20
	Gui, Add, Text,, %ErrorLC4%
	Gui, Show,, Lunar Client Lite
	LauncherMSA()
	IniRead, LauncherVer, Config.ini, LC, Launcher_Version
	URLDownloadToFile, https://launcherupdates.lunarclientcdn.com/Lunar Client v%LauncherVer%.exe, %A_Temp%\lunar.exe
	GuiControl,, Progress, +100
	Sleep 500
	Gui, Destroy
	IfNotExist, %A_Temp%\lunar.exe
		LCNotExist()
	Run, %A_Temp%\lunar.exe
	Process, Exist, lunar.exe
	WinActivate, ahk_exe lunar.exe
	ExitApp	
}

LCNotExist() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}
	FileReadLine, NotExistLCL1, Resources/lang/%LangUIFile%, 10
	FileReadLine, NotExistLCL2, Resources/lang/%LangUIFile%, 11
	FileReadLine, NotExistLCL3, Resources/lang/%LangUIFile%, 13
	Gui,Destroy
	MsgBox, 16, %NotExistLCL1%, %NotExistLCL2%`n%NotExistLCL3%
	ExitApp
}



VersionCheck() {
	IniRead, CheckVersion, Config.ini, LC, Version
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	If (CheckVersion = 1.7){
		IfNotExist, %UserProfile%\.lunarclient\offline\1.7
			FileCheck(1.7)
		return	
	}
	If (CheckVersion = 1.8){
		IfNotExist, %UserProfile%\.lunarclient\offline\1.8
			FileCheck(1.8)
		return	
	}
	If (CheckVersion = 1.9){
		IfNotExist, %UserProfile%\.lunarclient\offline\1.9
			FileCheck(1.9)
		return	
	}
	If (CheckVersion = 1.12){
		IfNotExist, %UserProfile%\.lunarclient\offline\1.12
			FileCheck(1.12)
		return	
	}
	If (CheckVersion = 1.16){
		IfNotExist, %UserProfile%\.lunarclient\offline\1.16
			FileCheck(1.16)
		return	
	}
	If (CheckVersion = 1.17){
		IfNotExist, %UserProfile%\.lunarclient\offline\1.17
			FileCheck(1.17)
		return	
	}
}

FileCheck(n) {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	FileReadLine, NotExistLCVer1, Resources/lang/%LangUIFile%, 13
	FileReadLine, NotExistLCVer2, Resources/lang/%LangUIFile%, 14
	FileReadLine, NotExistLCVer3, Resources/lang/%LangUIFile%, 15
	MsgBox, 16, %NotExistLCLVer1%, LC %n% %NotExistLCLVer2%`n%NotExistLCLVer3% %n%!
	Run, %UserProfile%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	ExitApp
}

NotExist(x) {
	if (x=1) {
		MsgBox, 16, Download Failed, The dependency could not be downloaded.`nCheck your internet connection.
		ExitApp
		
	}
	
	if (x=2) {
		MsgBox, 16, Download Failed, Failed to update dependencies.`nCheck your internet connection.
	}
}

Logs() {
	GuiControl, Focus, Button
	IfExist, %A_WorkingDir%\logs
		Run, %A_WorkingDir%\logs,, Max
		
	IfNotExist, %A_WorkingDir%\logs
		FileCreateDir, %A_WorkingDir%\logs
		Run, %A_WorkingDir%\logs,, Max
}

Reset() {
	FileDelete, Config.ini
	FileRemoveDir, Resources, 1
	Reload
}

MainGuiClose() {
	ExitApp
}

;Options
;------------------------------------------------------------------------------------
PathConfig() {
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.7_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.8_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.12_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.16_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.17_Dir
}

17FolderSelect() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}
	FileReadLine, SelectDirectory, Resources/lang/%LangUIFile%, 16
	GuiControl,, 17Select, Resources/Edit_Clicked.png
	Sleep, 100
	GuiControl,, 17Select, Resources/Edit.png
	IniRead, 17_Path, Config.ini, Paths, 1.7_Dir
	FileSelectFolder, 17PathSelected, *%17_Path%, 3, %SelectDirectory% 1.7
	if 17PathSelected =
		return
	else
		guicontrol,, 17Dir, %17PathSelected%
}

18FolderSelect() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}	
	FileReadLine, SelectDirectory, Resources/lang/%LangUIFile%, 16
	GuiControl,, 18Select, Resources/Edit_Clicked.png
	Sleep, 100
	GuiControl,, 18Select, Resources/Edit.png
	IniRead, 18_Path, Config.ini, Paths, 1.8_Dir
	FileSelectFolder, 18PathSelected, *%18_Path%, 3, %SelectDirectory% 1.8
	if 18PathSelected =
		return
	else
		guicontrol,, 18Dir, %18PathSelected%
	
}

112FolderSelect() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}	
	FileReadLine, SelectDirectory, Resources/lang/%LangUIFile%, 16
	GuiControl,, 112Select, Resources/Edit_Clicked.png
	Sleep, 100
	GuiControl,, 112Select, Resources/Edit.png
	IniRead, 112_Path, Config.ini, Paths, 1.12_Dir
	FileSelectFolder, 112PathSelected, *%112_Path%, 3, %SelectDirectory% 1.12
	if 112PathSelected =
		return
	else
		guicontrol,, 112Dir, %112PathSelected%
	
}

116FolderSelect() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}	
	FileReadLine, SelectDirectory, Resources/lang/%LangUIFile%, 16
	GuiControl,, 116Select, Resources/Edit_Clicked.png
	Sleep, 100
	GuiControl,, 116Select, Resources/Edit.png
	FileSelectFolder, 116PathSelected, *%116_Path%, 3, %SelectDirectory% 1.16
	if 116PathSelected =
		return
	else
		guicontrol,, 116Dir, %116PathSelected%
	
}

117FolderSelect() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}	
	FileReadLine, SelectDirectory, Resources/lang/%LangUIFile%, 16
	GuiControl,, 117Select, Resources/Edit_Clicked.png
	Sleep, 100
	GuiControl,, 117Select, Resources/Edit.png
	IniRead, 117_Path, Config.ini, Paths, 1.17_Dir
	FileSelectFolder, 117PathSelected, *%117_Path%, 3, %SelectDirectory% 1.17
	if 117PathSelected =
		return
	else
		guicontrol,, 117Dir, %117PathSelected%
	
}

Save() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}	
	FileReadLine, SaveText1, Resources/lang/%LangUIFile%, 17
	FileReadLine, SaveText2, Resources/lang/%LangUIFile%, 18
	GuiControl,, Save, Resources/Save_Settings_Clicked.png
	Sleep, 100
	GuiControl,, Save, Resources/Save_Settings.png
	guicontrolget, 17Path,, 17Dir
	guicontrolget, 18Path,, 18Dir
	guicontrolget, 112Path,, 112Dir
	guicontrolget, 116Path,, 116Dir
	guicontrolget, 117Path,, 117Dir
	guicontrolget, TextureLoad,, CosmeticDelayFix
	IniWrite, %17Path%, Config.ini, Paths, 1.7_Dir
	IniWrite, %18Path%, Config.ini, Paths, 1.8_Dir
	IniWrite, %112Path%, Config.ini, Paths, 1.12_Dir
	IniWrite, %116Path%, Config.ini, Paths, 1.16_Dir
	IniWrite, %117Path%, Config.ini, Paths, 1.17_Dir
	IniWrite, %TextureLoad%, Config.ini, LC, Cosmetics
	MsgBox, 64, %SaveText1%, %SaveText2%, 1
}

SaveJVMArguments() {
	IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}	
	FileReadLine, SaveText1, Resources/lang/%LangUIFile%, 17
	FileReadLine, SaveText2, Resources/lang/%LangUIFile%, 18
	GuiControl,, SaveJVMArguments, Resources/Save_JVMArguments_Clicked.png
	Sleep, 100
	GuiControl,, SaveJVMArguments, Resources/Save_JVMArguments.png
	GuiControlGet, JVMArgs,, Args
	IniWrite, %JVMArgs%, Config.ini, LC, Arguments
	MsgBox, 64, %SaveText1%, %SaveText2%, 1
}

;Experiments

JRESelect() {
		IniRead, Lang, Config.ini, Language, Language
	If (Lang = "English"){
		LangUIFile=englishui.txt
	}
	Else If (Lang = "French"){
		LangUIFile=frenchui.txt
	}
	Else If (Lang = "Arabic"){
		LangUIFile=arabicui.txt
	}
	Else If (Lang = "Georgian"){
		LangUIFile=georgianui.txt
	}	
	FileReadLine, Java1, Resources/lang/%LangUIFile%, 19
	FileReadLine, Java2, Resources/lang/%LangUIFile%, 20
	GuiControl,, JRESelect, Resources/Edit_Clicked.png
	Sleep, 100
	GuiControl,, JRESelect, Resources/Edit.png
	IniRead, SavedJRE, Config.ini, Minecraft, JRE
	FileSelectFile, SelectedJRE, 1, %SavedJRE%, %Java1%, %Java2% (javaw.exe)
	if SelectedJRE=
		return
	else
		IniWrite, %SelectedJRE%, Config.ini, Minecraft, JRE
	guicontrol,, JRE, %SelectedJRE%
}
