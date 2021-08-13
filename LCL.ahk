#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
#NoTrayIcon
Progress=0
LegacyDir=0
ModernDir=0
Launch=0
Save=0
;File Existence Checks
IfNotExist, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	LCCheck()
IfNotExist, Config.ini
	ConfigCreate()
IfNotExist, wrapper.cmd
	nowrappercmd()

;GUI
Gui, New
Gui, -MaximizeBox -MinimizeBox +OwnDialogs
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Add, Text,, JVM Arguments
Gui, Add, Edit, w255 h75, %GUIArguments%
Gui, Add, Text, x10 y105, Version:
Gui, Add, ListBox, x10 y121 gVersionWrite c30 r5, 1.7|1.8|1.12|1.16|1.17
Gui, Add, Button, x270 y20 w25 h25 gAbout, ?
Gui, Add, Button, w25 h25 gUpdateDependencies, ❐
Gui, Add, Button, w25 h25 gPathGUIConfig, ✎
VersionRead()
Gui, Add, Button, x191 y141 w100 h50 gLaunch +default vLaunch, Launch
GuiControl, Focus, Launch
GuiControl, Focus, +default
Gui, Show, w300 h200, Lunar Client Lite

;Functions
Launch(){	
	GuiControlGet, JVMArgs,, Edit1
	IniWrite, %JVMArgs%, Config.ini, LC, Arguments
	IniRead, LCArgs, Config.ini, LC, Arguments
	IniRead, LCVer, Config.ini, LC, Version
	IniRead, MCAssetIndex, Config.ini, Minecraft, AssetIndex
	IniRead, OptiPatchToggle, Config.ini, Minecraft, OptiPatch
	VersionCheck()
	IfNotExist, wrapper.cmd
		DependencyRemoved()
	IniRead, PathVersion, Config.ini, LC, Version
	If (PathVersion = 1.7) 
	{
		IniRead, Path, Config.ini, Paths, Legacy
	}	
	Else If (PathVersion = 1.8) 
	{
		IniRead, Path, Config.ini, Paths, Legacy
	}
	Else If (PathVersion = 1.12) 
	{
		IniRead, Path, Config.ini, Paths, Modern
	}
	Else If (PathVersion = 1.16) 
	{
		IniRead, Path, Config.ini, Paths, Modern
	}
	Else If (pathVersion = 1.17) 
	{
		IniRead, Path, Config.ini, Paths, Modern
	}
	Run, wrapper.cmd "%LCVer%" "%MCAssetIndex%" "%LCArgs%" "%Path%",, Hide
	Sleep, 100 
	ExitApp
}

ConfigCreate()
{
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	IniWrite, '1.8', Config.ini, LC, Version
	IniWrite, '1.8', Config.ini, Minecraft, AssetIndex
	IniWrite, -Xms3G -Xmx3G, Config.ini, LC, Arguments	
	IniWrite, 0, Config.ini, Minecraft, OptiPatch
	PathConfig()
}

VersionWrite()
{
	GuiControlGet, UserVersion,, ListBox1
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
		GuiControl, Choose, ListBox1, 1
	}	
	Else If (GUIVersion = 1.8) 
	{
		GuiControl, Choose, ListBox1, 2
	}
	Else If (GUIVersion = 1.12) 
	{
		GuiControl, Choose, ListBox1, 3
	}
	Else If (GUIVersion = 1.16) 
	{
		GuiControl, Choose, ListBox1, 4
	}
	Else If (GUIVersion = 1.17) 
	{
		GuiControl, Choose, ListBox1, 5
	}
	return
}

About(){
	MsgBox, 64, About, Made by Aetopia`nhttps://github.com/Aetopia/Lunar-Client-Lite-Launcher
}
DependencyRemoved(){
	Gui,Destroy
	MsgBox, 16, Launch Error, LC Lite has detected a dependency missing.`nClick on OK to download the missing dependency and then relaunch LC Lite.
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	IfNotExist, wrapper.cmd
		NotExist(1)
	MsgBox, 64, Dependency Downloaded, The missing dependency have been downloaded!, 5	
	ExitApp
}
LCCheck(){
	MsgBox, 16, Error: Lunar Client Not Installed, No Lunar Client installation is present on this device.`nClick on OK to install the latest version of Lunar Client.
	Gui, New
	Gui, -MaximizeBox -MinimizeBox
	Gui, Add, Progress, w200 h20 vProgress, 20
	Gui, Add, Text,, Downloading Lunar Client..
	Gui,Show,, Lunar Client Lite
	URLDownloadToFile, https://launcherupdates.lunarclientcdn.com/latest.yml, C:\Users\%A_UserName%\AppData\Local\Temp\ver.txt
	FileReadLine, LauncherYML, C:\Users\%A_UserName%\AppData\Local\Temp\ver.txt, 1
	StringTrimLeft, LauncherVer, LauncherYML, 9
	URLDownloadToFile, https://launcherupdates.lunarclientcdn.com/Lunar Client v%LauncherVer%.exe, C:\Users\%A_UserName%\AppData\Local\Temp\lunar.exe
	GuiControl,, Progress, +100
	Sleep 500
	Gui, Destroy
	IfNotExist, C:\Users\%A_UserName%\AppData\Local\Temp\lunar.exe
		LCNotExist()
	FileExist, ("%Temp%\lunar.exe")
		Run, C:\Users\%A_UserName%\AppData\Local\Temp\lunar.exe
	ExitApp	
}
LCNotExist(){
	Gui,Destroy
	MsgBox, 16, Download Error, Lunar Client couldn't be downloaded.`nCheck your internet connection and try again.
	ExitApp
}



