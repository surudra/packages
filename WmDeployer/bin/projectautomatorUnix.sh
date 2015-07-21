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
	echo "Please provide an input XML file. For information on how to create the XML file please refer to documentation"
else
${JVM_DIR}/bin/java -Dserver.install.dir=${IS_DIR} -classpath "${IS_DIR}/lib/wm-isserver.jar:${IS_DIR}/packages/WmDeployer/lib/CLI.jar:${IS_DIR}/packages/WmDeployer/lib/projectautomator.jar:${IS_DIR}/packages/WmDeployer/code/classes:${IS_DIR}/../common/lib/ext/jargs.jar:${IS_DIR}/../common/lib/wm-isclient.jar:${IS_DIR}/../common/lib/glassfish/gf.javax.mail.jar:${IS_DIR}/../common/lib/ext/xml-apis.jar:${IS_DIR}/../common/lib/ext/xercesImpl.jar:${IS_DIR}/../common/lib/ext/log4j.jar:${IS_DIR}/../common/lib/ext/enttoolkit.jar:${IS_DIR}/../common/lib/wm-scg-security.jar:${IS_DIR}/../common/lib/wm-scg-core.jar:${IS_DIR}/../common/lib/wm-g11nutils.jar" com.softwareag.webm.deployer.automation.MainClass "$@" "${IS_DIR}/packages/WmDeployer/config/ProjectAutomatorForRuntime.xsd" "${IS_DIR}/packages/WmDeployer/config/ProjectAutomatorForRepository.xsd" "${IS_DIR}/packages/WmDeployer/bin/log4j.properties" 0
fi

echo Error Code = $?
exit $?
