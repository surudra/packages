		%ifvar message%
			%switch status%
			%case 'Success'%
				<script>writeMessage("%value -htmlcode message%");</script>
			%case 'Error'%
				<script>writeError("%value -htmlcode message%");</script>
			%case 'Warning'%
				<script>writeWarning("%value -htmlcode message%");</script>
			%case%
				<script>writeMessage("%value -htmlcode message%");</script>
			%end%
		%endif%
