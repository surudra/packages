/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Packages for PO inbound in Application Schema  
    * Program Name:         wm_into_po_pkg.sql
    * Version #:            1.0
    * Title:                Package Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to handle submission of Open PO Document Concurrent Request
    *
    * Tables usage:     	INSERT		UPDATE		DELETE
    * PO_HEADERS_INTERFACE    			 X		              
    *
    * Procedures and Functions: wm_handle_openPO-> Performs pre-processing actions to determine 
    *					  the values  to be called for Open Purchasing Concurrent Request. 
    *					  It then submits the Open PO concurrent request. 
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
     12-AUG-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_po_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE Wm_OpenPO_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Open Purchasing Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Open Purchasing Import Concurrent Request

PROCEDURE WM_HANDLE_OPENPO( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    p_program_name IN VARCHAR2,
			    v_request_id OUT NUMBER,
			    p_default_buyer IN VARCHAR2 DEFAULT NULL,
			    p_document_type IN VARCHAR2 DEFAULT 'Standard',
			    p_document_subtype IN VARCHAR2 DEFAULT NULL,
			    p_create_update_items IN VARCHAR2 DEFAULT 'No',
			    p_create_sourcing_rules IN VARCHAR2 DEFAULT 'No',
			    p_approval_status IN VARCHAR2 DEFAULT NULL,
			    p_release_generation_method IN VARCHAR2 DEFAULT NULL,
			    p_batch_id IN NUMBER DEFAULT NULL,
			    p_global_agreement IN VARCHAR2 DEFAULT 'No',
			    v_errmsg OUT VARCHAR2,
          p_org_name IN VARCHAR2 DEFAULT NULL);

END Wm_OpenPO_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_OpenPO_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_OPENPO (p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    p_program_name IN VARCHAR2,
			    v_request_id OUT NUMBER,
			    p_default_buyer IN VARCHAR2 DEFAULT NULL,
			    p_document_type IN VARCHAR2 DEFAULT 'Standard',
			    p_document_subtype IN VARCHAR2 DEFAULT NULL,
			    p_create_update_items IN VARCHAR2 DEFAULT 'No',
			    p_create_sourcing_rules IN VARCHAR2 DEFAULT 'No',
			    p_approval_status IN VARCHAR2 DEFAULT NULL,
			    p_release_generation_method IN VARCHAR2 DEFAULT NULL,
			    p_batch_id IN NUMBER DEFAULT NULL,
			    p_global_agreement IN VARCHAR2 DEFAULT 'No',
			    v_errmsg OUT VARCHAR2,
          p_org_name IN VARCHAR2 DEFAULT NULL)
	IS

	--v_program  				   VARCHAR2(20):='POXPOPDOI'; -- PO Open Purchasing OA Module
	v_application		   	   	   VARCHAR2(20):='PO'; -- Application
	v_default_buyer_per_id	                   NUMBER;
	v_create_update_items	                   VARCHAR2(1);
	v_create_sourcing_rules	                   VARCHAR2(1);
	v_release_gen_method	                   VARCHAR2(30);
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	v_batch_id					NUMBER;
	v_global_agreement				VARCHAR2(1);
	errmsg				VARCHAR2(240):=NULL;
  v_org_id NUMBER;

BEGIN

	  -- Fetch Application id for PO Application

	 errmsg:='Error selecting Application Id. ';

	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'PO';

	  -- Fetch the User Id

 	 errmsg:='Error selecting User Id. ';

	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);

	  -- Fetch the Responsibility Id

	 errmsg:='Error selecting Responsibility Id. ';

	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);


	  -- Fetch the Default Buyer's Person Id for the Request

	 errmsg:='Error selecting Default Buyer Id. ';

	  IF p_default_buyer IS NOT NULL THEN

		 SELECT  PERSON_ID
		 INTO    v_default_buyer_per_id
		 FROM    PER_ALL_PEOPLE_F
		 WHERE   FULL_NAME = p_default_buyer
		 AND     SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE ;

 	  END IF;

	-- Convrting input values of update items and sourcing rules to BOOLIAN values

	IF UPPER(p_create_update_items) = 'NO' THEN
	   v_create_update_items := 'N';
	ELSE
	   v_create_update_items := 'Y';
	END IF;

	IF UPPER(p_create_sourcing_rules) = 'NO' THEN
	   v_create_sourcing_rules := 'N';
	ELSE
	   v_create_sourcing_rules := 'Y';
	END IF;

	-- Fetch the Release_Generation_Method for the Source

	IF p_release_generation_method IS NOT NULL THEN

	 errmsg:='Error selecting Release generation method. ';

		SELECT LOOKUP_CODE
		INTO v_release_gen_method
		FROM PO_LOOKUP_CODES
		WHERE  LOOKUP_TYPE = 'DOC GENERATION METHOD'
		AND DISPLAYED_FIELD = p_release_generation_method;

	END IF;

	-- Convrting input values of global agreement to BOOLEAN values

	IF UPPER(p_global_agreement) = 'NO' THEN
	   v_global_agreement := 'N';
	ELSE
	   v_global_agreement := 'Y';
	END IF;

         -- dbms_output.put_line('Calling Submit Request');

	  -- unique batch id generated

	 errmsg:='Error generating Batch Id sequence. ';

	SELECT wm_po_batch_s.nextval
	INTO v_batch_id
	FROM dual;

	-- Update the records pertaining to a particular document type with the unique batch id

	 errmsg:='Error updating PO_HEADERS_INTERFACE with the Batch ID. ';

	UPDATE po_headers_interface
	SET batch_id=v_batch_id
	WHERE batch_id=p_batch_id
	AND document_type_code=p_document_type;


  --Change 17-May-20004 for passing Org Id
  IF p_org_name IS NOT NULL THEN  
     SELECT ORGANIZATION_ID 
     INTO v_org_id
     FROM ORG_ORGANIZATION_DEFINITIONS 
     WHERE ORGANIZATION_NAME = p_org_name;  
  END IF;
  

 	  --- Call to Initialize Session Variables

	 errmsg:='Error initializing Application environment. ';


	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);


	-- Submit the concurrent request with required parameters

	 errmsg:='Error submitting Concurrent Request. ';

	  v_request_id := fnd_request.submit_request( v_application,
			  					  p_program_name,
			  					  NULL,
			  					  NULL,
			  					  FALSE,
                    			  	  	to_char(v_default_buyer_per_id),
							  	p_document_type	,
							  	p_document_subtype,
							  	v_create_update_items,
							  	v_create_sourcing_rules,
							  	p_approval_status,
							  	v_release_gen_method,
							  	to_char(v_batch_id),
								v_org_id,
								v_global_agreement);

	COMMIT;
/*

	 Wm_Conc_Request_Pkg.wm_request_submit(v_application_id,
							  v_user_responsibility_id,
							  v_user_id,
							  v_application,
							  v_program,
							  v_status,
							  v_request_id,
							  NULL,
							  NULL,
							  to_char(v_default_buyer_per_id),
							  p_document_type	,
							  p_document_subtype,
							  v_create_update_items,
							  v_create_sourcing_rules,
							  p_approval_status,
							  v_release_gen_method,
							  to_char(p_batch_id),
							  v_global_agreement);


*/

EXCEPTION

	WHEN others THEN
	v_errmsg:=errmsg||sqlerrm;

END WM_HANDLE_OPENPO;

END Wm_OpenPO_Imp_Handler_Pkg;
/


SHOW ERRORS
