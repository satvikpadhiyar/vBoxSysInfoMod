@echo off
:_PreInit
title vBoxSysInfoMod by JayMontana36 - Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
echo.
echo.
echo Hello %username% and %computername%, I am vBoxSysInfoMod (also known as VirtualBox VM System Information Modifier),
echo and I am both originally created and maintained by JayMontana36. Also, just as an additional and preemptive heads up:
echo.
echo.
echo This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
echo To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or
echo send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
echo.
echo.
echo One final note, I am donationware; if you find and/or consider me to be useful, please consider donating to JayMontana36
echo to help support further development (updates, functionality and features). See "Donate" for more information; thanks.
echo.
echo.
pause

:_Init
set _title=vBoxSysInfoMod - VirtualBox VM System Information Modifier v6.1rc1 by JayMontana36
title %_title%
set vBoxInstallLocation=%VBOX_MSI_INSTALL_PATH%
set _h=%time:~0,2%
IF %_h% GEQ 6 IF %_h% LEQ 11 (set "_tod=Morning") else IF %_h% GEQ 12 IF %_h% LEQ 16 (set "_tod=Afternoon") else IF %_h% GEQ 17 IF %_h% LEQ 19 (set "_tod=Evening") else IF %_h% GEQ 20 IF %_h% LEQ 23 (set "_tod=Night") else IF %_h% GEQ 0 IF %_h% LEQ 5 (set "_tod=Night")
IF %_h% GEQ 3 IF %_h% LEQ 17 (set "_t=today") else IF %_h% GEQ 18 IF %_h% LEQ 23 (set "_t=tonight") else IF NOT DEFINED _t (set "_t=currently")
echo Starting %_title%...
IF NOT EXIST "%vBoxInstallLocation%" (goto _vBoxLocateFailed) else IF NOT EXIST "%vBoxInstallLocation%\VBoxManage.exe" (goto _vBoxLocateFailed) else set vBox="%vBoxInstallLocation%\VBoxManage.exe"

:_PostInit
cls
echo Hello %username%, Good %_tod%, and Welcome to
echo %_title%!
echo.
echo.
IF %_h% GEQ 0 IF %_h% LEQ 4 (echo %computername% tells me that you're up rather late for your timezone, though that's really none of my business.) else IF %_h% GEQ 5 IF %_h% LEQ 7 (echo %computername% tells me that you're up rather early for your timezone, though that's really none of my business.) else IF %_h% GEQ 8 IF %_h% LEQ 23 (echo %computername% tells me that you're up rather normally for your timezone, though that's really none of my business.)
echo.
echo.
@REM IF ["%vBoxInstallLocation%"] EQU ["C:\Program Files\Oracle\Virtualbox"] (echo So anyways, what may I do for you %_t% %username%?) else echo So anyways, with all of that other stuff out of the way, what may I do for you %_t% %username%?
echo So anyways, what may I do for you %_t% %username%? I can currently "ModifyVM" which just so happens to be my original
echo and primary purpose as well as "ResetVM" which as you'd probably both think and/or assume allows me to restore a VM's
echo defaults, though if you'd like I can also bring up the creator's Discord server with "Discord", bring up the creator's
echo YouTube Channel with "YT" or "YouTube", or bring up the creator's website with "Site". There's also "Credits", the new
echo end page.
echo.
echo.
echo "ModifyVM", "ResetVM", "Credits", "Discord", "YouTube", "YT", "Site", "Exit"
echo.
set /p pinitsel="%username%@%computername%>"
IF /I [%pinitsel%] EQU [ModifyVM] (set _pinitsel=modify) else IF /I [%pinitsel%] EQU [ResetVM] (set _pinitsel=reset)
IF /I [%pinitsel%] EQU [Modify] (set pinitsel=ModifyVM) else IF /I [%pinitsel%] EQU [Reset] (set pinitsel=ResetVM) else IF /I [%pinitsel%] EQU [Mod] (set pinitsel=ModifyVM) else IF /I [%pinitsel%] EQU [M] (set pinitsel=ModifyVM) else IF /I [%pinitsel%] EQU [R] (set pinitsel=ResetVM)
goto %pinitsel%

