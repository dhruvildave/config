
REM __author__ = '0xdd'
REM 11 April 2020 17:26:24

@echo off
cd %HOMEPATH%\Downloads
set /p link="Enter video link: "
youtube-dl %link%
start .
