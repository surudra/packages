/*  ***************************************************************************
    *    $Date:   26 Nov 2002 10:56:36  $
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
    *				SO_PICKING_HEADERS_ALL		ON U
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
     26-NOV-02	   Gautam Naha		   Created
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

Trigger to populate the table WM_TRACKCHANGES when there is an update
on SO_PICKING_HEADERS_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_so_picking_headers_u_trg
AFTER  UPDATE ON  SO_PICKING_HEADERS_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW  WHEN (NEW.status_code='CLOSED') 
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='PICKDETAIL';

BEGIN

		IF UPDATING THEN 
		
    		 
    		  IF :OLD.STATUS_CODE <> 'CLOSED' THEN
    		 
                      	-- assign data for parent key identifier
                
                         p_rec_wm_trackChange.transaction_type:=c_transaction_type;
                         p_rec_wm_trackChange.transaction_id:=:NEW.picking_header_id;
                         p_rec_wm_trackChange.date_created:=SYSDATE;
                         p_rec_wm_trackChange.comments:='PICK DETAILS INSERT FOR '|| :NEW.picking_header_id;
                         p_rec_wm_trackChange.transaction_status:=1;
                    	 p_rec_wm_trackChange.processed_flag:='N';
                    
                         -- Call Procedure to Insert into wm_track_changes
                    	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
            
              END IF;
		   
		END IF;
		 
EXCEPTION
	WHEN OTHERS THEN NULL;

END;
/

show errors





