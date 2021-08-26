#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
ListLines Off
#SingleInstance, Force
#NoTrayIcon
Progress=0
17Dir=0
18Dir=0
112Dir=0
116Dir=0
117Dir=0
Launch=0
Save=0
CosmeticDelayFix=0
Button=0
EnvGet, vHomeDrive, HOMEDRIVE
EnvGet, vHomePath, HOMEPATH
UserProfile=% vHomeDrive vHomePath
;File Existence Checks
IfNotExist, %UserProfile%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	LCCheck()
IfNotExist, Config.ini
	ConfigCreate()
;GUI
Gui, Main:Default
Gui, -MaximizeBox -MinimizeBox +OwnDialogs
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Add, Text,, JVM Arguments
Gui, Add, Edit, w255 h85, %GUIArguments%
Gui, Add, Text, x10 y137, Version:
Gui, Add, DropDownList, x10 y154 w100 h50 vVersionList gVersionWrite c30 r5, 1.7|1.8|1.12|1.16|1.17
Gui, Add, Button, x270 y24 w25 h25 gAbout, ?
Gui, Add, Button, w25 h25 gGUIConfig, ✎
Gui, Add, Button, w25 h25 gOpenLCLPath, ❐
VersionRead()
Gui, Add, Button, x191 y141 w100 h50 gLaunch +default vLaunch, Launch
Gui, Add, Button, x0 y0 h0 w0 vButton
GuiControl, Focus, Button
GuiControl, Focus, +default
Gui, Show, w300 h200, ⠀
Gui, Main:+LastFound 
hWnd := WinExist() 
hSysMenu:=DllCall("GetSystemMenu","Int",hWnd,"Int",FALSE) 
nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu) 
DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-6,"Uint","0x400") 
DllCall("DrawMenuBar","Int",hWnd)

;Functions
Launch(){	
	Gui, +LastFound
	GuiControl, Focus, Button
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	GuiControlGet, JVMArgs,, Edit1
	IniWrite, %JVMArgs%, Config.ini, LC, Arguments
	IniRead, LCArgs, Config.ini, LC, Arguments
	IniRead, LCVer, Config.ini, LC, Version
	IniRead, MCAssetIndex, Config.ini, Minecraft, AssetIndex
	IniRead, TexturesToggle, Config.ini, LC, DisableCosmeticTextures
	VersionCheck()
	IniRead, PathVersion, Config.ini, LC, Version
	If (PathVersion = 1.7) 
	{
		IniRead, Path, Config.ini, Paths, 1.7_Dir
	}	
	Else If (PathVersion = 1.8) 
	{
		IniRead, Path, Config.ini, Paths, 1.8_Dir
	}
	Else If (PathVersion = 1.12) 
	{
		IniRead, Path, Config.ini, Paths, 1.12_Dir
	}
	Else If (PathVersion = 1.16) 
	{
		IniRead, Path, Config.ini, Paths, 1.16_Dir
	}
	Else If (PathVersion = 1.17) 
	{
		IniRead, Path, Config.ini, Paths, 1.17_Dir
	}
	Gui, Destroy
	Loop, Files, %A_AppData%\.minecraft\assets\objects, R
		FileCopyDir, %A_AppData%\.minecraft\assets\objects, %Path%\assets\objects, 1
	If (TexturesToggle=0){
		Textures=%UserProfile%\.lunarclient\textures
	}
	Loop, Files, %UserProfile%\.lunarclient\jre\zulu*, D
		Run, %A_LoopFileLongPath%\bin\javaw.exe --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" --add-opens java.base/java.io=ALL-UNNAMED %LCArgs% -Djava.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" -cp "%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-1-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-2-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-3-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-libs.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-prod-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\OptiFine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\vpatcher-prod.jar" com.moonsworth.lunar.patcher.LunarMain --version %LCVer% --accessToken 0 --assetIndex %MCAssetIndex% --userProperties {} --gameDir "%Path%" --texturesDir "%Textures%" --width 854 --height 480
	ExitApp
}

ConfigCreate()
{
	IniWrite, '1.8', Config.ini, LC, Version
	IniWrite, '1.8', Config.ini, Minecraft, AssetIndex
	IniWrite, -Xms3G -Xmx3G -XX:+DisableAttachMechanism, Config.ini, LC, Arguments	
	IniWrite, 0, Config.ini, LC, DisableCosmeticTextures
	PathConfig()
}