VersionCheck(){
	IniRead, CheckVersion, Config.ini, LC, Version
	If (CheckVersion = 1.7){
		IfNotExist, C:\Users\%A_UserName%\.lunarclient\offline\1.7
			FileCheck(1.7)
		return	
	}
	If (CheckVersion = 1.8){
		IfNotExist, C:\Users\%A_UserName%\.lunarclient\offline\1.8
			FileCheck(1.8)
		return	
	}
	If (CheckVersion = 1.9){
		IfNotExist, C:\Users\%A_UserName%\.lunarclient\offline\1.9
			FileCheck(1.9)
		return	
	}
	If (CheckVersion = 1.12){
		IfNotExist, C:\Users\%A_UserName%\.lunarclient\offline\1.12
			FileCheck(1.12)
		return	
	}
	If (CheckVersion = 1.16){
		IfNotExist, C:\Users\%A_UserName%\.lunarclient\offline\1.16
			FileCheck(1.16)
		return	
	}
	If (CheckVersion = 1.17){
		IfNotExist, C:\Users\%A_UserName%\.lunarclient\offline\1.17
			FileCheck(1.17)
		return	
	}
}

FileCheck(n){
	MsgBox, 16, Error: Version Not Found, LC %n% wasn't found on this device!`nPlease install LC %n%! 
	Run, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	ExitApp
}
	
nowrappercmd(){
	MsgBox, 16, Error: Dependency not found,"wrapper.cmd" wasn't found.`nClick on the "OK" button to download the dependency.
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	IfNotExist, wrapper.cmd
		NotExist(1)
}
	


UpdateDependencies(){
	FileDelete, C:\Users\%A_UserName%\AppData\Local\Temp\internetcheck.ico
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/Logo.ico, C:\Users\%A_UserName%\AppData\Local\Temp\internetcheck.ico
	IfNotExist, C:\Users\%A_UserName%\AppData\Local\Temp\internetcheck.ico
		NotExist(1)
	IfExist, C:\Users\%A_UserName%\AppData\Local\Temp\internetcheck.ico
		MsgBox, 64, Dependency Updated, LC Lite's dependency is now updated!
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

GuiClose(){
	ExitApp
}

;Custom Paths
;------------------------------------------------------------------------------------
PathConfig(){
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, Legacy
	IniWrite, %A_AppData%\.minecraft, Config.ini, Paths, Modern
}

PathGUIConfig(){
	IniRead, LPath, Config.ini, Paths, Legacy
	IniRead, MPath, Config.ini, Paths, Modern
	Gui, Dir: New
	Gui, -MaximizeBox -MinimizeBox +OwnDialogs
	IniRead, LPath, Config.ini, Paths, Legacy
	IniRead, MPath, Config.ini, Paths, Modern
	Gui, Add, Text,, Legacy Directory
	Gui, Add, Edit, w260 h20 vLegacyDir, %LPath%
	Gui, Add, Text,, Modern Directory
	Gui, Add, Edit, w260 h20 vModernDir, %MPath%
	Gui, Add, Button, x255 y110 w50 h25 vSave gSave +default, Save
	Gui, Add, Button, x280 y23 w25 h25 gLFolderSelect, ✎
	Gui, Add, Button, x280 y68 w25 h25 gMFolderSelect, ✎
	GuiControl, Focus, Save
	GuiControl, Focus, +default
	Gui, Show,, Directory Options
}

LFolderSelect(){
	FileSelectFolder, LPathSelected,, 3, Select a Directory for Lunar Client 1.7-1.8
	guicontrol,, LegacyDir, %LPathSelected%
}

MFolderSelect(){
	FileSelectFolder, MPathSelected,, 3, Select a Directory for Lunar Client 1.12-1.17
	guicontrol,, ModernDir, %MPathSelected%
	
}

Save(){
	Gui, Submit
	guicontrolget, LPath,, LegacyDir
	guicontrolget, MPath,, ModernDir
	IniWrite, %LPath%, Config.ini, Paths, Legacy
	IniWrite, %MPath%, Config.ini, Paths, Modern
}

DirGuiClose(){
	Gui, Destroy
}
