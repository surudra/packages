
<script>
function setNavLink(aID, imgID, coolID) {

	if (document.URL.indexOf(aID) > 0) {
		document.all[aID].href = "javascript:void(0)";
		document.all[imgID].alt = "This Page";
		// Give some visual cue which link is selected
		var cool = document.getElementById(coolID);
		cool.setSelected();
	}

	return null;
}

function disableNavLink(aID, imgID, coolID) {

	// If this page should be disabled, go to access denied
	if (document.URL.indexOf(aID) > 0)
		if(is_csrf_guard_enabled && needToInsertToken) {
   		   parent.document.location.href = "authorization-error.dsp?" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
		} else {
		  parent.document.location.href = "authorization-error.dsp";
		}
	else {
		document.all[aID].href = "javascript:void(0)";
		document.getElementById(coolID).setEnabled(false);
	}

	return null;
}

</script>

%invoke wm.deployer.gui.UIProject:getProjectInfo%
%ifvar status equals('Error')%
	<script>
		if(is_csrf_guard_enabled && needToInsertToken) {
   		   parent.document.location.href = "object-not-found.dsp?" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
		} else {
		   	parent.document.location.href = "object-not-found.dsp";
		}
	</script>
%else%

%ifvar defineAuthorized equals('true')%
	<SCRIPT>setNavLink("bundle-list", "define", "definex");</SCRIPT>
%else%
	%ifvar viewAuthorized equals('true')%
	<SCRIPT>setNavLink("bundle-list", "define", "definex");</SCRIPT>
	%else%
	<SCRIPT>disableNavLink("bundle-list", "define", "definex");</SCRIPT>
	%endif%
%endif%

%ifvar buildAuthorized equals('true')%
	<SCRIPT>setNavLink("release-list", "build", "releasex");</SCRIPT>
%else%
	%ifvar viewAuthorized equals('true')%
		<SCRIPT>setNavLink("release-list", "build", "releasex");</SCRIPT>
	%else%
		<SCRIPT>disableNavLink("release-list", "build", "releasex");</SCRIPT>
	%endif%
%endif%

%ifvar mapAuthorized equals('true')%
	<SCRIPT>setNavLink("map-list", "map", "mapx");</SCRIPT>
%else%
	%ifvar viewAuthorized equals('true')%
		<SCRIPT>setNavLink("map-list", "map", "mapx");</SCRIPT>
	%else%
		<SCRIPT>disableNavLink("map-list", "map", "mapx");</SCRIPT>
	%endif%
%endif%

%ifvar deployAuthorized equals('true')%
	<SCRIPT>setNavLink("deploy-list", "deploy", "deployx");</SCRIPT>
%else%
	%ifvar viewAuthorized equals('true')%
		<SCRIPT>setNavLink("deploy-list", "deploy", "deployx");</SCRIPT>
	%else%
		<SCRIPT>disableNavLink("deploy-list", "deploy", "deployx");</SCRIPT>
	%endif%
%endif%

%invoke wm.deployer.UIAuthorization:checkLock%
%endinvoke%

%ifvar canUserLock equals('true')%		
  %ifvar isLockingEnabled equals('false')%
       <script>writeMessage("\t**Locking is disabled.");</script>		
  %else%
  	  %ifvar isLocked equals('true')%	
  	  %ifvar sameUser equals('true')%   
  	    <script>writeMessage("\t**The Project is in update mode.");</script>
  	  %else%
  	    <script>writeMessage("\t**The Project is locked by other user.");</script>
  	  %endif%
  	  %else%
  	    <script>writeMessage("\t**The Project is not locked.");</script>
  	  %endif%
  %endif%
%else%
   <script>writeMessage("\t**User not authorized to lock/unlock Project.");</script>
%endif%

%endif%
%endinvoke%
