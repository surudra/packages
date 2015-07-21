#!/bin/sh

# Change IS_DIR and JVM_DIR to reflect their locations on your system
# Note: The JVM must have the JCE extension
# 
# --- LOCATION OF WEBMETHODS INTEGRATION SERVER ---

IS_DIR=C:\SoftwareAGWebm97\IntegrationServer
JVM_DIR=C:\SoftwareAGWebm97\jvm\jvm

export IS_DIR
export JVM_DIR

if [ -z "$1" ]
then
	${JVM_DIR}/bin/java -classpath "${IS_DIR}/../common/lib/wm-scg-security.jar:${IS_DIR}/../common/lib/wm-scg-core.jar:${IS_DIR}/packages/WmDeployer/lib/CLI.jar:${IS_DIR}/packages/WmDeployer/code/classes:${IS_DIR}/../common/lib/ext/jargs.jar:${IS_DIR}/../common/lib/wm-isclient.jar:${IS_DIR}/../common/lib/glassfish/gf.javax.mail.jar:${IS_DIR}/../common/lib/ext/log4j.jar:${IS_DIR}/../common/lib/ext/enttoolkit.jar:${IS_DIR}/packages/WmDeployer/bin/log4j.properties:${IS_DIR}/packages/WmDeployer/bin" com.wm.deployer.CLI.MainClass "--usage"
else
${JVM_DIR}/bin/java -classpath "${IS_DIR}/../common/lib/wm-scg-security.jar:${IS_DIR}/../common/lib/wm-scg-core.jar:${IS_DIR}/packages/WmDeployer/lib/CLI.jar:${IS_DIR}/packages/WmDeployer/code/classes:${IS_DIR}/../common/lib/ext/jargs.jar:${IS_DIR}/../common/lib/wm-isclient.jar:${IS_DIR}/../common/lib/glassfish/gf.javax.mail.jar:${IS_DIR}/../common/lib/ext/log4j.jar:${IS_DIR}/../common/lib/ext/enttoolkit.jar:${IS_DIR}/packages/WmDeployer/bin/log4j.properties:${IS_DIR}/packages/WmDeployer/bin" com.wm.deployer.CLI.MainClass "$@"
fi
