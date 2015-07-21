<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">
<link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
<script src="webMethods.js.txt"></script>

<script language ="javascript">

/**
 * onChange to 'Create Connection Using' was made
 */ 
function displaySettings(object) {

    document.all.createform.producerCachingMode.value=0;

    document.getElementById('divCacheEnabled').style.display = 'none';
    document.getElementById('divCacheEnabledPer').style.display = 'none';
    document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
    document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
    document.getElementById('divCacheEnabled2').style.display = 'none';

    if (object.options[object.selectedIndex].value == "JNDI") {
        document.all.div1.style.display = 'block';
        document.all.div2.style.display = 'none';
        document.all.createform.producerCachingMode.disabled=false;

        if (document.createform.jndi_connectionFactoryUpdateType.value == "CLIENT_POLL") {
            document.all.divPoll.style.display = 'block';
        }else {
            document.all.divPoll.style.display = 'none';
        }

    }else if (object.options[object.selectedIndex].value == "WM") {
        document.all.div1.style.display = 'none';
        document.all.divPoll.style.display = 'none';
        document.all.div2.style.display = 'block';
        document.all.createform.producerCachingMode.disabled=false;

    }else {
        document.all.div1.style.display = 'none';
        document.all.divPoll.style.display = 'none';
        document.all.div2.style.display = 'none';
        document.all.createform.producerCachingMode.disabled=true;
    }
}


/**
 * onChange was made to the producer cache mode
 */
function producerModeSettings(object) {

    if (object.value == 0) { // disabled

        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
	document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
	document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
	document.getElementById('divCacheEnabled2').style.display = 'none';
    
    }else if (object.value == 1) { // enabled     

        document.getElementById('divCacheEnabled').style.display = 'block';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
        document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
	document.getElementById('divCacheEnabled2').style.display = 'block';

    }else if (object.value == 2) { // per destination
        
        var associationTypeElem = document.all.createform.associationType
        var associationTypeValue = associationTypeElem.options[associationTypeElem.selectedIndex].value

        if (associationTypeValue == 'JNDI') {   
            document.getElementById('divCacheEnabled').style.display = 'none';
            document.getElementById('divCacheEnabledPer').style.display = 'block';
            document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
            document.getElementById('divCacheEnabledPer_JNDI').style.display = 'block';
	    document.getElementById('divCacheEnabled2').style.display = 'none';

        }else if (associationTypeValue == 'WM') {
            document.getElementById('divCacheEnabled').style.display = 'none';
            document.getElementById('divCacheEnabledPer').style.display = 'block';
            document.getElementById('divCacheEnabledPer_WM').style.display = 'block';
            document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
	    document.getElementById('divCacheEnabled2').style.display = 'none';
        }
    }
}

/**
 *
 */
function displayPollingInterval(object) {
  if (object.options[object.selectedIndex].value == "CLIENT_POLL") {
      document.all.divPoll.style.display = 'block';
  }else {
      document.all.divPoll.style.display = 'none';
  }
}

/**
 *
 */
function loadDocument() {

    setNavigation('settings-broker.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_CreateJMSaliasScrn');

    document.getElementById('divCacheEnabled').style.display = 'none';
    document.getElementById('divCacheEnabledPer').style.display = 'none';
    document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
    document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
    document.getElementById('divCacheEnabled2').style.display = 'none';
}

/**
 * Validation logic
 */
