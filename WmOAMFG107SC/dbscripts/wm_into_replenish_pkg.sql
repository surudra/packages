 /***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_replenish_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Open Replenishment Interface
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
    * Procedures and Functions: wm_handle_open_replenish-> Performs pre-processing actions to determine the values 
    *				to be called for Open Replenishment Concurrent Request
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


  prompt Program : wm_into_replenish_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE wm_open_replenish_Handler_Pkg AS

-- Procedure to determine calling parameters for Open Replenishment Concurrent Request
-- Takes in the mandatory and optional parameters required for Open Replenishment Concurrent Request

PROCEDURE WM_HANDLE_OPEN_REPLENISH( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_count_name IN VARCHAR2
			    );
			   

END wm_open_replenish_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY wm_open_replenish_Handler_Pkg AS

PROCEDURE WM_HANDLE_OPEN_REPLENISH(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_count_name IN VARCHAR2
			    )
	IS
	v_program2 			 VARCHAR2(20):='INCRPR'; 
						-- Open Replenishment Process
	v_program1 			 VARCHAR2(20):='INCRVL'; 
						-- Open Replenishment Validation
	v_application		 VARCHAR2(20):='INV'; -- Application
	v_application_id		 NUMBER;
	v_user_id			 NUMBER;
	v_user_responsibility_id NUMBER;
	v_header_id              VARCHAR2(100);
	v_Found                  VARCHAR2(1);
	v_statement              VARCHAR2(1000);
	v_request_id1            NUMBER;
	v_request_id2            NUMBER;
	v_status1                VARCHAR2(100);
	v_status2                VARCHAR2(100);

	CURSOR c1 IS
	SELECT REPLENISHMENT_HEADER_ID
	FROM   mtl_replenish_headers_int
	WHERE  REPLENISHMENT_COUNT_NAME = p_count_name;

BEGIN

	  -- Fetch Application id for INV Application
	  v_statement :='Fetching the Application Id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'INV';
	  
	  -- Fetch the User Id 
	  v_statement :='Fetching the User Id';
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_statement :='Fetching the Responsibility Id';

        v_user_responsibility_id:= wm_conc_request_pkg.get_user_responsibility_id( p_user_responsibility);

	  v_statement :='Fetching replenishment header ID';
	  
	  SELECT REPLENISHMENT_HEADER_ID
	  INTO   v_header_id
	  FROM   mtl_replenish_headers_int
	  WHERE  REPLENISHMENT_COUNT_NAME = p_count_name;

 Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);

	  -- Call to submit request
        v_statement:='Submitting the Concurrent Request for Validation';
          
	  Wm_Conc_Request_Pkg.wm_request_submit(v_application_id,
	  							v_user_responsibility_id,
	  							v_user_id,
	  							v_application,
			  			     		v_program1,
			  			     		v_status1,
			  			     		v_request_id1,
			  			     		NULL,
			  			     		NULL,
			  			     		o_message,
			  			     		v_errmsg,
           			  	     			2,
           			  	     			v_header_id);
	v_request_id := v_request_id1;
	v_status := v_status1;
	-- If validation is sucessful then invoke Replenishment Process
	  IF v_status1 = 'SUCCESS' THEN
		v_statement:='open c1';
		OPEN c1;
		v_statement:='fetch c1';
		FETCH c1 INTO v_header_id;
		IF c1%FOUND THEN
			v_Found := 'Y';
		ELSE
			v_Found := 'N';
		END IF;
		v_statement:='close c1';
		CLOSE c1;
		IF v_Found = 'N' THEN
		  /* Data has been loaded into MTL_REPLENISH_HEADERS 
		  after sucessful validation */
		  -- Call to submit request
	        v_statement:='Submitting Concurrent Request for Processing';
		  Wm_Conc_Request_Pkg.wm_request_submit(v_application_id,
							v_user_responsibility_id,
							v_user_id,
							v_application,
		  			     		v_program2,
		  			     		v_status2,
		  			     		v_request_id2,
		  			     		NULL,
		  			     		NULL,
		  			     		o_message,
		  			     		v_errmsg,
           		  	     			2,
           		  	     			v_header_id);
		  v_request_id := v_request_id2;
		  v_status := v_status2;
		END IF;
	  END IF;
                    						
EXCEPTION
WHEN OTHERS THEN
 v_errmsg:=v_statement||SQLERRM;                              						
 v_status:='FAILED'; 	

END WM_HANDLE_OPEN_REPLENISH;

END wm_open_replenish_Handler_Pkg;
/


SHOW ERRORS

