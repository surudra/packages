/*  ***************************************************************************
    *    $Date:   17 Oct 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Pick Details Outbound in Application Schema  
    * Program Name:         wm_from_pickdetails_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				MTL_MATERIAL_TRANSACTIONS_TEMP		ON D
    *			
    *
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
     17-OCT-02	   Gautam Naha		   Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON

 prompt Program : wm_from_pickdetails_trg.SQL

 CONNECT &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is a delete
on MTL_MATERIAL_TRANSACTIONS_TEMP table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_mtl_material_txn_temp_d_trg
AFTER DELETE ON  MTL_MATERIAL_TRANSACTIONS_TEMP
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='PICKDETAIL';
v_header_id		   mtl_txn_request_lines.line_id%TYPE;


BEGIN

	
         IF DELETING THEN 
		 
          	-- assign data for parent key identifier
    
             p_rec_wm_trackChange.transaction_type:=c_transaction_type;
             p_rec_wm_trackChange.transaction_id:=:OLD.transaction_header_id;
             p_rec_wm_trackChange.date_created:=SYSDATE;
             p_rec_wm_trackChange.comments:='PICK DETAILS INSERT FOR '|| :OLD.transaction_header_id;
             p_rec_wm_trackChange.transaction_status:=1;
        	 p_rec_wm_trackChange.processed_flag:='N';
        
             -- Call Procedure to Insert into wm_track_changes
        	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
    
    
         END IF;
		 
EXCEPTION
	WHEN OTHERS THEN NULL;

END;
/

show errors





