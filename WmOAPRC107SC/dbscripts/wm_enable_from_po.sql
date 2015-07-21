/*  ***************************************************************************
        $Date:   14 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Purchase Order outbound in APPS schema
    * Program Name:         wm_enable_from_po.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for Purchase Order Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for Purchase Order      
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to enable: 	WM_PO_HEADERS_ALL_IU_TRG
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     14-NOV-02	  Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  define apps_user  = '&apps_user' -- APPS User Id
  define appswd	    = '&appspwd'  -- APPS Password
  define DB_Name    = "&DBString" -- Database Instance in Oracle Apps 
  

  prompt Program : wm_enable_from_po.sql

  connect apps_user/&&apppwd@&&DbString

REM "Enabling Trigger For Purchase Orders....."

ALTER TRIGGER WM_PO_HEADERS_ALL_IU_TRG ENABLE;
/

SHOW ERRORS

SPOOL OFF

exit;