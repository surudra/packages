/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Vendor outbound in APPS schema
    * Program Name:         wm_enable_from_vendor.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for
    *				    Vendor outbound Transactions
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used 
    *			     	     for Vendor outbound Transactions
    *
    *    
    * 
    *		
    * Triggers to enable: WM_PO_VENDOR_IU_TRG
    *				  WM_PO_VENDOR_SITES_ALL_IU_PTRG
    *				  WM_PO_VENDOR_CONTACTS_IUD_TRG
    *				  WM_AP_BANK_ACC_USE_ALL_IU_TRG
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     05-NOV-02	Panchali Samanta	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  prompt Program : wm_enable_from_vendor.sql

  connect &&apps_user/&&appspwd@&&DBString

REM "Enabling Triggers....."

ALTER TRIGGER WM_PO_VENDORS_IU_TRG ENABLE
/
ALTER TRIGGER WM_PO_VENDOR_SITES_ALL_IU_TRG
ENABLE
/
ALTER TRIGGER WM_PO_VENDOR_CONTACTS_IUD_TRG
ENABLE
/
ALTER TRIGGER WM_AP_BANK_ACC_USE_ALL_IU_TRG
ENABLE
/
SHOW ERRORS

