/*  ***************************************************************************
        $Date:   24 Sep 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Inventory Item outbound in APPS schema
    * Program Name:         wm_enable_from_invitem.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for Inventory Item  Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for Inventory Item      
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to enable: 	wm_mtl_system_items_b_iu_trg,wm_mtl_item_categories_iud_trg,wm_mtl_item_revisions_iu_trg
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     21-OCT-02	  Sudip Chaudhuri	   Created
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
  

  prompt Program : wm_enable_from_invitem.sql

  connect &&apps_user/&&appspwd@&&DB_Name

REM "Enabling Trigger For Item Outbound....."

ALTER TRIGGER wm_mtl_item_categories_iud_trg ENABLE
/


SHOW ERRORS

SPOOL OFF

exit;