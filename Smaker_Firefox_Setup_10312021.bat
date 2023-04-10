:: Kill any running Firefox and Chrome processes
taskkill /im firefox.exe /f
taskkill /im chrome.exe /f
:: Install Firefox
E:
msiexec.exe /i Firefox86.msi /quiet
:: Copy new batch file for running SMaker in Kiosk mode and overwrite the old batch file, renaming as SM390.bat
xcopy /v "E:\SuccessMakerPCs_Location1\SuccessMakerCloudFirefox_10312021.bat" "C:\SM390.bat"
:: Place a copy on the desktop
xcopy /v "E:\SuccessMakerPCs_Location1\SuccessMakerCloudFirefox_10312021.bat" "C:\Users\CAI\Desktop"
:: Delete SuccessMaker_Trial.bat from Desktop
cd "C:\Users\CAI\Desktop"
del "SuccessMaker_Trial.bat"
:: Restart PC
shutdown /r