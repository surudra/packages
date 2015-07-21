/*  ***************************************************************************
    *    $Date:   24 Sep 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Inventory Items Outbound in Application Schema  
    * Program Name:         wm_from_invitem_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *					MTL_SYSTEM_ITEMS_B, MTL_ITEM_CATEGORIES, MTL_ITEM_REVISIONS
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
    * Trigger: WM_MTL_SYSTEM_ITEMS_B_IU_TRG 		-> To populate WM_TRACKCHANGES table on I/U
    *          WM_MTL_ITEM_CATEGORIES_IUD_TRG	        -> To populate WM_TRACKCHANGES table on I/U/D
    *	       WM_MTL_ITEM_REVISIONS_IU_TRG		-> To populate WM_TRACKCHANGES table on I/U
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
     21-Oct-02	   Sudip Chaudhuri	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_invitem_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on MTL_SYSTEM_ITEMS_B table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_mtl_system_items_b_iu_trg
AFTER INSERT OR UPDATE ON MTL_SYSTEM_ITEMS_B
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='ITEM';


BEGIN

	
	IF INSERTING THEN
     
     	  	-- assign data for parent key identifier
     	  
	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 	p_rec_wm_trackChange.transaction_id:=:new.inventory_item_id||'-'||:new.organization_id;
	 	p_rec_wm_trackChange.date_created:=SYSDATE;
	 	p_rec_wm_trackChange.comments:='Inventory Item '||:new.inventory_item_id||' for Organization '||:new.organization_id||' CREATED';
	 	p_rec_wm_trackChange.transaction_status:=1;
	 	p_rec_wm_trackChange.processed_flag:='N';
	 
	 
      	END IF;	 
	      	  
     	IF UPDATING THEN
      		-- assign data for parent key identifier
          	  
     	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=:new.inventory_item_id||'-'||:new.organization_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='Inventory Item '||:new.inventory_item_id||' for Organization '||:new.organization_id||' UPDATED';
     	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';
     	 
     	END IF;

     	 	-- Call Procedure to Insert into wm_track_changes
	 	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

     
EXCEPTION 
WHEN OTHERS THEN
Null;
     --
  
END;
/

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on MTL_ITEM_CATEGORIES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_mtl_item_categories_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON MTL_ITEM_CATEGORIES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='ITEM';


BEGIN

	
	IF INSERTING THEN
     
     	  	-- assign data for parent key identifier
     	  
	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 	p_rec_wm_trackChange.transaction_id:=:new.inventory_item_id||'-'||:new.organization_id;
	 	p_rec_wm_trackChange.date_created:=SYSDATE;
	 	p_rec_wm_trackChange.comments:='Category for Inventory Item '||:new.inventory_item_id||' for Organization '||:new.organization_id||' CREATED';
	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';
	 
	 
      	END IF;	 
	      	  
     	IF UPDATING THEN
      		-- assign data for parent key identifier
          	  
     	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=:new.inventory_item_id||'-'||:new.organization_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='Category for Inventory Item '||:new.inventory_item_id||' for Organization '||:new.organization_id||' UPDATED';
     	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';
     	 
     	END IF;
     	
     	IF DELETING THEN
	      		-- assign data for parent key identifier
	          	  
	     	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	     	 	p_rec_wm_trackChange.transaction_id:=:old.inventory_item_id||'-'||:old.organization_id;
	     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
	     	 	p_rec_wm_trackChange.comments:='Category for Inventory Item '||:old.inventory_item_id||' for Organization '||:old.organization_id||' DELETED';
	     	 	p_rec_wm_trackChange.transaction_status:=0;
		 	p_rec_wm_trackChange.processed_flag:='N';
	     	 
     	END IF;

     	 	-- Call Procedure to Insert into wm_track_changes
	 	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

     
EXCEPTION 
WHEN OTHERS THEN
Null;
     --
  
END;
/

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on MTL_ITEM_REVISIONS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_mtl_item_revisions_iu_trg
AFTER INSERT OR UPDATE ON MTL_ITEM_REVISIONS_B
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
v_transaction_type VARCHAR2(100):='ITEM';


BEGIN

	
	IF INSERTING THEN
     
     	  	-- assign data for parent key identifier
     	  
	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
	 	p_rec_wm_trackChange.transaction_id:=:new.inventory_item_id||'-'||:new.organization_id;
	 	p_rec_wm_trackChange.date_created:=SYSDATE;
	 	p_rec_wm_trackChange.comments:='Revision for Inventory Item '||:new.inventory_item_id||' for Organization '||:new.organization_id||' CREATED';
	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';
	 
	 
      	END IF;	 
	      	  
     	IF UPDATING THEN
      		-- assign data for parent key identifier
          	  
     	 	p_rec_wm_trackChange.transaction_type:=v_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=:new.inventory_item_id||'-'||:new.organization_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='Revision for Inventory Item '||:new.inventory_item_id||' for Organization '||:new.organization_id||' UPDATED';
     	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';
     	 
     	END IF;

     	 	-- Call Procedure to Insert into wm_track_changes
	 	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

     
EXCEPTION 
WHEN OTHERS THEN
Null;
     --
  
END;
/


SHOW ERRORS

