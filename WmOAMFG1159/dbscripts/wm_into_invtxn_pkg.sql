/*  ***************************************************************************
        $Date:   07 Sept 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
        Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *                       
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_invtxn_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Inventory Transaction Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the Open Inventory Transaction Interface
    *			Concurrent Request. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: wm_handle_inv_txn-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Inventory Transaction Worker
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
     27-SEPT-02	   Sudip Chaudhuri         Created
    ***************************************************************************
*/

 --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_Inv_Txn_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Inventory Open Transactions Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Inventory Open Transactions Import Concurrent Request

PROCEDURE WM_HANDLE_INV_TXN( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_transaction_header_id IN NUMBER
			    ) ;

END Wm_Inv_Txn_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Inv_Txn_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_INV_TXN(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_transaction_header_id IN NUMBER
			    )
IS
	v_program  				   VARCHAR2(20):='INCTCW'; -- Inventory Transaction Worker 	
	v_application		   	   	   VARCHAR2(20):='INV'; -- Application
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	

BEGIN

	  -- Fetch Application id for INV Application
	  v_errmsg:='Fetching Application id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = v_application;
	  
	  -- Fetch the User Id 
	  v_errmsg:='Fetching the User Id';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_errmsg:='Fetching the Responsibility Id';
	  
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  
           -- Initialize environment
       
	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);
                
          v_errmsg:='Calling Submit Request';
          
	  -- Call to submit request

	  wm_conc_request_pkg.wm_request_submit(v_application_id,
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
						 to_char(p_transaction_header_id),
						 '1',
						 Null,
						 Null
           			  	     	 );
           			  	     	 
         
						 
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_INV_TXN;

END Wm_Inv_Txn_Imp_Handler_Pkg;
/

SHOW ERRORS

