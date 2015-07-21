/*  ***************************************************************************
        $Date:   28 Sep 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for AR Transactions outbound in APPS schema
    * Program Name:         wm_enable_from_artrans.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for AR Transactions Outbound 			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for AR Transactions      
    *			     	     Outbound 			
    *
    *    
    * 
    *		
    * Triggers to enable: 		WM_RA_CUSTOMER_TRX_ALL_IU_TRG
    *					
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     28-SEP-02	  Gautam Naha   	Created
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
  

  prompt Program : wm_enable_from_artrans.sql

  connect &&apps_user/&&appspwd@&&DB_Name

REM "Enabling Triggers....."

ALTER TRIGGER WM_RA_CUSTOMER_TRX_ALL_IU_TRG ENABLE
/

SHOW ERRORS

SPOOL OFF

exit;