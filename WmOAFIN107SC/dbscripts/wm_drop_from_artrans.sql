/*  ***************************************************************************
        $Date:   14 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall Objects for AR Transactions Outbound 
    * Program Name:         wm_drop_from_artrans.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for AR Transactions Outbound   
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for AR Transactions Outbound 		
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
     14-NOV-02	  Gautam Naha             Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  --define SPOOL_FILE             = "&&SpoolFile" -- Spool File Name
  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd			="&&dbAppPwd"
  define DB_Name            = "&&DBString" -- Database Instance in Oracle Apps

  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"  

  --spool &&SPOOL_FILE

  prompt Program : wm_drop_from_artrans.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Triggers....."


-- Dropping All Triggers------------------------------------------------------

drop trigger &&dbappuser..wm_ra_customer_trx_all_iu_trg
/

-- DROP VIEWS in APPS------------------------------------------------------

drop view WM_RA_CUSTOMER_TRX_VW  
/
drop view WM_RA_CUST_TRX_LINE_GL_DIST_VW 	
/
drop view WM_RA_CUST_TRX_FREIGHT_VW
/
drop view WM_AR_NOTES_VW
/
drop view WM_RA_CUST_TRX_CHARGES_VW 
/
drop view WM_RA_CUSTOMER_TRX_LINES_VW
/
drop view WM_RA_CUST_TRX_FREIGHTLINES_VW 
/
drop view WM_RA_CUST_TRX_TAXLINES_VW
/
drop view WM_RA_SALESREPS_LINES_VW
/
drop view WM_RA_SALESREPS_DEFAULT_VW
/
drop view WM_RA_CUSTOMER_TRX_QRY_VW
/

clear buffer

SHOW ERRORS

prompt UnInstall Complete for AR Transactions Outbound
