/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall objects for Periodic Cost Open Interface inbound Transactions
    * Program Name:         wm_drop_into_periodiccost.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Periodic Cost Open Interface inbound Transactions 
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Periodic Cost Open Interface inbound Transactions	
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
     19-SEP-02	 Panchali Samanta        Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd		      = "&&dbAppPwd"
  define DB_Name              = "&&DBString" -- Database Instance in Oracle Apps
  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"
  

  prompt Program : wm_drop_into_periodiccost.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Packages....."

-- Dropping All Packages-----------------------------------------------------

DROP PACKAGE Wm_Pc_Imp_Handler_Pkg
/

-- DROP SYNONYMS in APPS----------------------------------------------------

DROP SYNONYM WM_CST_PC_INTERFACE_HEADER_S
/
DROP SYNONYM WM_CST_PC_INTERFACE_LINE_S
/

/* Connecting to Custom WebMethods Schema for uninstalling objects in WebMethods Schema */

--define CustomUser		= "&CustomUser" -- User to Connect to webMethods Schema
--define CustomPwd		= "& CustomPwd" -- Pwd to connect to webMethods schema

connect &&Custom_User/&&Custom_pwd@&&DB_Name

REM "Uninstalling Sequences....."

-- DROP Sequences in Custom Schema--------------------------------------------

DROP SEQUENCE WM_CST_PC_INTERFACE_HEADER_S
/
DROP SEQUENCE WM_CST_PC_INTERFACE_LINE_S
/

clear buffer

SHOW ERRORS

prompt UnInstall Complete for Periodic Cost Open Interface Inbound Transaction
