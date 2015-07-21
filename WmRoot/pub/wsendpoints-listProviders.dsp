%invoke wm.server.ws:listProviderEndpoints%

	<TR manualhide="true" id="Provider%value transportType%ToggleRow" onClick="toggle(this, 'Provider%value transportType%Row', 'Provider%value transportType%Img');">
	    <TD class="subHeading" style="cursor: pointer" colspan=10><img id='Provider%value transportType%Img' src="images/collapsed_brown.gif" border="0"> <a name="anchorProvider%value transportType%">%value transportType%</a></TD>
	</TR>
    
	<script>
		resetRows();
	</script>
	%loop endpoints%
		<TR name="Provider%value ../transportType%Row" style="display:none;">
		<script>writeTD("rowdata-l");</script>
			<a
			href="settings-wsendpoints-addedit.dsp?action=view&alias=%value -urlencode alias%&type=provider&transportType=%value -urlencode transportInfo/transportType%"
		>%value alias%</a>
		</TD>
		    <script>writeTD("row-l");</script>%value description%</TD>
		    <script>writeTD("rowdata");</script>
				  <a class="imagelink" href="" onClick="return confirmDelete('%value alias%','provider', '%value transportInfo/transportType%');">
				      <img src="icons/delete.gif" alt="Delete alias : %value alias%" border="none"></a>
		    </TD>

		</TR>

		<script>
		swapRows();</script>
	%endloop%
%endinvoke%
<script>checkPrevState('Provider%value transportType%ToggleRow', 'Provider%value transportType%Row', 'Provider%value transportType%Img');</script>