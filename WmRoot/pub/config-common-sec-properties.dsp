    <tr>
		<td class="heading" colspan="2">Security Configuration</td>
   	</tr>
	<tr>
			<td class="evenrow">Client Authentication</td>
		    <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
		    	%ifvar mode equals('view')%
		        	%ifvar clientAuth equals('none')%Username/Password%endif%
					%ifvar clientAuth equals('digest')%Digest%endif%
					%ifvar ssl equals('true')%
						%ifvar clientAuth equals('request')%Request Client Certificates%endif%
						%ifvar clientAuth equals('require')%Require Client Certificates%endif%
					%endif%
		         %else%
		                  <select name="clientAuth" id="clientAuth">
		                  <option %ifvar clientAuth equals('none')%selected %endif%value="none">Username/Password</option>
						  %ifvar listenerType equals('revinvokeinternal')%
						  %else%
							  %ifvar ftps equals('true')%
							  %else%
								<option %ifvar clientAuth equals('digest')%selected %endif%value="digest">Digest</option>
							  %endif%  	
						  %endif%
						  %ifvar ssl equals('true')%
							<option %ifvar clientAuth equals('request')%selected %endif%value="request">Request Client Certificates</option>
							<option %ifvar clientAuth equals('require')%selected %endif%value="require">Require Client Certificates</option>
						  %endif%
		                  </select>
		          %endif%
		       </td>
	</tr>
	%ifvar listenerType equals('revinvoke')%
		<tr>
			<td class="oddrow">&nbsp;</td>
			<td class="oddcol-l">Must match Client Authentication setting on the Internal Server.</td>
		</tr>	
	%endif%