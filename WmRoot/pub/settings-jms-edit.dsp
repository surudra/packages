<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">

<link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
<script src="webMethods.js.txt"></script>

%invoke wm.server.jms:getConnectionAliasReport%

<script language ="javascript">

/**
 * displaySettings
 */ 
function displaySettings(object) {

    if (object.options[object.selectedIndex].value == "0") {
        document.all.div1.style.display = 'block';
        document.all.div2.style.display = 'none';
    }else if (object.options[object.selectedIndex].value == "1") {
        document.all.div1.style.display = 'none';
        document.all.div2.style.display = 'block';
    }else {
        document.all.div1.style.display = 'none';
        document.all.div2.style.display = 'none';
    }
}

/**
 * onChange - capture change made to the producer cache mode
 */
function producerModeSettings(object) {

    if (object.value == 0) { // disabled
        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabled2').style.display = 'none';
    }else if (object.value == 1) { // enabled     
        document.getElementById('divCacheEnabled').style.display = 'block';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabled2').style.display = 'block';
    }else if (object.value == 2) { // per destination
        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'block';
        document.getElementById('divCacheEnabled2').style.display = 'none';
    }
}

/**
 * displayPollingInterval
 */
function displayPollingInterval(object) {

    if (object.options[object.selectedIndex].value == "CLIENT_POLL") {
        document.all.divPoll.style.display = 'block';

        // when Monitor type is changed to client polling set polling interval to default, but
        // if already saved as client polling display saved value.
        if (document.editform.jndi_connectionFactoryPollingInterval.value < 1) {
            document.editform.jndi_connectionFactoryPollingInterval.value = 1440;
        }
    }else {
        document.all.divPoll.style.display = 'none';
    }
}

/**
 * loadDocument
 */ 
function loadDocument() {

    setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMSaliasEditScrn');

    for (i=0; i<document.editform.classLoader.options.length; i++) {
      if ("PACKAGE: %value classLoader%" == document.editform.classLoader.options[i].text) {
        document.editform.classLoader.selectedIndex=i;
      }
    }
  
    %switch transactionType%
    %case '0'%
      document.editform.transactionType.selectedIndex=0;
    %case '1'%
      document.editform.transactionType.selectedIndex=1;
    %case '2'%
      document.editform.transactionType.selectedIndex=2;
    %end%

    for (i=0; i<document.editform.jndi_connectionFactoryUpdateType.options.length; i++) {
      if ("%value jndi_connectionFactoryUpdateType%" == document.editform.jndi_connectionFactoryUpdateType.options[i].value) {
        document.editform.jndi_connectionFactoryUpdateType.selectedIndex=i;
      }
    }

    for (i=0; i<document.editform.jndi_jndiAliasName.options.length; i++) {
      if ("%value jndi_jndiAliasName%" == document.editform.jndi_jndiAliasName.options[i].text) {
          document.editform.jndi_jndiAliasName.selectedIndex=i;
      }
    }

    %ifvar associationType equals('0')%
        document.editform.associationType.selectedIndex=0;
        document.all.div1.style.display = 'block';
        document.all.div2.style.display = 'none';

        %ifvar jndi_connectionFactoryUpdateType equals('CLIENT_POLL')%
            document.all.divPoll.style.display = 'block';
        %else%
            document.all.divPoll.style.display = 'none';
        %endif%
    %else%
        document.editform.associationType.selectedIndex=1;
        document.all.div1.style.display = 'none';
        document.all.divPoll.style.display = 'none';
        document.all.div2.style.display = 'block';
    %endif%

    %switch nwm_keystoreType%
        %case 'JKS'%
            document.editform.nwm_keystoreType.selectedIndex=1;
        %case 'PKCS12'%
            document.editform.nwm_keystoreType.selectedIndex=2;
    %end%
  
    %switch nwm_truststoreType%
        %case 'JKS'%
            document.editform.nwm_truststoreType.selectedIndex=1;
    %end%

    /*
     * Producer Caching 
     */

    %ifvar producerCachingMode equals('0')%
        document.editform.producerCachingMode.selectedIndex=0;

        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabled2').style.display = 'none';

        // set defaults values for the other options
        document.editform.producerSessionPoolMinSize_divCacheEnabled.value = '1';
        document.editform.producerSessionPoolSize_divCacheEnabled.value = '30';
        document.editform.producerSessionPoolMinSize_divCacheEnabledPer.value = '1';
        document.editform.producerSessionPoolSize_divCacheEnabledPer.value = '30';

        //document.editform.cacheProducersPoolMinSize_divCacheEnabledPer.value = '';
        //document.editform.cacheProducersPoolSize_divCacheEnabledPer.value = '';
    %else%
        %ifvar producerCachingMode equals('1')%
            // this feature is not implemented yet, so skip its index
            document.getElementById('divCacheEnabled').style.display = 'block';
            document.getElementById('divCacheEnabledPer').style.display = 'none';
            document.getElementById('divCacheEnabled2').style.display = 'block';
        %else%
            document.editform.producerCachingMode.selectedIndex=1;
            document.getElementById('divCacheEnabled').style.display = 'none';
            document.getElementById('divCacheEnabledPer').style.display = 'block';
            document.getElementById('divCacheEnabled2').style.display = 'none';
        %endif%
    %endif%
}

