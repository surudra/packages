<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="webMethods.js"></SCRIPT>
<LINK href="webMethods.css" type="text/css" rel="stylesheet">

<SCRIPT language=JavaScript>
function onMigrate() {
  document.forms["dummyMigrateProjects"].submit();
}
function onMigrateRebuild() {
  document.myFormMigrateProjects.reBuildProject.value = "true";
  onMigrate();
}

function disableEnableButton(){ 
   var allElements = document.getElementsByClassName('selectAll');
   var flag = false;
  var element;
	for (var i = 0; (element = allElements[i]) != null; i++) {	    
	 if(document.getElementById(element.id).checked == true) {
	       flag = true;              
           }    
       }
	if(flag == true)
	{
		document.getElementById("submit1").disabled = false;
		document.getElementById("submit2").disabled = false;
	}
	else
	{
		document.getElementById("submit1").disabled = true;
		document.getElementById("submit2").disabled = true;
	}
  }

function selectAll(id)
{
  var allElements = document.getElementsByClassName('selectAll');
  var element;
	for (var i = 0; (element = allElements[i]) != null; i++) {
	 if(document.getElementById(id).checked) {
    document.getElementById(element.id).checked = true;
    }
    else {
    document.getElementById(element.id).checked = false;    
    }
   }
   
	if(document.getElementById(id).checked)
	{  
		document.getElementById("submit1").disabled = false;
		document.getElementById("submit2").disabled = false;
	}
	else
	{
		document.getElementById("submit1").disabled = true;
		document.getElementById("submit2").disabled = true;
	}
}

document.getElementsByClassName = function(cl) 
{
  var retnode = [];
  var myclass = new RegExp('\\b'+cl+'\\b');
  var elem = this.getElementsByTagName('*');
  for (var i = 0; i < elem.length; i++) {
  var classes = elem[i].className;
  if (myclass.test(classes)) retnode.push(elem[i]);
  }
  return retnode;
}; 

</SCRIPT>
<BODY>
<FORM name="myFormMigrateProjects" method="POST" action="list-projects.dsp">
<TABLE width="100%">
	<TR>
		<TD class="menusection-DeployerTools" colspan="4"> Migrate Projects
		</TD>
	</TR>

	

</TABLE>

<TABLE width="100%">
<TR>
		
			<UL>
				<LI><p><A target="_blank" href="migrate-report.dsp">View Latest Migration Report</A></p></LI>
			</UL>
		
	             </TR>	

%ifvar actionName equals('migrate')%
	<!- buildName*  ->
	%invoke wm.deployer.gui.UIUpgrade:migrateProjects%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%

%ifvar actionName equals('testProject')%
	<!- buildName*  ->
	%invoke wm.deployer.gui.UIUpgrade:testProjectMigration%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
	%end invoke%
%end if%



</TABLE>
<!- Determine if this user is empowered to project creation/copy stuff ->
%invoke wm.deployer.UIAuthorization:isAuthorized%
%endinvoke%

