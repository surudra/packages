%comment%------ Display configured connection node ------%endcomment%
%comment%----- LG TRAX 1-MHXZY -----%endcomment%
%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
%comment%----- display lines in form have alternating colors -----%endcomment%
<HTML>
    <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <title>Connection Details</title>
    <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
    <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    <script src="artconnjs.txt"></script>
    </head>


<body>
<form name="form" action="ListResources.dsp" method="POST">
<input type="hidden" name="action" value="saveConnection">
<input type="hidden" name="passwordChange" value="false">
<input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">

    %invoke wm.art.admin:retrieveAdapterTypeData%
    %onerror%
    %endinvoke%
  
    <table width=100%>
    <tr>
    <td class="menusection-Adapters" colspan=4>Adapters &gt; %value displayName% &gt; Copy Connection</td>
    </tr>
  
    <tr>
    <td colspan=2>
        <ul>
        <li><A HREF="ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&dspName=.LISTRESOURCES">Return to %value displayName% Connections</A>
        </ul>
    </td>
    </tr>
   
    %invoke wm.art.admin.connection:getResourceConfiguration%
    <tr>
        <td class="heading" colspan=2>Configure Connection Type &gt; %value mcfDisplayName% Copy</td>
    </tr>


    <script>setNavigation('ListResources.dsp', '%value encode(javascript) TemplateURL%', 'foo');</script>
    <script>resetRows();</script>
    <tr>
    
        %include GetISPackages.dsp%
            <script>swapRows();writeTD('row');</script>
             Folder Name</td>
            <script>writeTD('rowdata-l');</script>
            <input size=30 name="resourceFolderName" value="%value -urlencode resourceFolderName%"></input></td>          
    </tr>
    <tr>
            <script>swapRows();writeTD('row');</script>
            Connection Name</td>
            <script>writeTD('rowdata-l');</script>
            <input size=30 name="resourceName" value="%value -urlencode resourceName%"></input></td>
    </tr>       
    %comment%-- LG TRAX 1-MHXP3 --%endcomment%
    %comment%-- Changed to point to NEW COPY ONLY .dsp --%endcomment%
    %comment%-- Changed for Elbe Release    --%endcomment%
    %include EditConnectionCopyProperties.dsp%
       
    %comment%----------------------ConnectionManagerProperties--------------%endcomment%    
    %include EditConnectionManagerProperties.dsp%
    %comment%----------------------End ConnectionManagerProperties--------------%endcomment%  
    
    %onerror%
      %ifvar localizedMessage%
        %comment%-- Localized error message supplied --%endcomment%
        <tr><td class="message">Error encountered <%value error%> %value localizedMessage%</td></tr>
      %else%
        %ifvar error%
          <tr><td class="message">Error encountered <%value error%> %value errorMessage%</td></tr>
        %endif%
      %endif%
    %endinvoke%
    </table>
       
    <table width=100%>
    <tr>
    <td class="action" colspan="2">
        <input type="submit" name="SUBMIT" value="Save Connection Copy" width=100 onclick="return validateForm(this.form)"></input>
        <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">        
        <input type="hidden" name="connectionFactoryType" value="%value connectionFactoryType%"> 
         
    </TD>    
    </tr>
    </table>
    </form>    
</body>
</HTML>