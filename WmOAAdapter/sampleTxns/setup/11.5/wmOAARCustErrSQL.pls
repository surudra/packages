WHENEVER SQLERROR EXIT FAILURE ROLLBACK
/
REM=============================================================================
REM Install script used by the webMethods Oracle Applications Adapter. This is  
REM called by the wmOASetup.sql script. This script will install the necessary 
REM procedures used by the error SQL portion of IS-to-Oracle transactions.
REM=============================================================================

CREATE OR REPLACE PACKAGE WM_ERR_SQL_TRANSACTIONS AS

PROCEDURE WM_IS_ARCUSTOMERS_ERROR  
           ( WM_USER                  IN VARCHAR2,
             ORIG_SYSTEM_CUSTOMER_REF IN VARCHAR2,
             ERROR_EXISTS             OUT NUMBER);

END;

/
CREATE OR REPLACE PACKAGE BODY WM_ERR_SQL_TRANSACTIONS AS

/**
 * This procedure will check all Open Interface tables for the
 * Customer interface in the Receivables module for import errors.
 * The user can query for errors based on the created by user and 
 * the legacy customer reference.
 *
 * Parameters:
 *  WM_USER - IN REQUIRED - The FND_USER_VIEW is searched 
 *   to find the corresponding user ID. The Interface Table 
 *   CREATED_BY column is matched against this user ID. The 
 *   parameter may contain %. Since CREATED_BY is a required 
 *   column it is defaulted to '%'.
 *
 *  ORIG_SYSTEM_CUSTOMER_REF - IN REQUIRED - The Interface Table 
 *   ORIG_SYSTEM_CUSTOMER_REF column is matched against this 
 *   value. The parameter may contain %. Since 
 *   ORIG_SYSTEM_CUSTOMER_REF is a required column it is 
 *   defaulted to '%'.
 *
 *  ERROR_EXISTS - OUT - The value will be set to 0 if no errors
 *   are found. 1 will be returned if any errors are found.
 **/
PROCEDURE WM_IS_ARCUSTOMERS_ERROR  
           ( WM_USER                  IN VARCHAR2 DEFAULT '%',
             ORIG_SYSTEM_CUSTOMER_REF IN VARCHAR2 DEFAULT '%',
             ERROR_EXISTS             OUT NUMBER) IS
BEGIN

  ERROR_EXISTS := 0;

  SELECT COUNT(*) INTO ERROR_EXISTS
  FROM RA_CUSTOMERS_INTERFACE_ALL raci, 
       FND_USER_VIEW
  WHERE
    FND_USER_VIEW.USER_NAME like WM_USER AND
    raci.INTERFACE_STATUS is not null AND 
    raci.ORIG_SYSTEM_CUSTOMER_REF LIKE ORIG_SYSTEM_CUSTOMER_REF AND
    raci.CREATED_BY = FND_USER_VIEW.USER_ID;

  IF ERROR_EXISTS = 0 THEN
    SELECT COUNT(*) INTO ERROR_EXISTS
    FROM RA_CUSTOMER_PROFILES_INT_ALL rapi,
         FND_USER_VIEW
    WHERE
      FND_USER_VIEW.USER_NAME like WM_USER AND
      rapi.INTERFACE_STATUS is not null AND 
      rapi.ORIG_SYSTEM_CUSTOMER_REF LIKE ORIG_SYSTEM_CUSTOMER_REF AND
      rapi.CREATED_BY = FND_USER_VIEW.USER_ID;
  END IF;

  IF ERROR_EXISTS = 0 THEN
    SELECT COUNT(*) INTO ERROR_EXISTS
    FROM RA_CONTACT_PHONES_INT_ALL raphone,
         FND_USER_VIEW
    WHERE
      FND_USER_VIEW.USER_NAME like WM_USER AND
      raphone.INTERFACE_STATUS is not null AND 
      raphone.ORIG_SYSTEM_CUSTOMER_REF LIKE ORIG_SYSTEM_CUSTOMER_REF AND
      raphone.CREATED_BY = FND_USER_VIEW.USER_ID;
  END IF;

  IF ERROR_EXISTS = 0 THEN
    SELECT COUNT(*) INTO ERROR_EXISTS
    FROM RA_CUSTOMER_BANKS_INT_ALL racbi,
         FND_USER_VIEW
    WHERE
      FND_USER_VIEW.USER_NAME like WM_USER AND
      racbi.INTERFACE_STATUS is not null AND 
      racbi.ORIG_SYSTEM_CUSTOMER_REF LIKE ORIG_SYSTEM_CUSTOMER_REF AND
      racbi.CREATED_BY = FND_USER_VIEW.USER_ID;
  END IF;

  IF ERROR_EXISTS = 0 THEN
    SELECT COUNT(*) INTO ERROR_EXISTS
    FROM RA_CUST_PAY_METHOD_INT_ALL racpmi,
         FND_USER_VIEW
    WHERE
      FND_USER_VIEW.USER_NAME like WM_USER AND
      racpmi.INTERFACE_STATUS is not null AND 
      racpmi.ORIG_SYSTEM_CUSTOMER_REF LIKE ORIG_SYSTEM_CUSTOMER_REF AND
      racpmi.CREATED_BY = FND_USER_VIEW.USER_ID;
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm||'. '||
    'ERROR: WM_ERR_SQL_TRANSACTIONS.WM_IS_ARCUSTOMERS_ERROR '||
    'WM_USER = '||WM_USER ||
    ' ORIG_SYSTEM_CUSTOMER_REF = '||WM_USER);
    app_exception.raise_exception;

END WM_IS_ARCUSTOMERS_ERROR;

END;
/