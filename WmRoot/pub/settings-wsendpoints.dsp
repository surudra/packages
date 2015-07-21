<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

  function checkPrevState(id, childName, imgID) {
  	var trElem = document.getElementById(id);
	
  	var vall = '0';
  	try {
  		vall = top[childName];
  	} catch(e) {
  	}
	
	/*if (id == 'ProviderJMSToggleRow') {
		vall ='0';
	}*/

  	if(vall == '1' && trElem != null) {
		trElem.setAttribute('manualhide', 'true');
		toggle(trElem, childName, imgID);

  	}
  }


  function confirmDelete (alias, type, transportType) {
    var msg = "OK to delete web service " + type + " endpoint '"+alias+"' from configuration?";
    if (confirm (msg)) {
         document.deleteform.alias.value = alias;
         document.deleteform.type.value = type;
         document.deleteform.transportType.value = transportType;
         document.deleteform.submit();
         return false;
    } else return false;
  }

  function toggle(parent, id, imgID) {
		var set = 'none';
		var topVall = '0';
		var imgElem = document.getElementById(imgID);
		if(parent.getAttribute('manualhide') == 'true') {
			set = 'table-row';
			parent.setAttribute('manualhide', 'false');
			imgElem.src = 'images/expanded_brown.gif'
			topVall = '1';

		} else {
			parent.setAttribute('manualhide', 'true');
			imgElem.src = 'images/collapsed_brown.gif'
			topVall = '0';

		}
		try {
			top[id] = topVall;
		} catch(e) {}
		var elements = getElements("TR", id);
		for ( var i = 0; i < elements.length; i++) {
			var element = elements[i];
			element.style.cssText = "display:"+set;
		}
	}

	function getElements(tag, name) {
		var elem = document.getElementsByTagName(tag);
		var arr = new Array();
		for(i=0, idx=0; i<elem.length; i++) {
			att = elem[i].getAttribute("name");
			if(att == name) {
				arr[idx++] = elem[i];
			}
		}
		return arr;
	}
</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('settings-wsendpints.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_WebServicesScrn');">
<TABLE width="100%">
<TR>
    <TD class="menusection-Settings" colspan="2">
    Settings &gt;
    Web Services </TD>
