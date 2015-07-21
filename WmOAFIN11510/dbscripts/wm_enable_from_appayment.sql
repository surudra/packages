/*  ***************************************************************************
        $Date:   24 Sep 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Ap Payments outbound in APPS schema
    * Program Name:         wm_enable_from_appayment.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for Ap Payments Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for Ap Payments      
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to enable: 	WM_AP_PAYMENTS_IU_TRG
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     24-SEP-02	  Rajib Naha		   Created
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
  

  prompt Program : wm_enable_from_appayment.sql

  connect &&apps_user/&&appspwd@&&DB_Name

REM "Enabling Trigger For Ap Payments....."

ALTER TRIGGER WM_AP_PAYMENTS_IU_TRG ENABLE
/

SHOW ERRORS

SPOOL OFF

exit;