REM=============================================================================
REM Script to remove all view/procedures/tables associated with the OAIM setup.
REM=============================================================================
WHENEVER SQLERROR EXIT FAILURE ROLLBACK
/
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
DROP PACKAGE WM_POO_UPDATE
/
DROP PACKAGE WM_POCO_UPDATE
/
DROP PACKAGE WM_INO_TRANSACTION
/

PROMPT
PROMPT Dropping Views...
DROP VIEW WM_PYO_PAYMENT_V
/
DROP VIEW WM_PYO_INVOICE_V
/
DROP VIEW WM_POO_HEADERS_V
/
DROP VIEW WM_POO_LINES_V
/
DROP VIEW WM_POO_SHIPMENTS_V
/
DROP VIEW WM_POCO_HEADERS_V
/
DROP VIEW WM_POCO_LINES_V
/
DROP VIEW WM_POCO_SHIPMENTS_V
/
DROP VIEW WM_INO_HEADER_V
/
DROP VIEW WM_INO_LINE_V
/
DROP VIEW WM_INO_LINE_TAX_V
/

PROMPT
PROMPT Dropping Tables...
DROP TABLE WM_CE_FORECAST_EXT
/

PROMPT
PROMPT Removal completed