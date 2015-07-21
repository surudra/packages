/*  ***************************************************************************
        $Date:   07 Sept 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
        Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *                           - COPYRIGHT NOTICE -
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_apinvoice_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Open Payables Invoice Import
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
    * Procedures and Functions: wm_handle_openAP-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Open Payables Concurrent Request
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
     07-SEPT-02	   Rajib Naha   			Created
    ***************************************************************************
*/
  prompt Program : wm_into_apinvoice_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString


 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_AP_Inv_Imp_Handler_Pkg AS

-- Procedure to determine calling parameters for Open Payables Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Open Payables Import Concurrent Request

PROCEDURE WM_HANDLE_OPENAP( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_source IN VARCHAR,
			    p_batch_name IN VARCHAR,
			    p_gl_date IN DATE,
			    p_purge_date IN DATE
			    ) ;

END Wm_AP_Inv_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_AP_Inv_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_OPENAP(p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg OUT VARCHAR,
			    p_source IN VARCHAR,
			    p_batch_name IN VARCHAR,
			    p_gl_date IN DATE ,
			    p_purge_date IN DATE
			    )
IS
	v_program  				   VARCHAR2(20):='APXXTR'; -- AP Invoice Open Interface OA Module
	v_application		   	   	   VARCHAR2(20):='SQLAP'; -- Application
	v_version				   VARCHAR2(1):='A';
	v_gl_set_of_books_id			   NUMBER;
	v_chart_of_accounts_id			   NUMBER;
	v_summarize_report			   VARCHAR2(1);
	v_max_page_length			   NUMBER;
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	o_request_id				   NUMBER;
	o_errmsg				   VARCHAR2(1000);
	


BEGIN

	  -- Fetch Application id for AP Application
	  o_errmsg:='Fetching Application id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'SQLAP';
	  
	  -- Fetch the User Id 
	  o_errmsg:='Fetching the User Id';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  o_errmsg:='Fetching the Responsibility Id';
	  
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  
	  
	 -- Initialize environment
	         
	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);
	  
	-- Fetch the Set of Books Id
	
	  v_gl_set_of_books_id:=Fnd_Profile.Value('GL_SET_OF_BKS_ID');
	  
	-- Fetch the Chart of Accounts Id
	
	  SELECT chart_of_accounts_id 
	  INTO	 v_chart_of_accounts_id
	  FROM   gl_sets_of_books
	  WHERE  set_of_books_id = v_gl_set_of_books_id;
	  
	-- Fetch the maximum page length
	
	   v_max_page_length:= Fnd_Profile.Value('MAX_PAGE_LENGTH');
	   
		
       v_errmsg:='Calling Submit Request';
          
	  -- Call to submit request

	   wm_conc_request_pkg.wm_request_submit(v_application_id,
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
           			  	     	 v_version,
           			  	     	 to_char(v_chart_of_accounts_id),
           			  	     	 to_char(v_user_id),
           			  	     	 p_batch_name,
           			  	     	 to_char(v_gl_set_of_books_id),
           			  	     	 'N',
           			  	     	 p_source,
           			  	     	 to_char(p_gl_date,'YYYY/MM/DD'),
           			  	     	 v_max_page_length,
           			  	     	 NULL,
           			  	     	 NULL,
           			  	     	 'N'
						);
	v_request_id:=o_request_id;
	v_errmsg:=o_errmsg;
						 
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=o_errmsg||SQLERRM;
 v_status:='FAILED';	

END WM_HANDLE_OPENAP;

END Wm_AP_Inv_Imp_Handler_Pkg;
/

SHOW ERRORS

