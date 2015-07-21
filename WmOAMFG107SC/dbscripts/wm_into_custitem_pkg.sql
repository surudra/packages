/*  ***************************************************************************
        $Date:   14 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
        Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *                          
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_custitem_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Customer Items Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the Customer Items Interface
    *			Concurrent Request. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: wm_handle_custitem-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Customer Items Concurrent Request
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
     14-NOV-02	   Sudip Chaudhuri         Created
    ***************************************************************************
*/

prompt Program: wm_into_custitem_pkg.sql
  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_INV_CtItem_Imp_Handler_Pkg AS

-- Procedure to determine calling parameters for Customer Items Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Customer Items Import Concurrent Request

PROCEDURE WM_HANDLE_CUSTITEM( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_abort_on_error IN VARCHAR,
		            p_delete_record IN VARCHAR
			    ) ;

END Wm_INV_CtItem_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_INV_CtItem_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_CUSTITEM(p_user_responsibility IN VARCHAR,
		       p_user IN VARCHAR,
		       v_status OUT VARCHAR,
		       v_request_id OUT NUMBER,
		       o_message OUT VARCHAR,
		       v_errmsg  OUT VARCHAR,
		       p_abort_on_error IN VARCHAR,
		       p_delete_record IN VARCHAR
		       )
IS
	v_program  				   VARCHAR2(20):='INVCIINT'; -- Customer Items Open Interface Program
	v_application		   	   	   VARCHAR2(20):='INV'; -- Application
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	o_request_id				   NUMBER;
	o_errmsg				   VARCHAR2(1000);

BEGIN

	  -- Fetch Application id for INV Application
	  o_errmsg:='Fetching Application id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = v_application;
	  
	  -- Fetch the User Id 
	  o_errmsg:='Fetching the User Id';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  
	  o_errmsg:='Fetching the Responsibility Id';
	  
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  
          o_errmsg:='Calling Submit Request';
          
	  -- Call to submit request

	   wm_conc_request_pkg.wm_request_submit(v_application_id,
	  					 v_user_responsibility_id,
	  					 v_user_id,
	  					 v_application,
			  			 v_program,
			  			 v_status,
						 o_request_id,
						 NULL,
			  			 NULL,
			  			 o_message,
						 o_errmsg,
						 p_abort_on_error,
						 p_delete_record
						 );
	 v_request_id := o_request_id;
	 v_errmsg := o_errmsg;						 
						 
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=o_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_CUSTITEM;

END Wm_INV_CtItem_Imp_Handler_Pkg;
/

SHOW ERRORS