/**
 * validateForm
 */ 
function validateForm(obj) {

    var associationTypeElem = obj.associationType;
    var associationTypeValue = associationTypeElem.options[associationTypeElem.selectedIndex].value;

    if (obj.description.value == "") {
        alert("Description must be specified.");
        return false;
    }

    if (associationTypeValue == '0') {
        if (obj.jndi_jndiAliasName.options.length == 0) {
            alert("No JNDI Provider Aliases are configured. You must first create a JNDI Provider Alias via Settings - Messaging - JNDI Settings.");
            return false;
        }
        if (obj.jndi_connectionFactoryLookupName.value == "") {
            alert("Connection Factory Lookup Name must be specified.");
            return false;
        }
        if (obj.jndi_connectionFactoryUpdateType.value == "CLIENT_POLL"
                && (obj.jndi_connectionFactoryPollingInterval.value == '0' || !isInt(obj.jndi_connectionFactoryPollingInterval.value))) {
            alert("Polling Interval must be a positive integer.");
            return false;
        }
    }else {
        if(obj.nwm_brokerHost.value == "") {
            alert("Broker Host must be specified.");
            return false;
        }
        if(obj.nwm_brokerName.value == "") {
            alert("Broker Name must be specified.");
            return false;
        }
        if(obj.nwm_clientGroup.value == "") {
            alert("Client Group must be specified.");
            return false;
        }
        if(obj.clientID.value == "") {
            alert("Connection Client ID must be specified when connecting via Native webMethods API");
            return false;
        }
    }

    if(obj.clientID.value != "") {
	      var regex=/^([A-Za-z][_A-Za-z0-9$]*)$/;
	      if(!regex.test(obj.clientID.value)) {
            alert("Connection Client ID must contain only letters, digits, underscores and dollar characters; and it must start with a letter.");
            return false;
        }
    }
    if (obj.csqSize.value != "" && obj.csqSize.value != "-1" && !isInt(obj.csqSize.value)) {
        alert("Maximum CSQ Size must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.");
        return false;
    }

    /*
     * Producer Caching Validation
     */

    var cacheMode = document.all.editform.producerCachingMode.value;
    var timeout;

    if (cacheMode == 1) { // enabled
      
        var minpool = document.all.editform.producerSessionPoolMinSize_divCacheEnabled.value;
        var maxpool = document.all.editform.producerSessionPoolSize_divCacheEnabled.value;

        var int_minpool = parseInt(minpool);
        var int_maxpool = parseInt(maxpool);

        timeout = document.all.editform.poolTimeout_divCacheEnabled.value;

        if (maxpool == '' || int_maxpool < 1) {
            alert("Maximum Pool Size is required and must be a positive integer.");
            return false;
        }

        if ( (minpool != '') && (!isInt(minpool)) ) {
            alert("Minimum Pool Size must be a nonnegative integer.");
            return false;
        }

        if (!isInt(maxpool)) {
            alert("Maximum Pool Size must be a positive integer.");
            return false;
        }

        if (int_minpool > int_maxpool) {
            alert("Minimum Pool Size cannot be greater than Maximum Pool Size.");
	          return false;
        }

        if ( (timeout != '') && (!isInt(timeout)) && (timeout != "-1") ) {
            alert("Idle Timeout must be a positive integer, 0, or -1. A value of 0 indicates the pool entry will never expire. A value of -1 indicates the system default will be used.");
            return false;
        }

    }else if (cacheMode == 2) { // enabled per destination
      
        var minpoolPerDefault = document.all.editform.producerSessionPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPerDefault = document.all.editform.producerSessionPoolSize_divCacheEnabledPer.value;
        var minpoolPer = document.all.editform.cacheProducersPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPer = document.all.editform.cacheProducersPoolSize_divCacheEnabledPer.value;

        var int_minpoolPerDefault = parseInt(minpoolPerDefault);
        var int_maxpoolPerDefault = parseInt(maxpoolPerDefault);
        var int_minpoolPer = parseInt(minpoolPer);
        var int_maxpoolPer = parseInt(maxpoolPer);

        if (maxpoolPerDefault == '' || int_maxpoolPerDefault < 1) {
            alert("Maximum Pool Size (unspecified destinations) is required and must be a positive integer.");
            return false;
        }

        if ( (minpoolPerDefault != '') && (!isInt(minpoolPerDefault)) ) {
            alert("Minimum Pool Size (unspecified destinations) must be a nonnegative integer.");
            return false;
        }

        if (!isInt(maxpoolPerDefault)) {
            alert("Maximum Pool Size (unspecified destinations) must be a positive integer.");
            return false;
        }

        if ( (minpoolPerDefault != '') && (int_minpoolPerDefault > int_maxpoolPerDefault) ) {
            alert("Minimum Pool Size (unspecified destinations) cannot be greater than Maximum (unspecified destinations) Pool Size.");
	          return false;
        }

        if ( (minpoolPer != '') && (!isInt(minpoolPer)) ) {
            alert("Minimum Pool Size Per Destination must be a nonnegative integer.");
            return false;
        }

        if ( (maxpoolPer != '') && (!isInt(maxpoolPer)) ) {
            alert("Maximum Pool Size Per Destination must be a positive integer.");
            return false;
        }

        if (int_minpoolPer > int_maxpoolPer) {
            alert("Minimum Pool Size Per Destination cannot be greater than Maximum Pool Size Per Destination.");
	          return false;
        }

        var queuelist = '';
        var topiclist = '';
        var destMsg = "The Maximum Pool Size Per Destination and at least one destination are required to enable per destination pooling.  To disable per destination pooling, set Maximum Pool Size Per Destination and the destination list(s) to blank."

        if (%value associationType% == '1') { //WM

            queuelist = document.all.editform.cacheProducersQueueList_divCacheEnabledPer.value;
            topiclist = document.all.editform.cacheProducersTopicList_divCacheEnabledPer.value;

            if (maxpoolPer != '' && maxpoolPer != '0' && queuelist == '' && topiclist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '' || topiclist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }

        }else {

            queuelist = document.all.editform.cacheProducersQueueList_divCacheEnabledPer.value;

            if (maxpoolPer != '' && maxpoolPer != '0' && queuelist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }

        }
        timeout = document.all.editform.poolTimeout_divCacheEnabledPer.value;
        if ( (timeout != '') && (!isInt(timeout)) && (timeout != "-1") ) {
            alert("Idle Timeout must be a positive integer, 0, or -1. A value of 0 indicates the pool entry will never expire. A value of -1 indicates the system default will be used.");
            return false;
        }
     }
    
    /*
     * Producer Retry Validation
     */
     
    if (obj.producerMaxRetryAttempts.value != "" && !isInt(obj.producerMaxRetryAttempts.value)) {
        alert("Max Retry Attempts must be a positive integer.");
        return false;
    }
    
    if (obj.producerRetryInterval.value != "" && !isInt(obj.producerRetryInterval.value)) {
        alert("Retry Interval must be a positive integer.");
        return false;
    } 
    
    return true;
}

