/*  ***************************************************************************
    *    $Date:   24 Sep 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications
    * Process Name:         Create Custom triggers for AP Invoice Outbound in Application Schema  
    * Program Name:         wm_from_apinvoice_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *					AP_INVOICE_DISTRIBUTIONS_ALL
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
    * Trigger: WM_AP_INVOICE_DIST_IU_TRG 		-> To populate WM_TRACKCHANGES table on I/U
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
     24-Sep-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_apinvoice_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on AP_INVOICES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_ap_invoice_dist_iu_trg
AFTER INSERT OR UPDATE ON AP_INVOICE_DISTRIBUTIONS_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='APINVOICE';
v_invoice_num VARCHAR2(50);
v_match_status_flag VARcHAR2(1);


BEGIN

	-- Fetch Data for key identifier
	
	SELECT	invoice_num
 	INTO	v_invoice_num
 	FROM 	AP_INVOICES_ALL
 	WHERE 	invoice_id =:NEW.invoice_id;


     	IF :new.match_status_flag = 'A' THEN
	
	IF INSERTING THEN
     
     	  	-- assign data for parent key identifier
     	  
	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 	p_rec_wm_trackChange.transaction_id:=:new.invoice_id;
	 	p_rec_wm_trackChange.date_created:=SYSDATE;
	 	p_rec_wm_trackChange.comments:='APPROVED AP INVOICE '||v_invoice_num||' CREATED.';
	 	p_rec_wm_trackChange.transaction_status:=1;
	 	p_rec_wm_trackChange.processed_flag:='N';
	 
	 
      	END IF;	 
	      	  
     	IF UPDATING THEN
      		-- assign data for parent key identifier
          	  
     	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=:new.invoice_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='AP INVOICE '||v_invoice_num||' UPDATED AND APPROVED.';
     	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';
     	 
     	END IF;

	-- Call Procedure to Insert into wm_track_changes
 	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	END IF;     

	select decode(:old.match_status_flag,'','X',null,'X','N','N','T','T','S','S','A','A','X') 
	into v_match_status_flag from dual;

     	IF :new.match_status_flag = 'S' AND v_match_status_flag = 'X' THEN

     	IF UPDATING THEN
      		-- assign data for parent key identifier
          	  
     	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=:new.invoice_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='AP INVOICE '||v_invoice_num||' INSERTED AND APPROVED.';
     	 	p_rec_wm_trackChange.transaction_status:=1;
	 	p_rec_wm_trackChange.processed_flag:='N';
     	 
     	END IF;

 	-- Call Procedure to Insert into wm_track_changes
 	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	END IF;     


EXCEPTION 
WHEN OTHERS THEN
Null;
     --
  
END;
/

SHOW ERRORS

