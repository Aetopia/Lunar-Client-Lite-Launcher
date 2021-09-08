#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
ListLines Off
#SingleInstance, Force
#NoTrayIcon
;Command Line Arguments
Arguments := ["1.7", "1.8", "1.12", "1.16", "1.17"]
for n, param in A_Args  ; For each parameter:
{
	If (param=1.7){
		LCVer=1.7
		MCAssetIndex=1.7.10
		IniRead, Path, Config.ini, Paths, 1.7_Dir
	}
	else If (param=1.8){
		LCVer=1.8
		MCAssetIndex=1.8
		IniRead, Path, Config.ini, Paths, 1.8_Dir
	}
	else If (param=1.12){
		LCVer=1.12
		MCAssetIndex=1.12
		IniRead, Path, Config.ini, Paths, 1.12_Dir
	}
	else If (param=1.16){
		LCVer=1.16
		MCAssetIndex=1.16
		IniRead, Path, Config.ini, Paths, 1.16_Dir
	}
	else If (param=1.17){
		LCVer=1.17
		MCAssetIndex=1.17
		IniRead, Path, Config.ini, Paths, 1.17_Dir
	}
	else
	{
		MsgBox, 16, Invaild Argument, Lunar Client Lite doesn't recognize "%param%" as a vaild argument.
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
	If (TexturesToggle=1){
		Textures=%UserProfile%\.lunarclient\textures
	}
	Try{
		Run, %LaunchJRE% --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" --add-opens java.base/java.io=ALL-UNNAMED %LCArgs% -Djava.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" -cp "%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-1-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-2-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-3-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-libs.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-prod-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\OptiFine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\vpatcher-prod.jar" com.moonsworth.lunar.patcher.LunarMain --version %LCVer% --accessToken 0 --assetIndex %MCAssetIndex% --userProperties {} --gameDir "%Path%" --texturesDir "%Textures%" --width 854 --height 480
		ExitApp
	}
	Catch Error {
		MsgBox, 16, Launch Error, Lunar Client Lite couldn't launch Lunar Client.`nCheck your specified Java Executable.
		ExitApp
	}	
}
Progress=0
EnvGet, vHomeDrive, HOMEDRIVE
EnvGet, vHomePath, HOMEPATH
UserProfile=% vHomeDrive vHomePath
;File Existence Checks
IfNotExist, %UserProfile%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	LCCheck()
IfNotExist, Config.ini
	ConfigCreate()
IfNotExist, %A_WorkingDir%\Resources
	FileCreateDir, %A_WorkingDir%\Resources
IfNotExist, Resources/Banner.png
	Resources(2)
;GUI
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Main:Default
Gui, -MaximizeBox -MinimizeBox
Gui, Font, s10
Gui, Add, Tab3, w490 h385 x6 Top +Background, Home|Game|Launcher|About
Gui, Font, s8
Gui, Add, Picture, x8 y32, Resources/Banner.png
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Tab, 1
Gui, Font, s10
Gui, Add, Button, x195 y340 w110 h40 gLaunch +default vLaunch, Launch
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
Gui, Add, Text,, 1.7 Directory
Gui, Add, Edit, w230 h20 v17Dir, %17_Path%
Gui, Add, Text,, 1.8 Directory
Gui, Add, Edit, w230 h20 v18Dir, %18_Path%
Gui, Add, Text,, 1.12 Directory
Gui, Add, Edit, w230 h20 v112Dir, %112_Path%
Gui, Add, Text,, 1.16 Directory
Gui, Add, Edit, w230 h20 v116Dir, %116_Path%
Gui, Add, Text,, 1.17 Directory
Gui, Add, Edit, w230 h20 v117Dir, %117_Path%
Gui, Add, Text,, Launch Options
If (CosmeticTextures = 1){
	Gui, Add, Checkbox, Checked vCosmeticDelayFix, Cosmetics
}
Else	 {
	Gui, Add, Checkbox, vCosmeticDelayFix, Cosmetics
}
Gui, Add, Button, x255 y57 w25 h24 g17FolderSelect, ✎
Gui, Add, Button, x255 y104 w25 h24 g18FolderSelect, ✎
Gui, Add, Button, x255 y151 w25 h24 g112FolderSelect, ✎
Gui, Add, Button, x255 y198 w25 h24 g116FolderSelect, ✎
Gui, Add, Button, x255 y245 w25 h24 g117FolderSelect, ✎
Gui, Font, s10
Gui, Add, Button, x381 y343 w100 h40 vSave gSave, Save
Gui, Font, s8
Gui, Add, Text, x290 y41, JVM Arguments
Gui, Add, Edit, x290 y58 w190 h275 vArgs, %GUIArguments%

Gui, Tab, 3
Gui, Add, Text,, Java Executable
IniRead, GUIJRE, Config.ini, Minecraft, JRE
Gui, Add, Edit, h20 w400 vJRE +ReadOnly, %GUIJRE%
Gui, Add, Text,, Specify your own Java Executable to use with Lunar Client.
Gui, Add, Text,, Assets Folder
IniRead, Assets, Config.ini, Minecraft, Assets
Gui, Add, Edit, h20 w400 vAssets +ReadOnly, %Assets%
Gui, Add, Text,, Specify an Assets folder from which Lunar Client Lite should pull Minecraft assets from.
Gui, Add, Button, x425 y57 w25 h24 gJRESelect, ✎
Gui, Add, Button, x425 y132 w25 h24 gAssetsFolderSelect, ✎

Gui, Tab, 4 
Gui, Add, Link,, Lunar Client Lite made by <a href="https://github.com/Aetopia">Aetopia</a>
Gui, Add, Link,, GitHub Repository: <a href="https://github.com/Aetopia/Lunar-Client-Lite-Launcher">https://github.com/Aetopia/Lunar-Client-Lite-Launcher</a>
Gui, Add, Link,, Couleur Tweaks Tips Discord: <a href="https://dsc.gg/ctt">https://dsc.gg/ctt</a>
Gui, Add, Text, w463 0x10
Gui, Add, Text,, Set Lunar Client Lite's settings to default and download a fresh set of resources.
Gui, Add, Button, gReset, Reset
Gui, Add, Text,, Open the Logs Folder.
Gui, Add, Button, gLogs, Open
Gui, Show, w500 h400, Lunar Client Lite
GuiControl, Focus, Launch
GuiControl, Focus, +default

;Functions
Launch(){	
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
	FileCopyDir, %Assets%\indexes, %Path%\assets\indexes, 0
	FileCopyDir, %Assets%\objects, %Path%\assets\objects, 0
	If (TexturesToggle=1){
		Textures=%UserProfile%\.lunarclient\textures
	}
	Try{
		Run, %LaunchJRE% --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" --add-opens java.base/java.io=ALL-UNNAMED %LCArgs% -Djava.library.path="%USERPROFILE%\.lunarclient\offline\%LCVer%\natives" -cp "%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-1-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-2-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-assets-prod-3-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-libs.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\lunar-prod-optifine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\OptiFine.jar";"%USERPROFILE%\.lunarclient\offline\%LCVer%\vpatcher-prod.jar" com.moonsworth.lunar.patcher.LunarMain --version %LCVer% --accessToken 0 --assetIndex %MCAssetIndex% --userProperties {} --gameDir "%Path%" --texturesDir "%Textures%" --width 854 --height 480
	}
	Catch Error
		MsgBox, 16, Launch Error, Lunar Client Lite couldn't launch Lunar Client.`nCheck your specified Java Executable.
	ExitApp
}

ConfigCreate()
{
	IniWrite, '1.8', Config.ini, LC, Version
	IniWrite, '1.8', Config.ini, Minecraft, AssetIndex
	IniWrite, -Xms3G -Xmx3G -XX:+DisableAttachMechanism, Config.ini, LC, Arguments	
	IniWrite, 1, Config.ini, LC, Cosmetics
	IniWrite, %A_AppData%\.minecraft\assets, Config.ini, Minecraft, Assets
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	UserProfile=% vHomeDrive vHomePath
	Loop, Files, %UserProfile%\.lunarclient\jre\zulu*, D
		IniWrite, %A_LoopFileLongPath%\bin\javaw.exe, Config.ini, Minecraft, JRE
	PathConfig()
}

Resources(x){
	If (x=1){
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Logo.png, Resources/Main.png
	}
	If (x=2){
		URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Banner.png, Resources/Banner.png
	}
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

LCCheck(){
	MsgBox, 16, Error: Lunar Client Not Installed, No Lunar Client installation is present on this device.`nClick on OK to install the latest version of Lunar Client.
	Gui, Install:New
	Gui, -MaximizeBox -MinimizeBox
	Gui, Add, Progress, w200 h20 vProgress cGreen, 20
	Gui, Add, Text,, Downloading Lunar Client...
	Gui, Show,, Lunar Client Lite
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

Logs(){
	GuiControl, Focus, Button
	IfExist, %A_WorkingDir%\logs
	Run, %A_WorkingDir%\logs,, Max
	IfNotExist, %A_WorkingDir%\logs
		MsgBox, 16, Error, Lunar Client Lite couldn't find any Logs folder.
}

Reset(){
	FileDelete, Config.ini
	FileRemoveDir, Resources, 1
	Reload
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
	GuiControlGet, JVMArgs,, Args
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
	IniWrite, %JVMArgs%, Config.ini, LC, Arguments
	MsgBox, 64, Settings Saved, Your Settings are now saved., 1
}

;Experiments

JRESelect(){
	IniRead, SavedJRE, Config.ini, Minecraft, JRE
	FileSelectFile, SelectedJRE, 1, %SavedJRE%, Select a new Java Executable, Java Executable (javaw.exe)
	if SelectedJRE=
		return
	else
		IniWrite, %SelectedJRE%, Config.ini, Minecraft, JRE
		guicontrol,, JRE, %SelectedJRE%
}

AssetsFolderSelect(){
	IniRead, Assets, Config.ini, Minecraft, Assets
	FileSelectFolder, AssetsFolderSelected, *%Assets%, 3, Select an Assets folder
	if AssetsFolderSelected =
		return
	else
		guicontrol,, Assets, %AssetsFolderSelected%
	IniWrite, %AssetsFolderSelected%, Config.ini, Minecraft, Assets
}
