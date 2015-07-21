<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <style>
          .cellBound{
                border:solid black 1px;
          }      
  </style>
  <script>
    function confirmDelete(ruleName) {
         return confirm("Are you sure you want to delete the rule " + ruleName + " ?");
    }
    function confirmEnableDisable(ruleName,operation)
    {
        return confirm("Are you sure you want to " + operation + " the rule " + ruleName + " ?");
    }
	  function disableLink(link)
	  {
         link.disabled=true;
         link.style.color='gray';
         link.style.cursor='default';
         link.onclick=function (){return false;}
    }
	function disableAllLinks()
	{
		var links=document.getElementsByTagName("a");
		for(i=0;i<links.length;i++)
		{
			disableLink(links[i]);
		}
	}
  function disableDirectionImage(link,direction){
         disableLink(link)
         if('UP' == direction){
            link.src='icons/moveup_disabled.png';
         }
         else{
            link.src='icons/movedown_disabled.png';
         }
  }
 </script>  
 </head>

<body onLoad="setNavigation('security-enterprisegateway-alert-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_DefaultAlertOptionsScrn');">
	<table width="100%">
		<tr>
			<td class="menusection-Security" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Default Alert Options</td>
		</tr>

			%ifvar operation equals('editAlertOptions')%
						
				%invoke wm.server.enterprisegateway:saveAlertOptions%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message%</td></tr>
					%endif%
					%onerror%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage%</td></tr>
				%endinvoke%
			%endif%

			<tr>
				<td colspan="2">
					<ul>
							<li><a href="security-enterprisegateway-rules.dsp">Return&nbsp;to&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules</a></li>
							<li><a href="security-enterprisegateway-alert-options.dsp?global=true">Edit&nbsp;Default&nbsp;Alert&nbsp;Options</a></li>
							
					</ul>
				</td>
			</tr>
			
			
			<tr>
			<td>
			  &nbsp;
			</td>
			<td width="98%">   
			%scope param(rule='')%
			%invoke wm.server.enterprisegateway:getEnterpriseGatewayAlertOptions%
			<table width="50%">
					<tr>
						   <td colspan="2" class="heading">
								Default Alert Options
						   </td>
					</tr>
				 <tr>
				 <td  width="10%" class="oddrow" nowrap>
								Alert Type
						  </td>
						   <td class="oddrowdata-l">
				 %ifvar alertType equals('flowService')%
								Flow Service
							%else%
							  %ifvar alertType equals('Email')%
								   Email
				   %else%
					 None   	
				   %endif%						
							%endif%
						 </td>
					</tr>
				   %ifvar alertType equals('None')%
			  %else% 
				  <tr>
						 <td class="evenrow" nowrap>
							 Send Alert 
						 </td>
						 <td class="evenrowdata-l">
							%ifvar alertOnEvery equals('false')%
								Every %value alertInterval% minutes
							%else%
								On rule violation
							%endif%
															
						 </td>
					 </tr>
			 %endif%        
			 %ifvar alertType equals('None')%
			  %else%     
					<tr>
				   <td class="oddrow"  nowrap>
								%ifvar alertType equals('Email')%Email Addresses%else%folder.subfolder:service%endif%
				   </td>
				   <td class="oddrowdata-l">
								%ifvar alertType equals('Email')%
									 %value emailTo%
								%else%
									 %value flowServiceName%
								%endif%
				   </td>
			   </tr>
					%ifvar alertType equals('flowService')% 
					<tr id="runAs" name="runAs">
						<td class="oddrow"  nowrap>Run As User</td>
						<td class="oddrowdata-l">%value runAsUser%</td>
					  </tr>
					%endif%
					%endif%
				  </table>
			%endinvoke%      
			%endscope%
		</td>
		</tr>
	  </table> 
  </body> 	
</html>