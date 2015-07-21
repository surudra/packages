/*  ***************************************************************************
        $Date:   24 Sep 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall Objects for Ap Invoices Outbound Transactions
    * Program Name:         wm_drop_from_apinvoice.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Ap Invoices Outbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Ap Invoices Outbound Transactions    			
    *
    *           
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
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
    *           Param2: &DatabaseApplicationUser
    *           Param3: &DatabaseApplicationPwd
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
     26-SEP-02	  Rajib Naha             Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  --define SPOOL_FILE      	= "&&SpoolFile" -- Spool File Name
  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd		= "&&dbAppPwd"
  define DB_Name            	= "&&DBString" -- Database Instance in Oracle Apps
  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"  

  --spool &&SPOOL_FILE

  prompt Program : wm_drop_from_ap_invoices.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Triggers....."


-- Dropping All Triggers------------------------------------------------------

DROP TRIGGER &&dbAppUser..WM_AP_INVOICE_DIST_IU_TRG
/

-- DROP VIEWS in APPS------------------------------------------------------

DROP VIEW WM_AP_INVOICES_QRY_VW
/
DROP VIEW WM_AP_INVOICES_VW 	
/
DROP VIEW WM_AP_INVOICES_LINES_VW
/

clear buffer

SHOW ERRORS

prompt UnInstall Complete for AP Invoices Outbound