/**
 * isInt
 */ 
function isInt(value) {

    var strValidChars = "0123456789";
    var strChar;
    var blnResult = true;

    for (i = 0; i < value.length && blnResult == true; i++) {
        strChar = value.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
            blnResult = false;
        }
    }
    return blnResult;
}

</script>

</head>

<body onLoad="loadDocument();">

  <table width="100%">
    <tr>
      <td class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; JMS Settings &gt; JMS Connection Alias &gt; Edit</TD>
    </tr>
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-jms-detail.dsp?aliasName=%value aliasName%">Return to JMS Connection Alias Detail</a></li>
        </ul>
      </td>
    </tr>
    <tr>

    <form name="editform" action="settings-jms-detail.dsp" METHOD="POST">

      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>
        <table class="tableView" width="100%">

          <!-- form name="editData" -->

          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true">Connection Alias Name</td>
            <td class="oddrowdata-l"><INPUT NAME="aliasName" size="50" value="%value aliasName%" DISABLED></td>
          </tr>

          <!-- Description -->
          <tr>
            <td class="evenrow-l">Description</td>
            <td class="evenrowdata-l"><INPUT NAME="description" size="50" value="%value description%"></td>
          </tr>

          <!-- Transaction Mode -->
          <tr>
            <td class="oddrow-l">Transaction Mode</td>
            <td class="oddrowdata-l">
              <select name="transactionType">
                <option value="0">NO_TRANSACTION</option>
                <option value="1">LOCAL_TRANSACTION</option>
                <option value="2">XA_TRANSACTION</option>
              </select>
            </td>
          </tr>

          <!-- Client ID -->
          <tr>
            <td class="evenrow-l">Connection Client ID</td>
            <td class="evenrowdata-l"><INPUT NAME="clientID" size="50" value="%value clientID%"></td>
          </tr>

          <!-- User -->
          <tr>
            <td class="oddrow-l">User (optional)</td>
            <td class="oddrowdata-l"><INPUT NAME="user" size="50" value="%value user%"></td>
          </tr>

          <!-- Password -->
          <tr>
            <td class="evenrow-l">Password (optional)</td>
            <td class="evenrowdata-l"><input name="password" type="password" autocomplete="off" size="50" value="%value password%"/></td>
          </tr>

          <tr>
            <TD class="heading" colspan=2>Connection Protocol Settings</TD>
          </tr>

          <!-- Association Type -->
          <tr>
            <td class="oddrow-l">
                Create Connection Using
            </td>
            <td class="oddrowdata-l">
                <select name="associationType" onChange="displaySettings(this)">
                    <option value="0">JNDI LOOKUP</option>
                    <option value="1">NATIVE BROKER API</option>
                </select>
            </td>
          </tr>

        </table>

        <!-- DIV1 JNDI -->

        <div id="div1" STYLE="display: none">
        <table class="tableView" width="100%">
          <tr>
            <td class="evenrow-l" width="40%">JNDI Provider Alias Name</td>
            <td class="evenrowdata-l">
              <select name="jndi_jndiAliasName">
                %invoke wm.server.jndi:getJNDIAliases%
                  %loop jndiData%
                    <option value="%value jndiAliasName%">%value jndiAliasName%</option>
                  %endloop%
                %onerror%
                  %value errorService%<br>%value error%<br>%value errorMessage%<br>
                %endinvoke%
              </select>
            </td>
          <tr>
            <td class="oddrow-l" nowrap>Connection Factory Lookup Name</td>
            <td class="oddrowdata-l"><input name="jndi_connectionFactoryLookupName" size="50" value=%value jndi_connectionFactoryLookupName%></td>
          </tr>
          <tr>
            <td class="evenrow-l">Monitor webMethods Connection Factory</td>
            <td class="evenrowdata-l">
              <select name="jndi_connectionFactoryUpdateType" onChange="displayPollingInterval(this.form.jndi_connectionFactoryUpdateType)")>
                <option value="NONE">No</option>
                <option value="CLIENT_POLL">Poll for changes (specify interval)</option>
                <option value="JNDI_POLL">Poll for changes (interval defined by webMethods Connection Factory)</option>
                <option value="NOTIFICATION">Register change listener</option>
              </select>
          </tr>

        </table>
        </div>

        <div id="divPoll" STYLE="display: block">
        <table class="tableView" width="100%">
          <tr>
            <td class="oddrow-l" width="40%">Polling Interval (minutes)</td>
            <td class="oddrowdata-l"><input name="jndi_connectionFactoryPollingInterval" size="50" value=%value jndi_connectionFactoryPollingInterval%></td>
          </tr>
        </table>
        </div>

        <!-- DIV2 WM -->

        <div id="div2" STYLE="display: none">
        <table class="tableView" width="100%">

          <!-- Broker Host -->
          <script>//swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Broker Host</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerHost" size="50" value="%value nwm_brokerHost%"></td>
          </tr>

          <!-- Broker Name -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Broker Name</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerName" size="50" value = "%value nwm_brokerName%"></td>
          </tr>

          <!-- Client Group -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Client Group</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_clientGroup" size="50" value="%value nwm_clientGroup%"></td>
          </tr>

          <!-- Broker List -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Broker List (optional)</td>
            <script>writeTD("row-l");</script><input name="nwm_brokerList" size="50" value="%value nwm_brokerList%"></td>
          </tr>

          <!-- Keystore -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Keystore (optional)</td>
            <script>writeTD("row-l");</script><input name="nwm_keystore" size="50" value="%value nwm_keystore%"></td>
          </tr>

          <!-- Keystore Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Keystore Type (optional)</td>
            <script>writeTD("row-l");</script>
              <select name="nwm_keystoreType">
                <option value=""></option>
                <option value="JKS">JKS</option>
                <option value="PKCS12">PKCS12</option>
              </select>
            </td>
          </tr>

          <!-- Truststore -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Truststore (optional)</td>
            <script>writeTD("row-l");</script><input name="nwm_truststore" size="50" value="%value nwm_truststore%"></td>
          </tr>

          <!-- Truststore Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Truststore Type (optional)</td>
            <script>writeTD("row-l");</script>
              <select name="nwm_truststoreType">
                <option value=""></option>
                <option value="JKS">JKS</option>
              </select>
            </td>
          </tr>

          <!-- Encrypted -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Encrypted</td>
            %ifvar nwm_encrypted equals('true')%
              <script>writeTD("row-l");</script><input type="checkbox" name="nwm_encrypted" checked="true">
            %else%
              <script>writeTD("row-l");</script><input type="checkbox" name="nwm_encrypted">
            %endif%
            </td>
          </tr>

        </table>
        </div>

        <table class="tableView" width="100%">

         <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>

          <!-- Class loader -->
          <script>//uncomment as needed... if (%value associationType% == 1)swapRows();</script>
          <script>swapRows();</script>

          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Class Loader</td>
            <script>writeTD("row-l");</script>
              <select name="classLoader">
                <option value="INTEGRATION_SERVER">INTEGRATION_SERVER</option>
                %invoke wm.server.packages:packageList%
                  %loop packages%
                    <option value="%value name%">PACKAGE: %value name%</option>
                  %endloop%
                %endinvoke%
              </select>
            </td>
          </tr>

          <!-- CSQ -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Maximum CSQ Size (messages)</td>
            <script>writeTD("rowdata-l");</script><input name="csqSize" size="50" value="%value csqSize%"></td>
          </tr>

          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Drain CSQ in Order</td>
            %ifvar csqDrainInOrder equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="csqDrainInOrder" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="csqDrainInOrder"></td>
            %endif%
          </tr>

          <!-- Temp Queue -->
          <script>swapRows();</script>
	        <tr>
            <script>writeTD("row-l");</script>Create Temporary Queue</td>
            %ifvar optTempQueueCreate equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="optTempQueueCreate" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="optTempQueueCreate"></td>
            %endif%
          </tr>

          <!-- Manage Dest -->
          <script>swapRows();</script>
          <tr>  
            <script>writeTDWidth("row-l", "40%");</script>Manage Destinations</td>
            %ifvar manageDestinations equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="manageDestinations" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="manageDestinations"></td>
            %endif%
            </td>
          </tr>

          <!-- Create New Connection per Trigger -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l", "40%");</script>Create New Connection per Trigger</td>
            %ifvar allowNewConnectionPerTrigger equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="allowNewConnectionPerTrigger" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="allowNewConnectionPerTrigger"></td>
            %endif%
            </td>
          </tr>

        </table>

        <!--------------------------->
        <!-- Producer Pool Caching -->
        <!--------------------------->
        <table class="tableView" width="100%">        
          <tr>
              <td class="heading" colspan=2>Producer Caching</td>
          </tr>

          <!-- Caching Mode -->
          <tr>
              <script>swapRows();</script>
              <script>writeTDWidth("row-l", "40%");</script>Caching Mode</td>
              <script>writeTD("rowdata-l");</script>
                  <select name="producerCachingMode" onchange="producerModeSettings(this.form.producerCachingMode)">
                      <option value="0">DISABLED</option>
                    <!--  <option value="1">ENABLED</option>  -->
                      <option value="2">ENABLED PER DESTINATION</option>
                  </select>
              </td>
          </tr>
        </table>

        <!-- Producer Pool Caching - Enabled -->
      <div id="divCacheEnabled" STYLE="display: block">
	    <table class="tableView" width="100%">

          <script>swapRows();</script>
	         <tr>
		         <script>writeTDWidth("row-l", "40%");</script>Minimum Pool Size</td>
		        <script>writeTD("rowdata-l");</script>
              <input name="producerSessionPoolMinSize_divCacheEnabled" size="50" value="%value producerSessionPoolMinSize%">
            </td>
          </tr>

		    <script>swapRows();</script>
	        <tr>
		        <script>writeTDWidth("row-l", "40%");</script>Maximum Pool Size</td>
		        <script>writeTD("rowdata-l");</script>
              <input name="producerSessionPoolSize_divCacheEnabled" size="50" value="%value producerSessionPoolSize%">
            </td>
		      </tr>

        </table>
        </div>

        <!-- Producer Pool Caching - Enabled Per Destination -->
	<div id="divCacheEnabledPer" STYLE="display: block">
	    <table class="tableView" width="100%">

                <script>swapRows();</script>
	        <tr>
		    <script>writeTDWidth("row-l", "40%");</script>Minimum Pool Size (unspecified destinations)</td>
		    <script>writeTD("rowdata-l");</script>
                        <input name="producerSessionPoolMinSize_divCacheEnabledPer" size="50" value="%value producerSessionPoolMinSize%">
                    </td>
		</tr>

		<script>swapRows();</script>
	        <tr>
		    <script>writeTDWidth("row-l", "40%");</script>Maximum Pool Size (unspecified destinations)</td>
		    <script>writeTD("rowdata-l");</script>
                        <input name="producerSessionPoolSize_divCacheEnabledPer" size="50" value="%value producerSessionPoolSize%">
                    </td>
		</tr>
		
                <script>swapRows();</script>
		<tr>
		    <script>writeTDWidth("row-l", "40%");</script>Minimum Pool Size Per Destination</td>
		    <script>writeTD("rowdata-l");</script>
                        %ifvar cacheProducersPoolMinSize equals('0')%
                            <input name="cacheProducersPoolMinSize_divCacheEnabledPer" size="50" value="">
                        %else%
                            <input name="cacheProducersPoolMinSize_divCacheEnabledPer" size="50" value="%value cacheProducersPoolMinSize%">
                        %endif%
                    </td>
		</tr>

                <script>swapRows();</script>
		<tr>
		    <script>writeTDWidth("row-l", "40%");</script>Maximum Pool Size Per Destination</td>
		    <script>writeTD("rowdata-l");</script>
                        %ifvar cacheProducersPoolMinSize equals('0')%
                            <input name="cacheProducersPoolSize_divCacheEnabledPer" size="50" value="">
                        %else%
                            <input name="cacheProducersPoolSize_divCacheEnabledPer" size="50" value="%value cacheProducersPoolSize%">
                        %endif%
                    </td>
		</tr>

                %ifvar associationType equals('1')%

                    <script>swapRows();</script>
	            <tr>
	                <script>writeTDWidth("row-l", "40%");</script>Queue List (semicolon delimited)</td>
	                <script>writeTD("row-l");</script>
	                   <input name="cacheProducersQueueList_divCacheEnabledPer" size="50" value="%value cacheProducersQueueList%">
	                </td>
	            </tr>
	          
                    <script>swapRows();</script>
	            <tr>
	                <script>writeTDWidth("row-l", "40%");</script>Topic List (semicolon delimited)</td>
	                <script>writeTD("row-l");</script>
	                   <input name="cacheProducersTopicList_divCacheEnabledPer" size="50" value="%value cacheProducersTopicList%">
	                </td>
	            </tr>

                %else%

	            <script>swapRows();</script>
	            <tr>
	                <script>writeTDWidth("row-l", "40%");</script>Destination List (semicolon delimited)</td>
	                <script>writeTD("row-l");</script>
	                    <input name="cacheProducersQueueList_divCacheEnabledPer" size="50" value="%value cacheProducersQueueList%">
	                </td>
                    </tr>


               %endif%

                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script>Idle Timeout (milliseconds)</td>
                    <script>writeTD("rowdata-l");</script><input name="poolTimeout_divCacheEnabledPer" size="50" value="%value poolTimeout%"</td>
                </tr>

            </table>
        </div>

    	<!-- Producer Pool Caching - Idle Timeout -->
      <div id="divCacheEnabled2" STYLE="display: block">
	    <table class="tableView" width="100%">
	        <script>if ("%value associationType%" == "0") { swapRows() };</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script>Idle Timeout (milliseconds)</td>
                    <script>writeTD("rowdata-l");</script><input name="poolTimeout_divCacheEnabled" size="50" value="%value poolTimeout%"</td>
                </tr>

            </table>
        </div>
        
        <!-- --------------------- -->
        <!-- Producer Retry        -->
        <!-- --------------------- -->
        <table class="tableView" width="100%">
            <tr>
		            <td class="heading" colspan=2>Producer Retry</td>
            </tr>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Max Retry Attempts</td>
                <script>writeTD("rowdata-l");</script>
                    <input name="producerMaxRetryAttempts" size="50" value="%value producerMaxRetryAttempts%">
                </td>
            </tr>
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Retry Interval (milliseconds)</td>
                <script>writeTD("rowdata-l");</script>
                    <input name="producerRetryInterval" size="50" value="%value producerRetryInterval%">
                </td>
            </tr>
            
        <!--   
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Retry Only if Connected</td>
                %ifvar producerRetryOnlyIfConnected equals('true')%
                    <script>writeTD("row-l");</script><input type="checkbox" name="producerRetryOnlyIfConnected" checked="true"></td>
                %else%
                    <script>writeTD("row-l");</script><input type="checkbox" name="producerRetryOnlyIfConnected"></td>
                %endif%
            </tr>
        -->
        
        </table>

        <!-- Submit Button -->
        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="aliasName" type="hidden" value="%value aliasName%">
                <input name="associationTypeREM" type="hidden" value="%value associationType%">
                <input name="action" type="hidden" value="edit">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">

                <!-- <a href="settings-jms-detail.dsp?aliasName=%value aliasName%"> -->

              </td>
            </tr>

        </table>

      </td>
    </tr>
    <tr>
      <td><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <td>
        <table class="tableView">
          <tr>

          </tr>
        </table>
      </td>
    <tr>

    </form>
  </table>

%onerror%
%value errorService%<br>
%value error%<br>
%value errorMessage%<br>

</body>

%endinvoke%

</html>