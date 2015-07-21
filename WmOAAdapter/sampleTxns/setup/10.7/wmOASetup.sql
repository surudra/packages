REM=============================================================================
REM Main setup script to install needed view/procedures for the webMethods
REM Oracle Applications adapter. This must be run on each Oracle DBMS you 
REM wish to run the adapter against.
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
@wmOAasnom.sql
@wmOAinom.sql
@wmOApocom.sql
@wmOApoom.sql
@wmOAasnop.pls
@wmOAinop.pls
@wmOApocop.pls
@wmOApoop.pls

PROMPT
PROMPT Installation completed