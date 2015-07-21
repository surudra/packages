/*  ***************************************************************************
        $Date:   07 Sept 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_bankstmt_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for Bank Statement Interface and recconciliation
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
    * Procedures and Functions: wm_handle_cebank	-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							Bank Statement Import and Reconciliation Concurrent Request
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
     12-SEPT-02	   Sudip Chaudhuri         Created
    ***************************************************************************
*/

prompt Program : wm_into_bankstmt_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString


 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_CE_Bank_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Bank Statement Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Bank Statement Import Concurrent Request

PROCEDURE WM_HANDLE_CEBANK( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_bank_branch_name IN VARCHAR,
			    p_bank_account_number IN VARCHAR,
			    p_statement_number_from IN VARCHAR,
			    p_statement_number_to IN VARCHAR,
			    p_statement_date_from IN DATE,
			    p_statement_date_to IN DATE,
			    p_gl_date IN DATE,
			    p_receivable_activity IN VARCHAR, 	 	
			    p_payment_method IN VARCHAR,
			    p_nsf_handling IN VARCHAR
			    ) ;

END Wm_CE_Bank_Imp_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_CE_Bank_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_CEBANK( p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR,
			    v_request_id OUT NUMBER,
			    o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_bank_branch_name IN VARCHAR,
			    p_bank_account_number IN VARCHAR,
			    p_statement_number_from IN VARCHAR,
			    p_statement_number_to IN VARCHAR,
			    p_statement_date_from IN DATE,
			    p_statement_date_to IN DATE,
			    p_gl_date IN DATE,
			    p_receivable_activity IN VARCHAR, 	 	
			    p_payment_method IN VARCHAR,
			    p_nsf_handling IN VARCHAR
			    )
IS
	v_program  				   VARCHAR2(20):='ARPLABIR'; -- Automatic Bank Reconciliation Program
	v_application		   	   	   VARCHAR2(20):='CE'; -- Application
	v_application_id		           NUMBER;
	v_user_id				   NUMBER;
	v_user_responsibility_id                   NUMBER;
	v_prg_mode				   VARCHAR2(100);
	v_bank_branch_id			   NUMBER;
	v_receivables_trx_id			   NUMBER;
	v_receipt_method_id			   NUMBER;
	v_bank_account_id			   NUMBER;
	v_nsf_handling_code			   VARCHAR2(100);
	
BEGIN

	  -- Fetch Application id for AP Application
	  v_errmsg:='Fetching Application Id';
	  
	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'CE';
	  
	  -- Fetch the User Id 
	  v_errmsg:='Fetching User Id';
	  
	  v_user_id:=wm_conc_request_pkg.get_user_id(p_user);
	  	  
	  -- Fetch the Responsibility Id
	  v_errmsg:='Fetching Responsibility Id';
	  
	  v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);
	  

	  -- Initialize environment
	  v_errmsg:='Initializing Apps Environment';
       
	  Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);
	  
	  -- Fetching the Program Mode
	  v_errmsg:='Fetching Program Mode';
	  
	  SELECT lookup_code
	  INTO   v_prg_mode
	  FROM   ce_lookups
	  WHERE  meaning='All'
	  AND    lookup_type = 'ABR_PROCESS_OPTION';
	  
	  -- Fetching the Bank Branch Id
	  v_errmsg:='Fetching Bank Branch Id';
	  
	  SELECT branch_party_id
	  INTO   v_bank_branch_id
	  FROM   ce_bank_branches_v
	  WHERE  bank_branch_name=p_bank_branch_name;
	  
	  -- Fetching the bank Account Id
	IF p_bank_account_number IS NOT NULL THEN

	  v_errmsg:='Fetching the bank Account Id';
	  SELECT bank_account_id
	  INTO   v_bank_account_id
	  FROM   ce_bank_accounts
	  WHERE  bank_branch_id = v_bank_branch_id
	  AND    bank_account_num=p_bank_account_number;

	END IF;
	  
	  
	  -- Fetching the Receivables Trx Id for the Receivable Activity
	IF p_receivable_activity IS NOT NULL THEN

	  v_errmsg:='Fetching Trx Id for the Receivable Activity Type';
	  
	  SELECT receivables_trx_id
	  INTO   v_receivables_trx_id
	  FROM   ar_receivables_trx_all
	  WHERE  set_of_books_id = fnd_profile.value('GL_SET_OF_BKS_ID')
	  AND    name = p_receivable_activity;

	END IF;
	  
	  -- Fetching the Receipt Method Id
	IF p_payment_method IS NOT NULL THEN

	  v_errmsg:='Fetching the Receipt Method Id';
	  
	  SELECT receipt_method_id
	  INTO   v_receipt_method_id
	  FROM   ce_receipt_methods_v
	  WHERE  receipt_method_id IN ( SELECT 
	  				rma.receipt_method_id
	  				FROM ar_receipt_method_accounts rma
	  				WHERE rma.REMIT_BANK_ACCT_USE_ID=v_bank_account_id)
	  AND   name = p_payment_method;

	END IF;
	  
	  -- Fetching NSF Handling Code

	IF p_nsf_Handling IS NOT NULL THEN

	  v_errmsg:='Fetching NSF Handling Code';
	  
	  SELECT lookup_code
	  INTO   v_nsf_handling_code
	  FROM   ce_lookups
	  WHERE  lookup_type = 'ABR_NSF_HANDLING'
	  AND    meaning = p_nsf_Handling;
	        
	END IF;

          --  dbms_output.put_line('Calling Submit Request');
          
	  -- Call to submit request

	   wm_conc_request_pkg.wm_request_submit(v_application_id,
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
           			  	     	 v_prg_mode,
                    				 to_char(v_bank_branch_id),
                      				 to_char(v_bank_account_id),
                    				 p_statement_number_from,
                    				 p_statement_number_to,
                    				 to_char(p_statement_date_from,'YYYY/MM/DD HH:MI:SS'),
                    				 to_char(p_statement_date_to,'YYYY/MM/DD HH:MI:SS'),
						 to_char(p_gl_date,'YYYY/MM/DD HH:MI:SS'),
						 NULL,
						 NULL,	
						 NULL,
						 NULL,
						 v_nsf_handling_code,
						 'N',
						 NULL,
						 NULL);
						 
EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED'; 	

END WM_HANDLE_CEBANK;

END Wm_CE_Bank_Imp_Handler_Pkg;
/

SHOW ERRORS

