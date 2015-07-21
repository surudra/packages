%ifvar listenerData%
    <script>setNavigation('ListResources.dsp', '%value TemplateURL%', 'foo');</script>

    <tr><td colspan=2 class="heading">Listener Properties</td></tr>

    %ifvar readOnly equals('true')%
        %loop listenerData%
			%comment%-- start trax# 1-13CREJ --%endcomment%
			%ifvar isHidden%
				%comment%-- set a hidden value --%endcomment%
				<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value value%"> </input>
			%else%
			%comment%-- end trax# 1-13CREJ --%endcomment%

	            <tr>
	                <script>writeTD('row');</script>%value displayName%</td>
	                <script>writeTD('rowdata-l');swapRows();</script>
	                    %ifvar isPassword%
	                        ******
	                    %else%
	                        %comment%----- TRAX 1-KPWS1 -----%endcomment%
	                        <script>xl("%value value%");</script>
	                    %endif%
	                </td>
	            </tr>
            %endif%
        %endloop%
    %else%
	    %ifvar readOnly equals('some')%
	        %loop listenerData%
				%comment%-- start trax# 1-13CREJ --%endcomment%
				%ifvar isHidden%
					%comment%-- set a hidden value --%endcomment%
					<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value value%"> </input>
				%else%
				%comment%-- end trax# 1-13CREJ --%endcomment%

		            <tr>
		                <script>writeTD('row');</script>%value displayName%</td>
		                <script>writeTD('rowdata-l');swapRows();</script>
		                    %ifvar isPassword%
		                        ******
		                    %else%
		                        %comment%----- TRAX 1-KPWS1 -----%endcomment%
					<script>xl("%value value%");</script>
		                    %endif%
		                </td>
		            </tr>
				%endif%
	        %endloop%
	    %else%
	        %comment%-- edit mode --%endcomment%
	        %loop listenerData%
				%comment%-- start trax# 1-13CREJ --%endcomment%
				%ifvar isHidden%
					%comment%-- set a hidden value --%endcomment%
					<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value value%"> </input>
				%else%
				%comment%-- end trax# 1-13CREJ --%endcomment%
				
		            <tr>
		                <script>writeTD('row');</script>%value displayName%</td>
		                %ifvar isPassword%
		                    <script>writeTD('rowdata-l');swapRows();</script>
			                %comment%-- LG TRAX 1-MHXQN --%endcomment%
				            %comment%-- Removed onBlur="storePassword(this.value)" --%endcomment%
	                        %comment%-- Changed onchange=setPassword() to onchange=passwordChanged() --%endcomment%
	                        %comment%-- Makes this form compatable with other Listener forms --%endcomment%
	                        %comment%-- LG TRAX 1-I49V9 --%endcomment%
	                        %comment%----- Added second argument to passwordChange() function -----%endcomment%
	                        %comment%----- to support artconnjs.txt for multiple password fields -----%endcomment%
		                    <input size=60
		                           type=password
		                           name=".CPROP.%value -urlencode systemName%"
		                           value="******"
		                           onchange= "passwordChanged(this.form, '%value -urlencode systemName%')"</input></td></tr>
		                    <script>writeTD('row');</script>Retype %value displayName%</td>
		                    <script>writeTD('rowdata-l');swapRows();</script>
	                        %comment%-- LG TRAX 1-MHXP3 --%endcomment%
				            %comment%-- Changed retype name to PWD..... to support validateForm() --%endcomment%
		                    <input size=60 type=password name="PWD.CPROP.%value -urlencode systemName%" value="******"></input></td>
		                %else%
		                    %ifvar resourceDomain -notEmpty%
					            <script>writeTD('rowdata-l');swapRows();</script>
		                        <select name=".CPROP.%value systemName%">
		                            %loop resourceDomain%
						                %comment%-- LG TRAX 1-LURUG --%endcomment%
						                %comment%-- Code to show current value as selected value --%endcomment%
		                                <option width = 300 value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>
							                %value resourceDomain%
						                 </option>
		                            %endloop%
		                        </select></td>
		                    %else%
	                            %comment%-- LG TRAX 1-LURUG --%endcomment%
	                            %comment%-- Code to support boolean fields added --%endcomment%
	                            %ifvar parameterType equals('boolean')%
		          		            <script>writeTDspan('rowdata-l');swapRows();</script>      
		          		            <select name=".CPROP.%value -urlencode systemName%">
		                                <option value="true"  %ifvar value equals('true')%selected="true"%endif%>true</option>
		                                <option value="false" %ifvar value equals('false')%selected="true"%endif%>false</option>
		          		            </select></td>
	                             %else%
		    			            <script>writeTDspan('rowdata-l');swapRows();</script>
		                            <input size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input></td>
							     %endif% 
		                    %endif%
		                %endif%
		            </tr>
				%endif%
	        %endloop%
	    %endif%
	%endif%
    <tr><td colspan=2 class="heading">Last Error</td></tr>

    <tr>
        <script>writeTD('row');</script></td><script>writeTD('rowdata-l')</script>%value lastError%</td>
    </tr>
%else%
 	%comment%-- LG TRAX 1-MHXZY --%endcomment%
	%comment%-- Changed word "Connection" to "Listener" --%endcomment%
    <tr><td class="message" colspan=4>Listener properties not found</td></tr>
%endif%
