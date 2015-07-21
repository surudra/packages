 <tr style="display: none;">
  <td  class="heading" colspan="2">Security Configuration</td>
  </tr>
  <tr style="display: none;">
      <td class="evenrow">Client Authentication</td>
      <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	%ifvar mode equals('view')%
	  %switch clientAuth%
	    %case 'none'%Username/Password
	    %case 'request'%Request Client Certificates
	    %case 'require'%Require Client Certificates
	    %case%Username/Password
	  %endswitch%
	%lse%
	  <select name="clientAuth">
	  <option %ifvar clientAuth equals('none')%selected %endif%value="none">Username/Password</option>
	  <option %ifvar clientAuth equals('request')%selected %endif%value="request">Request Client Certificates</option>
	  <option %ifvar clientAuth equals('require')%selected %endif%value="require">Require Client Certificates</option>
	  </select>
	%endif%
      </td>
  </tr>
  <tr style="display: none;">
      <td class="heading" colspan="2">Listener Specific Credentials (Optional)</td>
  </tr>
  <tr style="display: none;">
      <td class="oddrow">Server's Certificate</td>
      <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
	<script>writeEdit("%value encode(javascript) mode%", 'signedCert', "%value -code certChain[0]%");</script>
      </td>
  </tr>
  <tr style="display: none;">
      <td class="evenrow">Authority's Certificate</td>
      <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	<script>writeEdit("%value encode(javascript) mode%", 'caCert', "%value -code certChain[1]%");</script>
      </td>
  </tr>
  <tr style="display: none;">
      <td class="oddrow">Private Key</td>
      <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
	<script>writeEdit("%value encode(javascript) mode%", 'privKey', "%value -code privKey%");</script>
      </td>
  </tr>
  <td class="evenrow">Trusted Authority Directory</td>
      <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	<script>writeEdit("%value encode(javascript) mode%", 'caDir', "%value -code caDir%");</script>
      </td>
  </tr>
%comment% --- Trax 1-1-YN64D Add support for Keystores (HSM and file based) --- %endcomment%
           <tr>				                       	
              <td class="heading" colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---&nbsp;Or&nbsp;---</td>
          </tr>
          <tr>
              <td class="evenrow">KeyStore Location</td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                <script>writeEdit("%value encode(javascript) mode%", 'keyStoreLocation', "%value -code keyStoreLocation%");</script>
              </td>
          </tr>
		  %ifvar ../mode equals('edit')%
          <tr>
              <td class="evenrow">KeyStore Password</td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                <script>writeEditPass("%value encode(javascript) mode%", 'password', "%value -code password%");</script>
              </td>
          </tr>
		  %endif%
	  <tr>
              <td class="evenrow">KeyStore Type</td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
%comment%                <script>writeEdit("%value encode(javascript) mode%", 'keyStoreType', "%value -code keyStoreType%");</script> %endcomment%
                %ifvar ../mode equals('view')%
                  %value keyStoreType%%ifvar keyStoreProvider%(%value keyStoreProvider%)%endif%
                %else%
                  %invoke wm.server.net.listeners:listKeyStoreTypes%
                  <select name="keyStoreType">
                  %loop keyStoreTypes%
                      <option %ifvar ../keyStoreType vequals(keyStoreType)% selected %endif% value="%value keyStoreType%">%value keyStoreTypeName%</option>
                  %endloop%
                  </select>
                  %endinvoke%
                %endif%
              </td>
          </tr>
		  <tr>
              <td class="oddrow">HSM Based Keystore</td>
			  <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			  %ifvar ../mode equals('view')%
                %value -code useHSM%
			  %else%
				  %ifvar useHSM equals('true')%
						<INPUT TYPE="radio" NAME="useHSM" VALUE="true" checked>True</INPUT>
        	            <INPUT TYPE="radio" NAME="useHSM" VALUE="false">False</INPUT>
            	  %else%
			  			<INPUT TYPE="radio" NAME="useHSM" VALUE="true" >True</INPUT>
                    	<INPUT TYPE="radio" NAME="useHSM" VALUE="false" checked>False</INPUT>
			  	%endif%
			  %endif%
              </td>
          </tr>
          <tr>
              <td class="oddrow">Alias</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                <script>writeEdit("%value encode(javascript) mode%", 'alias', "%value -code alias%");</script>
              </td>
          </tr>
	%ifvar listenerKey equals('')%
			  <tr>
	              <td class="evenrow">Trusted Authority Directory</td>
	              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	                <script>writeEdit("%value encode(javascript) mode%", 'keyStoreCADir', "%value -code keyStoreCADir%");</script>
	              </td>
	          </tr>
	%else%
			  <tr>
	              <td class="evenrow">Trusted Authority Directory</td>
	              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	                <script>writeEdit("%value encode(javascript) mode%", 'keyStoreCADir', "%value -code keyStoreCADir%");</script>
	              </td>
	          </tr>
        %endif%
%comment% --- Trax 1-1-YN64D Add support for Keystores (HSM and file based) --- %endcomment%
