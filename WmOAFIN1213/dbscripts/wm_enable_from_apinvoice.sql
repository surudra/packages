/*  ***************************************************************************
        $Date:   24 Sep 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for AP Invoices outbound in APPS schema
    * Program Name:         wm_enable_from_apinvoice.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for AP Invoices Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for AP Invoices      
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to enable: 	WM_AP_INVOICE_DIST_IU_TRG
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
  define DbString	   = "&DBString" -- Database Instance in Oracle Apps 
  

  prompt Program : wm_enable_from_apinvoice.sql

  connect &&apps_user/&&appspwd@&&DbString

REM "Enabling Trigger For Ap Invoices....."

ALTER TRIGGER WM_AP_INVOICE_DIST_IU_TRG ENABLE;
/

SHOW ERRORS

SPOOL OFF

exit;