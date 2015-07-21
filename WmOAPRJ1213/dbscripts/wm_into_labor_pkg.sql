/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_labor_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Project Accounting Labor Transactions
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
    * Procedures and Functions: wm_handle_LaborTxn-> Performs pre-processing actions to determine the values 
    *				to be called for PRC: Transaction Import which is the Concurrent Request for
    *				Labor Transaction
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
     07-SEP-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_labor_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_LaborTxn_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Journal Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Journal Import Concurrent Request

PROCEDURE WM_HANDLE_LABORTXN( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_transaction_source IN VARCHAR,
			    p_batch_name IN VARCHAR,
			    p_orgname IN VARCHAR
			    );
			   
END Wm_LaborTxn_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_LaborTxn_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_LABORTXN (p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_transaction_source IN VARCHAR,
			    p_batch_name IN VARCHAR,
			    p_orgname IN VARCHAR
			    )
	IS
	v_program  				   VARCHAR2(20):='PAXTRTRX'; -- PA Import OA Module
	v_application			   	   VARCHAR2(20):='PA'; -- Application
	v_run_id				   NUMBER;
	v_application_id			   NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id		   NUMBER;
	v_transaction_source			   VARCHAR2(30);
	v_org_id				   NUMBER;
	v_multi_org_flag			   VARCHAR2(1) := 'N';

BEGIN

	  -- Fetch Application id for GL Application
	  v_errmsg:='Fetching Application Id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'PA';
	  
	  -- Fetch the User Id 
	  v_errmsg:='Fetching User Id';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_errmsg:='Fetching Responsibility Id';
	  
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  
	  -- Fetch the Transaction Source for the user transaction source that was entered
	  v_errmsg:='Fetching Transaction Source';
	  
	  SELECT transaction_source
	  INTO   v_transaction_source
	  FROM   pa_transaction_sources
	  WHERE  user_transaction_source=p_transaction_source;

	  
	  -- Fetch the multiOrg flag
	  select multi_org_flag into v_multi_org_flag from fnd_product_groups; 

	  -- If multi org is on, then get the orgid and set it.
	  if p_orgname is not null then
          	if v_multi_org_flag = 'Y' then 
			-- Fetch Org Id
			SELECT organization_id
			INTO   v_org_id
			FROM   ORG_ORGANIZATION_DEFINITIONS 
			WHERE  ORGANIZATION_NAME = p_orgname;
		end if;
	  end if;

	  -- set the org id
	  Fnd_Request.set_org_id(v_org_id);

	  -- Call to submit request
	  v_errmsg:='Submitting Concurrent Request';

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
						v_transaction_source,
						p_batch_name
						);
                              				
                              				
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;

	

END WM_HANDLE_LABORTXN;

END Wm_LaborTxn_Imp_Handler_Pkg;
/

SHOW ERRORS

