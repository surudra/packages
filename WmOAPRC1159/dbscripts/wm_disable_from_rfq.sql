/*  ***************************************************************************
        $Date:   28 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Disable Triggers for RFQ Outbound in APPS schema
    * Program Name:         wm_disable_from_rfq.sql
    * Version #:            1.0
    * Title:                Disable Triggers in APPS schema used for RFQ Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Disable Triggers in Apps schema used for              
    *			     	     RFQ Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to disable: 	wm_po_rfq_vendors_iu_trg 
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
     28-NOV-02	   Rajib Naha		   Created
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
  

  prompt Program : wm_disable_from_rfq.sql

  connect &&apps_user/&&appspwd@&&DB_Name

REM "Disabling Triggers....."

ALTER TRIGGER wm_po_rfq_vendors_iu_trg DISABLE;


SHOW ERRORS

exit;