WHENEVER SQLERROR EXIT FAILURE ROLLBACK

REM=============================================================================
REM Main setup script used by the webMethods Oracle Applications Adapter.  
REM This will install needed view/procedures for Oracle Apps 11.5.
REM This must be run on each Oracle DBMS you wish to run the adapter against.
REM=============================================================================

REM
REM Connect with the APPS user. The user will prompted for the password
REM
CLEAR BUFFER

PROMPT Please enter the oracle applications user name and password
ACCEPT DBUSER PROMPT 'Enter username: '
CONNECT &DBUSER

REM
REM Run our install scripts
REM
@wmOAARCustErrSQL.pls

PROMPT
PROMPT Installation completed