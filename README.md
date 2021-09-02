# <img src="https://github.com/Aetopia/Lunar-Client-Lite-Launcher/blob/main/Logo.png" alt="image.png" width="30" height="30">  Lunar Client Lite Launcher

Lunar Client Lite is a simple lightweight and unlocked launcher for Lunar Client which features the following: 
1. Quick Version Switching 
2. Custom JVM Arguments Support 
3. Multi Launch Directory Support
4. A Simple-to-Use Interface  

## Requirements
Before you begin using LC Lite, make sure that you have Lunar Client installed and also ensure you have your favourite LC versions installed.  
(If you don't have LC installed then LC Lite will download the latest Lunar Client installer.)  

<b>LC Lite will only work if you have bought Minecraft.</b>
## How to use & setup?
<b>Make sure to unblock `LCL.exe` in your antivirus protection settings incase if it gets false flagged.</b>
1. Download the latest release from here.  
https://github.com/Aetopia/Lunar-Client-Lite-Launcher/releases  

2. Start `LCL.exe`.

3. Once LC Lite is started, it should look like this:  

![image.png](https://i.imgur.com/MMvMBFz.png)

4. Configuring LCL's Minecraft's Options.  
Click on the `Game` Tab.    

![image.png](https://i.imgur.com/chJyWil.png)  

You can specify custom JVM Arguments within the `JVM Arguments` section.  
By default the arguments are set to `-Xms3G -Xmx3G -XX:+DisableAttachMechanism`. 

Here, you can set up a Custom Launch Directory for LC 1.7-1.17 by clicking on `✎`.   

Unchecking the `Cosmetics` toggle can reduce LC's startup time and also fixes the `"Title Screen Freeze upon Launch"` or `"Not Responding upon Launch"` issue.    
Unchecking this option will entirely disable cosmetics. This change is client sided only.  

Click on the `Save` button to save your settings.

5. Configuring LCL's Options.
Click on the `Launcher` Tab.  

![image.png](https://i.imgur.com/2nWvbZe.png) 

Here, you can do the following:
 - Specify a custom Java Executable for Lunar Client to use. Click on the `✎` to specify a Java Executable.
 - Specify a new `Assets` folder for Lunar Client Lite to pull Minecraft assets from. Click on the `✎` to specify a new `Assets` folder.


6. Click on the `About` Tab to view information on Lunar Client Lite.
 
![image.png](https://i.imgur.com/3aJcYrE.png)

In the `About` Tab, you can click on the given links to view my GitHub Profile, to view LC Lite's GitHub Repository and an invite link to join Couleur Tweak Tips Discord Server.  

If you click on the `Refresh` button, you can reset LC Lite's Settings and download a fresh set of resources from LC Lite's GitHub Repository.  

If you click on the `Open` button, you can open up LC Lite's Logs Folder.  

7. Select any version, you would like to use via the `Version` Dropdown List.<br><br>![image.png](https://i.imgur.com/Eqq1qV2.png)

8. Finally click on the launch button to launch Lunar Client!  
<i>LC not launching via LC Lite? Make sure you have your desired versions installed via the official LC Launcher!</i>  
<b>NOTE: To update Lunar Client and its dependencies, you must use the official LC launcher to update them.</b>


### JREs compatible with Lunar Client

- GraalVM Java 16: https://github.com/graalvm/graalvm-ce-builds/releases 

Optimized JVM Arguments for GraalVM Java 16 JRE originally made by [he3als](https://github.com/he3als), I have only added `-Xmn1G` to the original arguments.
```
-Xms3G -Xmx3G -Xmn1G -XX:+DisableAttachMechanism -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+EagerJVMCI -Djvmci.Compiler=graal
```

### Zulu x64 Java 16 JRE JVM Arguments  

1. These arguments are useful if you are running low on RAM.

```
-Xms1G -Xmx1G -Xmn768m -XX:+DisableAttachMechanism 
```

2. This is a slightly modified version of MC's default arguments for OpenJDK 16. From what I have seen using these arguments will make LC use 3 GB (5 and above will cause memory leaks) RAM and should provide optimal performance.  

 ```
-Xms3G -Xmx3G -Xmn1G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M
```  
3. This is a slightly modified version of MC's default arguments for OpenJDK 16. Here MC clears out RAM more slowly as compared to any other arguments listed here. This should also provide optimal performance alongside the other arguments listed here.

```
-XX:+UseG1GC -Xmx3G -Xms3G -Xmn1G -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M
```
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
[![image.png](https://i.postimg.cc/5yJkDYfn/image.png)](https://postimg.cc/TLk9DPLD)  
Here, you can view the latest log for the latest Lunar Client instance or view any log for a previous Lunar Client instance.

## Credits
<b>Original launch command made by [`lemons#2555`](https://github.com/respecting)  
LCLI Settings Patcher made by [CTT](https://dsc.gg/CTT) (Original Optifine Patcher made by [`temp#0001`](https://github.com/temp2742))  
This Project is based off [LCLI](https://github.com/couleur-tweak-tips/utils/blob/main/LCLI.bat) made by [Couleur](https://github.com/couleurm)</b>

