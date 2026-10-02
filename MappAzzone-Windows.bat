@echo off
REM MappAzzone — avvio su Windows (100% offline, nessun server)
REM Doppio click su questo file. Se Chrome/Edge mancano, apre il browser predefinito.
setlocal
set "PAGE=%~dp0index.html"
set "URL=file:///%PAGE:\=/%"
if not exist "%PAGE%" (
  echo Non trovo index.html nella stessa cartella di questo file.
  pause
  exit /b 1
)
where chrome.exe >nul 2>&1
if %errorlevel%==0 (start "" chrome.exe --app="%URL%" & exit /b 0)
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="%URL%" & exit /b 0)
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" --app="%URL%" & exit /b 0)
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="%URL%" & exit /b 0)
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="%URL%" & exit /b 0)
start "" "%URL%"