</TR>
%ifvar action%
%switch action%
	%case 'delete'%
		%ifvar type equals('provider')%
			%invoke wm.server.ws:deleteProviderEndpoint%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
			%endinvoke%
		%else%
			%ifvar type equals('consumer')%
				%invoke wm.server.ws:deleteConsumerEndpoint%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<TR><TD class="message" colspan="2">%value message%</TD></TR>
					%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
				%endinvoke%
			%else%
				%invoke wm.server.ws:deleteMessageAddressingEndpoint%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<TR><TD class="message" colspan="2">%value message%</TD></TR>
					%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
				%endinvoke%
			%endif%
		%endif%

	<!-- default action add or edit -->
	%case%
		<!-- CONSUMER START -->
		%ifvar type equals('consumer')%
			%switch transportType%
				%case 'HTTP'%
					<!-- Consumer HTTP -->
					%scope 
						rparam(transportInfo={transportType='HTTP'}) 
						rparam(messageInfo={user=''})
						rparam(messageAddressingProperties={mustUnderstand=''})
						rparam(reliableMessagingProperties={enable=''})
						rparam(toAdddress={attributes='';})
						rparam(toMetadata={attributes='';})
						rparam(fromAdddress={attributes='';})
						rparam(fromMetadata={attributes='';})
						rparam(replyToAdddress={attributes='';})
						rparam(replyToMetadata={attributes='';})
						rparam(faultToAdddress={attributes='';})
						rparam(faultToMetadata={attributes='';})
						rparam(to={attributes='';})
						rparam(from={attributes='';})
						rparam(replyTo={attributes='';})
						rparam(faultTo={attributes='';})%
						
						<!-- to EPR -->
						%scope toAdddress%
							%rename ../../toAddressURL value  -copy%
						%endscope%
						%scope toMetadata%
							%ifvar ../../toMetadataElementsList%
								%rename ../../toMetadataElementsList elements  -copy%
							%else%	
								%rename ../../toMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope to%
							%rename ../toAdddress address  -copy%
							%ifvar ../../toReferenceParamsList%
								%rename ../../toReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../toReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../toExtensibleList%
								%rename ../../toExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../toExtensible extensibleElements  -copy%
							%endif%
							%rename ../toMetadata metadata  -copy%								
						%endscope%

						<!-- from EPR -->
						%scope fromAdddress%
							%rename ../../fromAddressURL value  -copy%
						%endscope%
						%scope fromMetadata%
							%ifvar ../../fromMetadataElementsList%
								%rename ../../fromMetadataElementsList elements  -copy%
							%else%	
								%rename ../../fromMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope from%
							%rename ../fromAdddress address  -copy%
							%ifvar ../../fromReferenceParamsList%
								%rename ../../fromReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../fromReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../fromExtensibleList%
								%rename ../../fromExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../fromExtensible extensibleElements  -copy%
							%endif%
							%rename ../fromMetadata metadata  -copy%								
						%endscope%
							
						<!-- replyTo EPR -->
						%scope replyToAdddress%
						%rename ../../replyToAddressURL value  -copy%
						%endscope%
						%scope replyToMetadata%
							%ifvar ../../replyToMetadataElementsList%
								%rename ../../replyToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../replyToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope replyTo%
							%rename ../replyToAdddress address  -copy%
							%ifvar ../../replyToReferenceParamsList%
								%rename ../../replyToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../replyToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../replyToExtensibleList%
								%rename ../../replyToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../replyToExtensible extensibleElements  -copy%
							%endif%
							%rename ../replyToMetadata metadata  -copy%
						%endscope%
						
						<!-- faultTo EPR -->
						%scope faultToAdddress%
							%rename ../../faultToAddressURL value  -copy%
						%endscope%
						%scope faultToMetadata%
							%ifvar ../../faultToMetadataElementsList%
								%rename ../../faultToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../faultToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope faultTo%
							%rename ../faultToAdddress address  -copy%
							%ifvar ../../faultToReferenceParamsList%
								%rename ../../faultToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../faultToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../faultToExtensibleList%
								%rename ../../faultToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../faultToExtensible extensibleElements  -copy%
							%endif%
							%rename ../faultToMetadata metadata  -copy%
						%endscope%

						<!-- WS Message Addressing Info -->
						%scope messageAddressingProperties%
							%rename ../../mustUnderstand mustUnderstand -copy%
							%rename ../../soapRole soapRole -copy%
							%rename ../to to  -copy%
							%rename ../from from  -copy%
							%rename ../replyTo replyTo  -copy%
							%rename ../faultTo faultTo  -copy%
						%endscope%
						
						<!-- WS RM Info -->
						%scope reliableMessagingProperties%
							%rename ../enable enable -copy%
							%rename ../retransmissionInterval retransmissionInterval -copy%
							%rename ../acknowledgementInterval acknowledgementInterval -copy%
							%rename ../exponentialBackoff exponentialBackoff  -copy%
							%rename ../maximumRetransmissionCount maximumRetransmissionCount  -copy%
						%endscope%

						%scope transportInfo%
							%rename ../../transportType transportType -copy%
							%rename ../../host host -copy%
							%rename ../../port port -copy%
							%rename ../../authType authType -copy%
							%rename ../../transportUser user -copy%
							%rename ../../transportPassword password -copy%
							%rename ../../proxyAlias proxyAlias -copy%
						%endscope%
						%scope messageInfo%
							%rename ../../messageUser user -copy%
							%rename ../../messagePassword password -copy%
							%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
							%rename ../../messagePrivateKeyAlias keyAlias -copy%
							%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
							%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
						%endscope%
						%invoke wm.server.ws:massageEPRValuesInPipeline%
							%invoke wm.server.ws:addConsumerEndpoint%
								%ifvar message%
									<tr><td colspan="2">&nbsp;</td></tr>
									<TR><TD class="message" colspan="2">%value message%</TD></TR>
								%endif%
							%onerror%
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
							%endinvoke%
						%endinvoke%
					%endscope%
				%case 'HTTPS'%
					<!-- Consumer HTTPS -->
					%scope rparam(transportInfo={transportType='HTTP'}) 
					    rparam(messageInfo={user=''})
   						rparam(messageAddressingProperties={mustUnderstand=''})
						rparam(reliableMessagingProperties={enable=''})
						rparam(toAdddress={attributes='';})
						rparam(toMetadata={attributes='';})
						rparam(fromAdddress={attributes='';})
						rparam(fromMetadata={attributes='';})
						rparam(replyToAdddress={attributes='';})
						rparam(replyToMetadata={attributes='';})
						rparam(faultToAdddress={attributes='';})
						rparam(faultToMetadata={attributes='';})
						rparam(to={attributes='';})
						rparam(from={attributes='';})
						rparam(replyTo={attributes='';})
						rparam(faultTo={attributes='';})%
						
						<!-- to EPR -->
						%scope toAdddress%
							%rename ../../toAddressURL value  -copy%
						%endscope%
						%scope toMetadata%
							%ifvar ../../toMetadataElementsList%
								%rename ../../toMetadataElementsList elements  -copy%
							%else%	
								%rename ../../toMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope to%
							%rename ../toAdddress address  -copy%
							%ifvar ../../toReferenceParamsList%
								%rename ../../toReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../toReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../toExtensibleList%
								%rename ../../toExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../toExtensible extensibleElements  -copy%
							%endif%	
							%rename ../toMetadata metadata  -copy%								
						%endscope%

						<!-- from EPR -->
						%scope fromAdddress%
							%rename ../../fromAddressURL value  -copy%
						%endscope%
						%scope fromMetadata%
							%ifvar ../../fromMetadataElementsList%
								%rename ../../fromMetadataElementsList elements  -copy%
							%else%	
								%rename ../../fromMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope from%
							%rename ../fromAdddress address  -copy%
							%ifvar ../../fromReferenceParamsList%
								%rename ../../fromReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../fromReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../fromExtensibleList%
								%rename ../../fromExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../fromExtensible extensibleElements  -copy%
							%endif%
							%rename ../fromMetadata metadata  -copy%								
						%endscope%
							
						<!-- replyTo EPR -->
						%scope replyToAdddress%
						%rename ../../replyToAddressURL value  -copy%
						%endscope%
						%scope replyToMetadata%
							%ifvar ../../replyToMetadataElementsList%
								%rename ../../replyToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../replyToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope replyTo%
							%rename ../replyToAdddress address  -copy%
							%ifvar ../../replyToReferenceParamsList%
								%rename ../../replyToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../replyToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../replyToExtensibleList%
								%rename ../../replyToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../replyToExtensible extensibleElements  -copy%
							%endif%	
							%rename ../replyToMetadata metadata  -copy%
						%endscope%
						
						<!-- faultTo EPR -->
						%scope faultToAdddress%
							%rename ../../faultToAddressURL value  -copy%
						%endscope%
						%scope faultToMetadata%
							%ifvar ../../faultToMetadataElementsList%
								%rename ../../faultToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../faultToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope faultTo%
							%rename ../faultToAdddress address  -copy%
							%ifvar ../../faultToReferenceParamsList%
								%rename ../../faultToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../faultToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../faultToExtensibleList%
								%rename ../../faultToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../faultToExtensible extensibleElements  -copy%
							%endif%
							%rename ../faultToMetadata metadata  -copy%
						%endscope%

						<!-- WS Message Addressing Info -->
						%scope messageAddressingProperties%
							%rename ../../mustUnderstand mustUnderstand -copy%
							%rename ../../soapRole soapRole -copy%
							%rename ../to to  -copy%
							%rename ../from from  -copy%
							%rename ../replyTo replyTo  -copy%
							%rename ../faultTo faultTo  -copy%
						%endscope%

						<!-- WS RM Info -->
						%scope reliableMessagingProperties%
							%rename ../enable enable -copy%
							%rename ../retransmissionInterval retransmissionInterval -copy%
							%rename ../acknowledgementInterval acknowledgementInterval -copy%
							%rename ../exponentialBackoff exponentialBackoff  -copy%
							%rename ../maximumRetransmissionCount maximumRetransmissionCount  -copy%
						%endscope%

						%scope transportInfo%
							%rename ../../transportType transportType -copy%
							%rename ../../host host -copy%
							%rename ../../port port -copy%
							%rename ../../authType authType -copy%
							%rename ../../transportUser user -copy%
							%rename ../../transportPassword password -copy%
							%rename ../../transportKeyStoreAlias keyStoreAlias -copy%
							%rename ../../transportPrivateKeyAlias keyAlias -copy%
							%rename ../../proxyAlias proxyAlias -copy%
						%endscope%
						%scope messageInfo%
							%rename ../../messageUser user -copy%
							%rename ../../messagePassword password -copy%
							%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
							%rename ../../messagePrivateKeyAlias keyAlias -copy%
							%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
							%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
						%endscope%
						%invoke wm.server.ws:massageEPRValuesInPipeline%
							%invoke wm.server.ws:addConsumerEndpoint%
							%ifvar message%
								<tr><td colspan="2">&nbsp;</td></tr>
								<TR><TD class="message" colspan="2">%value message%</TD></TR>
							%endif%
							%onerror%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
							%endinvoke%
						%endinvoke%
					%endscope%
				%case 'JMS'%
					%ifvar jmsAliasType equals('JNDI')%
						<!-- Consumer JMS - JNDI Provider Alias -->
						%scope rparam(transportInfo={transportType='JMS'}) 
							rparam(messageInfo={user=''})
							rparam(messageAddressingProperties={mustUnderstand=''})
							rparam(toAdddress={attributes='';})
							rparam(toMetadata={attributes='';})
							rparam(fromAdddress={attributes='';})
							rparam(fromMetadata={attributes='';})
							rparam(replyToAdddress={attributes='';})
							rparam(replyToMetadata={attributes='';})
							rparam(faultToAdddress={attributes='';})
							rparam(faultToMetadata={attributes='';})
							rparam(to={attributes='';})
							rparam(from={attributes='';})
							rparam(replyTo={attributes='';})
							rparam(faultTo={attributes='';})%
							
							<!-- to EPR -->
							%scope toAdddress%
								%rename ../../toAddressURL value  -copy%
							%endscope%
							%scope toMetadata%
								%ifvar ../../toMetadataElementsList%
									%rename ../../toMetadataElementsList elements  -copy%
								%else%	
									%rename ../../toMetadataElements elements  -copy%
								%endif%	
							%endscope%

							%scope to%
								%rename ../toAdddress address  -copy%
								%ifvar ../../toReferenceParamsList%
									%rename ../../toReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../toReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../toExtensibleList%
									%rename ../../toExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../toExtensible extensibleElements  -copy%
								%endif%	
								%rename ../toMetadata metadata  -copy%								
							%endscope%

							<!-- from EPR -->
							%scope fromAdddress%
								%rename ../../fromAddressURL value  -copy%
							%endscope%
							%scope fromMetadata%
								%ifvar ../../fromMetadataElementsList%
									%rename ../../fromMetadataElementsList elements  -copy%
								%else%	
									%rename ../../fromMetadataElements elements  -copy%
								%endif%	
							%endscope%

							%scope from%
								%rename ../fromAdddress address  -copy%
								%ifvar ../../fromReferenceParamsList%
									%rename ../../fromReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../fromReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../fromExtensibleList%
									%rename ../../fromExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../fromExtensible extensibleElements  -copy%
								%endif%
								%rename ../fromMetadata metadata  -copy%								
							%endscope%
								
							<!-- replyTo EPR -->
							%scope replyToAdddress%
							%rename ../../replyToAddressURL value  -copy%
							%endscope%
							%scope replyToMetadata%
								%ifvar ../../replyToMetadataElementsList%
									%rename ../../replyToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../replyToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope replyTo%
								%rename ../replyToAdddress address  -copy%
								%ifvar ../../replyToReferenceParamsList%
									%rename ../../replyToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../replyToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../replyToExtensibleList%
									%rename ../../replyToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../replyToExtensible extensibleElements  -copy%
								%endif%
								%rename ../replyToMetadata metadata  -copy%
							%endscope%
							
							<!-- faultTo EPR -->
							%scope faultToAdddress%
								%rename ../../faultToAddressURL value  -copy%
							%endscope%
							%scope faultToMetadata%
								%ifvar ../../faultToMetadataElementsList%
									%rename ../../faultToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../faultToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope faultTo%
								%rename ../faultToAdddress address  -copy%
								%ifvar ../../faultToReferenceParamsList%
									%rename ../../faultToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../faultToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../faultToExtensibleList%
									%rename ../../faultToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../faultToExtensible extensibleElements  -copy%
								%endif%
								%rename ../faultToMetadata metadata  -copy%
							%endscope%

							<!-- WS Message Addressing Info -->
							%scope messageAddressingProperties%
								%rename ../../mustUnderstand mustUnderstand -copy%
								%rename ../../soapRole soapRole -copy%
								%rename ../to to  -copy%
								%rename ../from from  -copy%
								%rename ../replyTo replyTo  -copy%
								%rename ../faultTo faultTo  -copy%
							%endscope%

							%scope transportInfo%
								%rename ../../transportType transportType -copy%
								%rename ../../jmsAliasType jmsAliasType -copy%
								%rename ../../jndiProvAlias jndiProvAlias -copy%
								%rename ../../connFactoryName connFactoryName -copy%
								%rename ../../destinationNameJNDI destinationName -copy%
								%ifvar ../../destinationTypeJNDI -notempty%
									%rename ../../destinationTypeJNDI destinationType -copy%
								%else%
									%rename ../../dummyEmptyValue destinationType -copy%
								%endif%
								%rename ../../replyToDestNameJNDI replyToDestName -copy%
								%ifvar ../../replyToDestTypeJNDI -notempty%
									%rename ../../replyToDestTypeJNDI replyToDestType -copy%
								%else%
									%rename ../../dummyEmptyValue replyToDestType -copy%
								%endif%
							%endscope%
							%scope messageInfo%
								%rename ../../messageUser user -copy%
								%rename ../../messagePassword password -copy%
								%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
								%rename ../../messagePrivateKeyAlias keyAlias -copy%
								%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
								%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
  							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
  							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
  							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
							%endscope%
							%invoke wm.server.ws:massageEPRValuesInPipeline%
							%invoke wm.server.ws:addConsumerEndpoint%
								%ifvar message%
									<tr><td colspan="2">&nbsp;</td></tr>
									<TR><TD class="message" colspan="2">%value message%</TD></TR>
								%endif%
							%onerror%
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
							%endinvoke%
							%endinvoke%
						%endscope%
					%else%
						<!-- Consumer JMS - JMS Connection Alias -->
						%scope rparam(transportInfo={transportType='JMS'}) 
							rparam(messageInfo={user=''})
							rparam(messageAddressingProperties={mustUnderstand=''})
							rparam(toAdddress={attributes='';})
							rparam(toMetadata={attributes='';})
							rparam(fromAdddress={attributes='';})
							rparam(fromMetadata={attributes='';})
							rparam(replyToAdddress={attributes='';})
							rparam(replyToMetadata={attributes='';})
							rparam(faultToAdddress={attributes='';})
							rparam(faultToMetadata={attributes='';})
							rparam(to={attributes='';})
							rparam(from={attributes='';})
							rparam(replyTo={attributes='';})
							rparam(faultTo={attributes='';})%
							
							<!-- to EPR -->
							%scope toAdddress%
								%rename ../../toAddressURL value  -copy%
							%endscope%
							%scope toMetadata%
								%ifvar ../../toMetadataElementsList%
									%rename ../../toMetadataElementsList elements  -copy%
								%else%	
									%rename ../../toMetadataElements elements  -copy%
								%endif%	
							%endscope%

							%scope to%
								%rename ../toAdddress address  -copy%
								%ifvar ../../toReferenceParamsList%
									%rename ../../toReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../toReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../toExtensibleList%
									%rename ../../toExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../toExtensible extensibleElements  -copy%
								%endif%	
								%rename ../toMetadata metadata  -copy%								
							%endscope%

							<!-- from EPR -->
							%scope fromAdddress%
								%rename ../../fromAddressURL value  -copy%
							%endscope%
							%scope fromMetadata%
								%ifvar ../../fromMetadataElementsList%
									%rename ../../fromMetadataElementsList elements  -copy%
								%else%	
									%rename ../../fromMetadataElements elements  -copy%
								%endif%	
							%endscope%

							%scope from%
								%rename ../fromAdddress address  -copy%
								%ifvar ../../fromReferenceParamsList%
									%rename ../../fromReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../fromReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../fromExtensibleList%
									%rename ../../fromExtensibleList extensibleElements  -copy%
								%else%
									%rename ../../fromExtensible extensibleElements  -copy%
								%endif%
								%rename ../fromMetadata metadata  -copy%								
							%endscope%
								
							<!-- replyTo EPR -->
							%scope replyToAdddress%
							%rename ../../replyToAddressURL value  -copy%
							%endscope%
							%scope replyToMetadata%
								%ifvar ../../replyToMetadataElementsList%
									%rename ../../replyToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../replyToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope replyTo%
								%rename ../replyToAdddress address  -copy%
								%ifvar ../../replyToReferenceParamsList%
									%rename ../../replyToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../replyToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../replyToExtensibleList%
									%rename ../../replyToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../replyToExtensible extensibleElements  -copy%
								%endif%
								%rename ../replyToMetadata metadata  -copy%
							%endscope%
							
							<!-- faultTo EPR -->
							%scope faultToAdddress%
								%rename ../../faultToAddressURL value  -copy%
							%endscope%
							%scope faultToMetadata%
								%ifvar ../../faultToMetadataElementsList%
									%rename ../../faultToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../faultToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope faultTo%
								%rename ../faultToAdddress address  -copy%
								%ifvar ../../faultToReferenceParamsList%
									%rename ../../faultToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../faultToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../faultToExtensibleList%
									%rename ../../faultToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../faultToExtensible extensibleElements  -copy%
								%endif%
								%rename ../faultToMetadata metadata  -copy%
							%endscope%

							<!-- WS Message Addressing Info -->
							%scope messageAddressingProperties%
								%rename ../../mustUnderstand mustUnderstand -copy%
								%rename ../../soapRole soapRole -copy%
								%rename ../to to  -copy%
								%rename ../from from  -copy%
								%rename ../replyTo replyTo  -copy%
								%rename ../faultTo faultTo  -copy%
							%endscope%

							%scope transportInfo%
								%rename ../../transportType transportType -copy%
								%rename ../../jmsAliasType jmsAliasType -copy%
								%rename ../../jmsConnAlias jmsConnAlias -copy%
								%rename ../../destinationNameJMS destinationName -copy%
								%ifvar ../../destinationTypeJMS -notempty%
									%rename ../../destinationTypeJMS destinationType -copy%
								%else%
									%rename ../../dummyEmptyValue destinationType -copy%
								%endif%
								%rename ../../replyToDestNameJMS replyToDestName -copy%
								%ifvar ../../replyToDestTypeJMS -notempty%
									%rename ../../replyToDestTypeJMS replyToDestType -copy%
								%else%
									%rename ../../dummyEmptyValue replyToDestType -copy%
								%endif%
							%endscope%
							%scope messageInfo%
								%rename ../../messageUser user -copy%
								%rename ../../messagePassword password -copy%
								%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
								%rename ../../messagePrivateKeyAlias keyAlias -copy%
								%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
								%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
  							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
  							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
  							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
							%endscope%
							%invoke wm.server.ws:massageEPRValuesInPipeline%
							%invoke wm.server.ws:addConsumerEndpoint%
								%ifvar message%
									<tr><td colspan="2">&nbsp;</td></tr>
									<TR><TD class="message" colspan="2">%value message%</TD></TR>
								%endif%
							%onerror%
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
							%endinvoke%
							%endinvoke%
						%endscope%
					%endif%
			%endswitch%
			<!-- CONSUMER END -->
		%else%
		    %ifvar type equals('addressing')%
			<!-- WS ADDRESSING START -->
				%switch transportType%
				%case 'HTTP'%
					<!-- Addressing HTTP -->
					%scope rparam(transportInfo={transportType='HTTP'}) 
						rparam(messageInfo={user=''})
						rparam(messageAddressingProperties={mustUnderstand=''})
						rparam(fromAdddress={attributes='';})
						rparam(fromMetadata={attributes='';})
						rparam(replyToAdddress={attributes='';})
						rparam(replyToMetadata={attributes='';})
						rparam(faultToAdddress={attributes='';})
						rparam(faultToMetadata={attributes='';})
						rparam(from={attributes='';})
						rparam(replyTo={attributes='';})
						rparam(faultTo={attributes='';})%
							
						<!-- from EPR -->
						%scope fromAdddress%
							%rename ../../fromAddressURL value  -copy%
						%endscope%
						%scope fromMetadata%
							%ifvar ../../fromMetadataElementsList%
								%rename ../../fromMetadataElementsList elements  -copy%
							%else%	
								%rename ../../fromMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope from%
							%rename ../fromAdddress address  -copy%
							%ifvar ../../fromReferenceParamsList%
								%rename ../../fromReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../fromReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../fromExtensibleList%
								%rename ../../fromExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../fromExtensible extensibleElements  -copy%
							%endif%
							%rename ../fromMetadata metadata  -copy%								
						%endscope%
							
						<!-- replyTo EPR -->
						%scope replyToAdddress%
						%rename ../../replyToAddressURL value  -copy%
						%endscope%
						%scope replyToMetadata%
							%ifvar ../../replyToMetadataElementsList%
								%rename ../../replyToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../replyToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope replyTo%
							%rename ../replyToAdddress address  -copy%
							%ifvar ../../replyToReferenceParamsList%
								%rename ../../replyToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../replyToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../replyToExtensibleList%
								%rename ../../replyToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../replyToExtensible extensibleElements  -copy%
							%endif%
							%rename ../replyToMetadata metadata  -copy%
						%endscope%
						
						<!-- faultTo EPR -->
						%scope faultToAdddress%
							%rename ../../faultToAddressURL value  -copy%
						%endscope%
						%scope faultToMetadata%
							%ifvar ../../faultToMetadataElementsList%
								%rename ../../faultToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../faultToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope faultTo%
							%rename ../faultToAdddress address  -copy%
							%ifvar ../../faultToReferenceParamsList%
								%rename ../../faultToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../faultToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../faultToExtensibleList%
								%rename ../../faultToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../faultToExtensible extensibleElements  -copy%
							%endif%
							%rename ../faultToMetadata metadata  -copy%
						%endscope%

						<!-- WS Message Addressing Info -->
						%scope messageAddressingProperties%
							%rename ../../mustUnderstand mustUnderstand -copy%
							%rename ../../soapRole soapRole -copy%
							%rename ../from from  -copy%
							%rename ../replyTo replyTo  -copy%
							%rename ../faultTo faultTo  -copy%
						%endscope%

						%scope transportInfo%
							%rename ../../transportType transportType -copy%
							%rename ../../host host -copy%
							%rename ../../port port -copy%
							%rename ../../authType authType -copy%
							%rename ../../transportUser user -copy%
							%rename ../../transportPassword password -copy%
							%rename ../../proxyAlias proxyAlias -copy%
						%endscope%
						%scope messageInfo%
							%rename ../../messageUser user -copy%
							%rename ../../messagePassword password -copy%
							%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
							%rename ../../messagePrivateKeyAlias keyAlias -copy%
							%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
							%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
						%endscope%
						%invoke wm.server.ws:massageEPRValuesInPipeline%
						%invoke wm.server.ws:addMessageAddressingEndpoint%
							%ifvar message%
								<tr><td colspan="2">&nbsp;</td></tr>
								<TR><TD class="message" colspan="2">%value message%</TD></TR>
							%endif%
						%onerror%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
						%endinvoke%
						%endinvoke%
					%endscope%
				%case 'HTTPS'%
					<!-- addressing HTTPS -->
					%scope rparam(transportInfo={transportType='HTTP'}) 
						rparam(messageInfo={user=''})
						rparam(messageAddressingProperties={mustUnderstand=''})
						rparam(fromAdddress={attributes='';})
						rparam(fromMetadata={attributes='';})
						rparam(replyToAdddress={attributes='';})
						rparam(replyToMetadata={attributes='';})
						rparam(faultToAdddress={attributes='';})
						rparam(faultToMetadata={attributes='';})
						rparam(from={attributes='';})
						rparam(replyTo={attributes='';})
						rparam(faultTo={attributes='';})%
							
						<!-- from EPR -->
						%scope fromAdddress%
							%rename ../../fromAddressURL value  -copy%
						%endscope%
						%scope fromMetadata%
							%ifvar ../../fromMetadataElementsList%
								%rename ../../fromMetadataElementsList elements  -copy%
							%else%	
								%rename ../../fromMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope from%
							%rename ../fromAdddress address  -copy%
							%ifvar ../../fromReferenceParamsList%
								%rename ../../fromReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../fromReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../fromExtensibleList%
								%rename ../../fromExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../fromExtensible extensibleElements  -copy%
							%endif%	
							%rename ../fromMetadata metadata  -copy%								
						%endscope%
							
						<!-- replyTo EPR -->
						%scope replyToAdddress%
						%rename ../../replyToAddressURL value  -copy%
						%endscope%
						%scope replyToMetadata%
							%ifvar ../../replyToMetadataElementsList%
								%rename ../../replyToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../replyToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope replyTo%
							%rename ../replyToAdddress address  -copy%
							%ifvar ../../replyToReferenceParamsList%
								%rename ../../replyToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../replyToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../replyToExtensibleList%
								%rename ../../replyToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../replyToExtensible extensibleElements  -copy%
							%endif%
							%rename ../replyToMetadata metadata  -copy%
						%endscope%
						
						<!-- faultTo EPR -->
						%scope faultToAdddress%
							%rename ../../faultToAddressURL value  -copy%
						%endscope%
						%scope faultToMetadata%
							%ifvar ../../faultToMetadataElementsList%
								%rename ../../faultToMetadataElementsList elements  -copy%
							%else%	
								%rename ../../faultToMetadataElements elements  -copy%
							%endif%
						%endscope%
						%scope faultTo%
							%rename ../faultToAdddress address  -copy%
							%ifvar ../../faultToReferenceParamsList%
								%rename ../../faultToReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../faultToReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../faultToExtensibleList%
								%rename ../../faultToExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../faultToExtensible extensibleElements  -copy%
							%endif%
							%rename ../faultToMetadata metadata  -copy%
						%endscope%

						<!-- WS Message Addressing Info -->
						%scope messageAddressingProperties%
							%rename ../../mustUnderstand mustUnderstand -copy%
							%rename ../../soapRole soapRole -copy%
							%rename ../from from  -copy%
							%rename ../replyTo replyTo  -copy%
							%rename ../faultTo faultTo  -copy%
						%endscope%

						%scope transportInfo%
							%rename ../../transportType transportType -copy%
							%rename ../../host host -copy%
							%rename ../../port port -copy%
							%rename ../../authType authType -copy%
							%rename ../../transportUser user -copy%
							%rename ../../transportPassword password -copy%
							%rename ../../transportKeyStoreAlias keyStoreAlias -copy%
							%rename ../../transportPrivateKeyAlias keyAlias -copy%
							%rename ../../proxyAlias proxyAlias -copy%
						%endscope%
						%scope messageInfo%
							%rename ../../messageUser user -copy%
							%rename ../../messagePassword password -copy%
							%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
							%rename ../../messagePrivateKeyAlias keyAlias -copy%
							%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
							%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
						%endscope%
						%invoke wm.server.ws:massageEPRValuesInPipeline%
						%invoke wm.server.ws:addMessageAddressingEndpoint%
							%ifvar message%
								<tr><td colspan="2">&nbsp;</td></tr>
								<TR><TD class="message" colspan="2">%value message%</TD></TR>
							%endif%
						%onerror%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
						%endinvoke%
						%endinvoke%
					%endscope%
				%case 'JMS'%
					%ifvar jmsAliasType equals('JNDI')%
						<!-- addressing JMS - JNDI Provider Alias -->
						%scope rparam(transportInfo={transportType='JMS'}) 
							rparam(messageInfo={user=''})
							rparam(messageAddressingProperties={mustUnderstand=''})
							rparam(fromAdddress={attributes='';})
							rparam(fromMetadata={attributes='';})
							rparam(replyToAdddress={attributes='';})
							rparam(replyToMetadata={attributes='';})
							rparam(faultToAdddress={attributes='';})
							rparam(faultToMetadata={attributes='';})
							rparam(from={attributes='';})
							rparam(replyTo={attributes='';})
							rparam(faultTo={attributes='';})%
								
							<!-- from EPR -->
							%scope fromAdddress%
								%rename ../../fromAddressURL value  -copy%
							%endscope%
							%scope fromMetadata%
								%ifvar ../../fromMetadataElementsList%
									%rename ../../fromMetadataElementsList elements  -copy%
								%else%	
									%rename ../../fromMetadataElements elements  -copy%
								%endif%	
							%endscope%

							%scope from%
								%rename ../fromAdddress address  -copy%
								%ifvar ../../fromReferenceParamsList%
									%rename ../../fromReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../fromReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../fromExtensibleList%
									%rename ../../fromExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../fromExtensible extensibleElements  -copy%
								%endif%	
								%rename ../fromMetadata metadata  -copy%								
							%endscope%
								
							<!-- replyTo EPR -->
							%scope replyToAdddress%
							%rename ../../replyToAddressURL value  -copy%
							%endscope%
							%scope replyToMetadata%
								%ifvar ../../replyToMetadataElementsList%
									%rename ../../replyToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../replyToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope replyTo%
								%rename ../replyToAdddress address  -copy%
								%ifvar ../../replyToReferenceParamsList%
									%rename ../../replyToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../replyToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../replyToExtensibleList%
									%rename ../../replyToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../replyToExtensible extensibleElements  -copy%
								%endif%
								%rename ../replyToMetadata metadata  -copy%
							%endscope%
							
							<!-- faultTo EPR -->
							%scope faultToAdddress%
								%rename ../../faultToAddressURL value  -copy%
							%endscope%
							%scope faultToMetadata%
								%ifvar ../../faultToMetadataElementsList%
									%rename ../../faultToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../faultToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope faultTo%
								%rename ../faultToAdddress address  -copy%
								%ifvar ../../faultToReferenceParamsList%
									%rename ../../faultToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../faultToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../faultToExtensibleList%
									%rename ../../faultToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../faultToExtensible extensibleElements  -copy%
								%endif%
								%rename ../faultToMetadata metadata  -copy%
							%endscope%

							<!-- WS Message Addressing Info -->
							%scope messageAddressingProperties%
								%rename ../../mustUnderstand mustUnderstand -copy%
								%rename ../../soapRole soapRole -copy%
								%rename ../from from  -copy%
								%rename ../replyTo replyTo  -copy%
								%rename ../faultTo faultTo  -copy%
							%endscope%

							%scope transportInfo%
								%rename ../../transportType transportType -copy%
								%rename ../../jmsAliasType jmsAliasType -copy%
								%rename ../../jndiProvAlias jndiProvAlias -copy%
								%rename ../../connFactoryName connFactoryName -copy%
								%rename ../../destinationNameJNDI destinationName -copy%
								%ifvar ../../destinationTypeJNDI -notempty%
									%rename ../../destinationTypeJNDI destinationType -copy%
								%else%
									%rename ../../dummyEmptyValue destinationType -copy%
								%endif%
								%rename ../../replyToDestNameJNDI replyToDestName -copy%
								%ifvar ../../replyToDestTypeJNDI -notempty%
									%rename ../../replyToDestTypeJNDI replyToDestType -copy%
								%else%
									%rename ../../dummyEmptyValue replyToDestType -copy%
								%endif%
							%endscope%
							%scope messageInfo%
								%rename ../../messageUser user -copy%
								%rename ../../messagePassword password -copy%
								%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
								%rename ../../messagePrivateKeyAlias keyAlias -copy%
								%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
								%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
  							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
  							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
  							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
							%endscope%
							%invoke wm.server.ws:massageEPRValuesInPipeline%
							%invoke wm.server.ws:addMessageAddressingEndpoint%
								%ifvar message%
									<tr><td colspan="2">&nbsp;</td></tr>
									<TR><TD class="message" colspan="2">%value message%</TD></TR>
								%endif%
							%onerror%
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
							%endinvoke%
							%endinvoke%
						%endscope%
					%else%
						<!-- Addressing JMS - JMS Connection Alias -->
						%scope rparam(transportInfo={transportType='JMS'}) 
							rparam(messageInfo={user=''})
							rparam(messageAddressingProperties={mustUnderstand=''})
							rparam(fromAdddress={attributes='';})
							rparam(fromMetadata={attributes='';})
							rparam(replyToAdddress={attributes='';})
							rparam(replyToMetadata={attributes='';})
							rparam(faultToAdddress={attributes='';})
							rparam(faultToMetadata={attributes='';})
							rparam(from={attributes='';})
							rparam(replyTo={attributes='';})
							rparam(faultTo={attributes='';})%
								
							<!-- from EPR -->
							%scope fromAdddress%
								%rename ../../fromAddressURL value  -copy%
							%endscope%
							%scope fromMetadata%
								%ifvar ../../fromMetadataElementsList%
									%rename ../../fromMetadataElementsList elements  -copy%
								%else%	
									%rename ../../fromMetadataElements elements  -copy%
								%endif%	
							%endscope%

							%scope from%
								%rename ../fromAdddress address  -copy%
								%ifvar ../../fromReferenceParamsList%
									%rename ../../fromReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../fromReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../fromExtensibleList%
									%rename ../../fromExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../fromExtensible extensibleElements  -copy%
								%endif%
								%rename ../fromMetadata metadata  -copy%								
							%endscope%
								
							<!-- replyTo EPR -->
							%scope replyToAdddress%
							%rename ../../replyToAddressURL value  -copy%
							%endscope%
							%scope replyToMetadata%
								%ifvar ../../replyToMetadataElementsList%
									%rename ../../replyToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../replyToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope replyTo%
								%rename ../replyToAdddress address  -copy%
								%ifvar ../../replyToReferenceParamsList%
									%rename ../../replyToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../replyToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../replyToExtensibleList%
									%rename ../../replyToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../replyToExtensible extensibleElements  -copy%
								%endif%
								%rename ../replyToMetadata metadata  -copy%
							%endscope%
							
							<!-- faultTo EPR -->
							%scope faultToAdddress%
								%rename ../../faultToAddressURL value  -copy%
							%endscope%
							%scope faultToMetadata%
								%ifvar ../../faultToMetadataElementsList%
									%rename ../../faultToMetadataElementsList elements  -copy%
								%else%	
									%rename ../../faultToMetadataElements elements  -copy%
								%endif%
							%endscope%
							%scope faultTo%
								%rename ../faultToAdddress address  -copy%
								%ifvar ../../faultToReferenceParamsList%
									%rename ../../faultToReferenceParamsList referenceParameters  -copy%
								%else%	
									%rename ../../faultToReferenceParams referenceParameters  -copy%
								%endif%
								%ifvar ../../faultToExtensibleList%
									%rename ../../faultToExtensibleList extensibleElements  -copy%
								%else%	
									%rename ../../faultToExtensible extensibleElements  -copy%
								%endif%
								%rename ../faultToMetadata metadata  -copy%
							%endscope%

							<!-- WS Message Addressing Info -->
							%scope messageAddressingProperties%
								%rename ../../mustUnderstand mustUnderstand -copy%
								%rename ../../soapRole soapRole -copy%
								%rename ../from from  -copy%
								%rename ../replyTo replyTo  -copy%
								%rename ../faultTo faultTo  -copy%
							%endscope%

							%scope transportInfo%
								%rename ../../transportType transportType -copy%
								%rename ../../jmsAliasType jmsAliasType -copy%
								%rename ../../jmsConnAlias jmsConnAlias -copy%
								%rename ../../destinationNameJMS destinationName -copy%
								%ifvar ../../destinationTypeJMS -notempty%
									%rename ../../destinationTypeJMS destinationType -copy%
								%else%
									%rename ../../dummyEmptyValue destinationType -copy%
								%endif%
								%rename ../../replyToDestNameJMS replyToDestName -copy%
								%ifvar ../../replyToDestTypeJMS -notempty%
									%rename ../../replyToDestTypeJMS replyToDestType -copy%
								%else%
									%rename ../../dummyEmptyValue replyToDestType -copy%
								%endif%
							%endscope%
							%scope messageInfo%
								%rename ../../messageUser user -copy%
								%rename ../../messagePassword password -copy%
								%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
								%rename ../../messagePrivateKeyAlias keyAlias -copy%
								%rename ../../messagePartnerPublicKeyFileName partnerPublicKeyFileName -copy%
								%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
  							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
  							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
  							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
							%endscope%
							%invoke wm.server.ws:massageEPRValuesInPipeline%
							%invoke wm.server.ws:addMessageAddressingEndpoint%
								%ifvar message%
									<tr><td colspan="2">&nbsp;</td></tr>
									<TR><TD class="message" colspan="2">%value message%</TD></TR>
								%endif%
							%onerror%
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
							%endinvoke%
							%endinvoke%
						%endscope%
					%endif%
				%endswitch%
				<!-- WS ADDRESSING END -->
			%else%
				<!-- PROVIDER START -->
				%switch transportType%
				%case 'HTTP'%
					<!-- Provider HTTP -->
					%scope rparam(transportInfo={transportType='HTTP'}) 
					    rparam(messageInfo={keyStoreAlias=''})
						rparam(messageAddressingProperties={dummy=''})
						rparam(reliableMessagingProperties={enable=''})
						rparam(toMetadata={attributes='';})
						rparam(responseMapHelper={address='';})
						rparam(to={attributes='';})%
						
						<!-- to EPR -->
						%scope toMetadata%
							%ifvar ../../toMetadataElementsList%
								%rename ../../toMetadataElementsList elements  -copy%
							%else%	
								%rename ../../toMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope to%
							%ifvar ../../toReferenceParamsList%
								%rename ../../toReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../toReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../toExtensibleList%
								%rename ../../toExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../toExtensible extensibleElements  -copy%
							%endif%	
							%rename ../toMetadata metadata  -copy%								
						%endscope%
						
						%scope responseMapHelper%
							%ifvar ../../responseMapAddressList%
								%rename ../../responseMapAddressList address  -copy%
							%else%	
								%rename ../../responseMapAddress address  -copy%
							%endif%
							%ifvar ../../responseMapMsgAliasList%
								%rename ../../responseMapMsgAliasList messageAddressingEndpointAlias  -copy%
							%else%	
								%rename ../../responseMapMsgAlias messageAddressingEndpointAlias  -copy%
							%endif%
						%endscope%

						<!-- WS Message Addressing Info -->
						%scope messageAddressingProperties%
								%rename ../to to  -copy%
								%rename ../responseToMap responseToMap -copy%
						%endscope%

						<!-- WS RM Info -->
						%scope reliableMessagingProperties%
							%rename ../enable enable -copy%
							%rename ../retransmissionInterval retransmissionInterval -copy%
							%rename ../acknowledgementInterval acknowledgementInterval -copy%
							%rename ../exponentialBackoff exponentialBackoff  -copy%
							%rename ../maximumRetransmissionCount maximumRetransmissionCount  -copy%
						%endscope%

						%scope transportInfo%
							%rename ../../transportType transportType -copy%
							%rename ../../host host -copy%
							%rename ../../port port -copy%
						%endscope%
						%scope messageInfo%
							%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
							%rename ../../messagePrivateKeyAlias keyAlias -copy%
							%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
						%endscope%
						%invoke wm.server.ws:massageEPRValuesInPipeline%
						%invoke wm.server.ws:addProviderEndpoint%
							%ifvar message%
								<tr><td colspan="2">&nbsp;</td></tr>
								<TR><TD class="message" colspan="2">%value message%</TD></TR>
							%endif%
						%onerror%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
						%endinvoke%
						%endinvoke%
					%endscope%
				%case 'HTTPS'%
					<!-- Provider HTTPS -->
					%scope rparam(transportInfo={transportType='HTTPS'}) 
						rparam(messageInfo={keyStoreAlias=''})
						rparam(messageAddressingProperties={dummy=''})
						rparam(reliableMessagingProperties={enable=''})
						rparam(toMetadata={attributes='';})
						rparam(responseMapHelper={address='';})
						rparam(to={attributes='';})%
						
						<!-- to EPR -->
						%scope toMetadata%
							%ifvar ../../toMetadataElementsList%
								%rename ../../toMetadataElementsList elements  -copy%
							%else%	
								%rename ../../toMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope to%
							%ifvar ../../toReferenceParamsList%
								%rename ../../toReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../toReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../toExtensibleList%
								%rename ../../toExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../toExtensible extensibleElements  -copy%
							%endif%
							%rename ../toMetadata metadata  -copy%								
						%endscope%
						
						%scope responseMapHelper%
							%ifvar ../../responseMapAddressList%
								%rename ../../responseMapAddressList address  -copy%
							%else%	
								%rename ../../responseMapAddress address  -copy%
							%endif%
							%ifvar ../../responseMapMsgAliasList%
								%rename ../../responseMapMsgAliasList messageAddressingEndpointAlias  -copy%
							%else%	
								%rename ../../responseMapMsgAlias messageAddressingEndpointAlias  -copy%
							%endif%
						%endscope%
						
						<!-- WS Message Addressing Info -->
						%scope messageAddressingProperties%
							%rename ../to to  -copy%
							%rename ../responseMapHelper/responseToMap responseToMap -copy%
						%endscope%

						<!-- WS RM Info -->
						%scope reliableMessagingProperties%
							%rename ../enable isRMEnabled -copy%
							%rename ../retransmissionInterval retransmissionInterval -copy%
							%rename ../acknowledgementInterval acknowledgementInterval -copy%
							%rename ../exponentialBackoff exponentialBackoff  -copy%
							%rename ../maximumRetransmissionCount maximumRetransmissionCount  -copy%
						%endscope%

						%scope transportInfo%
							%rename ../../transportType transportType -copy%
							%rename ../../host host -copy%
							%rename ../../port port -copy%
						%endscope%
						%scope messageInfo%
							%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
							%rename ../../messagePrivateKeyAlias keyAlias -copy%
							%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
						%endscope%
						%invoke wm.server.ws:massageEPRValuesInPipeline%
						%invoke wm.server.ws:addProviderEndpoint%
							%ifvar message%
								<tr><td colspan="2">&nbsp;</td></tr>
								<TR><TD class="message" colspan="2">%value message%</TD></TR>
							%endif%
						%onerror%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
						%endinvoke%
						%endinvoke%
					%endscope%
				%case 'JMS'%
					<!-- Provider JMS -->
					%scope rparam(transportInfo={transportType='JMS'}) 
						rparam(messageInfo={keyStoreAlias=''})
						rparam(messageAddressingProperties={dummy=''})
						rparam(toMetadata={attributes='';})
						rparam(responseMapHelper={address='';})
						rparam(to={attributes='';})%
						
						<!-- to EPR -->
						%scope toMetadata%
							%ifvar ../../toMetadataElementsList%
								%rename ../../toMetadataElementsList elements  -copy%
							%else%	
								%rename ../../toMetadataElements elements  -copy%
							%endif%	
						%endscope%

						%scope to%
							%ifvar ../../toReferenceParamsList%
								%rename ../../toReferenceParamsList referenceParameters  -copy%
							%else%	
								%rename ../../toReferenceParams referenceParameters  -copy%
							%endif%
							%ifvar ../../toExtensibleList%
								%rename ../../toExtensibleList extensibleElements  -copy%
							%else%	
								%rename ../../toExtensible extensibleElements  -copy%
							%endif%
							%rename ../toMetadata metadata  -copy%								
						%endscope%
						
						%scope responseMapHelper%
							%ifvar ../../responseMapAddressList%
								%rename ../../responseMapAddressList address  -copy%
							%else%	
								%rename ../../responseMapAddress address  -copy%
							%endif%
							%ifvar ../../responseMapMsgAliasList%
								%rename ../../responseMapMsgAliasList messageAddressingEndpointAlias  -copy%
							%else%	
								%rename ../../responseMapMsgAlias messageAddressingEndpointAlias  -copy%
							%endif%
						%endscope%

						<!-- WS Message Addressing Info -->
						%scope messageAddressingProperties%
							%rename ../to to  -copy%
							%rename ../responseMapHelper/responseToMap responseToMap -copy%
						%endscope%

						%scope transportInfo%
							%rename ../../transportType transportType -copy%
							%rename ../../jmsTriggerName jmsTriggerName -copy%
							%rename ../../mepType mepType -copy%
							%ifvar ../../replyToDestName -notempty%
								%rename ../../replyToDestName replyToDestName -copy%
							%else%
								%rename ../../dummyEmptyValue replyToDestName -copy%
							%endif%
							%ifvar ../../replyToDestType -notempty%
							  %rename ../../replyToDestType replyToDestType -copy%
						  %else%
							  %rename ../../dummyEmptyValue replyToDestType -copy%
							%endif%
							%rename ../../deliveryMode deliveryMode -copy%
							%rename ../../timeToLive timeToLive -copy%
							%rename ../../priority priority -copy%
							%ifvar ../../includeConnFactoryName -notempty%
								%rename ../../includeConnFactoryName includeConnFactoryName -copy%
							%else%
								%rename ../../dummyEmptyValue includeConnFactoryName -copy%
							%endif%
							%ifvar ../../includeJNDIParams -notempty%
								%rename ../../includeJNDIParams includeJNDIParams -copy%
							%else%
								%rename ../../dummyEmptyValue includeJNDIParams -copy%
							%endif%
						%endscope%
						%scope messageInfo%
							%rename ../../messageKeyStoreAlias keyStoreAlias -copy%
							%rename ../../messagePrivateKeyAlias keyAlias -copy%
							%rename ../../messageTrustStoreAlias trustStoreAlias -copy%
							%rename ../../messageTimestampPrecisionInMillis timestampPrecisionInMillis -copy%
							%rename ../../messageTimestampTimeToLive timestampTimeToLive -copy%
							%rename ../../messageTimestampMaximumSkew timestampMaximumSkew -copy%
						%endscope%
						%invoke wm.server.ws:massageEPRValuesInPipeline%
						%invoke wm.server.ws:addProviderEndpoint%
							%ifvar message%
								<tr><td colspan="2">&nbsp;</td></tr>
								<TR><TD class="message" colspan="2">%value message%</TD></TR>
							%endif%
						%onerror%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
						%endinvoke%
						%endinvoke%
					%endscope%
			%endswitch%
			%endif%
		%endif%
	%endswitch%
	<!-- PROVIDER END -->
