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
    * Program Name:         wm_into_rcv_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Receiving Open Interface
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
    * Procedures and Functions: wm_handle_receiving-> Performs pre-processing actions to determine the values 
    *				to be called for Receiving Import Concurrent Request
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
     05-SEP-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_rcv_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_Receiving_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Receiving Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Receiving Import Concurrent Request

PROCEDURE WM_HANDLE_RECEIVING( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR
			    );
			   

END Wm_Receiving_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Receiving_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_RECEIVING(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR
			    )
	IS
	v_program  				   VARCHAR2(20):='RVCTP'; -- Receiving Import OA Module
	v_application			   	   VARCHAR2(20):='PO'; -- Application
	v_application_id			   NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id		   NUMBER;
	

BEGIN

	  -- Fetch Application id for GL Application
	  v_errmsg:='Fetching the Application Id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'PO';
	  
	  -- Fetch the User Id 
	  v_errmsg:='Fetching the User Id';
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_errmsg:='Fetching the Responsibility Id';
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  

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
           			  	     			'BATCH',
           			  	     			NULL
                    						);
                    						
EXCEPTION
WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED';                            						
	

END WM_HANDLE_RECEIVING;

END Wm_Receiving_Imp_Handler_Pkg;
/

SHOW ERRORS

