<TR>
                  <TD class="redheading" colspan="5">Deletion Sets</TD>
            </TR>
			<TR>
              <TD class="rowdata" colspan="5" align="left"><b>IMPORTANT: Deployer cannot detect dependencies across products. Make sure assets marked for deletion are not required by assets of other products.</b></TD>
            </TR>
		%comment%
			%ifvar bundles -notempty%
						<TR>
							<TD class="evencol-l" colspan="4"> 
								Click on a tree object to view or change its properties.
							</TD>
						</TR>
			%endif%
		%endcomment%

            <TR>
              <TD class="oddcol">Name</TD>
              %ifvar ../projectType equals('Repository')%
									<TD class="oddcol">Description</TD>
                  <TD class="oddcol">Unresolved<BR>Dependencies</TD>
							%else%
									<TD class="oddcol" colspan = "2">Description</TD>
							%endif%
              <TD class="oddcol">Delete</TD>
            </TR>
		%ifvar deleteBundles -notempty%
						<SCRIPT>resetRows();</SCRIPT>
						<SCRIPT>swapRows();</SCRIPT>		
			%loop deleteBundles%
						<SCRIPT>swapRows();</SCRIPT>		
			<TR>
						<!- The Project Tree, yeah baby! ->
							<script> writeTD("rowdata-l");</script>
							<SCRIPT>
								%ifvar bundleType equals('IS')%
									%include bundle-is-tree.dsp%
								%else%
									%include bundle-plugin-tree.dsp%
								%endif%
							</SCRIPT>
							</TD>
               %ifvar ../projectType equals('Repository')%
									<SCRIPT>writeTD("rowdata");</SCRIPT>%value bundleDescription%</TD>
				            <SCRIPT>writeTD("rowdata");</SCRIPT>
                    %ifvar hasDependentAssets equals('true')%
                    <IMG ID="img_%value bundleName -urlencode%" src="images/dependency.gif" border="no" width="14" height="14">
									   <A onclick="return startProgressBar('Checking dependencies');" target="propertyFrame" href="deletionset-refrences.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%&projectType=%value ../projectType%">Check</A>
								    %else%
									   <IMG ID="img_%value bundleName -urlencode%" src="images/green_check.gif" border="no" width="14" height="14">
									   <A onclick="return startProgressBar('Checking dependencies');" target="propertyFrame" href="deletionset-refrences.dsp?projectName=%value ../projectName%&bundleName=%value bundleName%&bundleType=%value bundleType%&projectType=%value ../projectType%">Check</A>
								    %endif% 
									  </TD>
							%else%
									<SCRIPT>writeTDspan('row-l', '2');</SCRIPT>%value bundleDescription%</TD>
							%endif%
              <SCRIPT>writeTD("rowdata");</SCRIPT> 
							%ifvar /defineAuthorized equals('true')%
								<A onclick="return confirmDeleteDeletionSet('%value bundleName%');"
                	href="bundle-list.dsp?action=delete&projectName=%value -htmlcode ../projectName%&bundleName=%value -htmlcode bundleName %&projectType=%value -htmlcode ../projectType%">
                	<IMG alt="Delete this Deletion Set" src="images/delete.gif" border="no" width="16" height="16"></A></TD>
							%else%
                	<IMG src="images/delete_disabled.gif" border="no" width="16" height="16"></TD>
							%endif%
            </TR>
			%endloop%
		%else%
						<TR>
							<TD colspan=4><FONT color="red"> * No Deletion Sets </FONT> </TD>
						</TR>
		%endif%