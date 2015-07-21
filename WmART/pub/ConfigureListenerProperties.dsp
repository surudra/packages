%comment%----- Displays Listener type parameters used by CREATE LISTENER ONLY -----%endcomment%
%comment%----- LG TRAX 1-MHXZY -----%endcomment%
%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
%comment%----- display lines in form have alternating colors -----%endcomment%
%ifvar listenerData%
    <script>setNavigation('ListListenerTypes.dsp', '%value TemplateURL%', 'foo');</script>
    <script>resetRows();</script>

    <tr>
        %include GetISPackages.dsp%
        <script>swapRows(); writeTD('row');</script>Folder Name</td>
        <script>writeTD('rowdata-l');</script>
            <input size=30 name="listenerFolderName" value="%value -urlencode resourceFolderName%"></input>
        </td>
    </tr>

    <tr>
        <script>swapRows(); writeTD('row');</script>Listener Name</td>
        <script>writeTD('rowdata-l');</script>
            <input size=30 name="listenerNodeName" value="%value -urlencode listenerName%"></input>
        </td>
    </tr>

    %ifvar requiresConnection equals('yes')%

        <tr>
            <script>swapRows(); writeTD('row');</script>Connection name</td>
            <script>writeTD('rowdata-l');</script>
                %invoke wm.art.admin.connection:listResources%
                    %ifvar connDataNode -notempty%
                        <select name="connDataNodeName">
                            %loop connDataNode%
                                <option value="%value connectionAlias%">%value connectionAlias%</option>
                            %endloop%
                        </select>
                    %else%
                        no connections
                    %endif%
                %endinvoke%
            </td>
        </tr>
    %endif%

    <tr>
        <script>;swapRows(); writeTD('row');</script>Retry Limit</TD>
        <script>writeTD('rowdata-l');</script>
             <input size=60 name="retryLimit" value="5"></input></td>
        </td>
    </tr>    
    
    <tr>
        <script>swapRows();writeTD('row');</script>Retry Backoff Timeout</TD>
        <script>writeTD('rowdata-l');</script>
             <input size=60 name="retryBackoffTimeout" value="10"></input></td>
        </td>
    </tr>    


    <tr><td class="heading" colspan=2>Listener Properties</td></tr>

    %loop listenerData%
		
		%comment%-- start trax# 1-13CREJ --%endcomment%
		%ifvar isHidden%
			%comment%-- set a hidden value --%endcomment%
			<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"> </input>
		%else%
		%comment%-- end trax# 1-13CREJ --%endcomment%

	        <tr>
	            <script>swapRows(); writeTD('row');</script>%value displayName%</td>
	
	            %ifvar isPassword%
	                <script>writeTD('rowdata-l');</script>
			    %comment%----- LG TRAX 1-MHXFJ -----%endcomment%
			    %comment%----- Change password field from "******" to "" -----%endcomment%
			    %comment%----- Added second argument to passwordChange() function -----%endcomment%
			    %comment%----- to support artconnjs.txt for multiple password fields -----%endcomment%
	                    <input size=60
	                           type=password
	                           name=".CPROP.%value -urlencode systemName%"
	                           value=""
	                           onChange="passwordChanged(this.form, '%value -urlencode systemName%')">
	                    </input>
	                </td>
			%comment%----- LG TRAX 1-MHXKO -----%endcomment%
			%comment%----- Added </tr> to put PWD retype on its own line -----%endcomment%
			</tr>
	                <script>swapRows();writeTD('row');</script>Retype %value displayName%</td>
	                <script>writeTD('rowdata-l');</script>
			    %comment%----- LG TRAX 1-MHXFJ -----%endcomment%
			    %comment%----- Change Retype field from "******" to "" -----%endcomment%
	                    <input size=60 type=password name="PWD.CPROP.%value -urlencode systemName%" value=""></input>
	                </td>
	            %else%
	                <script>writeTD('rowdata-l');</script>
	                    %ifvar resourceDomain -notEmpty%
	                        <select name=".CPROP.%value systemName%">
	                            %loop resourceDomain%
	                                <option width=300 value="%value resourceDomain%" %ifvar resourceDomain vequals(defaultValue)%selected="true"%endif%>
	                                    %value resourceDomain%
	                                </option>
	                            %endloop%
	                        </select>
	                    %else%
				%comment%-- LG TRAX 1-N9RJP --%endcomment%
				%comment%-- Code added to support boolean fields added --%endcomment%
	        		%ifvar parameterType equals('boolean')%
	          		    <select name=".CPROP.%value -urlencode systemName%">
	                            <option value="true"  %ifvar defaultValue equals('true')%selected="true"%endif%>true</option>
	                            <option value="false" %ifvar defaultValue equals('false')%selected="true"%endif%>false</option>
	          		    </select></td>
	        		%else%
	                            <input size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td>
				%endif% 
	                    %endif%
	                </td>
	            %endif%
	        </tr>
        %endif%
    %endloop%

%endif%
