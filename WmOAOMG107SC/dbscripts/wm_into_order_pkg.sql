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
    * Program Name:         wm_into_order_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Order Import Open Interface
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to handle Inserts to WM_TRACKCHANGES table
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
     13-NOV-02	 Panchali Samanta        Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_order_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE wm_Order_Imp_Handler_Pkg AS

-- Procedure to determine calling parameters for Order Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Order Import Concurrent Request

PROCEDURE WM_HANDLE_ORDER_IMPORT( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_order_src IN VARCHAR2
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
			    p_order_src IN VARCHAR2
			    )
	IS
	v_program  			 VARCHAR2(20):='OEOBOE'; -- Order Import
	v_application		 VARCHAR2(20):='OE'; -- Application
	v_application_id		 NUMBER;
	v_user_id			 NUMBER;
	v_user_responsibility_id NUMBER;
	v_validate_flag          VARCHAR2(1);  
	v_order_src              NUMBER; 
	v_instance               NUMBER; 	
	v_statement              VARCHAR2(2000);
	v_request_id1            NUMBER;
BEGIN

	  -- Fetch Application id for OE Application
	  v_statement :='Fetching the Application Id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'OE';
	  
	  -- Fetch the User Id 
	  v_statement :='Fetching the User Id';
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_statement :='Fetching the Responsibility Id';

        v_user_responsibility_id:= wm_conc_request_pkg.get_user_responsibility_id( p_user_responsibility);

	  v_statement :='Fetching the Order Source';
	  
	  IF p_order_src IS NOT NULL THEN
		  SELECT order_source_id
		  INTO   v_order_src
		  FROM   so_order_sources
		  WHERE  name = p_order_src;
	  END IF;

	  -- Defaulted to 'Y' as order is to be always imported
	  v_validate_flag := 'Y';

	  -- Instances set to 1 as default
	  v_instance := 1;
	  -- Initialize environment
       
 Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);

	  -- Call to submit request
        v_statement :='Submitting the Concurrent Request';
          
	  Wm_Conc_Request_Pkg.wm_request_submit(v_application_id,
	  							v_user_responsibility_id,
	  							v_user_id,
	  							v_application,
			  			     		v_program,
			  			     		v_status,
			  			     		v_request_id1,
			  			     		NULL,
			  			     		NULL,
			  			     		o_message,
			  			     		v_errmsg,
           			  	     			v_order_src,
           			  	     			v_validate_flag,
           			  	     			v_instance);
	v_request_id := v_request_id1;
                    						
EXCEPTION
WHEN OTHERS THEN
 v_errmsg := v_statement||SQLERRM;                              						
	

END WM_HANDLE_ORDER_IMPORT;

END wm_Order_Imp_Handler_Pkg;
/


SHOW ERRORS

