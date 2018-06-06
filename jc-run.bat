@echo off

rem in JC_JVM java parameters -Dxxx=yyy
rem in JC_CLI additional cli parameters

set CP=%~dp0lib
set CP=%CP%;%~dp0lib\commons-io.jar
set CP=%CP%;%~dp0lib\commons-logging.jar
set CP=%CP%;%~dp0lib\commons-vfs.jar
set CP=%CP%;%~dp0lib\joda-time.jar
set CP=%CP%;%~dp0lib\junit.jar
set CP=%CP%;%~dp0lib\log4j.jar
set CP=%CP%;%~dp0lib\groovy.jar
set CP=%CP%;%~dp0lib\ant.jar
set CP=%CP%;%~dp0lib\ant-launcher.jar
set CP=%CP%;%~dp0lib\jandcode-utils.jar
set CP=%CP%;%~dp0lib\jandcode-app.jar
set CP=%CP%;%~dp0lib\jandcode-groovy.jar
set CP=%CP%;%~dp0lib\jandcode-jc.jar

set JVM= 
set JVM=%JVM% -cp %CP%
set JVM=%JVM% -Djandcode.appdir=%~dp0
set JVM=%JVM% -Djandcode.consolecharset=auto
set JVM=%JVM% -Dfile.encoding=UTF-8

java %JVM% %JC_JVM% jandcode.jc.Main %JC_CLI% %*