function validateForm(obj) {

    var associationTypeElem = obj.associationType
    var associationTypeValue = associationTypeElem.options[associationTypeElem.selectedIndex].value
    
    if (obj.aliasName.value == "") {
        alert("Connection Alias Name must be specified.");
        return false;
    }

    if (obj.description.value == "") {
        alert("Description must be specified.");
        return false;
    }

    if (obj.associationType.selectedIndex == 0) {
        alert("Create Connection Using must be specified.");
        return false;
    }

    if (obj.associationType.selectedIndex == 1) {
        if (obj.jndi_jndiAliasName.options.length == 0) {
            alert("No JNDI Provider Aliases are configured. You must first create a JNDI Provider Alias via Settings - Messaging - JNDI Settings.");
            return false;
        }
        if (obj.jndi_connectionFactoryLookupName.value == "") {
            alert("Connection Factory Lookup Name must be specified.");
            return false;
        }

        if (obj.jndi_connectionFactoryUpdateType.value == "CLIENT_POLL") {
            if (obj.jndi_connectionFactoryPollingInterval.value == '0' || !isInt(obj.jndi_connectionFactoryPollingInterval.value)) {
                alert("Polling Interval must be a positive integer.");
                return false;
            }
        }else {
            obj.jndi_connectionFactoryPollingInterval.value = 1440; //reset to default
        }

    }else if (obj.associationType.selectedIndex == 2) {

        if(obj.nwm_brokerHost.value == "") {
            alert("Broker Host must be specified.");
            return false;

        }else if(obj.nwm_brokerName.value == "") {
            alert("Broker Name must be specified.");
            return false;

        }else if(obj.nwm_clientGroup.value == "") {
            alert("Client Group must be specified.");
            return false;

        }else if(obj.clientID.value == "") {
            alert("Connection Client ID must be specified when connecting via Native webMethods API.");
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

    /*
     * Producer Caching Validation
     */

    var cacheMode = document.all.createform.producerCachingMode.value;
    var timeout;

    if (cacheMode == 1) { // enabled
      
        var minpool = document.all.createform.producerSessionPoolMinSize_divCacheEnabled.value;
        var maxpool = document.all.createform.producerSessionPoolSize_divCacheEnabled.value;

        var int_minpool = parseInt(minpool);
        var int_maxpool = parseInt(maxpool);

        timeout = document.all.createform.poolTimeout_divCacheEnabled2.value;

        if (maxpool == '' || int_maxpool < 1) {
            alert("Maximum Pool Size is required and must be greater than 0.");
            return false;
        }

        if ( (minpool != '') && (!isInt(minpool)) ) {
            alert("Minimum Pool Size must be a non-negative integer.");
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

    } else if (cacheMode == 2) { // enabled per destination
      
        var minpoolPerDefault = document.all.createform.producerSessionPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPerDefault = document.all.createform.producerSessionPoolSize_divCacheEnabledPer.value;
        var minpoolPer = document.all.createform.cacheProducersPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPer = document.all.createform.cacheProducersPoolSize_divCacheEnabledPer.value;

        var int_minpoolPerDefault = parseInt(minpoolPerDefault);
        var int_maxpoolPerDefault = parseInt(maxpoolPerDefault);
        var int_minpoolPer = parseInt(minpoolPer);
        var int_maxpoolPer = parseInt(maxpoolPer);

        if (maxpoolPerDefault == '' || int_maxpoolPerDefault < 1) {
            alert("Maximum Pool Size (unspecified destinations) is required and must be greater than 0.");
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
            alert("Minimum Pool Size (unspecified destinations) cannot be greater than Maximum Pool Size (unspecified destinations).");
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

        if (associationTypeValue == "WM") { // Native WM
            timeout = document.all.createform.poolTimeout_divCacheEnabledPer_WM.value;
            queuelist = document.all.createform.cacheProducersQueueList_divCacheEnabledPer_WM.value;
            topiclist = document.all.createform.cacheProducersTopicList_divCacheEnabledPer_WM.value;

            if ( (maxpoolPer != '' && maxpoolPer != '0') && queuelist == '' && topiclist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '' || topiclist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }

        }else { // JNDI
            timeout = document.all.createform.poolTimeout_divCacheEnabledPer_JNDI.value;
            queuelist = document.all.createform.cacheProducersQueueList_divCacheEnabledPer_JNDI.value;

            if (maxpoolPer != '' && maxpoolPer != '0' && queuelist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }
        }

        if ( (timeout != '') && (!isInt(timeout)) && (timeout != "-1") ) {
            alert("Idle Timeout must be a positive integer, 0, or -1. A value of 0 indicates the pool entry will never expire. A value of -1 indicates the system default will be used.");
            return false;
        }
    }

    return true;
}

/**
 * Check if value is an int
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

  //  if (value.length == 0 || value > 2147483647) {
  //      return false;
  //  }

    return blnResult;
}

</script>
</head>

<body onLoad="loadDocument()">

  <table width="100%">
    <tr>
      <td class="menusection-Settings" colspan="2">Settings &gt; Messaging &gt; JMS Settings &gt; JMS Connection Alias &gt; Create</td>
    </tr>

    <tr>
      <td colspan="2">
        <ul>
          <li><a href="settings-jms.dsp">Return to JMS Settings</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>

      <form name='createform' action="settings-jms.dsp" method="post">

        <table class="tableView" width="100%">

          <!-- Connection Alias Name -->
          <script>swapRows();</script>
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Connection Alias Name</td>
            <td class="oddrow-l"><INPUT NAME="aliasName" size="50"></td>
          </tr>

          <!-- Description -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Description</td>
            <script>writeTD("row-l");</script><INPUT NAME="description" size="50"></td>
          </tr>

          <!-- Transaction Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Transaction Type</td>
            <script>writeTD("row-l");</script>
              <select name="transactionType">
                <!-- <option value="blank"></option> -->
                <option value="0">NO_TRANSACTION</option>
                <option value="1">LOCAL_TRANSACTION</option>
                <option value="2">XA_TRANSACTION</option>
              </select>
            </td>
          </tr>

          <!-- Connection Client ID -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Connection Client ID</td>
            <script>writeTD("row-l");</script><INPUT NAME="clientID" size="50"></td>
          </tr>

          <!-- User -->
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>User (optional)</td>
            <script>writeTD("row-l");</script><INPUT NAME="user" size="50"></td>
          </tr>

          <!-- Password -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Password (optional)</td>
            <script>writeTD("row-l");</script><input type="password" name="password" autocomplete="off" size="50" /></td>
          </tr>

          <tr>
            <td class="heading" colspan=2>Connection Protocol Settings</td>
          </tr>

          <!-- Connect Uisng -->

          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Create Connection Using</td>
            <script>writeTD("row-l");</script>
              <select name="associationType" onchange="displaySettings(this.form.associationType)">
                <option value="blank"></option>
                <option value="JNDI">JNDI LOOKUP</option>
                <option value="WM">NATIVE WEBMETHODS API</option>
              </select>
            </td>
          </tr>
        </table>

        <!-- DIV: CONNECTION MODE: JNDI -->

        <div id="div1" STYLE="display: none">
        <table class="tableView" width="100%">
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>JNDI Provider Alias Name</td>
            <script>writeTD("row-l");</script>
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
          <script>swapRows();</script>
          </tr>
          <tr>
            <script>writeTD("row-l");</script>Connection Factory Lookup Name</td>
            <script>writeTDnowrap("row-l");</script><INPUT NAME="jndi_connectionFactoryLookupName" size="50"></td>
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

        <div id="divPoll" STYLE="display: none">
        <table class="tableView" width="100%">
          <tr>
            <td class="oddrow-l" width="40%">Polling Interval (minutes)</td>
            <td class="oddrowdata-l"><input name="jndi_connectionFactoryPollingInterval" size="50" value="1440"></td>
          </tr>
        </table>
        </div>

        <!-- DIV: CONNECTION MODE: WM -->

        <div id="div2" STYLE="display: none">
        <table class="tableView" width="100%">

     <!-- Connection Type
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Connection Type</td>
            <script>writeTD("row-l");</script>
              <select name="nwm_connectionType">
                <option value="queue">QUEUE</option>
                <option value="topic">TOPIC</option>
                <option value="xaqueue">XA QUEUE</option>
                <option value="xatopic">XA TOPIC</option>
              </select>
            </td>
          </tr>

     -->

          <!-- Broker Host -->
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Broker Host</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerHost" size="50" value="localhost:6849"></td>
          </tr>

          <!-- Broker Name -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Broker Name</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerName" size="50" value="Broker #1"></td>
          </tr>

          <!-- Client Group -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Client Group</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_clientGroup" size="50" value="IS-JMS"></td>
          </tr>

          <!-- Shared State
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Shared State</td>
            <script>writeTD("row-l");</script>
               <input type="checkbox" name="nwm_sharedState" checked="true">
            </td>
          </tr>
          -->

          <!-- Shared State Order
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Shared State Order</td>
            <script>writeTD("row-l");</script>
              <select name="nwm_sharedStateOrder">
                <option value="0">NONE</option>
                <option value="1">ORDER BY PUBLISHER</option>
              </select>
            </td>
          </tr>
          -->

          <!-- Broker List -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Broker List (optional)</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerList" size="50"></td>
          </tr>

          <!-- Keystore -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Keystore (optional)</td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_keystore" size="50"></td>
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
            <script>writeTD("row-l");</script><INPUT NAME="nwm_truststore" size="50"></td>
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
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="nwm_encrypted">
            </td>
          </tr>

          <!-- Dead Letter Only
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Dead Letter Only</td>
            <script>writeTD("row-l");</script>
               <input type="checkbox" name="nwm_deadLetterOnly">
            </td>
          </tr>
          -->

        </table>
        </div>

		<div id="div3" STYLE="display: block">
        <table class="tableView" width="100%">

          <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>

          <script>swapRows();</script>

          <!-- Class loader -->
          <tr>
            <script>writeTD("row-l");</script>Class Loader</td>
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

          <!-- Max CSQ Size -->
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Maximum CSQ Size (messages)</td>
            <script>writeTD("row-l");</script>
               <input name="csqSize" size="50" value="-1">
            </td>
          </tr>

          <!-- Drain CSQ -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Drain CSQ in Order</td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="csqDrainInOrder" checked=true>
            </td>
          </tr>

          <!-- Create Tempororay queue -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Create Temporary Queue</td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="optTempQueueCreate" checked=true>
            </td>
          </tr>

          <!-- Manage Destinations -->
          <script>swapRows();</script>
          <tr>  
            <script>writeTD("row-l");</script>Manage Destinations</td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="manageDestinations" checked=true>
            </td>
          </tr>
          
          <!-- Create New Connection per Trigger -->
          <script>swapRows();</script>
          <tr>  
            <script>writeTD("row-l");</script>Create New Connection per Trigger</td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="allowNewConnectionPerTrigger">
            </td>
          </tr>

        </table>
      </div>

        <!-- --------------------- -->
        <!-- Producer Pool Caching -->
        <!-- --------------------- -->

        <table class="tableView" width="100%">
            <tr>
		<td class="heading" colspan=2>Producer Caching</td>
            </tr>
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Caching Mode</td>
                <script>writeTD("rowdata-l");</script>
                    <select name="producerCachingMode" disabled="disabled" onchange="producerModeSettings(this.form.producerCachingMode)">
                        <option value="0">DISABLED</option>
                     <!--   <option value="1">ENABLED</option>  -->
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
		    <script>writeTD("rowdata-l");</script><input name="producerSessionPoolMinSize_divCacheEnabled" size="50" value="1"></td>
		</tr>

		<script>swapRows();</script>
	        <tr>
		    <script>writeTDWidth("row-l", "40%");</script>Maximum Pool Size</td>
		    <script>writeTD("rowdata-l");</script>
                        <input name="producerSessionPoolSize_divCacheEnabled" size="50" value="30">
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
		    <script>writeTD("rowdata-l");</script><input name="producerSessionPoolMinSize_divCacheEnabledPer" size="50" value="1"></td>
		</tr>

		<script>swapRows();</script>
	        <tr>
		    <script>writeTDWidth("row-l", "40%");</script>Maximum Pool Size (unspecified destinations)</td>
		    <script>writeTD("rowdata-l");</script><input name="producerSessionPoolSize_divCacheEnabledPer" size="50" value="30"></td>
		</tr>
		
                <script>swapRows();</script>
		<tr>
		    <script>writeTDWidth("row-l", "40%");</script>Minimum Pool Size Per Destination</td>
		    <script>writeTD("rowdata-l");</script><input name="cacheProducersPoolMinSize_divCacheEnabledPer" size="50" value=""></td>
		</tr>

                <script>swapRows();</script>
		<tr>
		    <script>writeTDWidth("row-l", "40%");</script>Maximum Pool Size Per Destination</td>
		    <script>writeTD("rowdata-l");</script><input name="cacheProducersPoolSize_divCacheEnabledPer" size="50" value=""></td>
		</tr>

    </table>
        </div>

        <!-- Producer Pool Caching - Enabled Per Destination - Using WM -->
	       <div id="divCacheEnabledPer_WM" STYLE="display: block">
	           <table class="tableView" width="100%">
	           <script>swapRows();</script>
	               <tr>
	                   <script>writeTDWidth("row-l", "40%");</script>Queue List (semicolon delimited)</td>
	                   <script>writeTD("row-l");</script>
	                       <input name="cacheProducersQueueList_divCacheEnabledPer_WM" size="50" value="">
	                   </td>
	               </tr>
	                                
                 <script>swapRows();</script>
	               <tr>
	                   <script>writeTDWidth("row-l", "40%");</script>Topic List (semicolon delimited)</td>
	                   <script>writeTD("row-l");</script>
	                       <input name="cacheProducersTopicList_divCacheEnabledPer_WM" size="50" value="">
	                  </td>
	               </tr>
	               <script>swapRows();</script>
                 <tr>
                     <script>writeTDWidth("row-l", "40%");</script>Idle Timeout (milliseconds)</td>
                     <script>writeTD("row-l");</script><INPUT NAME="poolTimeout_divCacheEnabledPer_WM" size="50" value="60000"></td>
                 </tr>
            </table>
        </div>

        <!-- Producer Pool Caching - Using JNDI -->
        <div id="divCacheEnabledPer_JNDI" STYLE="display: block">
            <table class="tableView" width="100%">
	          <!--<script>swapRows();</script>-->
	              <tr>
	                  <script>writeTDWidth("row-l", "40%");</script>Destination List (semicolon delimited)</td>
	                  <script>writeTD("row-l");</script>
	                      <input name="cacheProducersQueueList_divCacheEnabledPer_JNDI" size="50" value="">
	                  </td>
                </tr>
	                  <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script>Idle Timeout (milliseconds)</td>
                    <script>writeTD("row-l");</script><INPUT NAME="poolTimeout_divCacheEnabledPer_JNDI" size="50" value="60000"></td>
                </tr>
            </table>
        </div>

        <!-- Producer Pool Caching - Idle Timeout (only used when mode = enabled -->
        <div id="divCacheEnabled2" STYLE="display: block">
            <table class="tableView" width="100%">
	          <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script>Idle Timeout (milliseconds)</td>
                    <script>writeTD("row-l");</script><INPUT NAME="poolTimeout_divCacheEnabled2" size="50" value="60000"></td>
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
                    <input name="producerMaxRetryAttempts" size="50" value="0">
                </td>
            </tr>
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Retry Interval (milliseconds)</td>
                <script>writeTD("rowdata-l");</script>
                    <input name="producerRetryInterval" size="50" value="1000">
                </td>
            </tr>
        <!--
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Retry Only if Connected</td>
                <script>writeTD("rowdata-l");</script>
                    <input type="checkbox" name="producerRetryOnlyIfConnected" checked="true">
                </td>
            </tr>
        -->
        </table>

        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="action" type="hidden" value="create">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
              </td>
            </tr>
        </table>

       </form>

      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>
        <table class="tableView">
          <tr>

          </tr>
        </table>
      </td>
    <tr>
  </table>
</body>
</html>
