<tbody id="headerMsgDiv">
<TR>
	<TD colspan="2" class="heading">WS Security Properties (Optional)</TD>
</TR>
</tbody>
<tbody id="usernameMsgDiv">
<TR>
	<TD class="oddrow">User Name</TD>
	<TD class="oddrow-l">
		%ifvar ../../action equals('view')%
			%value user%
		%else%
			<INPUT NAME="messageUser" VALUE="%value user%" style="width:40%">
		%endif% 
	</TD>
</TR>

%ifvar action ../../action equals('view')%
%else%
<TR>
	<TD class="evenrow">Password</TD>
	<TD class="evenrow-l">
		<INPUT TYPE="password" NAME="messagePassword" autocomplete="off" VALUE="%value password%" style="width:40%" />
	</TD>
</TR>

<TR>
	<TD class="oddrow">Retype Password</TD>
	<TD class="oddrow-l">
		<INPUT TYPE="password" NAME="retype_messagePassword" autocomplete="off" VALUE="%value password%" style="width:40%" />
	</TD>
</TR>
%endif%
</tbody>
<tbody id="partnerCertMsgDiv">
<TR>
	<TD class="evenrow">Partner's Certificate</TD>
	<TD class="evenrow-l">
		%ifvar ../../action equals('view')%
			%value partnerPublicKeyFileName%
		%else%
			<INPUT NAME="messagePartnerPublicKeyFileName" VALUE="%value partnerPublicKeyFileName%" style="width:100%">
		%endif% 
	</TD>
</TR>
</tbody>
<tbody id="keystoreMsgDiv">
<TR>
	<TD class="oddrow">Keystore Alias</TD>
	<TD class="oddrow-l">
		%ifvar ../../action equals('view')%
			%value keyStoreAlias%
		%else%
			<SELECT NAME="messageKeyStoreAlias" style="width:40%" class="listbox"  onchange="changeval('messageKeyStoreAlias')"></SELECT>
		%endif%
	</TD>
</TR>
<TR>
	<TD class="evenrow">Key Alias</TD>
	<TD class="evenrow-l">
		%ifvar ../../action equals('view')%
			%value keyAlias%
		%else%
			<select name="messagePrivateKeyAlias" style="width:40%" class="listbox"></select>
		%endif%
	</TD>
</TR>
</tbody>
<tbody id="truststoreMsgDiv">
<TR>
	<TD class="oddrow">Truststore Alias</TD>
	<TD class="oddrow-l">
		%ifvar ../../action equals('view')%
			%value trustStoreAlias%
		%else%
			%ifvar ../../action equals('edit')%
				<select name="messageTrustStoreAlias" class="listbox" style="width:40%">
				%invoke wm.server.security.keystore:listTrustStores%
					<option name="" value=""></option>
					%loop trustStores%
						<option name="%value keyStoreName%" value="%value keyStoreName%" %ifvar ../trustStoreAlias vequals(keyStoreName)%selected%endif%>%value keyStoreName%</option>
					%endloop%
				%endinvoke%
				</select>
			%else%
				<select name="messageTrustStoreAlias" class="listbox" style="width:40%">
				%invoke wm.server.security.keystore:listTrustStores%
					<option name="" value=""></option>
					%loop trustStores%
						%ifvar isLoaded equals('true')%
							<option name="%value keyStoreName%" value="%value keyStoreName%" %ifvar ../msgTruststore vequals(keyStoreName)%selected%endif%>%value keyStoreName%</option>
						%endif%
					%endloop%
				%endinvoke%
				</select>
			%endif%
		%endif%
	</TD>
</TR>
</tbody>
<tbody id="timestampMsgDiv">
<TR>
	<TD class="evenrow">Timestamp Precision</TD>
	<TD class="evenrow-l">
		%ifvar ../../action equals('view')%
		  %ifvar timestampPrecisionInMillis%
		    %ifvar timestampPrecisionInMillis equals('true')%milliseconds%else%seconds%endif%
      %endif%
		%else%
			<select name="messageTimestampPrecisionInMillis" class="listbox" style="width:40%">
				<option name="default" value="" %ifvar timestampPrecisionInMillis%%else%selected%endif%></option>
				<option name="milliseconds" value="true" %ifvar timestampPrecisionInMillis equals('true')%selected%endif%>milliseconds</option>
				<option name="seconds" value="false" %ifvar timestampPrecisionInMillis equals('false')%selected%endif%>seconds</option>
			</select>
		%endif% 
	</TD>
</TR>

<TR>
	<TD class="oddrow">Timestamp Time to Live (seconds)</TD>
	<TD class="oddrow-l">
		%ifvar ../../action equals('view')%
			%value timestampTimeToLive%
		%else%
			<INPUT NAME="messageTimestampTimeToLive" VALUE="%value timestampTimeToLive%" style="width:40%">
		%endif% 
	</TD>
</TR>

<TR>
	<TD class="evenrow">Timestamp Maximum Skew (seconds)</TD>
	<TD class="evenrow-l">
		%ifvar ../../action equals('view')%
			%value timestampMaximumSkew%
		%else%
			<INPUT NAME="messageTimestampMaximumSkew" VALUE="%value timestampMaximumSkew%" style="width:40%">
		%endif% 
	</TD>
</TR>
</tbody>
