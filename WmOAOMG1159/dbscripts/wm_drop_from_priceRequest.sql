/*  ***************************************************************************
        $Date:   14 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall Objects for Price Request Outbound Transactions
    * Program Name:         wm_drop_from_priceRequest.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Price Request Outbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Price Request Outbound Transactions    			
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
     14-OCT-02	  Rajib Naha             Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  --define SPOOL_FILE      	= "&&SpoolFile" -- Spool File Name
  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd		="&&dbAppPwd"
  define DB_Name            	= "&&DBString" -- Database Instance in Oracle Apps
  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"  

  --spool &&SPOOL_FILE

  prompt Program : wm_drop_from_priceRequest.sql

 connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Synonyms....."

-- DROP SYNONYMS in APPS------------------------------------------------------

drop synonym WM_LINE_TBL
/
drop synonym WM_QUAL_TBL
/
drop synonym WM_LINE_ATTR_TBL
/
drop synonym WM_LINE_DETAIL_TBL
/
drop synonym WM_LINE_DETAIL_QUAL_TBL
/
drop synonym WM_LINE_DETAIL_ATTR_TBL 
/
drop synonym WM_RELATED_LINES_TBL 
/

REM "Uninstalling Packages....."

-- DROP PACKAGES in APPS------------------------------------------------------

drop package Wm_PriceRequest_Handler_Pkg 
/


 connect &&Custom_User/&&Custom_pwd@&&DB_Name

REM "Uninstalling Tables....."

-- DROP TABLES in APPS------------------------------------------------------


DROP TABLE WM_LINE_TBL 
/
DROP TABLE WM_QUAL_TBL 
/
DROP TABLE WM_LINE_ATTR_TBL 
/
DROP TABLE WM_LINE_DETAIL_TBL 
/
DROP TABLE WM_LINE_DETAIL_QUAL_TBL 
/
DROP TABLE WM_LINE_DETAIL_ATTR_TBL 
/
DROP TABLE WM_RELATED_LINES_TBL 
/

clear buffer

SHOW ERRORS

prompt UnInstall Complete for Price Reqeust Outbound

