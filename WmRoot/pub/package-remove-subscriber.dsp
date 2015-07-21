<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('package-exchange.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_UpdateRemoveSubsScrn');">
   
  <SCRIPT LANGUAGE="JavaScript">

    function checkcheckboxes(formname)
    {
      var cnt = 0;

      if ( document.forms[formname].subscriber.length > 1 )
      {
        for( var i=0; i<document.forms[formname].subscriber.length; i++ )
        {
          if (document.forms[formname].subscriber[i].checked == true)
          cnt++;
        }
      } else {
        if( document.forms[formname].subscriber.checked == true )
          cnt++;
      }

      if ( cnt < 1 ) {
        alert("Select a Subscriber first.");
        return false;
      }
      else
        return true;
    }
  </SCRIPT>

    <TABLE width="100%">
      <TR>
        <TD class="menusection-Packages" colspan=2>
          Packages &gt;
          Publishing &gt;
          Update and Remove Subscriber
        </TD>
      </TR>
      %ifvar action equals('removesubscriber')%
        %invoke wm.server.replicator.adminui:subscriberCancel%
          %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value none message%</TD></TR>
          %endif%
        %endinvoke%
      %endif%
      <TR>
        <TD colspan=2>
          <UL>
            <LI><A HREF="package-exchange.dsp">Return to Publishing</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG src="images/blank.gif" height=10 width=10 border=0></TD>
        <TD>
        <script>
        	var count = 0;
        </script>
              %invoke wm.server.replicator:getDetailedReleasedList%
                %loop packages%
                  %invoke wm.server.replicator:publishedList%
                    %loop published%
                      %ifvar ../name vequals(package)%

												<script>
													var count = count + 1;
												</script>
          <TABLE class="tableView" width="100%">

                        <TR>
                          <TD class="heading" colspan=3>%value ../name%</TD>
                        </TR>
                        <TR>
                          <TD class="oddcol-l">Subscriber</TD>
                          <TD class="oddcol">Update</TD>
                          <TD class="oddcol-l">Delete</TD>
                        </TR>
                        <FORM name="%value ../name%" action="package-remove-subscriber.dsp" method=POST>
                        <input type="hidden" name="action" value="removesubscriber">
                        <input type="hidden" name="package" value="%value ../name%">
                        <script>resetRows();</script>

                 		%ifvar initbypub equals('yes')%

                        	%loop subscribers%
                          <TR>
                            <script>writeTD("rowdata-l");</script>
                              %value%
                            </TD>

                            <script>writeTD("rowdata");</script>
                              <A HREF="package-edit-subscriber.dsp?subscriber=%value%&package=%value ../name%">Edit</A></TD>

                            <script>writeTD("rowdata-l");</script>
                              <input type="checkbox" name="subscriber" value="%value%"></input>
                            </TD>
                            <script>swapRows();</script>
                          </TR>
                        	%endloop%

                        %else%
                        	%loop subscribers%
                          <TR>
                            <script>writeTD("rowdata-l");</script>
                              %value%
                            </TD>

                            <script>writeTD("rowdata");</script>
                              Not Available</TD>

                            <script>writeTD("rowdata-l");</script>
                              <input type="checkbox" name="subscriber" value="%value%"></input>
                            </TD>
                            <script>swapRows();</script>
                          </TR>
                        	%endloop%
                        %endif%

                        <TR>
                          <TD class="action" colspan="3">
                            <input class="button2" type="submit" name="submit" onclick="return checkcheckboxes('%value ../name%'); return false;" value="Delete Selected Subscribers">
                          </TD>
                        </TR>
                        </FORM>
          </TABLE>
                      %endif%
                    %endloop%
                  %endinvoke%
                %endloop%
              %endinvoke%

              <script>
								if(count == 0)
								{
									document.write('<table class="tableView"><tr><td class=heading>Remove Subscribers</td></tr><tr><td class=oddrow-l>No subscribers to remove</td></tr></table>');
								}
							</script>

        </TD>
      </TR>
    </TABLE>
  </BODY>
</HTML>
