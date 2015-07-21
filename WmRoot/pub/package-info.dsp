<HTML>
   <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


   <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">

   </HEAD>

      <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
      %ifvar showServices%
        <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_BrowseSvcsScrn');">
      %else%
        <BODY onLoad="setNavigation('package-list.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_PkgDescScrn');">
      %endif%
         %invoke wm.server.packages.adminui:packageInfo%
            %ifvar showServices%
            <TABLE WIDTH=100%>
                <TR>
                <TD class="menusection-Packages" colspan=2>
                    Packages &gt;
                    Management &gt;
                    %value package% &gt;
                    Services</TD>
                </TR>

      <TR>
      <td colspan=2>
                  <UL>
                      <LI><A HREF="package-info.dsp?package=%value package%">Return to properties for %value package%</A></LI>
                  </UL>
      </td>
      </tr>
            <TR>
            <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
            <TD>

               <TABLE class="tableView">
               <TR>
                  <TD class="heading">Services</TD>
               </TR>

               <script>resetRows();</script>
        %ifvar services%
               %loop services%
               <TR>
                  <script>writeTD("rowdata-l");swapRows();</script>
<nobr>&nbsp;&nbsp;<A HREF="service-info.dsp?service=%value%"><IMG src="icons/file.gif" border=0></A>&nbsp;<A HREF="service-info.dsp?service=%value%">%value%</A></nobr></TD>
                     </A>
                  </TR>
               %endloop%
        %else%
         <TR>
          <script>writeTD("rowdata-l");swapRows();</script>
          No services in %value package%

          </TR>

               %endif%


               </TABLE>


            </TD></TR>

            %else%
            <TABLE WIDTH=100%>
                <TR>
                <TD class="menusection-Packages" colspan=2>
                    Packages &gt;
                    Management &gt;
                    %value package%</TD>
                </TR>
              <TR>
        <TD colspan=2>
          <UL>
                    <LI><A HREF="package-list.dsp">Return to Packages Management</A></LI>
            <LI><A HREF="package-info.dsp?package=%value package%&showServices=true">Browse services in %value package%</A></LI>
          </UL>
        </td>
        </tr>
      <TR>
            <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
            <TD>

            <TABLE class="tableView">
            <TR>
                <TD class="heading" colspan=2>Package Information</TD>
            </TR>
            <TR>
                <script>writeTD("row");</script>
                    Package Name</TD>
                <script>writeTD("rowdata-l");</script>
                    %value package%</TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Version</TD>
               <script>writeTD("rowdata-l");</script>%value version%&nbsp;</TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Build</TD>
               <script>writeTD("rowdata-l");</script>%value build%&nbsp;</TD>
               <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Minimum Version of JVM</TD>
               <script>writeTD("rowdata-l");</script>%value jvm_version%&nbsp;</TD>
               <script>swapRows();</script>
            </TR>

            <TR>
               <script>writeTD("row");</script>Package List ACL</TD>
               <script>writeTD("rowdata-l");</script>%value listACL%&nbsp;</TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Patches Included</TD>
               <script>writeTD("rowdata-l");</script>%value patch_nums%&nbsp;</TD>
               <script>swapRows();</script>
            </TR>

            <TR>
               <script>writeTD("row");</script>Description</TD>
               <script>writeTD("rowdata-l");</script>%value description%&nbsp;</TD>
               <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Publisher</TD>
               <script>writeTD("rowdata-l");</script>%value publisher%&nbsp;</TD>
               <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Created on</TD>
               <script>writeTD("rowdata-l");</script>%value time%&nbsp;</TD>
               <script>swapRows();</script>
            </TR>

            %ifvar pkgkey%
            <TR>
               <script>writeTD("row");</script>License Key</TD>
               <script>writeTD("rowdata-l");</script>%value pkgkey%&nbsp;</TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Key expiration</TD>
               <script>writeTD("rowdata-l");</script>%value pkgkeyexp%&nbsp;</TD>
                <script>swapRows();</script>
            </TR> %endif%
            <TR>
               <script>writeTD("row");</script>Elements Loaded</TD>
               <script>writeTD("rowdata-l");</script> %value loadok%  
               %ifvar loadok equals('0')%  %else% %endif%  
               %ifvar loadwarning equals('0')%  
               %else% 
                    %ifvar loadwarning equals('1')%  
                        &nbsp;(%value loadwarning% warning)
                    %else%
                        &nbsp;(%value loadwarning% warnings)
                    %endif%  
                %endif%  
               </TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Elements Not Loaded</TD>
               <script>writeTD("rowdata-l");</script>%value loaderr%&nbsp;</TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Startup Services</TD>
               <script>writeTD("rowdata-l");</script> %ifvar startupServices%
               %loop startupServices%
                  <A HREF="service-info.dsp?service=%value%">
                  %value%
                  </A> %loopsep ',<BR>'% %endloop%  %else%  None  %endif%  </TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Shutdown Services</TD>
               <script>writeTD("rowdata-l");</script> %ifvar shutdownServices%
               %loop shutdownServices%
                  <A HREF="service-info.dsp?service=%value%">
                  %value%
                  </A>%loopsep ',<BR>'% %endloop%  %else%  None  %endif%  </TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Replication Services</TD>
               <script>writeTD("rowdata-l");</script> %ifvar replicationServices%
               %loop replicationServices%
                  <A HREF="service-info.dsp?service=%value%">
                  %value%
                  </A> %loopsep ',<BR>'% %endloop%  %else%  None  %endif%  </TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Packages on which this
                  package depends </TD>
               <script>writeTD("rowdata-l");</script>
               %ifvar successors%  %loop successors% %value% %loopsep ',<BR>'% %endloop% %else%  None %endif% </TD>
                <script>swapRows();</script>
            </TR>
            <TR>
               <script>writeTD("row");</script>Packages that depend on
                  this package</TD>
               <script>writeTD("rowdata-l");</script>
               %ifvar predecessors% %loop predecessors% %value% %loopsep ', <BR>'% %endloop% %else% None %endif%
                <script>swapRows();</script>
               </TR>
               <TR>
                  <script>writeTD("row");</script>Subscribers</TD>
                  <script>writeTD("rowdata-l");</script>
                  %ifvar subscribers%  %loop subscribers% %value% %loopsep ',<BR>'% %endloop%  %else%  None  %endif%  </TD>
                <script>swapRows();</script>
               </TR>
               </TABLE>
               <BR>


                <script>resetRows();</script>
               <TABLE class="tableView" width=100%>
                  <TR>
                     <TD colspan="2" class="heading">Load Errors</TD>
                  </TR>
               %ifvar notLoaded%
                  <TR>
                     <TD class="oddcol-l">Name</TD>
                     <TD class="oddcol-l">Reason</TD>
                  </TR>
                  %loop notLoaded%
                  <TR>
                     <script>writeTD("rowdata-l");</script>%value itemname%</TD>
                     <script>writeTD("rowdata-l");</script>%value reason%</TD>
                     </TR>
                    <script>swapRows();</script>
                  %endloop%
                %else%
                <TR><TD class="oddcol-l" colspan="2">No errors</TD></TR>
               %endif%
               </TABLE>


               <BR>
                <script>resetRows();</script>
               <TABLE class="tableView" width=100% ID=warnings>
                  <TR>
                     <TD colspan="2" class="heading">Load Warnings</TD>
                  </TR>
               %ifvar loadedWithWarning%
                  <TR>
                     <TD class="oddcol-l">Name</TD>
                     <TD class="oddcol-l">Reason</TD>
                  </TR>
                  %loop loadedWithWarning%
                  <TR>
                     <script>writeTD("rowdata-l");</script>%value itemname%</TD>
                     <script>writeTD("rowdata-l");</script>%value reason%</TD>
                     </TR>
                    <script>swapRows();</script>
                  %endloop%
              %else%
                    <TR><TD class="oddcol-l" colspan="2">No Warnings</TD></TR>
               %endif%
               </TABLE>


               <BR>
                <script>resetRows();</script>
            <TABLE class="tableView" width=100%>
                <TR>
                    <TD COLSPAN="5" class="heading">Patch History</TD>
                </TR>
            %ifvar patchlist%
                <TR>
                    <TD class="oddcol-l">Name</TD>
                    <TD class="oddcol-l">Version</TD>
                    <TD class="oddcol-l">Created on</TD>
                    <TD class="oddcol-l">Description</TD>
                    <TD class="oddcol-l">Publisher</TD>
                </TR>

                <script>resetRows();</script>
                %loop patchlist%
                <TR>
                    <script>writeTD("rowdata-l");</script>%value name%</TD>
                    <script>writeTD("rowdata-l");</script>%value version%</TD>
                    <script>writeTD("rowdata-l");</script>%value time%</TD>
                    <script>writeTD("rowdata-l");</script>%value description%</TD>
                    <script>writeTD("rowdata-l");</script>%value publisher%</TD>
                    <script>swapRows();</script>
                </TR>
                %endloop%
              %else%
                    <TR><TD class="oddcol-l" colspan="5">No Patches</TD></TR>
            %endif%
            </TABLE>

               %endinvoke%
            </TD>
         </TR>
         %endif%
     </TABLE>
   </BODY>
</HTML>
