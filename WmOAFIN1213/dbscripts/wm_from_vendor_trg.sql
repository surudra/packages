/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   2.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Vendor Outbound in Application Schema  
    * Program Name:         wm_from_vendor_trg_ver2_0.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *                    AP_SUPPLIERS
    *                    AP_SUPPLIER_SITES_ALL
    *                    AP_SUPPLIER_CONTACTS
    *                    AP_BANK_ACCOUNT_USES_ALL
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *        
    * Trigger:
    *
    * Restart Information:      
    *
    *
    *
    * Flexfields Used:          
    *
    *
    *
    * Value Sets Used:          
    *
    *
    * Input Parameters:     
    *         
    *           Param1: &SpoolFile     
    *           Param2: &Apps User Password
    *          
    *   
    *
    * Menu Responsibilities and path: 
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
     12-AUG-02       Sudip Kumar Chaudhuri   Created
     24-MAR-14       Vijayanand                    modified - retain only ON DELETE triggers
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_vendor_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."



/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
or delete on AP_SUPPLIER_CONTACTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/


CREATE OR REPLACE TRIGGER &&apps_user..wm_po_vendor_contacts_iud_trg
--AFTER INSERT OR UPDATE OR DELETE ON AP_SUPPLIER_CONTACTS   -- vijayanand ver 2.0
AFTER INSERT OR UPDATE OR DELETE ON AP_SUPPLIER_CONTACTS  -- vijayanand ver 2.0
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='VENDOR';
v_vendor_id po_vendors.vendor_id%TYPE;

BEGIN

     
     IF DELETING THEN
     
     -- Fetch data for Key Identifier
     
       SELECT vendor_id
       INTO   v_vendor_id
       FROM   AP_SUPPLIER_SITES_ALL
       WHERE  vendor_site_id = :old.vendor_site_id;
       
     -- assign data for parent key identifier
                     
     p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     p_rec_wm_trackChange.transaction_id:=v_vendor_id;
     p_rec_wm_trackChange.date_created:=SYSDATE;
     p_rec_wm_trackChange.comments:='VENDOR CONTACT DELETE FOR '||:old.first_name||' '||:old.middle_name||' '||:old.last_name;
     p_rec_wm_trackChange.transaction_status:=0;
     p_rec_wm_trackChange.processed_flag:='N';
     
     -- Call Procedure to Insert into wm_track_changes
     wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
     
     END IF;
     
EXCEPTION 
WHEN OTHERS THEN
Null;     
  
END;
/

SHOW ERRORS

