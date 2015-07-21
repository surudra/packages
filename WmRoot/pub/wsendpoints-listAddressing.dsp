%invoke wm.server.ws:listMessageAddressingEndpoints%

 	<TR manualhide="true" id="Addressing%value transportType%ToggleRow" onClick="toggle(this, 'Addressing%value transportType%Row', 'Addressing%value transportType%Img');">
        <TD class="subHeading" style="cursor: pointer;" colspan=10><img id='Addressing%value transportType%Img' src="images/collapsed_brown.gif" border="0"> <a name="anchorAddressing%value transportType%">%value transportType%</a></TD>
    </TR>
	<script>
		resetRows();
	</script>
%loop endpoints%
<TR name="Addressing%value ../transportType%Row" style="display: none;">
    <script>writeTD("rowdata-l");</script>
        <a
	   href="settings-wsendpoints-addedit.dsp?action=view&alias=%value -urlencode alias%&type=addressing&transportType=%value -urlencode transportInfo/transportType%"
        >%value alias%</a>
    </TD>

    <!-- <script>writeTD("row-l");</script>%value transportInfo/transportType%</TD> -->
    <script>writeTD("row-l");</script>%value description%</TD>
    <script>writeTD("rowdata");</script>
     <a class="imagelink" href="" onClick="return confirmDelete('%value alias%','addressing', '%value transportInfo/transportType%');">
     <img src="icons/delete.gif" alt="Delete alias : %value alias%" border="none"></a>
    </TD>

</TR>

    <script>swapRows();</script>
%endloop%
%endinvoke%
<script>checkPrevState('Addressing%value transportType%ToggleRow', 'Addressing%value transportType%Row', 'Addressing%value transportType%Img');</script>