VersionWrite()
{
	GuiControlGet, UserVersion,, VersionList
	If (UserVersion = 1.7) 
	{
		IniWrite, '1.7', Config.ini, LC, Version
		IniWrite, '1.7.10', Config.ini, Minecraft, AssetIndex
	}	
	Else If (UserVersion = 1.8) 
	{
		IniWrite, '1.8', Config.ini, LC, Version
		IniWrite, '1.8', Config.ini, Minecraft, AssetIndex
	}
	Else If (UserVersion = 1.12) 
	{
		IniWrite, '1.12', Config.ini, LC, Version
		IniWrite, '1.12', Config.ini, Minecraft, AssetIndex
	}
	Else If (UserVersion = 1.16) 
	{
		IniWrite, '1.16', Config.ini, LC, Version
		IniWrite, '1.16', Config.ini, Minecraft, AssetIndex
	}
	Else If (UserVersion = 1.17) 
	{
		IniWrite, '1.17', Config.ini, LC, Version
		IniWrite, '1.17', Config.ini, Minecraft, AssetIndex
	}
	Else If (UserVersion = 1.18) 
	{
		IniWrite, '1.18', Config.ini, LC, Version
		IniWrite, '1.18', Config.ini, Minecraft, AssetIndex
	}
	return
}

VersionRead(){
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

About(){
	GuiControl, Focus, Button
	Gui, Main:Hide
	MsgBox, 64, About, Made by Aetopia`nhttps://github.com/Aetopia/Lunar-Client-Lite-Launcher
	IfMsgBox, Ok
		Gui, Main: Show
}

LCCheck(){
	MsgBox, 16, Error: Lunar Client Not Installed, No Lunar Client installation is present on this device.`nClick on OK to install the latest version of Lunar Client.
	Gui, Install:New
	Gui, -MaximizeBox -MinimizeBox
	Gui, Add, Progress, w200 h20 vProgress cGreen, 20
	Gui, Add, Text,, Downloading Lunar Client...
	Gui,Show,, ⠀
	URLDownloadToFile, https://launcherupdates.lunarclientcdn.com/latest.yml, %A_Temp%\ver.txt
	FileReadLine, LauncherYML, %A_Temp%\ver.txt, 1
	StringTrimLeft, LauncherVer, LauncherYML, 9
	URLDownloadToFile, https://launcherupdates.lunarclientcdn.com/Lunar Client v%LauncherVer%.exe, %A_Temp%\lunar.exe
	GuiControl,, Progress, +100
	Sleep 500
	Gui, Destroy
	IfNotExist, %A_Temp%\lunar.exe
		LCNotExist()
	FileExist, ("%Temp%\lunar.exe")
	Run, %A_Temp%\lunar.exe
	ExitApp	
}
LCNotExist(){
	Gui,Destroy
	MsgBox, 16, Download Error, Lunar Client couldn't be downloaded.`nCheck your internet connection and try again.
	ExitApp
}



VersionCheck(){
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

FileCheck(n){
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	MsgBox, 16, Error: Version Not Found, LC %n% wasn't found on this device!`nPlease install LC %n%! 
	Run, %UserProfile%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	ExitApp
}
	
NotExist(x){
	if (x=1){
		MsgBox, 16, Download Failed, The dependency could not be downloaded.`nCheck your internet connection.
		ExitApp
		
	}
	
	if (x=2){
		MsgBox, 16, Download Failed, Failed to update dependencies.`nCheck your internet connection.
	}
}

OpenLCLPath(){
	GuiControl, Focus, Button
	Run, %A_WorkingDir%,, Max
}

MainGuiClose(){
	ExitApp
}

;Options
;------------------------------------------------------------------------------------
PathConfig(){
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.7_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.8_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.12_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.16_Dir
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, 1.17_Dir
}

GUIConfig(){
	GuiControl, Focus, Button
	IniRead, 17_Path, Config.ini, Paths, 1.7_Dir
	IniRead, 18_Path, Config.ini, Paths, 1.8_Dir
	IniRead, 112_Path, Config.ini, Paths, 1.12_Dir
	IniRead, 116_Path, Config.ini, Paths, 1.16_Dir
	IniRead, 117_Path, Config.ini, Paths, 1.17_Dir
	IniRead, CosmeticTextures, Config.ini, LC, DisableCosmeticTextures
	Gui, Main: Hide
	Gui, Options: New
	Gui, -MaximizeBox -MinimizeBox +OwnDialogs
	Gui, Add, Text,, 1.7 Directory
	Gui, Add, Edit, w260 h20 v17Dir, %17_Path%
	Gui, Add, Text,, 1.8 Directory
	Gui, Add, Edit, w260 h20 v18Dir, %18_Path%
	Gui, Add, Text,, 1.12 Directory
	Gui, Add, Edit, w260 h20 v112Dir, %112_Path%
	Gui, Add, Text,, 1.16 Directory
	Gui, Add, Edit, w260 h20 v116Dir, %116_Path%
	Gui, Add, Text,, 1.17 Directory
	Gui, Add, Edit, w260 h20 v117Dir, %117_Path%
	Gui, Add, Text,, Launch Options
	If (CosmeticTextures = 1){
		Gui, Add, Checkbox, Checked vCosmeticDelayFix, Disable Cosmetics
	}
	Else {
		Gui, Add, Checkbox, vCosmeticDelayFix, Disable Cosmetics
	}
	Gui, Add, Button, x255 w50 h25 vSave gSave +default, Save
	Gui, Add, Button, x280 y23 w25 h25 g17FolderSelect, ✎
	Gui, Add, Button, x280 y68 w25 h25 g18FolderSelect, ✎
	Gui, Add, Button, x280 y113 w25 h25 g112FolderSelect, ✎
	Gui, Add, Button, x280 y158 w25 h25 g116FolderSelect, ✎
	Gui, Add, Button, x280 y203 w25 h25 g117FolderSelect, ✎
	GuiControl, Focus, Save
	GuiControl, Focus, +default
	Gui, Show,, ⠀
	Gui Options:+LastFound 
	hWnd := WinExist() 
	hSysMenu:=DllCall("GetSystemMenu","Int",hWnd,"Int",FALSE) 
	nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu) 
	DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-6,"Uint","0x400") 
	DllCall("DrawMenuBar","Int",hWnd)
}

