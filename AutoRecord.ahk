#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

IniRead, GameDir, %A_ScriptDir%\AutoRecord.ini, Settings, GameDir
if (GameDir = "ERROR")
{
	GameDir = %A_ProgramFiles%\Steam\steamapps\common\Alien Swarm Reactive Drop\reactivedrop
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
}
IniRead, NewMapSettingsDir, %A_ScriptDir%\AutoRecord.ini, Settings, NewMapSettingsDir
IniRead, AutoRecordDir, %A_ScriptDir%\AutoRecord.ini, Settings, AutoRecordDir
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

FormatTime, CurrentTime, , yyyy_MM_dd__HH_mm_ss
FileRead, readfile, %AutoRecordDir%
DefaultNewrecord = alias AutoRecording "record ASRD_%CurrentTime%"
if (readfile == DefaultNewrecord)
{
	DefaultNewrecord = alias AutoRecording "record ASRD_%CurrentTime%_A"
}
recordfile := FileOpen(AutoRecordDir, "w")
recordfile.Write(DefaultNewrecord)
recordfile.Close()