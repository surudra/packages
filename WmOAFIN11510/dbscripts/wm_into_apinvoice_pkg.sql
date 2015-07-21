/*  ***************************************************************************
        $Date:   07 Sept 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
        Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *                           - COPYRIGHT NOTICE -
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_apinvoice_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Open Payables Invoice Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the Open Payables Interface
    *			Concurrent Request. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: wm_handle_openAP-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Open Payables Concurrent Request
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
     07-SEPT-02	   Rajib Naha   			Created
    ***************************************************************************
*/
  prompt Program : wm_into_apinvoice_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString


 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_AP_Inv_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Open Payables Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Open Payables Import Concurrent Request

PROCEDURE WM_HANDLE_OPENAP( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_source IN VARCHAR,
			    p_group_id IN VARCHAR DEFAULT NULL,
			    p_batch_name IN VARCHAR DEFAULT NULL,
			    p_hold_code IN VARCHAR DEFAULT NULL,
			    p_gl_date IN DATE DEFAULT NULL ,
			    p_purge_flag IN VARCHAR DEFAULT NULL,
			    p_summary_flag IN VARCHAR DEFAULT NULL
			    ) ;

END Wm_AP_Inv_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_AP_Inv_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_OPENAP(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_source IN VARCHAR,
			    p_group_id IN VARCHAR DEFAULT NULL,
			    p_batch_name IN VARCHAR DEFAULT NULL,
			    p_hold_code IN VARCHAR DEFAULT NULL,
			    p_gl_date IN DATE DEFAULT NULL ,
			    p_purge_flag IN VARCHAR DEFAULT NULL,
			    p_summary_flag IN VARCHAR DEFAULT NULL
			    )
IS
	v_program  				   VARCHAR2(20):='APXIIMPT'; -- AP Invoice Open Interface OA Module
	v_application		   	   	   VARCHAR2(20):='SQLAP'; -- Application
	v_hold_reason				   VARCHAR2(1000);
	v_purge_flag				   VARCHAR2(1);
	v_trace_switch				   VARCHAR2(1):='N';
	v_debug_switch				   VARCHAR2(1):='N';
	v_summary_flag	                           VARCHAR2(1);
	v_commit_batch_size			   VARCHAR2(15):='1000';
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	v_login_id				   VARCHAR2(100);
	


BEGIN

	  -- Fetch Application id for AP Application
	  v_errmsg:='Fetching Application id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'SQLAP';
	  
	  -- Fetch the User Id 
	  v_errmsg:='Fetching the User Id';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_errmsg:='Fetching the Responsibility Id';
	  
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  

	-- Checking input values and convrting purge and summary report to BOOLIAN values
	
	IF p_purge_flag IS NOT NULL THEN
	  	IF UPPER(p_purge_flag) = 'NO' THEN
       	   		v_purge_flag := 'N';
       		ELSE 
       	   		v_purge_flag := 'Y';
       		END IF;
    	ELSE
		v_purge_flag := 'N';
	END IF;
	        
	IF p_summary_flag IS NOT NULL THEN
	  	IF UPPER(p_summary_flag) = 'NO' THEN
       	   		v_summary_flag := 'N';
       		ELSE 
       	   		v_summary_flag := 'Y';
       		END IF;
    	ELSE
		v_summary_flag := 'N';
	END IF;

	-- Populating Holing Reason DATE table 
	v_errmsg:='Populating Holing Reason DATE table';

	IF p_hold_code IS NOT NULL THEN
	
		SELECT DESCRIPTION
		INTO v_hold_reason
		FROM AP_HOLD_CODES
		WHERE HOLD_LOOKUP_CODE = p_hold_code
		AND INACTIVE_DATE IS NULL; 
		
	END IF;	  
	
	
       -- Initialize environment
       
	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);
       
       -- Find the login id
          
          v_login_id := Fnd_Global.Login_Id;
	
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
           			  	     	 p_source,
                    				 p_group_id,
                      				 p_batch_name,
                    				 p_hold_code,
                    				 v_hold_reason,
                    				 to_char(p_gl_date,'YYYY/MM/DD HH:MI:SS'),
                    				 v_purge_flag,
						 v_trace_switch,
						 v_debug_switch,
						 v_summary_flag,	
						 v_commit_batch_size,
						 v_user_id,
						 v_login_id);
						 
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_OPENAP;

END Wm_AP_Inv_Imp_Handler_Pkg;
/

SHOW ERRORS