17FolderSelect(){
	IniRead, 17_Path, Config.ini, Paths, 1.7_Dir
	FileSelectFolder, 17PathSelected, *%17_Path%, 3, Select a Directory for Lunar Client 1.7
	if 17PathSelected =
		return
	else
		guicontrol,, 17Dir, %17PathSelected%
}

18FolderSelect(){
	IniRead, 18_Path, Config.ini, Paths, 1.8_Dir
	FileSelectFolder, 18PathSelected, *%18_Path%, 3, Select a Directory for Lunar Client 1.8
	if 18PathSelected =
		return
	else
		guicontrol,, 18Dir, %18PathSelected%
	
}

112FolderSelect(){
	IniRead, 112_Path, Config.ini, Paths, 1.12_Dir
	FileSelectFolder, 112PathSelected, *%112_Path%, 3, Select a Directory for Lunar Client 1.12
	if 112PathSelected =
		return
	else
		guicontrol,, 112Dir, %112PathSelected%
	
}

116FolderSelect(){
	IniRead, 116_Path, Config.ini, Paths, 1.16_Dir
	FileSelectFolder, 116PathSelected, *%116_Path%, 3, Select a Directory for Lunar Client 1.16
	if 116PathSelected =
		return
	else
		guicontrol,, 116Dir, %116PathSelected%
	
}

117FolderSelect(){
	IniRead, 117_Path, Config.ini, Paths, 1.17_Dir
	FileSelectFolder, 117PathSelected, *%117_Path%, 3, Select a Directory for Lunar Client 1.17
	if 117PathSelected =
		return
	else
		guicontrol,, 117Dir, %117PathSelected%
	
}

Save(){
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
	IniWrite, %TextureLoad%, Config.ini, LC, DisableCosmeticTextures
	Gui, Main: Show
	Gui, Destroy
	SetTitleMatchMode, 2
	WinActivateBottom, Lunar Client Lite ahk_class AutoHotkeyGUI
	#WinActivateForce
}


OptionsGuiClose(){
	Gui, Main: Show
	Gui, Destroy
	SetTitleMatchMode, 2
	WinActivateBottom, Lunar Client Lite ahk_class AutoHotkeyGUI
	#WinActivateForce
}
