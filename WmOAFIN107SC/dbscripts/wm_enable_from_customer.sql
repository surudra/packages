/*  ***************************************************************************
        $Date:   09 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Vendor outbound in APPS schema
    * Program Name:         wm_enable_from_customer.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for Customer Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for Customer      
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to enable: 	WM_RA_CUSTOMERS_IU_TRG
    *						WM_RA_ADDRESSES_IU_TRG
    *						WM_AR_CUSTOMER_PROFILES_IU_TRG
    *						WM_AR_CUST_PROF_AMTS_IUD_TRG
    *						WM_AP_BANK_ACCOUNT_USES_IU_TRG
    *						WM_RA_SITE_USES_IU_TRG
    *						WM_RA_PHONES_IUD_TRG
    *						WM_RA_CUST_RELATIONS_IU_TRG
    *						WM_RA_CUST_RECP_METHODS_IU_TRG
    *						WM_RA_CONTACTS_IU_TRG
    *						WM_RA_CONTACT_ROLES_IUD_TRG
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
     09-NOV-02	  Gautam Naha			   Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON
  
  define apps_user  = '&apps_user' -- APPS User Id
  define appspwd    = '&appspwd'  -- APPS Password
  define DB_Name    = "&DBString" -- Database Instance in Oracle Apps 
  

  prompt Program : wm_enable_from_customer.SQL

  CONNECT &&apps_user/&&appspwd@&&DB_Name

REM "Enabling Triggers....."

ALTER TRIGGER WM_RA_CUSTOMERS_IU_TRG ENABLE;
/
ALTER TRIGGER WM_RA_ADDRESSES_IU_TRG ENABLE;
/
ALTER TRIGGER WM_AR_CUSTOMER_PROFILES_IU_TRG ENABLE;
/
ALTER TRIGGER WM_AR_CUST_PROF_AMTS_IUD_TRG ENABLE;
/
ALTER TRIGGER WM_AP_BANK_ACCOUNT_USES_IU_TRG ENABLE;
/
ALTER TRIGGER WM_RA_SITE_USES_IU_TRG ENABLE;
/
ALTER TRIGGER WM_RA_PHONES_IUD_TRG ENABLE;
/
ALTER TRIGGER WM_RA_CUST_RELATIONS_IU_TRG ENABLE;
/
ALTER TRIGGER WM_RA_CUST_RECP_METHODS_IU_TRG ENABLE;
/
ALTER TRIGGER WM_RA_CONTACTS_IU_TRG ENABLE;
/
ALTER TRIGGER WM_RA_CONTACT_ROLES_IUD_TRG ENABLE;
/

SHOW ERRORS

SPOOL OFF

EXIT;