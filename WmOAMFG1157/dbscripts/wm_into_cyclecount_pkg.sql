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
    * Program Name:         wm_into_cyclecount_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Cycle Count Entries Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the Open Cycle Count Entries Interface
    *			Concurrent Request. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: wm_handle_inv_cc-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Cycle Count Import Request
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
     2-OCT-02	   Sudip Chaudhuri         Created
    ***************************************************************************
*/

 --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_Inv_CC_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Cycle Count Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Cycle Count Import Concurrent Request

PROCEDURE WM_HANDLE_INV_CC( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_cycle_count_name IN VARCHAR,
			    p_number_of_worker IN NUMBER,
			    p_commit_point IN NUMBER,
			    p_error_report_level IN VARCHAR,
			    p_delete_processed_records IN VARCHAR
			    ) ;

END Wm_Inv_CC_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Inv_CC_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_INV_CC(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_cycle_count_name IN VARCHAR,
			    p_number_of_worker IN NUMBER,
			    p_commit_point IN NUMBER,
			    p_error_report_level IN VARCHAR,
			    p_delete_processed_records IN VARCHAR
			    )
IS
	v_program  				   VARCHAR2(20):='MTL_CCEOI_IMPORT'; -- Cycle Count Import Worker
	v_application		   	   	   VARCHAR2(20):='INV'; -- Application
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	v_cc_header_id				   NUMBER;
	v_err_rep_level				   VARCHAR2(100);
	v_del_process				   VARCHAR2(100);
	

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
          
          -- Fetch the Cycle Count Header Id
          v_errmsg:='Fetch the Cycle Count Header Id';
          
          SELECT cycle_count_header_id
          INTO   v_cc_header_id
          FROM   mtl_cycle_count_headers
          WHERE  cycle_count_header_name=p_cycle_count_name;
                    
          -- Fetch lookup code for error report level
          v_errmsg:='Fetch lookup code for error report level';
          
          SELECT lookup_code
          INTO   v_err_rep_level
          FROM   mfg_lookups
          WHERE  lookup_type='MTL_CCEOI_ERROR_REPORT_LEVEL' 
          AND    enabled_flag = 'Y' 
          AND    meaning = p_error_report_level;
          
          -- Fetch the lookup code for delete processed
          v_errmsg:='Fetch the lookup code for delete processed';
          
          SELECT lookup_code
          INTO   v_del_process
          FROM   mfg_lookups
          WHERE  lookup_type = 'MTL_CCEOI_DELETE_PROC_RECS' 
          AND    enabled_flag = 'Y' 
          AND    meaning=p_delete_processed_records;
          
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
						 to_char(v_cc_header_id),
						 to_char(p_number_of_worker),
						 to_char(p_commit_point),
						 v_err_rep_level,
						 v_del_process
           			  	     	 );
						 
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_INV_CC;

END Wm_Inv_CC_Imp_Handler_Pkg;
/

SHOW ERRORS

