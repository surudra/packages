/*  ***************************************************************************
        $Date:   04 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Packages for REQ inbound in Application Schema  
    * Program Name:         wm_into_req_pkg.sql
    * Version #:            1.0
    * Title:                Package Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to handle Inserts to WM_TRACKCHANGES table
    *
    * Tables usage:     		INSERT		UPDATE		DELETE
    *
    * Procedures and Functions: wm_handle_req-> Performs pre-processing actions to determine 
    *					  the values  to be called for Requisition Import Concurrent Request. 
    *					  It then submits the Requisition Import concurrent request. 
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
     04-NOV-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_req_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE Wm_Req_Imp_Handler_Pkg AS

-- Procedure to determine calling parameters for Requisition Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Requisition Import Concurrent Request

PROCEDURE WM_HANDLE_REQ( p_user_responsibility IN VARCHAR2,
			    p_user IN VARCHAR2,
			    v_status OUT VARCHAR2,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR2,
			    v_errmsg  OUT VARCHAR2,
			    p_source IN VARCHAR2,
			    p_batch_id IN NUMBER,
			    p_group_by IN VARCHAR2,
			    p_last_req_num IN VARCHAR2);


END Wm_Req_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Req_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_REQ (p_user_responsibility IN VARCHAR2,
			    p_user IN VARCHAR2,
			    v_status OUT VARCHAR2,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR2,
			    v_errmsg  OUT VARCHAR2,
			    p_source IN VARCHAR2,
			    p_batch_id IN NUMBER,
			    p_group_by IN VARCHAR2,
			    p_last_req_num IN VARCHAR2)

IS
	
	v_program  				   VARCHAR2(20):='REQIMPORT'; -- PO Requisition OA Module
	v_application		   	   	   VARCHAR2(20):='PO'; -- Application Short Name
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	o_request_id 				   VARCHAR2(240):=NULL;
	o_errmsg				   VARCHAR2(240):=NULL;
	
BEGIN

	  -- Fetch Application id for PO Application
	
	 o_errmsg:='Error selecting Application Id. ';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'PO';
	  
	  -- Fetch the User Id

 	 o_errmsg:='Error selecting User Id. ';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  
	 o_errmsg:='Error selecting Responsibility Id. ';

	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  
	
 	-- Call to Initialize Session Variables

	 o_errmsg:='Error initializing Application environment. ';


	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);


	-- Submit the concurrent request with required parameters

	 o_errmsg:='Error submitting Concurrent Request. ';

	 Wm_Conc_Request_Pkg.wm_request_submit(	v_application_id,
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
						p_source,
						to_char(p_batch_id),
						p_group_by,
						p_last_req_num);

	v_request_id := o_request_id;
	v_errmsg := o_errmsg;

EXCEPTION

	WHEN others THEN
	v_errmsg:= o_errmsg||sqlerrm;	
	v_status:='FAILED';	
 	
END WM_HANDLE_REQ;

END Wm_Req_Imp_Handler_Pkg;
/


SHOW ERRORS
