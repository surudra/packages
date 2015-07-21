/*  ***************************************************************************
        $Date:   07 Sept 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
        Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_autoinvoice_pkg.sql
    * Version #:            1.0
    * Title:                Pre-processing Script for AutoInvoice Import
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to call the AutoInvoice Interface
    *			Concurrent Request. 
    *
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: WM_HANDLE_AUTOINVOICE-> Performs pre-processing 
    * 			 	 			actions to determine the values  to be called for 
    *							autoinvoice Concurrent Request
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
  prompt Program : wm_into_autoinvoice_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_AutoInvoice_Imp_Handler_Pkg AUTHID CURRENT_USER AS

-- Procedure to determine calling parameters for Auto Invoice Import Concurrent Request
-- Takes in the mandatory and optional parameters required for Auto Invoice Import Concurrent Request

PROCEDURE WM_HANDLE_AUTOINVOICE( p_user_responsibility IN VARCHAR,
			         p_user IN VARCHAR,
			         v_status OUT VARCHAR2,
			         v_request_id OUT NUMBER,
			         o_message OUT VARCHAR,
			         v_errmsg  OUT VARCHAR,	
			         p_instance_count IN NUMBER,
			         p_invoice_source IN VARCHAR2 ,
			         p_default_date IN DATE ,
				 p_trans_flexfield IN VARCHAR2 DEFAULT NULL,
				 p_transaction_type IN VARCHAR2 DEFAULT NULL,
				 p_bill_to_customer_num_low IN VARCHAR2 DEFAULT NULL,
				 p_bill_to_customer_num_high IN VARCHAR2 DEFAULT NULL,
				 p_bill_to_customer_name_low IN VARCHAR2 DEFAULT NULL,
				 p_bill_to_customer_name_high IN VARCHAR2 DEFAULT NULL,
				 p_GL_Date_low IN VARCHAR2 DEFAULT NULL,
				 p_GL_Date_high IN VARCHAR2 DEFAULT NULL,
				 p_ship_date_low IN VARCHAR2 DEFAULT NULL,
				 p_ship_date_high IN VARCHAR2 DEFAULT NULL,
				 p_transaction_num_low IN VARCHAR2 DEFAULT NULL,
				 p_transaction_num_high IN VARCHAR2 DEFAULT NULL,
				 pa_sales_order_num_low IN VARCHAR2 DEFAULT NULL,
				 p_sales_order_num_high IN VARCHAR2 DEFAULT NULL,
				 p_invoice_date_low IN VARCHAR2 DEFAULT NULL,
				 p_invoice_date_high IN VARCHAR2 DEFAULT NULL,
				 p_ship_to_customer_num_low IN VARCHAR2 DEFAULT NULL,
				 p_ship_to_customer_num_high IN VARCHAR2 DEFAULT NULL,
				 p_ship_to_customer_name_low IN VARCHAR2 DEFAULT NULL,
				 p_ship_to_customer_name_high IN VARCHAR2 DEFAULT NULL,
				 p_base_due_date_on_trx_date IN VARCHAR2 DEFAULT 'Y',
				 p_due_date_adjust_days IN VARCHAR2 DEFAULT NULL,
				 p_org_name IN VARCHAR2 DEFAULT NULL
			    );

END Wm_AutoInvoice_Imp_Handler_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Wm_AutoInvoice_Imp_Handler_Pkg AS

PROCEDURE WM_HANDLE_AUTOINVOICE (p_user_responsibility IN VARCHAR,
			    p_user IN VARCHAR,
			    v_status OUT VARCHAR2,
			    v_request_id OUT NUMBER,
                            o_message OUT VARCHAR,
			    v_errmsg  OUT VARCHAR,
			    p_instance_count IN NUMBER,
			    p_invoice_source IN VARCHAR2 ,
			    p_default_date IN DATE ,
				p_trans_flexfield IN VARCHAR2 DEFAULT NULL,
				p_transaction_type IN VARCHAR2 DEFAULT NULL,
				p_bill_to_customer_num_low IN VARCHAR2 DEFAULT NULL,
				p_bill_to_customer_num_high IN VARCHAR2 DEFAULT NULL,
				p_bill_to_customer_name_low IN VARCHAR2 DEFAULT NULL,
				p_bill_to_customer_name_high IN VARCHAR2 DEFAULT NULL,
				p_GL_Date_low IN VARCHAR2 DEFAULT NULL,
				p_GL_Date_high IN VARCHAR2 DEFAULT NULL,
				p_ship_date_low IN VARCHAR2 DEFAULT NULL,
				p_ship_date_high IN VARCHAR2 DEFAULT NULL,
				p_transaction_num_low IN VARCHAR2 DEFAULT NULL,
				p_transaction_num_high IN VARCHAR2 DEFAULT NULL,
				pa_sales_order_num_low IN VARCHAR2 DEFAULT NULL,
				p_sales_order_num_high IN VARCHAR2 DEFAULT NULL,
				p_invoice_date_low IN VARCHAR2 DEFAULT NULL,
				p_invoice_date_high IN VARCHAR2 DEFAULT NULL,
				p_ship_to_customer_num_low IN VARCHAR2 DEFAULT NULL,
				p_ship_to_customer_num_high IN VARCHAR2 DEFAULT NULL,
				p_ship_to_customer_name_low IN VARCHAR2 DEFAULT NULL,
				p_ship_to_customer_name_high IN VARCHAR2 DEFAULT NULL,
				p_base_due_date_on_trx_date IN VARCHAR2 DEFAULT 'Y',
				p_due_date_adjust_days IN VARCHAR2 DEFAULT NULL,
				p_org_name IN VARCHAR2 DEFAULT NULL
			    )
	IS

	v_program  			VARCHAR2(20):='RAXMTR'; -- Autoinvoice Master Program
	v_application		   	VARCHAR2(20):='AR'; -- Application
	v_invoice_source_id	        NUMBER;
	v_application_id		NUMBER;
	v_user_id			NUMBER;
	v_user_responsibility_id        NUMBER;
	v_org_id		        NUMBER;
  p_org_id		        NUMBER;




BEGIN

	  -- Fetch Application id for AR Application
	  v_errmsg:='Fetching the Application Id';

	  SELECT application_id
	  INTO   v_application_id
	  FROM   fnd_application
	  WHERE  application_short_name = 'AR';


	  	-- Fetch the User Id
	  	v_errmsg:='Fetching the User Id';

	   	v_user_id:=wm_conc_request_pkg.get_user_id(p_user);

	  	-- Fetch the Responsibility Id
	  	v_errmsg:='Fetching the Responsibility Id';

	  	v_user_responsibility_id:=wm_conc_request_pkg.get_user_responsibility_id(p_user_responsibility);

	  	--- Initialize Application Profiles and Global Variables

		Fnd_Global.apps_initialize(v_user_id,v_user_responsibility_id,v_application_id);

		-- Fetch the Set of Books for the User Environment

		v_org_id:=Fnd_Profile.Value('ORG_ID');

	        -- Fetch the Invoice_source_id
	        v_errmsg:='Fetching the Source Id';

	        SELECT batch_source_id
	        INTO   v_invoice_source_id
	        FROM   ra_batch_sources_all
	        WHERE  name = p_invoice_source
	        AND    org_id = v_org_id;

	IF p_org_name IS NOT NULL THEN
		SELECT ORGANIZATION_ID 
		INTO p_org_id
		FROM ORG_ORGANIZATION_DEFINITIONS 
		WHERE ORGANIZATION_NAME = p_org_name;
	END IF;

	 -- Call to submit request
	 v_errmsg:='Calling the Concurrent Request';

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
					       p_instance_count ,
					       p_org_id,
					       v_invoice_source_id,
					       p_invoice_source  ,
			    		       to_char(p_default_date ,'yyyy/mm/dd hh:mm:ss') ,
					       p_trans_flexfield ,
					       p_transaction_type ,
					       p_bill_to_customer_num_low ,
					       p_bill_to_customer_num_high ,
					       p_bill_to_customer_name_low ,
					       p_bill_to_customer_name_high ,
					       p_GL_Date_low ,
					       p_GL_Date_high ,
					       p_ship_date_low ,
					       p_ship_date_high ,
					       p_transaction_num_low ,
					       p_transaction_num_high ,
					       pa_sales_order_num_low ,
					       p_sales_order_num_high ,
					       p_invoice_date_low ,
					       p_invoice_date_high ,
					       p_ship_to_customer_num_low ,
					       p_ship_to_customer_num_high ,
					       p_ship_to_customer_name_low ,
					       p_ship_to_customer_name_high ,
					       p_base_due_date_on_trx_date ,
					       p_due_date_adjust_days );


EXCEPTION
 WHEN OTHERS THEN
 v_errmsg:=v_errmsg||SQLERRM;
 v_status:='FAILED';

END WM_HANDLE_AUTOINVOICE;

END Wm_AutoInvoice_Imp_Handler_Pkg;

/

SHOW ERRORS
