@echo off
setlocal

rem === SEKTA launcher - self-contained for shell startup ===
rem Hardcoded paths so it works even when PATH / working dir is not loaded yet.

set "SEKTA_DIR=D:\RIKYDWIANTO\002. RIKY DWIANTO\PROJECT\NODEJS\sekta\sekta"
set "NODE_EXE=C:\nvm4w\nodejs\node.exe"
set "NPM_CMD=C:\nvm4w\nodejs\npm.cmd"

if not exist "%NODE_EXE%" (
  echo [ERROR] Node.js not found: %NODE_EXE%
  pause
  exit /b 1
)
if not exist "%SEKTA_DIR%\package.json" (
  echo [ERROR] Project not found: %SEKTA_DIR%
  pause
  exit /b 1
)

rem Make node/npm resolvable no matter the startup environment
set "PATH=C:\nvm4w\nodejs;%PATH%"
cd /d "%SEKTA_DIR%"

echo === SEKTA - Install dependencies ===
call "%NPM_CMD%" install
if errorlevel 1 goto :error

echo === SEKTA - Build ===
call "%NPM_CMD%" run build
if errorlevel 1 goto :error

echo === SEKTA - Running on http://localhost:5176 ===
set "PORT=5176"
set "HOST=0.0.0.0"
"%NODE_EXE%" "%SEKTA_DIR%\build\index.js"

goto :eof

:error
echo Build failed. Check the error above.
pause
exit /b 1
