/*  ***************************************************************************
        $Date:   04 Oct 2002 10:56:36  $
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
     04-OCT-02	   Rajib Naha		   Created
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
CREATE OR REPLACE PACKAGE Wm_Req_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Requisition Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Requisition Import Concurrent Request

PROCEDURE WM_HANDLE_REQ( p_user_responsibility IN VARCHAR2,
			    p_user IN VARCHAR2,
			    v_status OUT VARCHAR2,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR2,
			    v_errmsg  OUT VARCHAR2,
			    p_orgname IN VARCHAR2,
			    p_source IN VARCHAR2,
			    p_batch_id IN NUMBER,
			    p_group_by IN VARCHAR2,
			    p_last_req_num IN NUMBER,
			    p_ini_approval_reqimp IN VARCHAR2);


END Wm_Req_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Req_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_REQ (p_user_responsibility IN VARCHAR2,
			    p_user IN VARCHAR2,
			    v_status OUT VARCHAR2,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR2,
			    v_errmsg  OUT VARCHAR2,
			    p_orgname IN VARCHAR2,
			    p_source IN VARCHAR2,
			    p_batch_id IN NUMBER,
			    p_group_by IN VARCHAR2,
			    p_last_req_num IN NUMBER,
			    p_ini_approval_reqimp IN VARCHAR2)

IS
	
	v_program  				   VARCHAR2(20):='REQIMPORT'; -- PO Requisition OA Module
	v_application		   	   	   VARCHAR2(20):='PO'; -- Application Short Name
	v_ini_approval_reqimp	                   VARCHAR2(1);
	v_multi_dist				   VARCHAR2(1) := 'Y';
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
        v_org_id				NUMBER;
	errmsg				VARCHAR2(240):=NULL;
	v_multi_org_flag                VARCHAR2(1) := 'N';
	
BEGIN

	  -- Fetch Application id for PO Application
	
	 errmsg:='Error selecting Application Id. ';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'PO';

	if p_orgname is not null then
		-- Fetch Org Id
		SELECT organization_id
		INTO   v_org_id
		FROM   hr_all_organization_units 
		WHERE  name = p_orgname;
	end if;

	  
	  -- Fetch the User Id

 	 errmsg:='Error selecting User Id. ';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  
	 errmsg:='Error selecting Responsibility Id. ';

	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  
	
	-- Convrting input values of Initiate Approval to BOOLIAN values
	
	IF UPPER(p_ini_approval_reqimp) = 'NO' THEN
	   v_ini_approval_reqimp := 'N';
	ELSE 
	   v_ini_approval_reqimp := 'Y';
	END IF;

 	-- Call to Initialize Session Variables

	 errmsg:='Error initializing Application environment. ';


	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);

	  select multi_org_flag into v_multi_org_flag from fnd_product_groups; 

	-- If multi org is on, then get the orgid and set it.
	if p_orgname is not null then
          	if v_multi_org_flag = 'Y' then 
			-- Fetch Org Id
			SELECT organization_id
			INTO   v_org_id
			FROM   hr_all_organization_units 
			WHERE  name = p_orgname;
	  		FND_REQUEST.SET_ORG_ID(v_org_id);
		end if;
	end if;



	-- Submit the concurrent request with required parameters

	 errmsg:='Error submitting Concurrent Request. ';

	 Wm_Conc_Request_Pkg.wm_request_submit(	v_application_id,
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
						to_char(p_batch_id),
						p_group_by,
						to_char(p_last_req_num),
						v_multi_dist,
						v_ini_approval_reqimp);

EXCEPTION

	WHEN others THEN
	v_errmsg:=errmsg||sqlerrm;	
	v_status:='FAILED';	
 	
END WM_HANDLE_REQ;

END Wm_Req_Imp_Handler_Pkg;
/


SHOW ERRORS
