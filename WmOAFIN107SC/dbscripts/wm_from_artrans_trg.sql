/*  ***************************************************************************
    *    $Date:   15 Nov 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for AR Transactions Outbound in Application Schema  
    * Program Name:         wm_from_artrans_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				RA_CUSTOMER_TRX_ALL			ON I/U
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
     14-NOV-02	   Gautam Naha		   Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON

 prompt Program : wm_from_artrans_trg.SQL

 CONNECT &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an update
on RA_CUSTOMER_TRX_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_ra_customer_trx_all_iu_trg
AFTER INSERT OR UPDATE ON  RA_CUSTOMER_TRX_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='ARTRANSACTION';

BEGIN

         IF INSERTING THEN

		-- Note that that this point a record is inserted into trackchanges table
		-- with transaction_status as 9. Only when the complete_flag is updated to 'Y,'
		-- the transaction_status will be updated to 1, i.e., INSERT
        
		IF :NEW.complete_flag = 'N' THEN

			p_rec_wm_trackChange.transaction_type:=c_transaction_type;
			p_rec_wm_trackChange.transaction_id:=:NEW.customer_trx_id;
			p_rec_wm_trackChange.date_created:=SYSDATE;
			p_rec_wm_trackChange.comments:='AR TRANSACTION INTERIM INSERT FOR '||:NEW.customer_trx_id;
			p_rec_wm_trackChange.transaction_status:=9;
			p_rec_wm_trackChange.processed_flag:='N';
        
			-- Call Procedure to Insert into wm_track_changes
			Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
		ELSE

			p_rec_wm_trackChange.transaction_type:=c_transaction_type;
			p_rec_wm_trackChange.transaction_id:=:NEW.customer_trx_id;
			p_rec_wm_trackChange.date_created:=SYSDATE;
			p_rec_wm_trackChange.comments:='AR TRANSACTION INSERT FOR '||:NEW.customer_trx_id;
			p_rec_wm_trackChange.transaction_status:=1;
			p_rec_wm_trackChange.processed_flag:='N';
        
			-- Call Procedure to Insert into wm_track_changes
			Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

		END IF;
    
         END IF;
    

         IF UPDATING THEN 

		IF :NEW.complete_flag = 'Y' THEN
	
		-- If Transaction is complete, check if complete_flag is now 'Y'.
		-- This may indicate a New Transaction or an Update.
		-- Update the record, if any, with transaction_status 9 to value 1.

			UPDATE WM_TRACKCHANGES 
			SET TRANSACTION_STATUS = 1,
			    COMMENTS = 'AR TRANSACTION INSERT FOR '||:NEW.customer_trx_id
			WHERE TRANSACTION_TYPE = c_transaction_type
			AND TRANSACTION_STATUS = 9
			AND transaction_id = TO_CHAR(:NEW.customer_trx_id)
			AND PROCESSED_FLAG='N';
	
			p_rec_wm_trackChange.transaction_type:=c_transaction_type;
			p_rec_wm_trackChange.transaction_id:=:NEW.customer_trx_id;
			p_rec_wm_trackChange.date_created:=SYSDATE;
			p_rec_wm_trackChange.comments:='AR TRANSACTION UPDATE FOR '||:NEW.customer_trx_id;
			p_rec_wm_trackChange.transaction_status:=0;
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