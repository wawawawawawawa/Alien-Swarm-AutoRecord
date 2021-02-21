#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
	
IniRead, GameDir, %A_ScriptDir%\AutoRecord.ini, Settings, GameDir
if (GameDir = "ERROR")
{
	GameDir = %A_ProgramFiles%\Steam\steamapps\common\Alien Swarm Reactive Drop\reactivedrop
}

FileSelectFile, GameDir, 3, %GameDir%, Select reactivedrop.exe, RD (reactivedrop.exe)
If (!ErrorLevel)
{
	IniWrite, %GameDir%, %A_ScriptDir%\AutoRecord.ini, Settings, GameDir
	SplitPath, GameDir,, dir
	IniWrite, %dir%\reactivedrop\cfg\newmapsettings.cfg, %A_ScriptDir%\AutoRecord.ini, Settings, NewMapSettingsDir
	IniWrite, %dir%\reactivedrop\cfg\autorecording.cfg, %A_ScriptDir%\AutoRecord.ini, Settings, AutoRecordDir
}
else
{
	ExitApp
}

TextToWrite = START "AutoRecord" "%A_ScriptDir%\AutoRecord.ahk"`nSTART "Alien Swarm" "%GameDir%" -console -novid
FileDelete, %A_ScriptDir%\AlienSwarmLauncher.bat
FileAppend, %TextToWrite%, %A_ScriptDir%\AlienSwarmLauncher.bat
MsgBox, AlienSwarmLauncher.bat created!

IniRead, NewMapSettingsDir, %A_ScriptDir%\AutoRecord.ini, Settings, NewMapSettingsDir
; IniRead, AutoRecordDir, %A_ScriptDir%\AutoRecord.ini, Settings, AutoRecordDir
count = 0
Loop, read, %NewMapSettingsDir%
{
	if (A_LoopReadLine = "exec autorecording")
	{
		count += 1
	}
	else if (A_LoopReadLine = "AutoRecording")
	{
		count += 1
	}
	else if (A_LoopReadLine != "")
	{
		DefaultNewmapsettings .= A_LoopReadLine . "`r`n"
	}
}
if (count = 0)
{
	file := FileOpen(NewMapSettingsDir, "a")
	Newmap = `r`nexec autorecording`r`nAutoRecording
	file.Write(Newmap)
	file.Close()
	MsgBox, NewMapSettings Updated!
}
else if (count = 1)
{
	file := FileOpen(NewMapSettingsDir, "w")
	RemoveExtraSpace := RTrim(DefaultNewmapsettings)
	Newmap = %RemoveExtraSpace%exec autorecording`r`nAutoRecording
	file.Write(Newmap)
	file.Close()
	MsgBox, NewMapSettings Updated!
}
Gui, Add, Text,, Instructions :`n1) Go To Steam`n2) Right Click on Alien Swarm : Reactive Drop`n3) Left Click On Properties`n4) Go Under General`n5) Look At Launch Options`n6) Write That Inside :
Gui, Add, Edit, ReadOnly, "%A_ScriptDir%\Alien Swarm Launcher.bat" `%command`%
Gui, Add, Button, w80 gAllDone, Done!
Gui, Show
return

AllDone:
{
	MsgBox, Now Games Will Be Recorded Automatically In`n%dir%\reactivedrop\`n`nYou Can Sort/Rename Those At Any Time By Using The DemoRenamer!`nIt Will Sort By Date/Server/MapName
	ExitApp
}
return