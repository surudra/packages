<script>
 function confirmDelete(ip) {
         return confirm("Are you sure you want to delete " + ip + " ?");
    }
</script>
	<table width="100%">
		<tr>
			<td colspan="2" class="heading">
			   Denied IP Address List
			</td>
		</tr>
		<tr>
			<td class="oddcol-l" width="80%">
				IP Address
			</td>
			<td class="oddcol" >
				Delete
			</td>
		</tr>
		%invoke wm.server.enterprisegateway:getDeniedIPList%
			%loop deniedIPList%
				<tr>
					<td class="evencol-l" width="80%">
					  %value%
					</td>
					<td class="evencol" >
					  <a class="imagelink" href="enterprisegateway-dos-options.dsp?action=delete&IP=%value%" onclick="return confirmDelete('%value%')">
                                   <img src="icons/delete.gif" border="none">
                      </a>
					</td>
				</tr>
			%end%
		%endinvoke%
			</table>