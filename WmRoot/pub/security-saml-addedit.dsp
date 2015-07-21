
<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
    <base target="_self">
	<style>
	  .listbox  { width: 100%; }
	</style>
  </HEAD>
  %ifvar action equals('edit')%
  <BODY onLoad="loadKeyStoresOptions(); setNavigation('security-saml.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditSAMLIssuer');">
  %else%
  <BODY onLoad="loadKeyStoresOptions(); setNavigation('security-saml.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddSAMLTokenIssuerScrn');">
  %endif%
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Security" colspan="2">
            Security &gt;
            SAML &gt;
            %ifvar action equals('edit')%
                %value IssuerName% &gt; Edit
            %else%
                Add SAML Token Issuer
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="security-saml.dsp">Return to Trusted SAML Token Issuers</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height="10" width="10"></TD>
        <TD>
      <TABLE class="tableForm">
        <TR>
            <TD colspan="2" class="heading">SAML Token Issuer Details</TD>
        </TR>
          <FORM NAME="addform" ACTION="security-saml.dsp" METHOD="POST">
          <SCRIPT LANGUAGE="JavaScript">
          
          var hiddenOptions = new Array();
      
	      function loadKeyStoresOptions()
	      {
				var clockSkew = document.addform.ClockSkew.value;
				if(clockSkew == "")
					document.addform.ClockSkew.value = "0";
			    var ts = document.addform.TruststoreAlias.options
	      		%invoke wm.server.saml:listTruststoresAndAliases%
	      			   ts[ts.length] = new Option("","");
				       hiddenOptions[ts.length-1] = new Array();
				       
			       	   %loop trustStoresAndConfiguredCertAliases%
			       			ts.length=ts.length+1;
				       		ts[ts.length-1] = new Option("%value trustStoreName%","%value trustStoreName%");
			           		var aliases = new Array();
			    	   		%loop certAliases%
			       				aliases[%value $index%] = new Option("%value%","%value%");		
			       			%endloop%
			       			if (aliases.length == 0)
			       			{
								aliases[0] = new Option("","");		
							}
				       		hiddenOptions[ts.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%
			    
			    var keyOpts = document.addform.TruststoreAlias.options;
    			var key = '%value -htmlcode TruststoreAlias%';
				if ( key != "") 
				{
	       			for(var i=0; i<keyOpts.length; i++) 
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}
				
				changeval();
				
				var aliasOpts = document.addform.CertAlias.options;
    			var alias = '%value -htmlcode CertAlias%';
				if ( alias != "") 
				{
	       			for(var i=0; i<aliasOpts.length; i++) 
	       			{
				    	if(alias == aliasOpts[i].value) {
				    		aliasOpts[i].selected = true;
		    			}
			      	}
				}
	      }
	      
	      function changeval() {
       		var ts = document.addform.TruststoreAlias.options;
       		var selectedKS = document.addform.TruststoreAlias.value;
       		for(var i=0; i<ts.length; i++) {
       			if(selectedKS == ts[i].value) {
		       		var aliases = hiddenOptions[i];
       				document.addform.CertAlias.options.length = aliases.length;
       				for(var j=0;j<aliases.length;j++) {
       					var opt = aliases[j];
       					document.addform.CertAlias.options[j] = new Option(opt.text, opt.value);
     				}
       			}
       		}
		}
		
          function confirmEdit ()
          {
            if ((document.addform.IssuerName.value == "") ||
                (document.addform.TruststoreAlias.value == "")  ||
                (document.addform.CertAlias.value == "") )
            {
              alert ("You must specify the arguments (Issuer Name, TrustStore Alias, Certificate Alias) for the Issuer.");
			  return false;
            }
			
			if(!checkName())
				return false;
				
			if(!checkClockSkew())
				return false;
			
			if(!checkDuplicate())
				return false;
				
            document.addform.submit();
			return true;
          }

        function checkDuplicate()
        {
          var issuersArray;
          if (! document.addform.issuers)
          {
            issuersArray = new Array(0);
          }
          else if (! document.addform.issuers.length)
          {
            issuersArray = new Array(1);
            issuersArray[0] = document.addform.issuers.value;
          }
          else
          {
            var aliasesLen = document.addform.issuers.length;
            issuersArray = new Array(aliasesLen);
            for (i = 0; i < aliasesLen; i++)
            {
              issuersArray[i] = document.addform.issuers[i].value;
            }
          }            
          for (ind = 0; ind < issuersArray.length; ind++)
          {
            if (issuersArray[ind] == document.addform.IssuerName.value)
            {
              var confirmation = confirm("Do you want to overwrite existing Issuer " + document.addform.IssuerName.value + "?");
              if (confirmation == false)
              {
                return false;
              }
	        }
	      }
          return true;
         }          
		 
          function confirmAdd ()
          {
            if ((document.addform.IssuerName.value == "") ||
                (document.addform.TruststoreAlias.value == "")  ||
                (document.addform.CertAlias.value == "") )
            {
              alert ("You must specify the arguments (Issuer Name, TrustStore Alias, Certificate Alias) for the Issuer."); 
			  return false;
            }
			
			if(!checkName())
				return false;
				
			if(!checkClockSkew())
				return false;
				
			if(!checkDuplicate())
				return false;
				
			document.addform.submit();
			return true;
		  }
		  
			function checkName()
			{
				var name = document.addform.IssuerName.value;
				if (name.charAt(0) == " ")
				{
					alert ("IssuerName begins with illegal character: ' '");
					return false;
				}
				return true;
			}

		  function checkClockSkew()
          {
          	 var regExp = /^[+-]?[0-9]+$/;
          	 var clockSkew = document.addform.ClockSkew.value;
          	 if ( clockSkew != "")
          	 {
	          	 if (clockSkew.match(regExp) == null)
	          	 {
	          	    alert("Clock Skew must be an integer value");
	          	 	document.addform.ClockSkew.focus();
	          	 	return false;
	          	 }
    		  }      	
          	 return true;
          }
		  
          
		  var agent = navigator.userAgent.toLowerCase();
    	  var ie = (agent.indexOf("msie") != -1);          
    	  
         
          </SCRIPT>
          <TR>
            <TD class="oddrow">Issuer Name</TD>
            <TD class="oddrow-l">
              <INPUT NAME="IssuerName" VALUE="%value IssuerName%"> </TD>
          </TR>
          <TR>
            <TD class="evenrow">Truststore Alias</TD>
            <TD class="evenrow-l">
              <SELECT class="listbox" name="TruststoreAlias" onchange="changeval()"></SELECT>
          </TR>
          <TR>
            <TD class="oddrow">Certificate Alias</TD>
            <TD class="oddrow-l">
              <!--<INPUT NAME="CertAlias" VALUE="%value CertAlias%"> </TD> -->
			  <select class="listbox" name="CertAlias" ></select>
          </TR>
          <TR>
            <TD class="evenrow">Clock Skew</TD>
            <TD class="evenrow-l">
              <INPUT NAME="ClockSkew" VALUE="%value ClockSkew%"> </TD>
          </TR>

          %invoke wm.server.saml:listIssuers%

          <TR>
          %loop -struct issuers%
            %scope #$key%
            <TD>
              <INPUT TYPE="hidden" NAME="issuers" VALUE="%value IssuerName%" />
            </TD>
            %endscope%
          %endloop%
          </TR>

          <TR>
            <TD colspan=2 class="action">
              <INPUT TYPE="hidden" NAME="args" VALUE="xxx">
            %ifvar action equals('edit')%
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT TYPE="hidden" NAME="oldIssuerName" VALUE="%value IssuerName%">
              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
            %else%
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
            %endif%
            </TD>
          </TR>
          
          

          
        </FORM>
      </TABLE>
    </TD>
  </TR>
</TABLE>

    </BODY>
  </HTML>
