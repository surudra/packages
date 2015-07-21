/*  ***************************************************************************
        $Date:   14 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Disable Triggers for AR Transactions outbound in APPS schema
    * Program Name:         wm_disable_from_artrans.sql
    * Version #:            1.0
    * Title:                Disable Triggers in APPS schema used for AR Transactions Outbound 			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Disable Triggers in Apps schema used for              
    *			     	    AR Transactions Outbound 			
    *
    *    
    * 
    *		
    * Triggers to disable: 		WM_RA_CUSTOMER_TRX_ALL_IU_TRG
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     14-NOV-02	  Gautam Naha   	Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  define apps_user  = '&apps_user' -- APPS User Id
  define appspwd	    = '&appspwd'  -- APPS Password
  define DB_Name    = "&DBString" -- Database Instance in Oracle Apps 
  

  prompt Program : wm_disable_from_artrans.sql

  connect &&apps_user/&&appspwd@&&DB_Name

REM "Disabling Triggers....."

ALTER TRIGGER WM_RA_CUSTOMER_TRX_ALL_IU_TRG DISABLE
/

SHOW ERRORS

SPOOL OFF

exit;