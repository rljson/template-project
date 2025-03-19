
@echo off
setlocal enabledelayedexpansion

:: Validate CLI-Params
if "%1"=="" goto usage
if "%2"=="" goto usage

set "CLASS_A=%1"
set "CLASS_B=%2"

:: Methods for name conversion
call :toLowerFirst "%CLASS_A%" LOWER_CLASS_A
call :toLowerFirst "%CLASS_B%" LOWER_CLASS_B
call :toSnakeCase "%CLASS_A%" SNAKE_CLASS_A
call :toSnakeCase "%CLASS_B%" SNAKE_CLASS_B

:: Replace in files
for /r %%F in (*.ts *.md package.json) do (
    if "%%F" neq "./node_modules/*" (
        powershell -Command "(Get-Content -Raw '%%F') -replace '%CLASS_A%', '%CLASS_B%' | Set-Content '%%F'"
        powershell -Command "(Get-Content -Raw '%%F') -replace '!LOWER_CLASS_A!', '!LOWER_CLASS_B!' | Set-Content '%%F'"
        powershell -Command "(Get-Content -Raw '%%F') -replace '!SNAKE_CLASS_A!', '!SNAKE_CLASS_B!' | Set-Content '%%F'"
    )
)

:: Rename files
for /r %%F in (*!SNAKE_CLASS_A!*) do (
    set "newname=%%F"
    set "newname=!newname:%SNAKE_CLASS_A%=%SNAKE_CLASS_B%!"
    ren "%%F" "!newname!"
)

:: Update goldens
rd /s /q test\goldens
pnpm updateGoldens

goto :eof

:usage
echo Usage: %0 ^<CLASS_A^> ^<CLASS_B^>
exit /b 1

:: Convert first letter to lowercase
:toLowerFirst
setlocal
set "str=%~1"
set "firstchar=%str:~0,1%"
set "rest=%str:~1%"
for /f "tokens=* delims=ABCDEFGHIJKLMNOPQRSTUVWXYZ" %%a in ("%firstchar%") do set "firstchar=%%a"
endlocal & set "%2=%firstchar%%rest%"
goto :eof

:: Convert to snake case
:toSnakeCase
setlocal
set "input=%~1"
set "output=%input%"
for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "output=!output:%%A=-%%A!"
set "output=!output:A=a!"
set "output=!output:B=b!"
set "output=!output:C=c!"
set "output=!output:D=d!"
set "output=!output:E=e!"
set "output=!output:F=f!"
set "output=!output:G=g!"
set "output=!output:H=h!"
set "output=!output:I=i!"
set "output=!output:J=j!"
set "output=!output:K=k!"
set "output=!output:L=l!"
set "output=!output:M=m!"
set "output=!output:N=n!"
set "output=!output:O=o!"
set "output=!output:P=p!"
set "output=!output:Q=q!"
set "output=!output:R=r!"
set "output=!output:S=s!"
set "output=!output:T=t!"
set "output=!output:U=u!"
set "output=!output:V=v!"
set "output=!output:W=w!"
set "output=!output:X=x!"
set "output=!output:Y=y!"
set "output=!output:Z=z!"
endlocal & set "%2=%output%"
goto :eof
