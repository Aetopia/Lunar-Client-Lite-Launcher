#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
#NoTrayIcon
;Visiblity Variables
OptiPatchVisiblity = 1
IfNotExist, C:\Users\%A_UserName%\AppData\Local\Programs\lunarclient\Lunar Client.exe
	LCCheck()
;GUI for LC Mini
IfNotExist, Config.ini
	ConfigCreate()
IfNotExist, wrapper.cmd
	nowrappercmd()
;GUI
Gui, New
IniRead, GUIArguments, Config.ini, LC, Arguments
Gui, Add, Text,, Java VM Arguments:
Gui, Add, Edit, w550 h21, %GUIArguments%
;Removes the Optifine Patcher Option if Patcher.cmd doesn't exist
IfNotExist, patcher.cmd
	OptiPatchVisiblity = 0
If (OptiPatchVisiblity = 1){
Gui, Add, Text,, Game Options:
IniRead, OptiPatchToggle, Config.ini, Minecraft, OptiPatch
If (OptiPatchToggle = 1){
	Gui, Add, Checkbox, Checked vOptiPatch gOptiPatchToggle, Optifine Patcher
}
else if (OptiPatchToggle = 0){
	Gui, Add, Checkbox, vOptiPatch gOptiPatchToggle, Optifine Patcher
}
}
Gui, Add, Text, x10 y300, Version:
Gui, Add, Button, x560 y23 w25 h25 gJVMArgsHelp, ?
Gui, Add, ListBox, gVersionWrite c30 r5 x10 y315, 1.7|1.8|1.12|1.16|1.17
VersionRead()
Gui, Add, Button, x492 y335 w100 h50 gLaunch, Launch
GuiControl, Focus, Button1
Gui, Show, w600 h400, LC Lite

;Functions
Launch(){	
	GuiControlGet, JVMArgs,, Edit1
	IniWrite, '%JVMArgs%', Config.ini, LC, Arguments
	IniRead, LCArgs, Config.ini, LC, Arguments
	IniRead, LCVer, Config.ini, LC, Version
	IniRead, MCAssetIndex, Config.ini, Minecraft, AssetIndex
	IniRead, OptiPatchToggle, Config.ini, Minecraft, OptiPatch
	If (OptiPatchVisiblity = 1){
	If (OptiPatchToggle=1){
		OptifinePatcher()
	}
	}
     Run, wrapper.cmd %LCVer% %MCAssetIndex% %LCArgs%,, Hide
	Sleep, 250
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

JVMArgsHelp(){
	MsgBox,, Help: JVM Arguments,Here, you can set custom JVM arguments for LC. Only change the JVM arguments if you know what you are doing! Always make sure you enclose the arguments with double quotes!
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
;Patches your optifine settings.
OptifinePatcher(){
	IniRead, PatcherVersion, Config.ini, LC, Version
	If (PatcherVersion = 1.7){
		run, patcher.cmd "1",, hide
	}
	else If (PatcherVersion = 1.8){
		run, patcher.cmd "2",, hide
	}
	else If (PatcherVersion = 1.12 or patcherVersion = 1.16 or patcherVersion = 1.17){
		run, patcher.cmd "3",, hide
	}
	return
	}
nowrappercmd(){
	MsgBox,, Important File not found.,"wrapper.cmd" wasn't found. It is required for the functioning of LC Lite.
     ExitApp
}
GuiClose(){
	ExitApp
}
