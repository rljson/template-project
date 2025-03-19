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
    set "filePath=%%F"
    for %%D in (%%~dpF) do (
        if /I not "%%~nxD" lss "d" if "%%~nxD" neq "node_modules" if "%%~nxD" neq "test" if "%%~nxD" neq "goldens" if "%%~nxD" neq "pnpm-lock.yaml" (
            echo Processing: %%F
            powershell -Command "(Get-Content -Raw '%%F') -replace '%CLASS_A%', '%CLASS_B%' | Set-Content '%%F'"
            powershell -Command "(Get-Content -Raw '%%F') -replace '!LOWER_CLASS_A!', '!LOWER_CLASS_B!' | Set-Content '%%F'"
            powershell -Command "(Get-Content -Raw '%%F') -replace '!SNAKE_CLASS_A!', '!SNAKE_CLASS_B!' | Set-Content '%%F'"
        )
    )
)

:: Rename files
for /r %%F in (*!SNAKE_CLASS_A!*) do (
    set "newname=%%F"
    set "newname=!newname:%SNAKE_CLASS_A%=%SNAKE_CLASS_B%!"
    for %%D in (%%~dpF) do (
        if /I not "%%~nxD" lss "d" if "%%~nxD" neq "node_modules" if "%%~nxD" neq "test" if "%%~nxD" neq "goldens" if "%%~nxD" neq "pnpm-lock.yaml" (
            ren "%%F" "!newname!"
        )
    )
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
set "output:B=b!"
set "output:C=c!"
set "output:D=d!"
set "output:E=e!"
set "output:F=f!"
set "output:G=g!"
set "output:H=h!"
set "output:I=i!"
set "output:J=j!"
set "output:K=k!"
set "output:L=l!"
set "output:M=m!"
set "output:N=n!"
set "output:O=o!"
set "output:P=p!"
set "output:Q=q!"
set "output:R=r!"
set "output:S=s!"
set "output:T=t!"
set "output:U=u!"
set "output:V=v!"
set "output:W=w!"
set "output:X=x!"
set "output:Y=y!"
set "output:Z=z!"
endlocal & set "%2=%output%"
goto :eof
