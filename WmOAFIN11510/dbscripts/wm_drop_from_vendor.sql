/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall objects in PO schema
    * Program Name:         wm_drop_from_vendor.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Vendor Outbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Vendor Outbound Transactions    			
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
     16-AUG-02	  Koushik Chakraborty             Created
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

  prompt Program : wm_drop_from_vendor.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Triggers....."


-- Dropping All Triggers------------------------------------------------------

DROP TRIGGER &&dbAppUser..WM_PO_VENDORS_IU_TRG
/

DROP TRIGGER &&dbAppUser..WM_PO_VENDOR_SITES_ALL_IU_TRG
/

DROP TRIGGER &&dbAppUser..WM_PO_VENDOR_CONTACTS_IUD_TRG
/

DROP TRIGGER &&dbAppUser..WM_AP_BANK_ACC_USE_ALL_IU_TRG
/

-- DROP VIEWS in APPS------------------------------------------------------

DROP VIEW WM_PO_VENDORS_QRY_VW 
/
DROP VIEW WM_PO_VENDORS_VW
/
DROP VIEW WM_PO_VENDOR_SITES_ALL_VW
/
DROP VIEW WM_PO_VENDOR_CONTACTS_VW
/
DROP VIEW WM_BANK_ACC_USE_VEND_SITES_VW
/
DROP VIEW WM_BANK_ACCOUNT_USES_VENDOR_VW
/

clear buffer

SHOW ERRORS

prompt UnInstall Complete for Vendor Outbound
