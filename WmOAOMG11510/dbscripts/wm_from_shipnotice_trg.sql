/*  ***************************************************************************
    *    $Date:   30 Sep 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Advance Ship Notice Outbound in Application Schema  
    * Program Name:         wm_from_shipnotice_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				WSH_DELIVERY_DETAIL		ON U
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
     24-OCT-02	 Panchali Samanta        Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_shipnotice_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an update on WSH_DELIVERY_DETAIL table so that the Released Status is 'Shipped' and gives a call to WEB_TRANSACTION procedure to populate WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_delivery_detail_u_trg
AFTER UPDATE OF RELEASED_STATUS ON WSH_DELIVERY_DETAILS
FOR EACH ROW
WHEN (new.released_status = 'C' AND new.source_code = 'OE' )
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type   VARCHAR2(100):='ASN';

BEGIN

      -- assign data for parent key identifier
	IF :old.released_status <> 'C' THEN
	 	p_rec_wm_trackChange.transaction_type := c_transaction_type;
 		p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';

 		p_rec_wm_trackChange.transaction_id := 
			:new.source_line_id;
	 	p_rec_wm_trackChange.comments:=
			'DELIVERY DETAIL SHIPPED FOR ORDER LINE '|| 
				:new.source_line_id;
 		p_rec_wm_trackChange.transaction_status := 1;

	     	-- Call Procedure to Insert into wm_track_changes
		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	END IF;

EXCEPTION
	WHEN OTHERS THEN NULL;

END;
/

show errors

