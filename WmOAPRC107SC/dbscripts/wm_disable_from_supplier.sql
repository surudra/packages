/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Disable Triggers for Supplier outbound in APPS schema
    * Program Name:         wm_disable_from_vendor.sql
    * Version #:            1.0
    * Title:                Disable Triggers in APPS schema used for Suplier Outbound Transactions			
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
    * Triggers to disable: WM_PO_SUPPLIER_IU_TRG
    *			   WM_PO_SUPP_SITES_ALL_IU_TRG 
    *			   WM_PO_SUPP_CONTACTS_IUD_TRG 
    *			   WM_AP_BK_SUP_AC_USE_ALL_IU_TRG 
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     05-NOV-02	   Panchali Samanta   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  define apps_user  = '&apps_user' -- APPS User Id
  define appspwd	  = '&appspwd'  -- APPS Password
  define DBString   = '&DBString' -- Database Instance in Oracle Apps 
  

  prompt Program : wm_disable_from_supplier.sql

  connect &&apps_user/&&appspwd@&&DbString

REM "Disabling Triggers....."

ALTER TRIGGER WM_PO_SUPPLIER_IU_TRG DISABLE
/
ALTER TRIGGER WM_PO_SUPP_SITES_ALL_IU_TRG
DISABLE
/
ALTER TRIGGER WM_PO_SUPP_CONTACTS_IUD_TRG
DISABLE
/
ALTER TRIGGER WM_AP_BK_SUP_AC_USE_ALL_IU_TRG
DISABLE
/


SHOW ERRORS

SPOOL OFF

