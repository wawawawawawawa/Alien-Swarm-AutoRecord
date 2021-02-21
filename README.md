# Alien Swarm AutoRecord

This tool will allow you to setup an automatic recording of your games in a few clicks!

Download and Extract the files, then Run AutoRecordInstaller.exe (or .ahk if you have AutoHotkey installed).

1) You will be asked the game executable localization.

2) The tool will then update newmapsettings.cfg and create AlienSwarmLauncher.bat

3) You will be asked to change your launch options

And it's done!

Now your games will be named "asrd_(date/time when u launched the game)_X.dem"

You can sort them by using my other tool : [DemoRenamer]()

To view a record, just write "demoui" in console and select the .dem file

# How Does It Work

1) Launches AutoRecord.exe (or .ahk) alongside the game, by using AlienSwarmLauncher.bat (that is set in the steam launch options)

  You can open the .bat file to see the code, it just open AutoRecord.exe, then the game executable path asked during install.

2) Add to newmapsettings.cfg :

- exec autorecording
- AutoRecording
