/*  ***************************************************************************
        $Date:   07 Sept 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   TCS  $
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_bom_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for BOM Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the Bills and Routing Interface
    *			Concurrent Request. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: WM_HANDLE_BOM-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							BOM Concurrent Request
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
     07-OCT-02	Indrani Das			Created
    ***************************************************************************
*/

  prompt Program : wm_into_bom_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString


 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_Bom_Imp_Handler_Pkg AS

-- Procedure to determine calling parameters for Bom Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Bom Import Concurrent Request

PROCEDURE WM_HANDLE_BOM( 
			    p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR2,
			    v_request_id  OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg   OUT VARCHAR,
                      p_orgname IN VARCHAR,
                      p_allorg IN VARCHAR,
			    p_routing IN VARCHAR,
                      p_bom IN VARCHAR,
                      p_delete IN VARCHAR
			    );

END Wm_Bom_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Bom_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_BOM (
			    p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR2,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
                      p_orgname IN VARCHAR,
                      p_allorg IN VARCHAR,
			    p_routing IN VARCHAR,
                      p_bom IN VARCHAR,
                      p_delete IN VARCHAR
			    )
	IS

	v_program  				   VARCHAR2(20):= 'BMCOIN'; -- Bom Concurrent Program
	v_application		   	   VARCHAR2(20):= 'BOM'; -- Application
	v_application_id		   	   NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id   	   NUMBER;
      v_org_id					NUMBER;
      v_all_org					NUMBER;
      v_routing					NUMBER;
      v_bom						NUMBER;
      v_delete					NUMBER;
      t_errmsg                  VARCHAR2(200);
      t_request_id              NUMBER;
	v_stmt			  VARCHAR2(100);
	
BEGIN

	-- Fetch Application id for BOM Application
	v_stmt:='Fetching Application Id';

	SELECT application_id
	INTO   v_application_id
	FROM   fnd_application
	WHERE  application_short_name = 'BOM';
	  
	-- Fetch Org Id
if p_orgname is not null then
	v_stmt:='Fetching Organization Id';

	SELECT organization_id
	INTO   v_org_id
	FROM   hr_all_organization_units 
	WHERE  name = p_orgname;	  
end if;

if p_allorg is not null then
	v_stmt:='Fetching All Org Lookup code';
	  
	SELECT lookup_code
	INTO   v_all_org
	FROM   mfg_lookups
	WHERE  lookup_type = 'SYS_YES_NO'
  	AND meaning = p_allorg;
end if;

if p_routing is not null then
	v_stmt:='Fetching Routing Lookup code';

	SELECT lookup_code
	INTO   v_routing
	FROM   mfg_lookups
	WHERE  lookup_type = 'SYS_YES_NO'
  	AND meaning = p_routing;
end if;

if p_bom is not null then
	v_stmt:='Fetching BOM Lookup code';

	SELECT lookup_code
	INTO   v_bom
	FROM   mfg_lookups
	WHERE  lookup_type = 'SYS_YES_NO'
  	AND meaning = p_bom;
end if;

if p_delete is not null then
	v_stmt:='Fetching Delete Lookup code';

	SELECT lookup_code
	INTO   v_delete
	FROM   mfg_lookups
	WHERE  lookup_type = 'SYS_YES_NO'
  	AND meaning = p_delete;
end if;

     	-- Fetch the User Id
	  
	v_user_id := wm_conc_request_pkg.get_user_id(p_user);

	-- Fetch the Responsibility Id

	v_user_responsibility_id := wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);

	  
	-- Initialize Application Profiles and Global Variables
		
	Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);

		
	--  dbms_output.put_line('Calling Submit Request');

	-- Call to submit request
	v_stmt:='Submitting Concurrent Request';

	Wm_Conc_Request_Pkg.wm_request_submit(v_application_id,
							  v_user_responsibility_id,
							  v_user_id,
							  v_application,
							  v_program,
							  v_status,
							  t_request_id,
							  NULL,
							  NULL,
							  o_message,
						        t_errmsg,
							  v_org_id,
							  v_all_org,
							  v_routing,
							  v_bom,
							  v_delete
						 	  );

    v_errmsg := t_errmsg;
    v_request_id := t_request_id;
    
EXCEPTION
WHEN OTHERS THEN
	v_errmsg := v_stmt||SQLERRM;
 	v_status:='FAILED';	


END WM_HANDLE_BOM;

END Wm_Bom_Imp_Handler_Pkg;
/

