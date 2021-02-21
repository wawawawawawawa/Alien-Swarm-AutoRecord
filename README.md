# Alien Swarm AutoRecord

This tool will allow you to setup an automatic recording of your games in a few clicks!

Download and Extract the files, then Run AutoRecordInstaller.exe (or .ahk if you have AutoHotkey installed).

1) You will be asked the game executable localization.

2) The tool will then update newmapsettings.cfg and create AlienSwarmLauncher.bat + autorecording.cfg

3) You will be asked to change your launch options

And it's done!

Now your games will be named "asrd_(date/time when u launched the game)_X.dem"

You can sort them by using my other tool : [DemoRenamer](https://github.com/wawawawawawawa/DemoRenamer)

To view a record, just write "demoui" in console and select the .dem file

## How Does It Work

1) Launches AutoRecord.exe (or .ahk) alongside the game, by using AlienSwarmLauncher.bat (that is set in the steam launch options)

   *You can open the .bat file to see the code, it just open AutoRecord.exe, then the game executable path asked during install.*

2) AutoRecord.exe will then modify autorecording.cfg (created by installer in the cfg folder) to have the current date/time.
   
   This is done only once when launching the game. 
   
   This file only contains 1 line (example) :

   `alias AutoRecording "record ASRD_2021_02_21__01_18_36"`

3) Add 2 lines to newmapsettings.cfg :
   ```
   exec autorecording
   AutoRecording
   ```
   *This will reload autorecording.cfg to update the AutoRecording alias and execute it*
   
4) Each game is now named asrd_(date/time when game was launched)_X
   
   X is the game number (50 = 50th map change or restart)
   
   If you want to rename and sort those, I made another tool for this purpose : [DemoRenamer](https://github.com/wawawawawawawa/DemoRenamer)
   
5) To Uninstall, you need to delete :
- game directory/reactivedrop/cfg/autorecording.cfg => delete file
- game directory/reactivedrop/cfg/newmapsettings.cfg => delete those 2 lines : exec autorecording & AutoRecording
- Steam -> Launch Options => remove the launch option line
- Script File/Folder => delete all
