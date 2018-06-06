#! /bin/sh

WD=`dirname $0`
LB="${WD}/lib"
CP="${LB}/commons-io.jar:${LB}/commons-logging.jar:${LB}/commons-vfs.jar:${LB}/joda-time.jar:${LB}/junit.jar:${LB}/log4j.jar"
CP="${CP}:${LB}/groovy.jar:${LB}/ant.jar:${LB}/ant-launcher.jar:${LB}/jandcode-utils.jar:${LB}/jandcode-app.jar"
CP="${CP}:${LB}/jandcode-groovy.jar:${LB}/jandcode-jc.jar"

JVM=""
JVM="${JVM} -Djandcode.appdir=${WD}"
JVM="${JVM} -Dfile.encoding=UTF-8"

java -cp ${CP} ${JVM} ${JC_JVM} jandcode.jc.Main ${JC_CLI} $*

