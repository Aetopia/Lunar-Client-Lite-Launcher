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
[![github.png](https://i.postimg.cc/pVp3MkDD/github.png)](https://postimg.cc/CdpcjGr1)

4. You can specify custom JVM Arguments within `Java VM Arguments` section.  
By default the arguments are set to `"-Xms3G -Xmx3G"`.  
You can click on the handy `?` button for help with the `Java VM Arguments` section!

5. Within the `Game Options` Section, you can enable the `Optifine Patcher`.  
Enabling this option will patch your optifine settings, everytime you use LC Lite.  
You can use this option to keep your optifine settings tidy, everytime you switch versions.

6. You can select version you would like to use via the `Version` Listbox. 
Click on any version, you would like to use.  

7. Finally click on the launch button to launch Lunar Client!
### Which JVM Arguments are good for LC?
LC uses Java 16 so they aren't many "optimal" JVM arguments which you can find online.  
Here is a list of arguments you can use for LC via LC Lite which I consider optimal.  

1. `-Xmx3G`  
Using this argument can be useful if you are low on RAM since using this argument will force LC to use only 3 GB of RAM.
2. `-Xms4G -Xmx4G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M`  
This is a slightly modified version of MC's default arguments for Java 16. From what I have seen using these arguments will make LC use 6 GB RAM and should provide optimal performance.

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
Original Optifine Patcher made by `temp`  
Project inspired by [LCLI](https://github.com/couleur-tweak-tips/utils/blob/main/LCLI.bat)</b>

## Discord Servers
These discord servers also helped me to make this project.  
1. [Hone](https://discord.com/invite/hone)  
(For the Patcher script.)
2. [Couleur Tweak Tips](http://discord.gg/CTT)  
(For LCLI.)
