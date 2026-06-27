@echo off
title Cartelera Work and Fun 26
rem ============================================================
rem  Abre la cartelera en MODO KIOSKO (pantalla completa, sin
rem  barras del navegador). Doble clic en este archivo y listo.
rem  Para SALIR de la cartelera: Alt + F4.
rem ============================================================

set "PAGE=%~dp0index.html"
set "EDGE=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHROME86=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

rem 1) Microsoft Edge (normalmente ya viene instalado en Windows)
if exist "%EDGE%" (
  start "" "%EDGE%" --kiosk "%PAGE%" --edge-kiosk-type=fullscreen --no-first-run --disable-features=Translate
  exit /b
)

rem 2) Google Chrome
if exist "%CHROME%" (
  start "" "%CHROME%" --kiosk "%PAGE%" --no-first-run
  exit /b
)
if exist "%CHROME86%" (
  start "" "%CHROME86%" --kiosk "%PAGE%" --no-first-run
  exit /b
)

rem 3) Si no encuentra ninguno, abre con el navegador por defecto
rem    (en ese caso apreta F11 para pantalla completa).
start "" "%PAGE%"
exit /b
