::::::::::::::::::::
::
:: @author ABOTlegacy
:: 
:: @building
:: @room
::
:: @description Simple Command Script that will automatically set up network printer
::
:: @note Made IP Addresses, Buildings, and Rooms generic for the GIThub versions.
::
::::::::::::::::::::


:: Instantiate Variables
for /f "tokens=2 delims=:" %%a in ('ipconfig^|find "IPv4 Address"') do (SET varIpAddress=%%a) 
SET varComputerName="%computername%"
SET modifiedString=%varComputerName:*-=%
CALL SET varRoomName=%%varComputerName:-%modifiedString%=%%
SET hasBW=false
SET hasColor=false
SET bwIP=
SET colorIP=

:: Determine IP Address for Printers
if 1==2 ()
ELSE IF %varRoomName%=="BUILDING_ID" (SET bwIP=)

:: Make the TCP/IP connection to the printer first
::Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r IP_###.###.##.### -h ###.###.##.### -o raw -n 9100 -2e

:: Add printer
::rundll32 printui.dll,PrintUIEntry /if /b "BUILDING-ROOMNUM Printer - B&W" /f %windir%\inf\ntprint.inf /r "IP_###.###.##.###" /m "HP LaserJet P4515 PCL6" /Z

:: Set as default printer
::rundll32 printui.dll,PrintUIEntry /y /n "BUILDING-ROOMNUM Printer - B&W"



mkdir j%varIpAddress%
mkdir kk%varComputerName%
mkdir %modifiedString%
mkdir uu%varRoomName%