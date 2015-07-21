/*  ***************************************************************************
        $Date:   09 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall Objects for Customer Outbound Transactions
    * Program Name:         wm_drop_from_customer.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Customer Outbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Customer Outbound Transactions    			
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
     09-NOV-02	  Gautam Naha             Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON

  --define SPOOL_FILE             = "&&SpoolFile" -- Spool File Name
  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd			="&&dbAppPwd"
  define DB_Name            = "&&DBString" -- Database Instance in Oracle Apps

  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"  

  --spool &&SPOOL_FILE

  prompt Program : wm_drop_from_customer.SQL

  
CONNECT &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Triggers....."


-- Dropping All Triggers------------------------------------------------------

DROP TRIGGER WM_RA_CUSTOMERS_IU_TRG
/

DROP TRIGGER WM_RA_ADDRESSES_IU_TRG
/

DROP TRIGGER WM_AR_CUSTOMER_PROFILES_IU_TRG
/

DROP TRIGGER WM_AR_CUST_PROF_AMTS_IUD_TRG
/

DROP TRIGGER WM_AP_BANK_ACCOUNT_USES_IU_TRG
/

DROP TRIGGER WM_RA_SITE_USES_IU_TRG
/

DROP TRIGGER WM_RA_PHONES_IUD_TRG
/

DROP TRIGGER WM_RA_CUST_RELATIONS_IU_TRG
/

DROP TRIGGER WM_RA_CUST_RECP_METHODS_IU_TRG
/

DROP TRIGGER WM_RA_CONTACTS_IU_TRG
/

DROP TRIGGER WM_RA_CONTACT_ROLES_IUD_TRG
/


-- DROP VIEWS in APPS------------------------------------------------------

DROP VIEW WM_AR_CUSTOMERS_VW
/
DROP VIEW WM_CUST_PHONES_VW 	
/
DROP VIEW WM_CONT_PHONES_VW 
/
DROP VIEW WM_AR_SITE_USES_VW 
/
DROP VIEW WM_AR_CUST_RELATIONSHIPS_VW 
/
DROP VIEW WM_AR_CUST_RECEIPT_METHODS_VW 
/
DROP VIEW WM_AR_CUST_BANK_ACCOUNTS_VW 
/
DROP VIEW WM_AR_CUSTOMER_PROF_AMTS_VW 
/
DROP VIEW WM_AR_CUSTOMER_PROFILES_VW 
/
DROP VIEW WM_AR_CONTACT_ROLES_VW 
/
DROP VIEW WM_AR_CONTACTS_VW 
/
DROP VIEW WM_AR_ADDRESSES_VW 
/
DROP VIEW WM_ADDR_PHONES_VW 
/
DROP VIEW WM_AR_CUSTOMERS_QRY_VW 
/


clear buffer

SHOW ERRORS

prompt UnInstall Complete FOR Customer Outbound
