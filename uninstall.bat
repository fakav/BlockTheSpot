@echo off
echo *****************
echo Author: @rednek46
echo Edited by: @Daksh777
echo *****************
echo Removing Patch
if exist "%APPDATA%\Spotify\chrome_elf_bak.dll" (
    del /s /q "%APPDATA%\Spotify\chrome_elf.dll" > NUL 2>&1
    move "%APPDATA%\Spotify\chrome_elf_bak.dll" "%APPDATA%\Spotify\chrome_elf.dll" > NUL 2>&1
) else (
    echo done
)
pause
