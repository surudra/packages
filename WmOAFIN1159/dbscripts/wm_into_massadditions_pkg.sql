/*  ***************************************************************************
        $Date:   07 Sept 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
        Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_massadditions_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for FA Mass Additions Import
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
    * Procedures and Functions: wm_handle_fa_massadd-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							FA Mass Additions Concurrent Request Set
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
     17-SEPT-02	   Sudip Chaudhuri         Created
    ***************************************************************************
*/

  prompt Program : wm_into_massadditions_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString


 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_FA_MassAdd_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for FA Mass Additions Import Concurrent Request Set
-- Takes in the mandatory and optional parameters required for FA Mass Additions Import Concurrent Request

PROCEDURE WM_HANDLE_Fa_MassAdd( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_book_name IN VARCHAR
			    ) ;

END Wm_FA_MassAdd_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_FA_MassAdd_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_Fa_MassAdd(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_book_name IN VARCHAR
			    )
IS
	v_request_set				   VARCHAR2(50):= 'FNDRSSUB46';
	v_application			   	   VARCHAR2(20):='OFA'; -- Application
	v_application_id			   NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id		   NUMBER;
	submit_failed				   EXCEPTION;
	v_success				   BOOLEAN;
--	v_boolean				   BOOLEAN;
--	v_phase					   VARCHAR2(100);
--	v_request_status				   VARCHAR2(100);
--	v_dev_phase				   VARCHAR2(100);
--	v_dev_status				   VARCHAR2(100);
       

BEGIN

	
	  -- Fetch Application id for FA Application
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
	  
	  -- Initialize Ora Apps Environment
	  
	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);
	  
	  -- Set the Request Set Context
	  v_errmsg:='Setting up the Request Set Context';
	  
	  v_success:= Fnd_Submit.set_request_set(v_application,v_request_set);
	  
	  IF (v_success) THEN
	  
	  	-- Submit program FAMAPT which is Mass Additions Post in STAGE 10
	  	v_errmsg:='Submit Program FAMAPT';
	  	
	  	v_success:= Fnd_Submit.submit_program(v_application,
	  						'FAMAPT',
	  						'STAGE10',
	  						p_book_name,
	  						'NORMAL');
	  						
	  						
          
          	IF (NOT v_success) THEN
          	raise submit_failed;
          	END IF;
          
          
          	-- Submit Program FAS824 which the Mass Additions Post Report in STAGE20
          	v_errmsg:='Submit Program FAS824';
          	
          	v_success:= Fnd_Submit.submit_program(v_application,
          						'FAS824',
          						'STAGE20',
          						p_book_name);
          						
          						
	  	IF (NOT v_success) THEN
	  	raise submit_failed;
	  	END IF;
	  
	  	-- Submit the Request Set
	  	v_errmsg:='Submitting the Request Set';
	  		  
	  	v_request_id:=Fnd_Submit.submit_set(NULL,FALSE);
	  
	  END IF;		
	  
	  Commit;
	  
	  Wm_Conc_Request_Pkg.CHECK_CONC_PROG_STATUS(v_request_id, 10, v_status, o_message, v_errmsg);
/*
	  v_boolean := fnd_concurrent.wait_for_request(                                               	        5,
                                              		1000,
		                                       	v_phase,
                                                       	v_request_status,
                                                       	v_dev_phase,
                                                       	v_dev_status,
                                                       	o_message);	
                                                       	
          IF v_dev_phase = 'COMPLETE' AND v_dev_status IN ('NORMAL','WARNING') THEN
      	 	v_status := 'SUCCESS';
      	  ELSE
                v_status := 'FAILED';
      	  END IF;                                                       	
*/  
EXCEPTION
  
 WHEN submit_failed THEN
 v_errmsg:='Request Set Submission Failed at:'||v_errmsg;
 v_status:='FAILED';
 
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_Fa_MassAdd;

END Wm_Fa_MassAdd_Imp_Handler_Pkg;
/

SHOW ERRORS

