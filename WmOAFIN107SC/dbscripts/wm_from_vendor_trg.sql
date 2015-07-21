/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Vendor Outbound in Application Schema  
    * Program Name:         wm_from_vendor_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *					PO_VENDORS
    *					PO_VENDOR_SITES_ALL
    *					PO_VENDOR_CONTACTS
    *					AP_BANK_ACCOUNT_USES_ALL
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
    * Trigger: PO_VENDORS_TRG -> To populate WM_TRACKCHANGES table on I/U
    *	       PO_VENDOR_SITES_ALL_TRG -> To populate WM_TRACKCHANGES on I/U
    *          PO_VENDOR_CONTACTS -> To populate WM_TRACKCHANGES on I/U/D
    *		 AP_BANK_ACCOUNT_USES_ALL -> To populate WM_TRACKCHANGES on I/U
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
     01-NOV-02	   Panchali Samanta   Created
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
on PO_VENDORS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_po_vendors_iu_trg
AFTER INSERT OR UPDATE ON PO_VENDORS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='VENDOR';

BEGIN
     IF INSERTING THEN
     
     	  -- assign data for parent key identifier
     	  
	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.vendor_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='VENDOR INSERT FOR '||:new.vendor_name;
	 p_rec_wm_trackChange.transaction_status:=1;
	 p_rec_wm_trackChange.processed_flag:='N';
	 
	 
	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	 
      END IF;	 
	      	  
     IF UPDATING THEN
      -- assign data for parent key identifier
          	  
     	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.vendor_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='VENDOR UPDATE FOR '||:new.vendor_name;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';
     	 
     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
     
          
     END IF;
     
EXCEPTION 
WHEN OTHERS THEN
Null;
     --
  
END;
/

/*****************************************************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on PO_VENDORS_SITES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/


CREATE OR REPLACE TRIGGER &&apps_user..wm_po_vendor_sites_all_iu_trg
AFTER INSERT OR UPDATE ON PO_VENDOR_SITES_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='VENDOR';

BEGIN
     IF INSERTING THEN
     
     	  -- assign data for parent key identifier
     	  
	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.vendor_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='VENDOR SITE INSERT FOR '||:new.vendor_site_code;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';
	 
	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	 
      END IF;	 
	      	  
     IF UPDATING THEN
      -- assign data for parent key identifier
          	  
     	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.vendor_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='VENDOR SITE UPDATE FOR '||:new.vendor_site_code;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';
     	 
     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
     
          
     END IF;
     --
EXCEPTION 
WHEN OTHERS THEN
Null;
  
END;
/

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
or delete on PO_VENDOR_CONTACTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/


CREATE OR REPLACE TRIGGER &&apps_user..wm_po_vendor_contacts_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON PO_VENDOR_CONTACTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='VENDOR';
v_vendor_id po_vendors.vendor_id%TYPE;

BEGIN
     IF INSERTING THEN
     	
     	  -- Fetch data for Key Identifier
     	  
     	  SELECT vendor_id
	  INTO   v_vendor_id
	  FROM   po_vendor_sites_all
	  WHERE  vendor_site_id = :new.vendor_site_id;
     
     	  -- assign data for parent key identifier
     	  
	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=v_vendor_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='VENDOR CONTACT INSERT FOR '||:new.first_name||' '||:new.middle_name||' '||:new.last_name;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';
	 
	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	 
      END IF;	 
	      	  
     IF UPDATING THEN
     
     -- Fetch data for Key Identifier
          	  
          SELECT vendor_id
     	  INTO   v_vendor_id
     	  FROM   po_vendor_sites_all
	  WHERE  vendor_site_id = :new.vendor_site_id;
	  
      -- assign data for parent key identifier
          	  
     	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=v_vendor_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='VENDOR CONTACT UPDATE FOR '||:new.first_name||' '||:new.middle_name||' '||:new.last_name;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';
     	 
     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
     
          
     END IF;
     --
     
     IF DELETING THEN
     
     -- Fetch data for Key Identifier
     
       SELECT vendor_id
       INTO   v_vendor_id
       FROM   po_vendor_sites_all
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

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on AP_BANK_ACCOUNT_USES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_ap_bank_acc_use_all_iu_trg
AFTER INSERT OR UPDATE ON ap_bank_account_uses_all
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='VENDOR';
v_vendor_id po_vendors.vendor_id%TYPE;

BEGIN
     IF INSERTING THEN
     
     	  --  Check whether data pertaining to Vendor or Vendor Sites is being entered
     	  
     	  IF :new.vendor_id IS NOT NULL OR :new.vendor_site_id IS NOT NULL THEN
     	
     	  -- assign data for parent key identifier
     	  
	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.vendor_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='BANK ACCOUNT INSERTED FOR VENDOR ID: '||:new.vendor_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';
	 
	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	 
	 END IF;
	 
      END IF;	 
	      	  
     IF UPDATING THEN
     
     	-- Check whether data pertaining to Vendor or Vendor Sites is being updated
     
     -- Fetch data for Key Identifier
          	  
          IF :new.vendor_id IS NOT NULL OR :new.vendor_site_id IS NOT NULL THEN
	  
      -- assign data for parent key identifier
          	  
     	 p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.vendor_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='BANK ACCOUNT UPDATED FOR VENDOR ID: '||:new.vendor_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';
     	 
     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	 
	 END IF;
     
          
     END IF;
     --
      
EXCEPTION 
WHEN OTHERS THEN
Null;     
  
END;
/
SHOW ERRORS