%endif%
<!-- ****************Add/Edit****************end -->

<TR>
    <TD colspan="2">
        <UL>
			<LI><A HREF="settings-rm.dsp">Reliable Messaging</A></LI>
			<LI><A HREF="settings-wsendpoints-addedit.dsp?action=create">Create Web Service Endpoint Alias</A></LI>
        </UL>
    </TD>
</TR>

<!-- Web Service Provider Endpoints List -->
<TR>
    <TD width='0%'><IMG SRC="images/blank.gif" height=10 width=10></TD>
    <TD width='100%'>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=10>Web Service Provider Endpoints List</TD>
    </TR>
	<TR>
	   <TD class="oddcol-l" width="20%">Alias</TD>
	   <TD class="oddcol-l" width="50%">Description</TD>
	   <TD class="oddcol" width="10%">Delete</TD>
	</TR>

		%scope param(transportType='HTTP')%
			%include wsendpoints-listProviders.dsp%
		%endscope%

		%scope param(transportType='HTTPS')%
			%include wsendpoints-listProviders.dsp%
		%endscope%

		%scope param(transportType='JMS')%
			%include wsendpoints-listProviders.dsp%
		%endscope%
</TABLE>
</TD>
</TR>

<TR><TD><IMG SRC="images/blank.gif" height=10 width=10></TD></TR>

