# Project Deprecation
**I have decided on 6 January 2023 to de-archive this repository for those people who like to the project source code. Any releases will be removed only leaving the source for a given respective tag.**


# <img src="https://github.com/Aetopia/Lunar-Client-Lite-Launcher/blob/main/Logo.png" alt="image.png" width="30" height="30"> Lunar Client Lite Flavors
### Lunar Client Lite Python:  
> LCLPy (Python): https://github.com/Aetopia/LCLPy

### Lunar Client Lite AutoHotkey (Deprecated):    
> LCL (AutoHotkey): https://github.com/Aetopia/Lunar-Client-Lite-Launcher 

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

## How to use & setup?
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

