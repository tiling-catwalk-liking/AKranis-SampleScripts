:: This script is intended to configure the lab at Location1 to Launch IXL at startup. It used to launch SuccesMaker at startup.
:: The files that it copies are the batch files that actually launch IXL in a headless fashion.
:: Kill any running Firefox and Chrome processes
taskkill /im firefox.exe /f
taskkill /im chrome.exe /f
:: Install Firefox
E:
msiexec.exe /i Firefox102.msi /quiet
:: Copy new batch file for running SMaker in Kiosk mode and overwrite the old batch file, renaming as SM390.bat
xcopy /v "E:\SuccessMakerPCs_Location1\Launch-IXL_LAB_07252022.bat" "C:\SM390.bat"
:: Place a copy on the desktop
xcopy /v "E:\Launch-IXL_LAB_07252022.bat" "C:\Users\CAI\Desktop"
:: Restart PC
shutdown /r