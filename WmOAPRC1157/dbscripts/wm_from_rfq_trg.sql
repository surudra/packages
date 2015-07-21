/*  ***************************************************************************
    *    $Date:   28 Nov 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for RFQ Outbound in Application Schema  
    * Program Name:         wm_from_rfq_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *					PO_RFQ_VENDORS
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
    * Trigger: wm_po_rfq_vendors_iu_trg	 -> To populate WM_TRACKCHANGES table on I/U
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
     28-Nov-02	Koushik Chakraborty	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_rfq_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on PO_RFQ_VENDORS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_po_rfq_vendors_iu_trg
AFTER INSERT OR UPDATE ON PO_RFQ_VENDORS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW WHEN (new.print_count<>nvl(old.print_count,-1) and new.print_count is not null)
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='RFQ';

BEGIN
	
	IF :new.print_count = 1 THEN
     
     	  	-- assign data for parent key identifier
     	  
	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 	p_rec_wm_trackChange.transaction_id:=:new.po_header_id||'-'||:new.vendor_site_id;
	 	p_rec_wm_trackChange.date_created:=SYSDATE;
	 	p_rec_wm_trackChange.comments:='RFQ INSERT FOR '||:new.po_header_id||'-'||:new.vendor_site_id;
	 	p_rec_wm_trackChange.transaction_status:=1;
	 	p_rec_wm_trackChange.processed_flag:='N';

		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	 
	ELSIF :new.print_count > 1 THEN 
      		-- assign data for parent key identifier
          	  
     	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=:new.po_header_id||'-'||:new.vendor_site_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='RFQ UPDATE FOR '||:new.po_header_id||'-'||:new.vendor_site_id;
     	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';
     	 	 	
		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

     	END IF;

     	 	-- Call Procedure to Insert into wm_track_changes
EXCEPTION 
	WHEN OTHERS THEN
	Null;
END;
/

SHOW ERRORS

