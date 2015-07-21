/*  ***************************************************************************
        $Date:   24 Sep 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Disable Triggers for Inventory Items Outbound in APPS schema
    * Program Name:         wm_disable_from_invitem.sql
    * Version #:            1.0
    * Title:                Disable Triggers in APPS schema used for Inventory Items Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Disable Triggers in Apps schema used for              
    *			     	     Inventory Items Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to disable: 	wm_mtl_system_items_iu_trg,wm_mtl_item_categories_iud_trg,wm_mtl_item_revisions_iu_trg
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
     21-OCT-02	   Sudip Chaudhuri	   Created
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
  

  prompt Program : wm_disable_from_invitem.sql

  connect &&apps_user/&&appspwd@&&DB_Name

REM "Disabling Triggers....."

ALTER TRIGGER wm_mtl_system_items_iu_trg DISABLE;


ALTER TRIGGER wm_mtl_item_categories_iud_trg DISABLE;


ALTER TRIGGER wm_mtl_item_revisions_iu_trg DISABLE;


SHOW ERRORS

SPOOL OFF

exit;