<TABLE width="100%">
	<BR>

	%invoke wm.deployer.gui.UIUpgrade:listProjects%
	%include error-handler.dsp%
	<TR>		
		<TD valign="top">
		
		
		
			<INPUT type="hidden" VALUE="migrate" name="actionName">
        <TR>
    			<TD class="heading" colspan=2>Projects</TD>
    		</TR>			
		<TABLE width="100%" class="tableView"">

		%ifvar projects -notempty%
				<TR>
					<TD class="heading" width="2%"><input id="project_" type="checkbox"
				              		name="serverAliasName" value="%value serverAliasName%" onclick="selectAll(id);"></TD>
					<TD class="heading" width="30%">Project Name</TD>
					<TD class="heading" width="40%">Project Description</TD>
				  <TD class="heading" width="10%">Simulate Migration</TD>				
					<TD class="heading" width="10%">Migration Report</TD>
				</TR>

								

				<SCRIPT>resetRows();</SCRIPT>
				%loop projects%
				<TR>
				%ifvar exists equals('false')%
  				<SCRIPT>writeTD('row-l');</SCRIPT>				
  										<input id="project_%value projectName -urlencode%" type="checkbox"
  						name="projectName" value="%value projectName%" class="selectAll" onclick="disableEnableButton();"></TD>
  			%else%
  		  	<SCRIPT>writeTD('row-l');</SCRIPT>				
  										<input id="project_%value projectName -urlencode%" type="checkbox"
  						name="projectName" value="%value projectName%" disabled></TD>	
  			%endif%

			
					<SCRIPT>writeTD('row-l');</SCRIPT> %value projectName%
					</TD>
			
					<SCRIPT>writeTD('row-l');</SCRIPT> %value description%
					</TD>
					
					<SCRIPT>writeTD('row-l');</SCRIPT>
					 %ifvar exists equals('false')%
						<A class="imagelink" onclick="startProgressBar();"
							href="list-projects.dsp?projectName=%value projectName%&actionName=testProject&pageNumber1=%value -urlencode ../pStart1%">							
							<IMG alt="Test connectivity to Resource Package on this Integration Server" src="images/simulate.gif" border="0" width="14" height="14"></A>
            %else%
              <A class="imagelink"><IMG height="14" src="images/simulate_disabled.gif"/></A>
            %endif%							
					</TD>	

          %ifvar exists equals('false')%
				  <SCRIPT>writeTD('row-l');</SCRIPT>
				       %else%
					<SCRIPT>writeTD('row-l');</SCRIPT><A target="_blank" class="imagelink" href="migrate-project-report.dsp?projectName=%value -htmlcode projectName%"> <IMG alt="View this Report in a separate browser." src="images/edit.gif" border="no">
					</TD>
				  %endif%
				<SCRIPT>swapRows();</SCRIPT>
				</TR>
				%endloop projects%
        </TR>
        
         <TD colspan="6">
  					<div class="oddrowdata" id="paginationContainer1" name="paginationContainer1" style="display:;padding-top=2mm;">
                  %ifvar pStart1 equals('1')%
            			%else%
                    		<a href="list-projects.dsp?actionName=listprojects&prev1=true&currentPage1=%value -urlencode pStart1%&host=%value host%&port=%value port%&userName=%value userName%&password=%value password%">« Previous</a>              
            			%endif%
        	        %loop totalNosOfPages1%
        		        %ifvar totalNosOfPages1 -notempty%           		
        	         		<a href="list-projects.dsp?actionName=listprojects&pageNumber1=%value -urlencode totalNosOfPages1%&host=%value host%&port=%value port%&userName=%value userName%&password=%value password%">
          	         		%ifvar totalNosOfPages1 vequals(/pStart1)% 
          	         			<a><label style="color:#666666;font-weight:bold;">%value totalNosOfPages1%</label>
                		    %else%		
                	          %ifvar totalNosOfPages1 equals('...')%
                	         				</a><a href="javascript:showHidePageCriteria()">%value totalNosOfPages1%</a>
                	         			%else%
                	         				%value totalNosOfPages1%<a>
                	         	%endif%
                	      %endif%	
              	    %else%
              	        %value pStart1%
              	   	%endif%	      						
                  %endloop%		
            		%ifvar pStart1 vequals(totalPages1)%			
            				<!-- Next -->
            		%else%
            				<a href="list-projects.dsp?actionName=listprojects&prev1=false&currentPage1=%value -urlencode pStart1%&host=%value host%&port=%value port%&userName=%value userName%&password=%value password%">Next >></a>
            		%endif%		
        		</div>
      		</TD>        
				
				<TR>
				<TD colspan="6" class="action" style="color: black;">
					<TABLE>
						<TR >
							<input type="hidden" name="pageNumber1" value="%value pStart1%" />
							<input type="hidden" name="reBuildProject" value="false" />
							<TD style="text-align:left;"><INPUT type="submit" id="submit1" onclick="return onMigrate();" align="right" value="Migrate Projects" disabled></TD>
							<TD style="text-align:left;"><INPUT type="submit" id="submit2" onclick="return onMigrateRebuild();" align="right" value="Migrate and Rebuild Projects" disabled></TD>

						</TR>
					</TABLE>
				</TD>
				</TR>
			%else%
				<TR>
      		<TD colspan="6"><FONT color="red">* No projects exist on the server.</FONT></TD>
      	</TR>				
	    %endif%
			
		</TABLE>
		</FORM>

			<FORM name="dummyMigrateProjects" method="POST" action="migrate-report.dsp" target="_blank">
			</FORM>
			
		</TD>
	</TR>
	%endinvoke%		
</TABLE>

<SCRIPT>

  var allElements = document.getElementsByClassName('selectAll');
  if(allElements == null || allElements == "") 
    document.getElementById("project_").disabled = true;

</SCRIPT>

</BODY>
</HTML>
