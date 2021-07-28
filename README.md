# Lunar-Client-Lite-Launcher
A lightweight launcher for Lunar Client.
## What is Lunar Client Lite?
Lunar Client Lite is a simple lightweight launcher which features the following: 
1. Optifine Settings Patcher 
2. Quick Version Switching 
3. Custom JVM Arguments Support 
4. A Simple-to-Use Interface  
## Requirements
Before you begin using LC Lite, make sure that you have Lunar Client installed and also ensure you have your favourite LC versions installed.  
(If you don't have LC installed then the application will redirect you to the download page of Lunar Client.)  
## How to use & setup?
1. Download the latest release from here.  
https://github.com/Aetopia/Lunar-Client-Lite-Launcher/releases

2. Extract the zip file's contents and then start `LC Lite.exe`.

3. Once LC Lite is started, it should look like this:  
[![LC-Lite-1vk76x-MXOY.png](https://i.postimg.cc/y8JQQ9JD/LC-Lite-1vk76x-MXOY.png)](https://postimg.cc/3kTFWkFh)

4. You can specify custom JVM Arguments within `Java VM Arguments` section.  
By default the arguments are set to `"-Xms3G -Xmx3G"`.  
You can click on the handy `?` button for help with the `Java VM Arguments` section!

5. Within the `Game Options` Section, you can enable the `OptiFine Patcher`.  
Enabling this option will patch your optifine settings, everytime you use LC Lite.  
You can use this option to keep your optifine settings tidy, everytime you switch versions.
6. You can also configure the OptiFine Patcher.  

Click on the `Configure Button`.  
If you have `Notepad++ x64` or `Notepad++ x86` then `patcher.cmd` will open in `Notepad++` else `patcher.cmd` will open in Notepad.

Here are the options you can configure within `patcher.cmd`:
```
::Configurable Settings

set FullscreenMode=Default
::'Default' will scale Minecraft according to your current resolution
::If you want it to force a downscale (like 720p) then type in 1280x720
::The main downside is long tab-out times (3-5 seconds black screens)

set FastRender=true
::Setting Fast Render false will decrease FPS but make lc motion-blur work

set SmoothFPS=false
::Setting Smooth FPS to true will decrease FPS but let more resources to OBS (e.g encoding lag)

set RenderDistance=6
set CustomSky=false

:: To set 'X' as the zoom key, it's stored as the number 45.
:: IF YOU WANT A 
set Zoom Key-old=45
set Zoom Key-new=x
:: In older versions, 45 = X for controls
```
7. You can select version you would like to use via the `Version` Listbox. 
Click on any version, you would like to use.  

8. Finally click on the launch button to launch Lunar Client!  


<b>NOTE: To update Lunar Client and its dependencies, you must use the official LC launcher to update them.</b>
### Which JVM Arguments are good for LC?  
<b>Make sure that you enclose your custom JVM Arguments entered within LC Lite with double quotes or else the entered JVM Arguments won't be detected correctly by LC Lite.</b>

LC uses OpenJDK 16 so they aren't many "optimal" JVM arguments which you can find online.  
Here is a list of arguments you can use for LC via LC Lite which I consider optimal.  

1. Using this argument can be useful if you are low on RAM since using this argument will force LC to use only 3 GB of RAM.  

```
-Xmx3G  
```

2. This is a slightly modified version of MC's default arguments for OpenJDK 16. From what I have seen using these arguments will make LC use 6 GB RAM and should provide optimal performance.  

 ```
-Xms4G -Xmx4G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M
```  
3. This is a slightly modified version of MC's default arguments for OpenJDK 16. Here MC clears out RAM more slowly as compared to any other arguments listed here. This should also provide optimal performance alongside the other arguments listed here.

```
-XX:+UseG1GC -Xmx4G -Xms4G -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M
```

# Extras
## Information about `patcher.cmd` and `wrapper.cmd`

The entire core of LC Lite is `wrapper.cmd`, LC Lite only serves as the GUI for the script.  
Using `wrapper.cmd` its possible to specify arguments to launch a specific version of Lunar Client.  

To use this functionality of the script, use the following format:  
`wrapper.cmd "Version" "Asset Index of Version" "JVM Arguments"`  
i.e  
`wrapper.cmd "1.8" "1.8" "-Xms3072m -Xmx3072m"`  
This will launch `LC 1.8`.  

You can do the same for `patcher.cmd`. This script is used to patch optifine settings.  
To use this functionality of the script, use the following format:  
`patcher.cmd "1"` for 1.7   
`patcher.cmd "2"` for 1.8   
`patcher.cmd "3"` for 1.12+

## Credits
<b>Original launch command made by [`lemons#2555`](https://github.com/respecting)  
LCLI Settings Patcher made by [CTT](https://dsc.gg/CTT) (Original Optifine Patcher made by `temp`)  
Project inspired by [LCLI](https://github.com/couleur-tweak-tips/utils/blob/main/LCLI.bat)</b>  

