#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
#NoTrayIcon

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
Gui, Add, Text,, Java VM Arguments:
Gui, Add, Edit, w260 h20, %GUIArguments%
Gui, Add, Text,, Game Options:
IniRead, OptiPatchToggle, Config.ini, Minecraft, OptiPatch
If (OptiPatchToggle = 1){
	Gui, Add, Checkbox, Checked vOptiPatch gOptiPatchToggle, OptiFine Patcher
}
else if (OptiPatchToggle = 0){
	Gui, Add, Checkbox, vOptiPatch gOptiPatchToggle, OptiFine Patcher
}
Gui, Add, Button, x110 y65 gConfigurePatcher, Configure
Gui, Add, Text, x10 y105, Version:
Gui, Add, ListBox, x10 y121 gVersionWrite c30 r5, 1.7|1.8|1.12|1.16|1.17
Gui, Add, Button, x272 y22 w25 h25 gAbout, ?
VersionRead()
Gui, Add, Button, x191 y141 w100 h50 gLaunch +default, Launch
GuiControl, Focus, Button4
GuiControl, Focus, +default
Gui, Show, w300 h200, LC Lite

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
	Run, wrapper.cmd %LCVer% %MCAssetIndex% %LCArgs%,, Hide
	Process, Exist, cmd.exe
	Sleep, 100
	Process, Close, cmd.exe
	ExitApp
}

ConfigCreate()
{
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
	MsgBox,, About, Made by Aetopia`nhttps://github.com/Aetopia/Lunar-Client-Lite-Launcher
}

LCCheck(){
	MsgBox,, No LC Installation Detected, No Lunar Client installation is present on this device.`nPlease download the latest version of Lunar Client!
     	Run, https://www.lunarclient.com/download/
	ExitApp
}

OptiPatchToggle(){
	GuiControlGet, OptiPatch
	If (OptiPatch = 1){
		IniWrite, 1, Config.ini, Minecraft, OptiPatch
	}	
	else{ 
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
	else If (PatcherVersion = 1.8){
		run, patcher.cmd "2",, hide
		Process, Exist, cmd.exe
		Sleep, 250
		Process, Close, cmd.exe
	}
	else If (PatcherVersion = 1.12 or patcherVersion = 1.16 or patcherVersion = 1.17){
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
	If (CheckVersion = 1.7) 
	{
		IfNotExist C:\Users\%A_UserName%\.lunarclient\offline\1.7
		MsgBox,, Error: Version not installed., LC 1.7 wasn't found on your device.`nPlease download LC 1.7!
		Run, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
		ExitApp
	}	
	Else If (CheckVersion = 1.8) 
	{
		IfNotExist C:\Users\%A_UserName%\.lunarclient\offline\1.8
		MsgBox,, Error: Version not installed., LC 1.8 wasn't found on your device.`nPlease download LC 1.8!
		Run, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
		ExitApp
	}
	Else If (CheckVersion = 1.12) 
	{
		IfNotExist C:\Users\%A_UserName%\.lunarclient\offline\1.12
		MsgBox,, Error: Version not installed., LC 1.12 wasn't found on your device.`nPlease download LC 1.12!
		Run, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
		ExitApp	
	}
	Else If (CheckVersion = 1.16) 
	{
		IfNotExist C:\Users\%A_UserName%\.lunarclient\offline\1.16
		MsgBox,, Error: Version not installed., LC 1.16 wasn't found on your device.`nPlease download LC 1.16!
		Run, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
		ExitApp	
	}
	Else If (CheckVersion = 1.17) 
	{
		IfNotExist C:\Users\%A_UserName%\.lunarclient\offline\1.17
		MsgBox,, Error: Version not installed., LC 1.17 wasn't found on your device.`nPlease download LC 1.17!
		Run, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
		ExitApp
	}
	return
}

;Dependencies	
nowrappercmd(){
	MsgBox,, Error: Dependency not found.,"wrapper.cmd" wasn't found. It is required for the functioning of LC Lite.
     ExitApp
}

nopatchercmd(){
	MsgBox,, Error: Dependency not found.,"patcher.cmd" wasn't found. It is required for the functioning of LC Lite.
     ExitApp
}

GuiClose(){
	ExitApp
}
