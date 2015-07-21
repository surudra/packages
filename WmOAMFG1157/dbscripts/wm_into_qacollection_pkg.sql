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
    * Program Name:         wm_into_qacollection_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Quality Collection Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the Quality Collection Interface
    *			Concurrent Request. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: wm_handle_qa-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Quality Collection Concurrent Request
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
     23-SEPT-02	   Sudip Chaudhuri         Created
    ***************************************************************************
*/

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_QA_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Quality Collection Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Quality Collection Import Concurrent Request

PROCEDURE WM_HANDLE_QA( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_worker_rows IN NUMBER,
			    p_transaction_type IN VARCHAR DEFAULT NULL
			    ) ;

END Wm_QA_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_QA_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_QA(p_user_responsibility IN VARCHAR,
		       p_user IN VARCHAR,
		       v_status OUT VARCHAR,
		       v_request_id OUT NUMBER,
		       o_message OUT VARCHAR,
		       v_errmsg OUT VARCHAR,
		       p_worker_rows IN NUMBER,
		       p_transaction_type IN VARCHAR DEFAULT NULL
		       )
IS
	v_program  				   VARCHAR2(20):='QLTTRAMB'; -- Quality Collection Open Interface OA Module
	v_application		   	   	   VARCHAR2(20):='QA'; -- Application
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	v_transaction_type			   NUMBER;
	


BEGIN

	  -- Fetch Application id for QA Application
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
	  

	-- Checking input Transaction Type and converting it to corresponding numeric value
	
	IF p_transaction_type IS NOT NULL THEN
	  	IF UPPER(p_transaction_type) = 'INSERT TRANSACTION' THEN
       	   		v_transaction_type := 1;
       		ELSE 
       	   		v_transaction_type := 2;
       		END IF;
    	END IF;
	        
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
						 p_worker_rows,
						 v_transaction_type,
						 v_user_id
           			  	     	 );
						 
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_QA;

END Wm_QA_Imp_Handler_Pkg;
/

SHOW ERRORS

