<HTML>
    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    </HEAD>

    <script>
        function launchHelp() {
            if (parent.menu != null){
                window.open(parent.menu.document.forms["urlsaver"].helpURL.value, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
            }
        }
       
	function logout() {
        // Chrome doesn't support any kind of logoff, so we are sending a request without password that will get a 401
        // This currently seems to be the only way to get Chrome to forget the prior credentials other than closing the whole browser.
        // Not pretty, but it's the best we can find for now.
        var isChrome = window.chrome;
        if (isChrome) {
          var xmlHttp = null;
          xmlHttp = new XMLHttpRequest();
          try {
            // The "true" on this call is setting it to be an async call, so the logoff result returns and displays 
            // Then, eventually Chrome will prompt for a Userid/Password again 
            xmlHttp.open( "GET", "http://Administrator@"+window.location.hostname+":"+window.location.port, true );
            xmlHttp.send();
          }
          catch (e) {}  
        }
        // Only IE supports the ClearAuthenticationCache to effectively logoff
        // Firefox seems to ignore the ClearAuthenticationCache, but at least honors the logoff
        else {
          document.execCommand("ClearAuthenticationCache"); 
        }  
	  }

    </script>

    <BODY onLoad="logout()" class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
       %invoke wm.server:disconnect%
       <table width="100%">
            %ifvar $result equals('ok')% 
                <tr><td class="title">Session terminated</td></tr>
                <tr><td>Click <A  target="_top" HREF="/WmRoot/">here</A> to resume</td></tr> 
            %else%
                <tr><td class="title">Logoff Failed - %value $result%</td></tr>
                <tr><td>Click <A target="_top" HREF="/WmRoot/">here</A> to resume</td></tr> 
            %endif%          
        </table>    
    </BODY>
</HTML>
