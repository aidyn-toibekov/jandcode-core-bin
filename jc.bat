@echo off

rem run first found jc-run.bat from current dir and up

set CWD=.\
set LEV=x
set JCR=jc-run.bat

:nextstep
set FND=%CWD%%JCR%
if exist %FND% goto found
set FND=%CWD%jandcode-core-bin\%JCR%
if exist %FND% goto found
set FND=%CWD%jandcode-core\%JCR%
if exist %FND% goto found

set LEV=%LEV%x
if "%LEV%"=="xxxxxxxxxxxxx" goto error
set CWD=%CWD%..\
goto nextstep

:found
%FND% %*
goto end

:error
set FND=%~dp0%JCR%
if exist %FND% goto found

echo ERROR! %JCR% not found!

:end
