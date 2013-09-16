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

:: Make the TCP/IP connection to the printer first
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r IP_###.###.##.### -h ###.###.##.### -o raw -n 9100 -2e

:: Add printer
rundll32 printui.dll,PrintUIEntry /if /b "BUILDING-ROOMNUM Printer - B&W" /f %windir%\inf\ntprint.inf /r "IP_###.###.##.###" /m "HP LaserJet P4515 PCL6" /Z

:: Set as default printer
rundll32 printui.dll,PrintUIEntry /y /n "BUILDING-ROOMNUM Printer - B&W"