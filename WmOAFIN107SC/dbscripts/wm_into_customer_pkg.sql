/*  ***************************************************************************
        $Date:   11 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: $
    *		Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_customer_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Customer Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the Customer Interface
    *			Concurrent Request and handle the error. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: WM_HANDLE_CUSTOMER-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Customer Concurrent Request
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
     11-NOV-02	   Gautam Naha   			Created
    ***************************************************************************
*/
  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  CONNECT &&apps_user/&&AppsPwd@&&DBString


 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------



CREATE OR REPLACE PACKAGE Wm_Customer_Imp_Handler_Pkg  AS

-- Procedure to determine calling parameters for Customer Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Customer Import Concurrent Request

PROCEDURE WM_HANDLE_CUSTOMER( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR2,
			    v_request_id  OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg   OUT VARCHAR
			    );

END Wm_Customer_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Customer_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_CUSTOMER (p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR2,
			    v_request_id  OUT NUMBER,
                o_message OUT VARCHAR,
			    v_errmsg   OUT VARCHAR
			    )
	IS

	v_program  				   VARCHAR2(20):='RACUST'; -- Customer Concurrent Program
	v_application		   	   VARCHAR2(20):='AR'; -- Application
	v_application_id		   NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id   NUMBER;
	o_request_id				   NUMBER;
	o_errmsg				   VARCHAR2(1000);




BEGIN

	  -- Fetch Application id for AR Application
	  o_errmsg:='Fetching Application id';

	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'AR';
	  
	  
	  	-- Fetch the User Id
	  o_errmsg:='Fetching the User Id';
	  
	   	v_user_id:=Wm_Conc_Request_Pkg.get_user_id(p_user);

	  	-- Fetch the Responsibility Id
	  o_errmsg:='Fetching the Responsibility Id';

	  	v_user_responsibility_id:=Wm_Conc_Request_Pkg.get_user_responsibility_id(p_user_responsibility);

	  	--- Initialize Application Profiles and Global Variables
		
		Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);
		
		
	
	--  dbms_output.put_line('Calling Submit Request');

	  -- Call to submit request
       o_errmsg:='Calling Submit Request';

	 Wm_Conc_Request_Pkg.wm_request_submit(v_application_id,
							  v_user_responsibility_id,
							  v_user_id,
							  v_application,
							  v_program,
							  v_status,
							  o_request_id,
							  NULL,
							  NULL,
							  o_message,
						      o_errmsg
						 	  );


	   v_request_id := o_request_id;
	   v_errmsg := o_errmsg;
	   
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=o_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_CUSTOMER;

END Wm_Customer_Imp_Handler_Pkg;
/
Show error
