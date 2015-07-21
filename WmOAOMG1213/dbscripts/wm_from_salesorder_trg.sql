/*  ***************************************************************************
    *    $Date:   30 Sep 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Sales Order Outbound in Application Schema  
    * Program Name:         wm_from_salesorder_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				OE_ORDER_HEADERS_ALL		ON I/U
    *				OE_ORDERS_LINES_ALL		ON I/U/D
    *				OE_SALES_CREDITS			ON I/U/D
    *				OE_LOT_SERIAL_NUMBERS		ON I/U/D
    *				OE_PRICE_ADJUSTMENTS		ON I/U/D
    *				OE_ORDER_PRICE_ATTRIBS		ON I/U/D
    *				OE_LINE_SETS			ON I/D
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
     30-SEP-02	 Panchali Samanta        Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_salesorder_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."


show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_ORDER_LINES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_order_lines_iud_trg
AFTER DELETE ON OE_ORDER_LINES_ALL
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
p_booked_flag        oe_order_headers_all.booked_flag%TYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';

CURSOR oe_header IS
  SELECT booked_flag
  FROM   oe_order_headers_all
  WHERE  header_id = NVL(:new.header_id,:old.header_id);

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 'Y' THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;
	
		IF DELETING THEN
	 		p_rec_wm_trackChange.transaction_id := :old.header_id;
	    	 	p_rec_wm_trackChange.comments := 
					'ORDER LINE DELETE FOR ORDER HEADER '|| 
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

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_SALES_CREDITS table and gives a call to WEB_TRANSACTION procedure to populate WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_sales_credits_iud_trg
AFTER DELETE ON OE_SALES_CREDITS
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
p_booked_flag        oe_order_headers_all.booked_flag%TYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';

CURSOR oe_header IS
  SELECT booked_flag
  FROM   oe_order_headers_all
  WHERE  header_id = NVL(:new.header_id,:old.header_id);

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 'Y' THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;

		IF DELETING THEN
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

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_LOT_SERIAL_NUMBERS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_oe_lotserial_iud_trg
AFTER DELETE ON OE_LOT_SERIAL_NUMBERS
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';
p_booked_flag        oe_order_headers_all.booked_flag%TYPE;
p_header_id oe_order_headers_all.header_id%TYPE;

CURSOR oe_header IS
  SELECT H.header_id, H.booked_flag
  FROM   oe_order_lines_all L, oe_order_headers_all H
  WHERE  L.line_id = NVL(:new.line_id,:old.line_id)
  AND    L.header_id = H.header_id;

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_header_id,p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 'Y' THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;

		IF DELETING THEN
	 		p_rec_wm_trackChange.transaction_id := p_header_id;
	    	 	p_rec_wm_trackChange.comments := 
			'LOT SERIAL DELETE FOR LINE OF ORDER HEADER '|| 
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

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_PRICE_ADJUSTMENTS table and gives a call to WEB_TRANSACTION procedure to populate WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_oe_price_adj_iud_trg
AFTER  DELETE ON OE_PRICE_ADJUSTMENTS
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
p_booked_flag        oe_order_headers_all.booked_flag%TYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';

CURSOR oe_header IS
  SELECT booked_flag
  FROM   oe_order_headers_all
  WHERE  header_id = NVL(:new.header_id,:old.header_id);

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 'Y' THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;

		IF DELETING THEN
	 		p_rec_wm_trackChange.transaction_id := :old.header_id;
	    	 	p_rec_wm_trackChange.comments := 
					'PRICE ADJUSTMENTS DELETE FOR ORDER '|| 
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

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_ORDER_PRICE_ATTRIBS table and gives a call to WEB_TRANSACTION procedure to populate WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_oe_price_attribs_iud_trg
AFTER DELETE ON OE_ORDER_PRICE_ATTRIBS
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
p_booked_flag        oe_order_headers_all.booked_flag%TYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';

CURSOR oe_header IS
  SELECT booked_flag
  FROM   oe_order_headers_all
  WHERE  header_id = NVL(:new.header_id,:old.header_id);

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 'Y' THEN
	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';
	 	p_rec_wm_trackChange.transaction_status := 0;

		IF DELETING THEN
	 		p_rec_wm_trackChange.transaction_id := :old.header_id;
	    	 	p_rec_wm_trackChange.comments := 
				'ORDER PRICE ATTRIBUTES DELETE FOR ORDER '|| 
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

Trigger to populate the table WM_TRACKCHANGES when there is an insert or delete on OE_LINE_SETS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_line_sets_id_trg
AFTER DELETE ON OE_LINE_SETS
FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='SALESORDER';
p_booked_flag        oe_order_headers_all.booked_flag%TYPE;
p_header_id oe_order_headers_all.header_id%TYPE;

CURSOR oe_header IS
  SELECT H.header_id, H.booked_flag
  FROM   oe_order_lines_all L, oe_order_headers_all H
  WHERE  L.line_id = NVL(:new.line_id,:old.line_id)
  AND    L.header_id = H.header_id;

BEGIN
	OPEN oe_header;
	FETCH oe_header 
	INTO p_header_id,p_booked_flag;
	CLOSE oe_header;

	IF p_booked_flag = 'Y' THEN

	      -- assign data for parent key identifier

 		p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 	p_rec_wm_trackChange.date_created := SYSDATE;
		p_rec_wm_trackChange.processed_flag := 'N';

		IF DELETING THEN
	 		p_rec_wm_trackChange.transaction_id := p_header_id;
	    	 	p_rec_wm_trackChange.comments := 
				'ORDER LINE SET DELETE FOR ORDER HEADER '|| 
				p_header_id;
     		 	p_rec_wm_trackChange.transaction_status := 0;
		END IF;

     		-- Call Procedure to Insert into wm_track_changes
		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	END IF;
	EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors


