/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall Core objects in PO schema
    * Program Name:         wm_drop_core.sql
    * Version #:            1.0
    * Title:                Uninstall core objects used     
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall core objects used 			
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
     16-AUG-02	   Gautam Naha             Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd			= "&&dbAppPwd"
  define DB_Name            = "&&DBString" -- Database Instance in Oracle Apps
  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"
  
  prompt Program : wm_drop_core.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name


REM "Uninstalling Packages....."

-- Dropping Core Packages-----------------------------------------------------

DROP PACKAGE WM_TRACK_CHANGES_PKG
/

DROP PACKAGE WM_CONC_REQUEST_PKG
/

DROP PACKAGE WM_UTILS_PKG
/

-- DROP Core SYNONYMS in APPS----------------------------------------------------

DROP SYNONYM WM_TRACKCHANGES
/

DROP SYNONYM WM_CONTROL
/

DROP SYNONYM WM_WEB_TRANSACTION_S
/

-- DROP VIEWS in APPS------------------------------------------------------

DROP VIEW WM_TRACK_CHANGES_VW
/

/* Connecting to Custom WebMethods Schema for uninstalling objects in WebMethods Schema */

--define CustomUser		= "&CustomUser" -- User to Connect to webMethods Schema
--define CustomPwd		= "& CustomPwd" -- Pwd to connect to webMethods schema

connect &&Custom_User/&&Custom_pwd@&&DB_Name

REM "Uninstalling Sequences....."

-- DROP Sequences in Custom Schema--------------------------------------------

DROP SEQUENCE wm_web_transaction_s
/

REM "Uninstalling Tables....."

-- DROP tables in Custom Schema------------------------------------------------
DROP TABLE &&Custom_User..WM_CONTROL
/

DROP TABLE &&Custom_User..WM_TRACKCHANGES
/

clear buffer

SHOW ERRORS

prompt UnInstall Complete for Core components
