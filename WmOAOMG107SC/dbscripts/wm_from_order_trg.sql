/*  ***************************************************************************
    *    $Date:   30 Sep 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Order Outbound in Application Schema  
    * Program Name:         wm_from_order_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				SO_HEADERS_ALL		ON I/U
    *				SO_LINES_ALL		ON I/U
    *				SO_SALES_CREDITS	ON I/U/D
    *				SO_LINE_DETAILS		ON I/U/D
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
     11-NOV-02	 Panchali Samanta        Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_order_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update 
on SO_HEADERS_ALL table and gives a call to WEB_TRANSACTION procedure to 
populate WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_order_headers_iu_trg
AFTER INSERT OR UPDATE ON SO_HEADERS_ALL
FOR EACH ROW
WHEN (new.s1 = 1)
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type   VARCHAR2(100):='SALESORDER';

BEGIN

      -- assign data for parent key identifier

 	p_rec_wm_trackChange.transaction_type := c_transaction_type;
 	p_rec_wm_trackChange.date_created := SYSDATE;
	p_rec_wm_trackChange.processed_flag := 'N';

	IF INSERTING THEN
	 	p_rec_wm_trackChange.transaction_id := :new.header_id;
    	 	p_rec_wm_trackChange.comments:='ORDER HEADER INSERT FOR '|| 
								:new.header_id;
     	 	p_rec_wm_trackChange.transaction_status := 1;

	ELSIF UPDATING THEN
	 	p_rec_wm_trackChange.transaction_id := :new.header_id;
    	 	p_rec_wm_trackChange.comments:='ORDER HEADER UPDATE FOR '|| 
								:new.header_id;
     	 	p_rec_wm_trackChange.transaction_status := 0;
	END IF;

     	-- Call Procedure to Insert into wm_track_changes
	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	EXCEPTION
		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update 
on SO_LINES_ALL table and gives a call to WEB_TRANSACTION procedure to 
populate  WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_order_lines_iu_trg
AFTER INSERT OR UPDATE ON SO_LINES_ALL
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
p_booked_flag        so_headers_all.s1%TYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';

CURSOR oe_header IS
  SELECT s1
  FROM   so_headers_all
  WHERE  header_id = NVL(:new.header_id,:old.header_id);

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 1 THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;
	
		IF INSERTING THEN
	 		p_rec_wm_trackChange.transaction_id := :new.header_id;
	    	 	p_rec_wm_trackChange.comments :=
					'ORDER LINE INSERT FOR ORDER HEADER '|| 
					:new.header_id;

		ELSIF UPDATING THEN
	 		p_rec_wm_trackChange.transaction_id := :new.header_id;
	    	 	p_rec_wm_trackChange.comments := 
					'ORDER LINE UPDATE FOR ORDER HEADER '|| 
					:new.header_id;
		END IF;

	     	-- Call Procedure to Insert into wm_track_changes
		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	END IF;
  EXCEPTION
  	WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete 
on SO_SALES_CREDITS table and gives a call to WEB_TRANSACTION procedure to populate 
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_sales_credits_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON SO_SALES_CREDITS
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
p_booked_flag        so_headers_all.s1%TYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';

CURSOR oe_header IS
  SELECT s1
  FROM   so_headers_all
  WHERE  header_id = NVL(:new.header_id,:old.header_id);

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 1 THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;

		IF INSERTING THEN
	 		p_rec_wm_trackChange.transaction_id := :new.header_id;
	    	 	p_rec_wm_trackChange.comments :=
					'SALES CREDIT INSERT FOR ORDER '|| 
					:new.header_id;
		ELSIF UPDATING THEN
	 		p_rec_wm_trackChange.transaction_id := :new.header_id;
	    	 	p_rec_wm_trackChange.comments := 
					'SALES CREDIT UPDATE FOR ORDER '|| 
					:new.header_id;
		ELSIF DELETING THEN
	 		p_rec_wm_trackChange.transaction_id := :old.header_id;
	    	 	p_rec_wm_trackChange.comments := 
					'SALES CREDIT DELETE FOR ORDER '|| 
					:old.header_id;
		END IF;

	     	-- Call Procedure to Insert into wm_track_changes
		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	END IF;
	EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete 
on SO_LINE_DETAILS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_line_details_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON SO_LINE_DETAILS
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type   VARCHAR2(100):='SALESORDER';
p_booked_flag        so_headers_all.s1%TYPE;
p_header_id          so_headers_all.header_id%TYPE;

CURSOR oe_header IS
  SELECT H.header_id, H.s1
  FROM   so_lines_all L, so_headers_all H
  WHERE  L.line_id = NVL(:new.line_id,:old.line_id)
  AND    L.header_id = H.header_id;

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_header_id,p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 1 THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;

		IF INSERTING THEN
	 		p_rec_wm_trackChange.transaction_id := p_header_id;
	    	 	p_rec_wm_trackChange.comments :=
			'INSERT FOR LINE DETAILS OF ORDER HEADER '|| 
			p_header_id;
		ELSIF UPDATING THEN
	 		p_rec_wm_trackChange.transaction_id := p_header_id;
	    	 	p_rec_wm_trackChange.comments := 
			'UPDATE FOR LINE DETAILS OF ORDER HEADER '|| 
			p_header_id;
		ELSIF DELETING THEN
	 		p_rec_wm_trackChange.transaction_id := p_header_id;
	    	 	p_rec_wm_trackChange.comments := 
			'DELETE FOR LINE DETAILS OF ORDER HEADER '|| 
			p_header_id;
		END IF;

	     	-- Call Procedure to Insert into wm_track_changes
		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	END IF;
	EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors



