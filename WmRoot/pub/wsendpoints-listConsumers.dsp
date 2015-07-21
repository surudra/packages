%invoke wm.server.ws:listConsumerEndpoints%

 	<TR manualhide="true" id="Consumer%value transportType%ToggleRow" onClick="toggle(this, 'Consumer%value transportType%Row', 'Consumer%value transportType%Img');">
        <TD class="subHeading" style="cursor: pointer;" colspan=10><img id='Consumer%value transportType%Img' src="images/collapsed_brown.gif" border="0"> <a name="anchorConsumer%value transportType%">%value transportType%</a></TD>
    </TR>
	<script>
		resetRows();
	</script>
%loop endpoints%
<TR name="Consumer%value ../transportType%Row" style="display: none;">
    <script>writeTD("rowdata-l");</script>
        <a
	   href="settings-wsendpoints-addedit.dsp?action=view&alias=%value -urlencode alias%&type=consumer&transportType=%value -urlencode transportInfo/transportType%"
        >%value alias%</a>
    </TD>

    <!-- <script>writeTD("row-l");</script>%value transportInfo/transportType%</TD> -->
    <script>writeTD("row-l");</script>%value description%</TD>
    <script>writeTD("rowdata");</script>
     <a class="imagelink" href="" onClick="return confirmDelete('%value alias%','consumer', '%value transportInfo/transportType%');">
     <img src="icons/delete.gif" alt="Delete alias : %value alias%" border="none"></a>
    </TD>

</TR>

    <script>swapRows();</script>
%endloop%
%endinvoke%
<script>checkPrevState('Consumer%value transportType%ToggleRow', 'Consumer%value transportType%Row', 'Consumer%value transportType%Img');</script>
