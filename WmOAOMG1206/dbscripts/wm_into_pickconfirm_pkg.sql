 /***************************************************************************
        $Date:   24 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *				
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_pickconfirm_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Pick Confirm Inbound
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema. This wrapper calls Inv_Pick_Wave_Pick_Confirm_Pub.pick_confirm, the
    *		Pick Confirm API.
    *
    * Tables usage:     
    *     
    *
    * Procedures and Functions: Wm_Pick_Confirm_Api-> Wrapper procedure that calls Pick Confirm API in Oracle Applications
    *				
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
    *           Param3: &CustomUser 
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
     24-OCT-02	 Gautam Naha        Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON


  prompt Program : wm_into_pickconfirm_pkg.SQL

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  CONNECT &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_Pickconfirm_Handler_Pkg AUTHID CURRENT_USER AS

      PROCEDURE Wm_Pick_Confirm_Api (
		v_status 			OUT VARCHAR2
	,	o_message 			OUT VARCHAR2
	,	v_errmsg  			OUT VARCHAR2
	,	x_line_id			OUT VARCHAR2
	,	x_move_order_number		OUT VARCHAR2
	,	x_move_order_type_name		OUT VARCHAR2
	,	x_inventory_item_code		OUT VARCHAR2
	,	x_organization_name		OUT VARCHAR2
	,	x_item_revision_number		OUT VARCHAR2
	,	x_project_name			OUT VARCHAR2
	,	x_task_name			OUT VARCHAR2
	,	x_transaction_type		OUT VARCHAR2
	,	x_source_subinventory		OUT VARCHAR2
	,	x_source_locator		OUT VARCHAR2
	,	x_destination_subinventory	OUT VARCHAR2
	,	x_destination_locator		OUT VARCHAR2
	,	x_lot_number			OUT VARCHAR2
	,	x_pick_slix_number		OUT VARCHAR2
	,	x_sales_order_num		OUT VARCHAR2
	,	p_line_id			IN VARCHAR2
	,	p_move_order_number		IN VARCHAR2
	,	p_move_order_type_name		IN VARCHAR2
	,	p_inventory_item_code		IN VARCHAR2
	,	p_organization_name		IN VARCHAR2
	,	p_item_revision_number		IN VARCHAR2
	,	p_project_name			IN VARCHAR2
	,	p_task_name			IN VARCHAR2
	,	p_transaction_type		IN VARCHAR2
	,	p_source_subinventory		IN VARCHAR2
	,	p_source_locator		IN VARCHAR2
	,	p_destination_subinventory	IN VARCHAR2
	,	p_destination_locator		IN VARCHAR2
	,	p_lot_number			IN VARCHAR2
	,	p_pick_slip_number		IN VARCHAR2
	,	p_sales_order_num		IN VARCHAR2);

END Wm_Pickconfirm_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Pickconfirm_Handler_Pkg AS

       PROCEDURE Wm_Pick_Confirm_Api (
		v_status 			OUT VARCHAR2
	,	o_message 			OUT VARCHAR2
	,	v_errmsg  			OUT VARCHAR2
	,	x_line_id			OUT VARCHAR2
	,	x_move_order_number		OUT VARCHAR2
	,	x_move_order_type_name		OUT VARCHAR2
	,	x_inventory_item_code		OUT VARCHAR2
	,	x_organization_name		OUT VARCHAR2
	,	x_item_revision_number		OUT VARCHAR2
	,	x_project_name			OUT VARCHAR2
	,	x_task_name			OUT VARCHAR2
	,	x_transaction_type		OUT VARCHAR2
	,	x_source_subinventory		OUT VARCHAR2
	,	x_source_locator		OUT VARCHAR2
	,	x_destination_subinventory	OUT VARCHAR2
	,	x_destination_locator		OUT VARCHAR2
	,	x_lot_number			OUT VARCHAR2
	,	x_pick_slix_number		OUT VARCHAR2
	,	x_sales_order_num		OUT VARCHAR2
	,	p_line_id			IN VARCHAR2
	,	p_move_order_number		IN VARCHAR2
	,	p_move_order_type_name		IN VARCHAR2
	,	p_inventory_item_code		IN VARCHAR2
	,	p_organization_name		IN VARCHAR2
	,	p_item_revision_number		IN VARCHAR2
	,	p_project_name			IN VARCHAR2
	,	p_task_name			IN VARCHAR2
	,	p_transaction_type		IN VARCHAR2
	,	p_source_subinventory		IN VARCHAR2
	,	p_source_locator		IN VARCHAR2
	,	p_destination_subinventory	IN VARCHAR2
	,	p_destination_locator		IN VARCHAR2
	,	p_lot_number			IN VARCHAR2
	,	p_pick_slip_number		IN VARCHAR2
	,	p_sales_order_num		IN VARCHAR2)

IS

l_trolin_tbl		Inv_Move_Order_Pub.Trolin_Tbl_Type;
l_trolin_tbl1		Inv_Move_Order_Pub.Trolin_Tbl_Type;
l_mold_tbl		Inv_Mo_Line_Detail_Util.g_mmtt_tbl_type ;
l_return_status		VARCHAR2(1); 
l_msg_count		NUMBER ;
l_msg_data		VARCHAR2(2000); 
l_data			VARCHAR2(2000); 
v_api_version_number	NUMBER := 1.0;
v_move_order_type 	NUMBER;
l_mmtt_tbl_type      	Inv_Mo_Line_Detail_Util.g_mmtt_tbl_type ;
l_trolin_tbl_type       Inv_Move_Order_Pub.Trolin_Tbl_Type;
p_msg_data		VARCHAR2(2000);
p_transaction_mode   	NUMBER := 3; 
l_msg_index		number := 1;

BEGIN

---	Copy IN variables to OUT variables

x_line_id		:=	p_line_id	;
x_move_order_number	:=	p_move_order_number	;
x_move_order_type_name	:=	p_move_order_type_name	;
x_inventory_item_code	:=	p_inventory_item_code	;
x_organization_name	:=	p_organization_name	;
x_item_revision_number	:=	p_item_revision_number	;
x_project_name		:=	p_project_name	;
x_task_name		:=	p_task_name	;
x_transaction_type	:=	p_transaction_type	;
x_source_subinventory	:=	p_source_subinventory	;
x_source_locator	:=	p_source_locator	;
x_destination_subinventory	:=	p_destination_subinventory	;
x_destination_locator	:=	p_destination_locator	;
x_lot_number		:=	p_lot_number	;
x_pick_slix_number	:=	p_pick_slip_number	;
x_sales_order_num	:=	p_sales_order_num	;


---	Fetch move_order_type
	
	v_errmsg := 'Fetching Move order type Id' ; 
	 
	SELECT LOOKUP_CODE
	INTO   v_move_order_type 
	FROM   MFG_LOOKUPS mfg
	WHERE  mfg.meaning = p_move_order_type_name
	AND lookup_type = 'MOVE_ORDER_TYPE';

---	Populate Move Order record structure
	
	l_trolin_tbl(1).line_id			:= p_line_id ;	

---	Call Pick Confirm API

	v_errmsg := 'Calling Pick Confirm API';
	
	Inv_Pick_Wave_Pick_Confirm_Pub.pick_confirm (
		p_api_version_number	=> v_api_version_number, 
	    	p_init_msg_list		=> Fnd_Api.G_TRUE, 
    		p_commit		=> Fnd_Api.G_TRUE, 
	    	x_return_status		=> v_status, 
	    	x_msg_count		=> l_msg_count, 
	    	x_msg_data		=> p_msg_data, 
	    	p_move_order_type	=> v_move_order_type, 
	    	p_transaction_mode	=> p_transaction_mode, 
	    	p_trolin_tbl		=> l_trolin_tbl,
		p_mold_tbl		=> l_mold_tbl,  
	    	x_mmtt_tbl		=> l_mmtt_tbl_type, 
    		x_trolin_tbl		=> l_trolin_tbl_type ); 

	COMMIT; 
	
	Fnd_Msg_Pub.get(
		p_msg_index	=> Fnd_Msg_Pub.G_FIRST, 
		p_encoded	=> Fnd_Api.G_FALSE, 
		p_data		=> l_data, 
		p_msg_index_out => l_msg_index); 
			
	IF v_status = 'S' THEN
		v_status := 'SUCCESS';
		o_message:='Normal Completion';
		v_errmsg:=NULL;	   
	ELSE
		v_status := 'FAILED';
		o_message:='Pick Confirm API Failure' || ' Error Count = '|| l_msg_count;
		v_errmsg := l_data;
	END IF;
	
--	DBMS_OUTPUT.PUT_LINE('AFTER api call');
--	DBMS_OUTPUT.PUT_LINE('RETURN STATUS : ' || l_return_status); 
--	DBMS_OUTPUT.PUT_LINE('msg_count : ' || l_msg_count); 
--	DBMS_OUTPUT.PUT_LINE('data : ' || l_data); 
	
EXCEPTION
WHEN OTHERS THEN 
v_errmsg := v_errmsg || ':' || SQLERRM;
v_status:='FAILED';

END Wm_Pick_Confirm_Api;

END wm_pickconfirm_handler_pkg;
/