<!-- Web Service Consumer Endpoints List -->
<TR>
    <TD width='0%'><IMG SRC="images/blank.gif" height=10 width=10></TD>
    <TD width='100%'>
		<TABLE class="tableView" width=100%>
			<TR>
				<TD class="heading" colspan=10>Web Service Consumer Endpoints List</TD>
			</TR>

			<TR>
			   <TD class="oddcol-l" width="20%">Alias</TD>
			   <TD class="oddcol-l" width="50%">Description</TD>
			   <TD class="oddcol" width="10%">Delete</TD>
			</TR>
			%scope param(transportType='HTTP')%
				%include wsendpoints-listConsumers.dsp%
			%endscope%

			%scope param(transportType='HTTPS')%
				%include wsendpoints-listConsumers.dsp%
			%endscope%

			%scope param(transportType='JMS')%
				%include wsendpoints-listConsumers.dsp%
			%endscope%
		</TABLE>
	</TD>
</TR>

<TR><TD><IMG SRC="images/blank.gif" height=10 width=10></TD></TR>

<!-- Message Addressing List -->
<TR>
    <TD width='0%'><IMG SRC="images/blank.gif" height=10 width=10></TD>
    <TD width='100%'>
		<TABLE class="tableView" width=100%>
			<TR>
				<TD class="heading" colspan=10>Message Addressing Endpoint List</TD>
			</TR>

			<TR>
			   <TD class="oddcol-l" width="20%">Alias</TD>
			   <TD class="oddcol-l" width="50%">Description</TD>
			   <TD class="oddcol" width="10%">Delete</TD>
			</TR>
			%scope param(transportType='HTTP')%
				%include wsendpoints-listAddressing.dsp%
			%endscope%

			%scope param(transportType='HTTPS')%
				%include wsendpoints-listAddressing.dsp%
			%endscope%

			%scope param(transportType='JMS')%
				%include wsendpoints-listAddressing.dsp%
			%endscope%
		</TABLE>
	</TD>
</TR>

</TABLE>

<FORM name="deleteform" action="settings-wsendpoints.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="alias">
  <INPUT type="hidden" name="type">
  <INPUT type="hidden" name="transportType">
</FORM>

</BODY>
</HTML>
