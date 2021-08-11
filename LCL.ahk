#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
#NoTrayIcon
Progress=0
;File Existence Checks
IfNotExist, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	LCCheck()
IfNotExist, Config.ini
	ConfigCreate()
IfNotExist, wrapper.cmd
	nowrappercmd()
IfNotExist, patcher.cmd
	nopatchercmd()

;GUI
Gui, New
Gui, -MaximizeBox -MinimizeBox
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Add, Text,, JVM Arguments
Gui, Add, Edit, w260 h20, %GUIArguments%
Gui, Add, Text,, Game Options
IniRead, OptiPatchToggle, Config.ini, Minecraft, OptiPatch
If (OptiPatchToggle = 1){
	Gui, Add, Checkbox, Checked vOptiPatch gOptiPatchToggle, OptiFine Patcher
}
else if (OptiPatchToggle = 0){
	Gui, Add, Checkbox, vOptiPatch gOptiPatchToggle, OptiFine Patcher
}
Gui, Add, Button, x110 y65 w25 h25 gConfigurePatcher, ✎
Gui, Add, Text, x10 y105, Version:
Gui, Add, ListBox, x10 y121 gVersionWrite c30 r5, 1.7|1.8|1.12|1.16|1.17
Gui, Add, Button, x272 y22 w25 h25 gAbout, ?
Gui, Add, Button, w25 h25 gUpdateDependencies, ❐
VersionRead()
Gui, Add, Button, x191 y141 w100 h50 gLaunch +default, Launch
GuiControl, Focus, Button5
GuiControl, Focus, +default
Gui, Show, w300 h200, Lunar Client Lite

;Functions
Launch(){	
	GuiControlGet, JVMArgs,, Edit1
	IniWrite, '%JVMArgs%', Config.ini, LC, Arguments
	IniRead, LCArgs, Config.ini, LC, Arguments
	IniRead, LCVer, Config.ini, LC, Version
	IniRead, MCAssetIndex, Config.ini, Minecraft, AssetIndex
	IniRead, OptiPatchToggle, Config.ini, Minecraft, OptiPatch
	If (OptiPatchToggle=1){
		OptifinePatcher()
	}
	VersionCheck()
	IfNotExist, patcher.cmd
		DependencyRemoved()
	IfNotExist, wrapper.cmd
		DependencyRemoved()
	Run, wrapper.cmd %LCVer% %MCAssetIndex% %LCArgs%,, Hide
	Process, Exist, cmd.exe
	Sleep, 100
	Process, Close, cmd.exe
	ExitApp
}

ConfigCreate()
{
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/patcher.cmd, %A_WorkingDir%\patcher.cmd
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	IniWrite, '1.8', Config.ini, LC, Version
	IniWrite, '1.8', Config.ini, Minecraft, AssetIndex
	IniWrite, ""-Xms3G -Xmx3G"", Config.ini, LC, Arguments	
	IniWrite, 0, Config.ini, Minecraft, OptiPatch
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
	MsgBox, 16, Launch Error, LC Lite has detected a single dependency or multiple dependencies are missing.`nClick on OK to download the missing dependencies and then relaunch LC Lite.
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/patcher.cmd, %A_WorkingDir%\patcher.cmd
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	IfNotExist, patcher.cmd
		NotExist()
	MsgBox, 64, Dependencies Downloaded, The missing dependencies have been downloaded!, 5	
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

OptiPatchToggle(){
	GuiControlGet, OptiPatch
	If (OptiPatch = 1){
		IniWrite, 1, Config.ini, Minecraft, OptiPatch
	}	
	Else { 
		IniWrite, 0, Config.ini, Minecraft, OptiPatch
	}
}

OptifinePatcher(){
	IniRead, PatcherVersion, Config.ini, LC, Version
	If (PatcherVersion = 1.7){
		run, patcher.cmd "1",, hide
		Process, Exist, cmd.exe
		Sleep, 250
		Process, Close, cmd.exe
	}
	Else If (PatcherVersion = 1.8){
		run, patcher.cmd "2",, hide
		Process, Exist, cmd.exe
		Sleep, 250
		Process, Close, cmd.exe
	}
	Else If (PatcherVersion = 1.12 or patcherVersion = 1.16 or patcherVersion = 1.17){
		run, patcher.cmd "3",, hide
		Process, Exist, cmd.exe
		Sleep, 250
		Process, Close, cmd.exe
	}
	return
}

ConfigurePatcher(){
	IfExist C:\Program Files\Notepad++\notepad++.exe
		Run, C:\Program Files\Notepad++\notepad++.exe patcher.cmd
		
	IfExist C:\Program Files (x86)\Notepad++\notepad++.exe
		Run, C:\Program Files (x86)\Notepad++\notepad++.exe patcher.cmd	
	
	IfNotExist C:\Program Files\Notepad++\notepad++.exe
		Run, notepad.exe patcher.cmd	
		
	
	IfNotExist C:\Windows\notepad.exe
		MsgBox,, Error, Notepad not found!
		return	
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

;Dependencies	
nowrappercmd(){
	MsgBox, 16, Error: Dependency not found,"wrapper.cmd" wasn't found.`nClick on the "OK" button to download the dependency.
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	IfNotExist, wrapper.cmd
		NotExist()
}
NotExist(){
	MsgBox, 16, Download Failed, The dependency could not be downloaded. Check your internet connection.
	ExitApp
	}
nopatchercmd(){
	MsgBox, 16, Error: Dependency not found,"patcher.cmd" wasn't found.`nClick on the "OK" button to download the dependency.
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/patcher.cmd, %A_WorkingDir%\patcher.cmd
	IfNotExist, patcher.cmd
		NotExist()
}

UpdateDependencies(){
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/patcher.cmd, %A_WorkingDir%\patcher.cmd
	URLDownloadToFile, https://raw.githubusercontent.com/Aetopia/Lunar-Client-Lite-Launcher/main/wrapper.cmd, %A_WorkingDir%\wrapper.cmd
	MsgBox, 64, Dependencies Updated, LC Lite's dependencies are now updated!
}

GuiClose(){
	ExitApp
}
