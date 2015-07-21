 /***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *				
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_periodiccost_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Periodic Cost Open Interface
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call Periodic Cost Import Program
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: wm_handle_periodic_cost-> Performs pre-processing actions to determine the values 
    *				to be called for Periodic Cost Import Concurrent Request
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
     19-SEP-02	 Panchali Samanta        Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_periodiccost_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_Pc_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Periodic Cost Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Periodic Cost Import Concurrent Request

PROCEDURE WM_HANDLE_PERIODIC_COST( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    v_delete_flag IN VARCHAR
			    );
			   

END Wm_Pc_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Pc_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_PERIODIC_COST(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    v_delete_flag IN VARCHAR
			    )
	IS
	v_program  				   VARCHAR2(20):='CMCPIM'; -- Periodic Cost Import
	v_application				   VARCHAR2(20):='BOM'; -- Application
	v_application_id			   NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id		   NUMBER;
	v_delete_id				   NUMBER;
	

BEGIN

	  -- Fetch Application id for BOM Application
	  v_errmsg:='Fetching the Application Id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'BOM';
	  
	  -- Fetch the User Id 
	  v_errmsg:='Fetching the User Id';
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_errmsg:='Fetching the Responsibility Id';

        v_user_responsibility_id:= wm_conc_request_pkg.get_user_responsibility_id( p_user_responsibility);

	  v_errmsg:='Fetching Delete Flag';
	  
        SELECT lookup_code 
        INTO   v_delete_id
        FROM   mfg_lookups 
        WHERE  lookup_type = 'SYS_YES_NO' 
        AND    meaning = v_delete_flag;

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
           			  	     			v_delete_id);
                    						
EXCEPTION
WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;                              						
	

END WM_HANDLE_PERIODIC_COST;

END Wm_Pc_Imp_Handler_Pkg;
/

SHOW ERRORS
