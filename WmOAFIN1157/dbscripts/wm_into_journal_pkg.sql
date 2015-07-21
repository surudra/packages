/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Packages for GL Journal inbound in Application Schema  
    * Program Name:         wm_into_journal_pkg.sql
    * Version #:            1.0
    * Title:                Package Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to handle Journal Import Concurrent Request
    *
    * Tables usage:     	INSERT		UPDATE		DELETE
    *
    *GL_INTERFACE						  X
    *GL_INTERFACE_CONTROL	  X
    *
    * Procedures and Functions: wm_handle_journal-> Performs pre-processing actions to determine the values 
    *				to be called for Journal Import Concurrent Request
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


  prompt Program : wm_into_journal_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE Wm_Journal_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Journal Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Journal Import Concurrent Request

PROCEDURE WM_HANDLE_JOURNAL( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR2,
			    v_errmsg  OUT VARCHAR2,
			    p_user_je_source_name IN VARCHAR,
			    p_group_id IN NUMBER DEFAULT NULL,
			    p_suspense_flag IN VARCHAR,
			    p_start_date IN DATE DEFAULT NULL,
			    p_end_date IN DATE DEFAULT NULL,
			    p_summary_flag IN VARCHAR
			    );
			   

END Wm_Journal_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Journal_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_JOURNAL (p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR2,
			    v_errmsg  OUT VARCHAR2,
			    p_user_je_source_name IN VARCHAR,
			    p_group_id IN NUMBER DEFAULT NULL,
			    p_suspense_flag IN VARCHAR,
			    p_start_date IN DATE DEFAULT NULL,
			    p_end_date IN DATE DEFAULT NULL,
			    p_summary_flag IN VARCHAR
			    )
	IS
	v_program  				   VARCHAR2(20):='GLLEZL'; -- Gl Journal Import OA Module
	v_application			   	   VARCHAR2(20):='SQLGL'; -- Application
	v_run_id				   NUMBER;
	v_je_source_name			   VARCHAR2(240);
	v_grp_id				   NUMBER;
	v_application_id			   NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id		   NUMBER;
	v_set_of_books_id			   NUMBER;
	errmsg				VARCHAR2(200);
	
	
BEGIN

	  -- Fetch Application id for GL Application
	
	errmsg:='Error Selecting Application Id.';
  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'SQLGL';
	  
	  -- Fetch the User Id 

	errmsg:='Error Selecting User Id.';

	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	 
	errmsg:='Error Selecting Responsibility Id.';
 
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  

	  -- Fetch the Run Id for the Request from the

	errmsg:='Error Generating run id sequence.';


	  SELECT GL_JOURNAL_IMPORT_S.NEXTVAL
	  INTO   v_run_id
	  FROM   dual;

	-- NOTE: the source_name used here IS NOT the user_je_source_name
	
	-- Fetch the je_source_name for the Source

	errmsg:='Error Selecting je_source_name.';

	  SELECT je_source_name
	  INTO   v_je_source_name
	  FROM   gl_je_sources
	  WHERE  user_je_source_name=p_user_je_source_name;
	  
	-- If the Group Id passed is null then generate the group id and update the Gl Interface table
	-- Else use the same group id to Insert into gl_interface_control
	
	IF p_group_id IS NULL THEN

	errmsg:='Error Generating group id sequence.';
	   
	   SELECT gl_interface_control_s.nextval
	   INTO   v_grp_id
	   FROM   dual;
	   
	-- Update the Gl Interface for the Source using the Group Id generated above
	-- For Unprocessed Records Only

	errmsg:='Error Updating group id.';

	   UPDATE gl_interface
	   SET    group_id = v_grp_id
	   WHERE  user_je_source_name=p_user_je_source_name
	   AND    status='NEW'
	   AND    request_id IS NULL;
	   
	ELSE
	   v_grp_id:=p_group_id;
	END IF;
	
	--- Initialize Application Profiles and Global Variables

	errmsg:='Error initializing environment inside handle journal.';

	Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);
		
	-- Fetch the Set of Books for the User Environment

	errmsg:='Error Getting set of book id from Applications profile.';
		
	v_set_of_books_id:=Fnd_Profile.Value('GL_SET_OF_BKS_ID');

	errmsg:='Error Inserting into gl_interface_control.';
	
	INSERT 
	INTO 
	gl_interface_control
	(je_source_name,
	 status,
	 interface_run_id,
	 set_of_books_id,
	 group_id)
	VALUES
	(v_je_source_name, 
	 'S', 
	 v_run_id, 
	 v_set_of_books_id, 
	 v_grp_id); 
	
	COMMIT;
	
	
                   
	  -- Call to submit request

	errmsg:='Error Calling Wm_Conc_Request_Pkg package.';

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
									to_char(v_run_id),
                    						to_char(v_set_of_books_id)	,
                      						p_suspense_flag,
                    						TO_CHAR(p_start_date,'DD-MON-YYYY'),
                    						TO_CHAR(p_end_date,'DD-MON-YYYY'),
                    						p_summary_flag,
                    						'N'
                    						);
                              						
EXCEPTION

WHEN others THEN
	v_errmsg:=errmsg||sqlerrm;
	v_status:='FAILED';
	
END WM_HANDLE_JOURNAL;

END Wm_Journal_Imp_Handler_Pkg;
/

SHOW ERRORS

