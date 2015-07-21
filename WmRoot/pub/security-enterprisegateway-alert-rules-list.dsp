 <table width="100%">
               <tr>
                      <td colspan="7" class="heading">
                           Alert Rules
                      </td>
               </tr>
               <tr>
                     <td class="oddcol-l" width="12%">
                         Rule Name
                     </td>
                     <td class="oddcol" width="20%">
                         Filters
                     </td>
                     <td class="oddcol" width="12%">
                         Enabled
                     </td>
					           <td class="oddcol" width="12%">
                         Alert Options
                     </td>
                     <td class="oddcol" width="12%">
                         Copy
                     </td>
                     <td class="oddcol" width="12%">
                         Delete
                     </td>
                     <td class="oddcol" width="14%">
                         Priority
                     </td>
               </tr>
               %ifvar -notempty alertRuleList%
                      <!-- making sync with other tables  included above.-->
                      <script>resetRows();</script>
                      %loop alertRuleList%
                          <tr>
                                <script>writeTD("rowdata-l");</script>
                                <a href="security-enterprisegateway-create-rule.dsp?operation=editRule&ruleType=ALERT&rule=%value ruleName%&index=%value $index%">
                                %value ruleName%
                                </a>
                                </td>
                                <script>writeTD("rowdata");</script>
                                <script>
                                  var sep="";
                                  var filterStr = "";
                                  %loop Filters%
                                    %ifvar filterName equals('DoSFilter')%  
                                       %ifvar isDOSEnabled equals('true')%    
                                          filterStr = filterStr+sep+"Denial of Service Protection";
                                          sep=", ";
                                        %endif%
                                    %endif%
                                    %ifvar filterName equals('OAuthFilter')%
                                      %ifvar isOAuthEnabled equals('true')%
                                          filterStr = filterStr+sep+"OAuth Credentials";
                                          sep=", ";
                                      %endif%
                                    %endif%
                                    %ifvar filterName equals('MsgSizeLimitFilter')%      
                                      %ifvar isMessageSizeEnabled equals('true')%
                                          filterStr = filterStr+sep+"Message Size Limit";
                                          sep=", ";   
                                      %endif%  
                                    %endif% 
									%ifvar filterName equals('mobileAppProtectionFilter')%      
                                      %ifvar isMobileAppProtectionEnabled equals('true')%
                                          filterStr = filterStr+sep+"Mobile Application Protection";
                                          sep=", ";   
                                      %endif%  
                                    %endif%
									%ifvar filterName equals('sqlInjectionFilter')%      
                                      %ifvar isSQLInjectionFilterEnabled equals('true')%
                                          filterStr = filterStr+sep+"SQL Injection Protection";
                                          sep=", ";   
                                      %endif%  
                                    %endif% 
									%ifvar filterName equals('antiVirusFilter')%      
                                      %ifvar isAntiVirusScanEnabled equals('true')%
                                          filterStr = filterStr+sep+"Anti Virus Scan";
                                          sep=", ";   
                                      %endif%  
                                    %endif%	
                                  %endloop%
                                  if("" == filterStr ){
                                    filterStr="None";
                                  }
                                  document.write(filterStr);
                                 </script>
                                </td>
                                <script>writeTD("rowdata");</script>
                                  %ifvar isRuleEnabled equals('true')%
                                         <img src="images/green_check.gif" border="no">
                                         <a href="security-enterprisegateway-rules.dsp?action=enableDisable&index=%value $index%&ruleType=ALERT&rule=%value ruleName%"  onclick="return confirmEnableDisable('%value ruleName%','disable')">Yes<a>
                                  %else%
                                      <a href="security-enterprisegateway-rules.dsp?action=enableDisable&index=%value $index%&ruleType=ALERT&rule=%value ruleName%" onclick="return confirmEnableDisable('%value ruleName%','enable')">No<a>
                                  %endif%
                               </td>
							    <script>writeTD("rowdata");</script>
									%ifvar alertOption%
									   <a href="security-enterprisegateway-alert-options.dsp?ruleType=ALERT&rule=%value ruleName%&global=false&alertSettings=false">
										Custom
									   </a>
									%else%
										<a href="security-enterprisegateway-alert-options.dsp?ruleType=ALERT&rule=%value ruleName%&global=false&alertSettings=true">
										 Default
									   </a>
									%endif%
								</td>
                               <script>writeTD("rowdata");</script><a href="security-enterprisegateway-create-rule.dsp?operation=copyRule&ruleType=ALERT&rule=%value ruleName%&index=%value $index%">
                                <img src="icons/copy.gif" border="no">
                               </a></td>
                               <script>writeTD("rowdata");</script>
                                  <a class="imagelink" href="security-enterprisegateway-rules.dsp?action=delete&index=%value $index%&ruleType=ALERT&rule=%value ruleName%" onclick="return confirmDelete('%value ruleName%')">
                                    <img src="icons/delete.gif" border="none">
                                  </a>
                               </td>
                               <script>writeTD("rowdata");</script>
                                   <a href="security-enterprisegateway-rules.dsp?action=moveUp&index=%value $index%&ruleType=ALERT&rule=%value ruleName%"><img id = "link_up_alert_%value $index%" src="icons/moveup_enabled.png" border="none"></a> 
                                   <a href="security-enterprisegateway-rules.dsp?action=moveDown&index=%value $index%&ruleType=ALERT&rule=%value ruleName%"><img id = "link_down_alert_%value $index%" src="icons/movedown_enabled.png" border="none"></a> 
                               </td>
                          </tr>
                          <script>swapRows();</script>
                          %ifvar $index equals('0')%
                                <script>
                                          var firstUp =   document.getElementById('link_up_alert_%value $index%');
                                          var lastDown;
                                </script>
                          %endif%
                          <script>
                                   lastDown =  document.getElementById('link_down_alert_%value $index%');
                          </script>                         
                      %endloop% 
               %else%
                  <tr>
                    <td colspan="7" class="evencol-l">
                         No rules are currently configured.
                    </td>
                  </tr>                                                                              
               %endif%
              </table>
              <script>
              if(typeof lastDown != 'undefined'){
                    disableDirectionImage(lastDown,'DOWN');
              }
              
              if(typeof firstUp != 'undefined'){
                    disableDirectionImage(firstUp,'UP');
              }

              </script>