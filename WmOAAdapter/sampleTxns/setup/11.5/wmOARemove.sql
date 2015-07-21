WHENEVER SQLERROR EXIT FAILURE ROLLBACK

REM=============================================================================
REM Uninstall script used by the webMethods Oracle Applications Adapter.
REM This will remove the view/procedures used by the adapter for 
REM Oracle Apps 11.5.
REM=============================================================================

REM
REM Connect with the APPS user. The user will prompted for the password
REM
CLEAR BUFFER
/
PROMPT Please enter the oracle applications user name and password
ACCEPT DBUSER PROMPT 'Enter username: '
CONNECT &DBUSER
/
REM
REM Delete the packages and bodies
REM
PROMPT
PROMPT Dropping Packages and Bodies...
DROP PACKAGE WM_ERR_SQL_TRANSACTIONS
/

PROMPT
PROMPT Removal completed