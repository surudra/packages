<HTML>
   <HEAD language="JavaScript">
   <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
   <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
   </HEAD>
   <script>
   function handleCondition(intf, svc) {
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.location='/invoke/'+intf+'/'+svc+'?'+_csrfTokenNm_+"="+_csrfTokenVal_ ;
		} else {
			document.location='/invoke/'+intf+'/'+svc;
		}
   }
   </script>
   <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_TestSvcsScrn');">
      <TABLE width="100%">
         <TR>
            <TD class="menusection-Packages" colspan="2">
                Packages &gt;
                Management &gt;
                Services &gt;
                %value service% &gt;
                Test
            </TD>
         </TR>
         <TR>
          <TD colspan=2>
            <UL>
              <LI><A HREF="service-info.dsp?interface=%value interface%&service=%value service%">Return to %value service%</A></LI>
            </UL>
          </TD>
        </TR>

         <TR><td><img src="images/blank.gif" height=10 width=10 border=0></td>
            <TD>
               <TABLE class="tableForm" CELLPADDING=2> %ifvar interface%
                %invoke wm.server.xidl.adminui:testService%
                  <FORM name="testform" method="post" action="/invoke/wm.server.xidl:testServiceWrapper">
                     <TR>
                        <TD class="heading" colspan=2>Assign Input Values</TD>
		               <INPUT name="interface" type="HIDDEN"  value="%value interface%"/>
		               <INPUT name="service" type="HIDDEN"  value="%value service%"/>
                     </TR>
                     <!-- - - - Inputs Section - - - -->
                     %ifvar input% %loop input/rec_fields%
                     <TR>
                        <script>writeTD("row");</script>
                        %ifvar field_opt equals('true')%<i>%endif%
                        %value field_name% &nbsp;&nbsp;%ifvar field_opt equals('true')%</i>%endif%


                        %switch field_type%
                            %case 'string'%
                            <script>writeTD("row-l");</script>
                            <INPUT name="%value field_name%" value="" %ifvar node_hints/field_password equals('true')%type="PASSWORD"%endif%></TD>

                            %case 'record'%
                            <script>writeTD("row-l");swapRows();</script>
                                <TABLE CELLPADDING=2> %loop rec_fields%
                                <TR>
                                <script>writeTD("row");</script>
                                %value field_name% &nbsp;&nbsp;</TD>
                                <script>writeTD("row-l");</script>
                                <INPUT name="%value field_name%" value="" %ifvar node_hints/field_password equals('true')%type="PASSWORD"%endif%>
                                </TD>
                                </TR>
                                %endloop%
                                </TABLE>
                            <script>swapRows();</script>
                            </TD>

                            %case 'object'%
                            <script>writeTD("row-l");</script>
                            (Can't input objects)</TD>
                        %endswitch%
                        </TR>
                        <script>swapRows();</script>
                        %endloop%  %else%
                     <TR>
                        <TD class="oddrow-l" colspan=2> No inputs to assign.  If
                           inputs are required, make sure this  service has a
                           registered signature.  Otherwise, click "Test"  to
                           test this service with no inputs.  </TD>
                     </TR> %endif%
                     <TR>
                        <TD class="action" colspan=2>%ifvar input%<INPUT class="button2" type="button" value="Test (with inputs)"
                           onclick="document.testform.submit();"></input>
                           %endif%

                           <INPUT class="button2" type="button" value="Test (without inputs)"
                           onclick="handleCondition('%value -urlencode interface%','%value -urlencode service%');"></input></TD>
                     </TR>

                  </FORM> %endinvoke%  %else%
                  <FORM name="testform" method="post"
                     action="service-test.dsp">
                     <TR class="menusection-Utilization">
                        <TD colspan="2">Test a Service</TD>
                     </TR>
                     <TR>
                        <TD class="action" colspan=2>
                           <INPUT type="button" value="Test"
                           onclick="document.testform.submit();"> </TD>
                     </TR>
                     <TR class="heading">
                        <TD colspan=2>Specify Service to Test</TD>
                     </TR>
                     <TR>
                        <TD class="oddrow">Interface</TD>
                        <TD class="oddrowdata">
                           <INPUT name="interface">
                           </INPUT></TD>
                     </TR>
                     <TR>
                        <TD class="oddrow">Service</TD>
                        <TD class="oddrowdata">
                           <INPUT name="service">
                           </INPUT></TD>
                     </TR>

                  </FORM> %endif%
               </TABLE> </TD>
         </TR>
      </TABLE>
   </BODY>
</HTML>
