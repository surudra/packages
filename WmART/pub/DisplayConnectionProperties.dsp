%comment%----- Displays connection type parameters -----%endcomment%
%comment%----- LG TRAX 1-MHXZY -----%endcomment%
%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
%comment%----- display lines in form have alternating colors -----%endcomment%
%ifvar parameters%
    <script>resetRows();</script>
    <script>setNavigation('ListAdapterConnTypes.dsp', '%value TemplateURL%', 'foo');</script>

    <tr>
        %include GetISPackages.dsp%
        <script>swapRows();writeTD('row');</script>Folder Name</td>
        <script>writeTD('rowdata-l');</script>
        <input size=30 name="resourceFolderName" value="%value -urlencode resourceFolderName%"></input></td>
    </tr>

    <tr>
        <script>swapRows();writeTD('row');</script>Connection Name</td>
        <script>writeTD('rowdata-l');</script>
        <input size=30 name="resourceName" value="%value -urlencode resourceName%"></input></td>
    </tr>

    <tr><td class="heading" colspan=2>Connection Properties</td></tr>

    %loop parameters%
	    %comment%-- start trax# 1-122V6J --%endcomment%
	    %ifvar isHidden%
		%comment%-- set a hidden value --%endcomment%
		<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"> </input>
	    %else%
	    %comment%-- end trax# 1-122V6J --%endcomment%
	    
	        <tr>
	            <script>writeTD('row');</script>%value displayName%</td>
	 
	            %ifvar isPassword%
	                <script>writeTD('rowdata-l');swapRows();</script>
			%comment%----- LG TRAX 1-BKBFM -----%endcomment%
			%comment%----- Change password field from "******" to "" -----%endcomment%
			%comment%----- LG TRAX 1-I49V9 -----%endcomment%
			%comment%----- Added second argument to passwordChange() function -----%endcomment%
			%comment%----- to support artconnjs.txt for multiple password fields -----%endcomment%
	                <input size=60 
	                       type=password
	                       onChange="return passwordChanged(this.form, '%value -urlencode systemName%')"
	                       name=".CPROP.%value -urlencode systemName%"
	                       value=""></input></td></tr>
	
	                <script>writeTD('row');</script>Retype %value displayName%</td>
	                <script>writeTD('rowdata-l'); swapRows();</script>
			%comment%----- LG TRAX 1-BKBFM -----%endcomment%
			%comment%----- Change Retype field from "******" to "" -----%endcomment%
	                <input size=60
	                       type=password
	                       name="PWD.CPROP.%value -urlencode systemName%"
	                       value=""></input></td></tr>
	            %else%
	                <script>writeTD('rowdata-l'); swapRows();</script>
	                    %ifvar resourceDomain -notEmpty%
	                        <select name=".CPROP.%value systemName%">
	                            %loop resourceDomain%
	                                <option width=300 value="%value resourceDomain%">%value resourceDomain%</option>
	                            %endloop%
	                        </select>
	                    %else%
	                        <input size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input>
	                    %endif%
	                </td>
	            %endif%
	        </tr>
        %endif%
    %endloop%
%endif%
