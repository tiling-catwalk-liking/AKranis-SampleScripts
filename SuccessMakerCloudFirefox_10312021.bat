:: End any running Chrome process
taskkill /im chrome.exe /f
:: End any running Firefox process
taskkill /im firefox.exe /f
:: Launch Firefox in Kiosk Mode and go to SuccessMaker login
cd "C:\Program Files\Mozilla Firefox"
firefox.exe -kiosk "https://ourinstance.smhost.net/lms/sm.view?headless=1&action=home"