::::::::::::::::::::
::
:: @author: ABOTlegacy
:: @description: Simple Command Script that will automatically set up network printer
:: @note: Made IP Addresses, Buildings, and Rooms generic for the GIThub versions.
::
::::::::::::::::::::



:: Instantiate Variables
for /f "tokens=2 delims=:" %%a in ('ipconfig^|find "IPv4 Address"') do (SET varIpAddress=%%a) 

:: Get The Room Code
SET varComputerName=%computername%
SET modifiedString=%varComputerName:*-=%
CALL SET varRoomName=%%varComputerName:-%modifiedString%=%%

:: Get The Domain IP
SET modifiedString=%varIpAddress%
SET modifiedString=%modifiedString:*.=%
SET modifiedString=%modifiedString:*.=%
CALL SET domainIP=%%varIpAddress:.%modifiedString%=%%
SET domainIP=%domainIP:* =%

:: Set the Printer Properties
SET bwIP=
SET rgbIP=



:: Determine IP Address for Printers
GOTO :%varRoomName%

:TCC
SET bwIP=%domainIP%.64.26
SET bwIP=%domainIP%.64.28
SET rgbIP=%domainIP%.64.27
GOTO :END_ROOM_NAMES

:GCLL10
SET rgbIP=%domainIP%.128.12
GOTO :END_ROOM_NAMES

:CGS121
SET rgbIP=%domainIP%.128.12
SET bwIP=%domainIP%.71.193
GOTO :END_ROOM_NAMES

:END_ROOM_NAMES



:: Add Printers
IF NOT "%rgbIP%" == "" ( GOTO :RGBPrinter )
GOTO :NextPrinter

:RGBPrinter
:: Make the TCP/IP connection to the printer first
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r IP_%rgbIP% -h %rgbIP% -o raw -n 9100 -2e
:: Add printer
rundll32 printui.dll,PrintUIEntry /if /b "%varRoomName% Printer - Color FREE" /f %windir%\inf\ntprint.inf /r "IP_%rgbIP%" /m "HP LaserJet P4515 PCL6" /Z
:: Set as default printer
rundll32 printui.dll,PrintUIEntry /y /n "%varRoomName% Printer - Color FREE"
GOTO :NextPrinter

:NextPrinter
IF NOT "%bwIP%" == "" ( GOTO :BWPrinter )
GOTO :END

:BWPrinter
:: Make the TCP/IP connection to the printer first
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r IP_%bwIP% -h %bwIP% -o raw -n 9100 -2e
:: Add printer
rundll32 printui.dll,PrintUIEntry /if /b "%varRoomName% Printer - B&W FREE" /f %windir%\inf\ntprint.inf /r "IP_%bwIP%" /m "HP LaserJet P4515 PCL6" /Z
:: Set as default printer
rundll32 printui.dll,PrintUIEntry /y /n "%varRoomName% Printer - B&W FREE"
GOTO :END



:: End of Program
:END