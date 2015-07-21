 /***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *				- COPYRIGHT NOTICE -
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_salesorder_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Sales Order Import Open Interface
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to handle import of Sales Order
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: wm_handle_order_import-> Performs pre-processing actions to determine the values 
    *				to be called for Order Import Concurrent Request
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
     05-OCT-02	 Panchali Samanta        Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_salesorder_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE wm_Order_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Order Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Order Import Concurrent Request

PROCEDURE WM_HANDLE_ORDER_IMPORT( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_order_src IN VARCHAR2,
			    p_order_ref IN VARCHAR2
			    );
			   

END wm_Order_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY wm_Order_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_ORDER_IMPORT(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_order_src IN VARCHAR2,
			    p_order_ref IN VARCHAR2
			    )
	IS
	v_program  			 VARCHAR2(20):='OEOIMP'; -- Order Import
	v_application		 VARCHAR2(20):='ONT'; -- Application
	v_application_id		 NUMBER;
	v_user_id			 NUMBER;
	v_user_responsibility_id NUMBER;
	v_validate_flag          VARCHAR2(1);  
	v_order_src              NUMBER; 
	v_order_ref              VARCHAR2(100);
	v_debug_level            NUMBER; 	
	v_instance               NUMBER; 	
BEGIN

	  -- Fetch Application id for ONT Application
	  v_errmsg:='Fetching the Application Id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'ONT';
	  
	  -- Fetch the User Id 
	  v_errmsg:='Fetching the User Id';
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_errmsg:='Fetching the Responsibility Id';

        v_user_responsibility_id:= wm_conc_request_pkg.get_user_responsibility_id( p_user_responsibility);

	  v_errmsg:='Fetching the Order Source';
	  
	  IF p_order_src IS NOT NULL THEN
		  SELECT order_source_id
		  INTO   v_order_src
		  FROM   oe_order_sources
		  WHERE  name = p_order_src;
	  END IF;

	  v_errmsg:='Fetching the Order Reference';

	  IF p_order_ref IS NOT NULL THEN
		  SELECT 
			b.orig_sys_document_ref
		  INTO
			v_order_ref
		  FROM
			po_requisition_headers_all a, 
			oe_headers_iface_all b
		  WHERE 
			b.orig_sys_document_ref = 
				to_char(a.requisition_header_id(+)) 
		  AND b.order_source_id = b.order_source_id 
		  AND NVL(decode(b.order_source_id, 10, 
			a.segment1,b.orig_sys_document_ref)
			,b.orig_sys_document_ref) = p_order_ref;
	  END IF;

	  -- Defaulted to 'N' as order is to be always imported
	  v_validate_flag := 'N';

	  -- Debug Lebel set to 1 as default
	  v_debug_level := 1;

	  -- Instances set to 1 as default
	  v_instance := 1;
	  -- Initialize environment
       
 Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);

	  -- Call to submit request
        v_errmsg:='Submitting the Concurrent Request';
          
	  Wm_Conc_Request_Pkg.wm_request_submit(v_application_id,
	  							v_user_responsibility_id,
	  							v_user_id,
	  							v_application,
			  			     		v_program,
			  			     		v_status,
			  			     		v_request_id,
			  			     		NULL,
			  			     		NULL,
			  			     		o_message,
			  			     		v_errmsg,
           			  	     			v_order_src,
           			  	     			v_order_ref,
           			  	     			NULL,
           			  	     			v_validate_flag,
           			  	     			v_debug_level,
           			  	     			v_instance);
                    						
EXCEPTION
WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;                              						
	

END WM_HANDLE_ORDER_IMPORT;

END wm_Order_Imp_Handler_Pkg;
/


SHOW ERRORS

