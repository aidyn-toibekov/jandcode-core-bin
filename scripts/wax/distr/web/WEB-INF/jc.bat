@echo off

rem in JC_JVM java parameters -Dxxx=yyy
rem in JC_CLI additional cli parameters

set CP=%~dp0lib;%~dp0lib\*

set JVM= 
set JVM=%JVM% -cp %CP%
set JVM=%JVM% -Djandcode.appdir=%~dp0
set JVM=%JVM% -Djandcode.consolecharset=866
set JVM=%JVM% -Dfile.encoding=UTF-8

java %JVM% %JC_JVM% jandcode.jc.Main %JC_CLI% -npp %*
