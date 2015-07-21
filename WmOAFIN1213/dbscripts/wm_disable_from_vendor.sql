/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Disable Triggers for Vendor outbound in APPS schema
    * Program Name:         wm_disable_from_vendor.sql
    * Version #:            1.0
    * Title:                Disable Triggers in APPS schema used for Vendor Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Disable Triggers in Apps schema used for              
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to disable: 
    *				   WM_PO_VENDOR_CONTACTS_IUD_TRG
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  define apps_user  = '&apps_user' -- APPS User Id
  define appswd	    = '&appspwd'  -- APPS Password
  define DB_Name    = "&DBString" -- Database Instance in Oracle Apps 
  

  prompt Program : wm_disable_from_vendor.sql

  connect apps_user/&&apppwd@&&DbString

REM "Disabling Triggers....."

ALTER TRIGGER WM_PO_VENDOR_CONTACTS_IUD_TRG
DISABLE;
/

SHOW ERRORS
