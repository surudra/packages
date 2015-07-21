/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
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
    * Triggers to enable: 	WM_AP_BANK_ACCOUNT_USES_IU_TRG
    *					WM_HZ_CONTACT_POINTS_IUD_TRG
    *					WM_HZ_CUSTOMER_PROFILES_IU_TRG
    *					WM_HZ_CUST_ACCOUNTS_IU_TRG
    *					WM_HZ_CUST_ACCT_RELATE_IU_TRG
    *					WM_HZ_CUST_ACCT_SITES_IU_TRG
    *					WM_HZ_CUST_PROF_AMTS_IUD_TRG
    *					WM_HZ_CUST_SITE_USES_IU_TRG
    *					WM_HZ_LOCATIONS_IU_TRG
    *					WM_HZ_PARTIES_U_TRG
    *					WM_HZ_CUST_ACCT_ROLES_I_TRG
    *					WM_HZ_ROLE_RESP_IUD_TRG
    *					WM_RA_CUST_RECP_METHODS_IU_TRG
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     12-AUG-02	  Koushik Chakraborty   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  define apps_user  = '&apps_user' -- APPS User Id
  define appswd	    = '&appspwd'  -- APPS Password
  define DB_Name    = "&DBString" -- Database Instance in Oracle Apps 
  

  prompt Program : wm_enable_from_customer.sql

  connect apps_user/&&apppwd@&&DbString

REM "Enabling Triggers....."

ALTER TRIGGER WM_HZ_CONTACT_POINTS_IUD_TRG ENABLE;
/
ALTER TRIGGER WM_HZ_CUST_PROF_AMTS_IUD_TRG ENABLE;
/
ALTER TRIGGER WM_HZ_ROLE_RESP_IUD_TRG ENABLE;
/

SHOW ERRORS

SPOOL OFF

exit;