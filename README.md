# <img src="https://github.com/Aetopia/Lunar-Client-Lite-Launcher/blob/main/Logo.png" alt="image.png" width="30" height="30">  Lunar Client Lite Launcher

Lunar Client Lite is a simple lightweight and unlocked launcher for Lunar Client which features the following: 
1. Quick Version Switching 
2. JVM Arguments Support 
3. Multi Launch Directories Support
4. User Defined Java Executable Support
5. A Simple-to-Use Interface  
## Credits
<b>Original launch command made by [lem6ns](https://github.com/lem6ns)  
LCLI Settings Patcher made by [CTT](https://dsc.gg/CTT) (Original Optifine Patcher made by [`temp#0001`](https://github.com/temp2742))  
This Project is based off [LCLI](https://github.com/couleur-tweak-tips/utils/blob/main/LCLI.bat) made by [Couleur](https://github.com/couleurm)</b>

### Translators
Arabic: amine#0001 & rezic#6249   
French: [Couleur#9249](https://github.com/couleurm)   
Georgian: zazk#0904  
Chinese: [Cang-Yue](https://github.com/Cang-Yue)
Spanish: Fumiko!?#6685 & Cosmica#3727

## Requirements
Before you begin using LC Lite, make sure that you have Lunar Client installed and also ensure you have your favourite LC versions installed.  
(If you don't have LC installed then LC Lite will download the latest Lunar Client installer.)  

<b>LC Lite will only work if you have bought Minecraft.</b>
## How to use & setup?
<b>Make sure to unblock `LCL.exe` in your antivirus protection settings incase if it gets false flagged.</b>

<b>Check out the Lunar Client Lite Wiki to see how to setup LCL:   
  https://github.com/Aetopia/Lunar-Client-Lite-Launcher/wiki</b>  

# Extras
## Information on `wrapper.cmd`
Via `wrapper.cmd` its possible to specify arguments to launch a specific version of Lunar Client.    

To use this functionality of the script, use the following format:  
`wrapper.cmd "Version" "Asset Index of the Version" "JVM Arguments" "Directory" "Lunar Client Cosmetic Textures Directory"`  
i.e  
```
wrapper.cmd "1.8" "1.8" "-Xms3072m -Xmx3072m" "%APPDATA%\.minecraft" "%USERPROFILE%\.lunarclient\textures" 
```
This will launch `LC 1.8` and will allocate 3 GB to LC and will have cosmetic textures enabled.    

<b>OR</b>  
```
wrapper.cmd "1.8" "1.8" "-Xms3072m -Xmx3072m" "%APPDATA%\.minecraft" 
```
This will launch `LC 1.8` and will allocate 3 GB to LC and will have cosmetic textures disabled. 

## Logs
LC Lite also generates a `logs` folder.  
![image.png](https://i.postimg.cc/5yJkDYfn/image.png)    
Here, you can view the latest log for the latest Lunar Client instance or view any log for a previous Lunar Client instance.

## Command Line Arguments
Launch any version of Lunar Client and join any server directly via the command line.   

Usage:   
```
lcl <Version> <Server IP>
```

`<Version>` can be `1.7, 1.8, 1.12, 1.16, 1.17`.

Example:
```
lcl 1.8 hypixel.net
```