:ResetVM
:ModifyVM
cls
echo %_title%
echo.
echo Here's a list of all VMs that are currently registered in VirtualBox here on %computername%:
echo.
echo.
%vBox% list vms
echo.
set /p VMname="Which vBox VM would you like me to %_pinitsel%, %username%? [Last: '%VMname%'] "
@REM for /f "tokens=1 delims={" %%F in ('"%vBox% list vms | findstr /C:"%VMname%""') do set _VMname=%%F
@REM IF ["%_VMname%"] NEQ [\"%VMname%\"] goto ModifyVM
for /f "tokens=1 delims=firmware=" %%F in ('"%vBox% showvminfo "%VMname%" --machinereadable | findstr firmware"') do set _vmMode=%%~F
IF [%_vmMode%] EQU [BIOS] (set fw=pcbios) else IF [%_vmMode%] EQU [EFI] (set fw=efi) else (goto %pinitsel%)
goto _%_pinitsel%1

:_Modify1
echo.
set /p SYSven="Alright, what would you like the System Manufacturer to appear as, %username%? [Last: '%SYSven%'] "
echo.
set /p SYSprod="Alright, now how about the System Model, %username%? [Last: '%SYSprod%'] "
echo.
echo Okay, this one's optional %username%: The System BIOS Build Date, which will default to December 1, 2006 if left
echo blank; feel free to leave this field blank if you wish to use the vBox default (or you don't care). MM/DD/YYYY format.
set /p SYSdate="System BIOS Build Date? [Default: '12/01/2006' - Last: '%SYSdate%'] "

:_Reset1
:_ModifyVMsummary
cls
echo %_title%
echo.
echo Summary:
echo Ready to %_pinitsel% vBox VM "%VMname%" whenever you're ready, %username%!
goto _%_pinitsel%2
:_Modify2
echo %_VMmode% Information will be changed to "%SYSven% %SYSprod%"
echo %_VMmode% Date will be changed to "%SYSdate%"
:_Reset2
echo.
echo Warning: Before continuing, please shutdown any/all vBox VMs you care about;
echo failure to do so may result in data loss or data corruption for running VMs.
pause

:_Taskkill
echo Force closing any and all VirtualBox VM windows...
taskkill /F /IM VirtualBox.exe
taskkill /F /IM VBoxSVC.exe
cls
echo %_title%
echo.
goto _%_pinitsel%Process

:_ModifyProcess
echo Suppressing VM Indications in TaskManager and other areas for "%VMname%"
echo ...
%vBox% modifyvm "%VMname%" --paravirtprovider none
echo Applying System Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemProduct" "%SYSprod%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVersion" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSerial" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSKU" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemFamily" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemUuid" "9852bf98-b83c-49db-a8de-182c42c7226b"
echo Applying BIOS Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVersion" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSReleaseDate" "%SYSdate%"
echo Applying Motherboard Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardProduct" "%SYSprod%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVersion" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardSerial" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardAssetTag" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardLocInChass" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardBoardType" "10"
echo.
echo Complete!
echo.
echo Successfully applied vBox System Information to vBox VM "%VMname%" in %_VMmode% Mode!
echo.
pause
echo.
@REM start /MIN "" "%vBoxInstallLocation%\VirtualBox.exe"
%vBox% startvm "%VMname%" --type gui
goto credits

:_ResetProcess
echo Restoring VM Indications in TaskManager and other areas for "%VMname%"
echo ...
%vBox% modifyvm "%VMname%" --paravirtprovider default
echo Resetting all possible System Information for vBox "%VMname%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiSystemVendor" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemVendor" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemProduct" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemVersion" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiSystemSerial" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSerial" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiSystemSKU" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSKU" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiSystemFamily" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemFamily" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiSystemUuid" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemUuid" ""
echo ...
echo Resetting all possible BIOS Information for vBox "%VMname%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBIOSVendor" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSVendor" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBIOSVersion" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSVersion" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBIOSReleaseDate" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSReleaseDate" ""
echo ...
echo Resetting all possible BaseBoard Information for vBox "%VMname%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBoardVendor" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardVendor" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardProduct" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBoardVersion" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardVersion" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBoardSerial" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardSerial" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBoardAssetTag" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardAssetTag" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBoardLocInChass" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardLocInChass" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/efi/0/Config/DmiBoardBoardType" ""
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardBoardType" ""
echo ...
echo Complete!
echo.
echo Successfully reset all vBox System Information for vBox VM "%VMname%"!
echo.
pause
echo.
@REM start /MIN "" "%vBoxInstallLocation%\VirtualBox.exe"
%vBox% startvm "%VMname%" --type gui
goto credits

:_vBoxLocateFailed
cls
echo Failed to start %_title%:
echo.
echo VirtualBox was not found in directory "%vBoxInstallLocation%"
echo.
set /p vBoxInstallLocation="Please provide the location of your current VirtualBox Installation: "
goto _Init

:credits
cls
echo %_title%
echo.
echo.
echo.
echo vBoxSysInfoMod - VirtualBox VM System Information Modifier was originally created and maintained by JayMontana36.
echo.
echo.
echo.
echo.
echo Discord: https://discord.gg/23SckZN - You'll be able to communicate and interact more with me directly in realtime or
echo together as a community; you'll also be able to see and/or hear about new things (features/functionalities) before
echo they even become a thing or as they're becoming things, and you'll be able to more directly influence what additions
echo and improvements I make by directly giving me feedback and suggestions as well as more directly reporting bugs to me.
echo There will be sections for scambaiting, gaming, tech, tutorials, software, as well as anything else you might request.
echo.
echo.
echo.
echo.
echo YouTube: https://www.youtube.com/channel/UCq-L3aIwJD3tCpMEawdgW7Q - Subscribe if you'd like to support my channel, I
echo will be uploading more and/or new tutorials from time to time as well as some other tech related content in the future.
echo JM36's Tech TV - https://goo.gl/QiKWrj
echo.
echo.
echo.
echo.
echo Official Website: https://sites.google.com/site/jaymontana36jasen - Bookmark my website for easy access if you'd like,
echo as I may add to it in the future with other scripts, content, programs/software, etc. Site - https://goo.gl/3SCLQN
echo.
echo.
echo.
echo.
echo "ModifyVM", "ResetVM", "Credits", "Discord", "YouTube", "YT", "Site", "Exit"
echo.
set /p endsel="%username%@%computername%>"
IF /I [%endsel%] EQU [ModifyVM] (set pinitsel=ModifyVM) else IF /I [%endsel%] EQU [ResetVM] (set pinitsel=ResetVM) else IF /I [%endsel%] EQU [Modify] (set pinitsel=ModifyVM) else IF /I [%endsel%] EQU [Reset] (set pinitsel=ResetVM) else IF /I [%endsel%] EQU [Mod] (set pinitsel=ModifyVM) else IF /I [%endsel%] EQU [M] (set pinitsel=ModifyVM) else IF /I [%endsel%] EQU [R] (set pinitsel=ResetVM)
IF /I [%pinitsel%] EQU [ModifyVM] (set _pinitsel=modify) else IF /I [%pinitsel%] EQU [ResetVM] (set _pinitsel=reset)
goto %endsel%

:Exit
exit

:Site
start https://sites.google.com/site/jaymontana36jasen
goto credits

:YT
:YouTube
start https://www.youtube.com/channel/UCq-L3aIwJD3tCpMEawdgW7Q
goto credits

:Discord
start https://discord.gg/23SckZN
goto credits

:License
echo This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
echo To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or
echo send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
pause
goto credits

:Debug
echo Heads up! Reminder:
echo This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
echo To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or
echo send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
pause
start http://creativecommons.org/licenses/by-nc-sa/4.0/
pause
@echo on
goto _Init
