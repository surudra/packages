/*  ***************************************************************************
        $Date:   08 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall objects for wip work order Transaction inbound
    * Program Name:         wm_drop_into_workorder.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for WIP work order Transaction Inbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for WIP work order Inbound Transaction    			
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
     08-OCT-02	   Gautam Naha        Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON

  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd		= "&&dbAppPwd"
  define DB_Name                = "&&DBString" -- Database Instance in Oracle Apps
  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"
  

  prompt Program : wm_drop_into_workorder.sql

  
CONNECT &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Packages....."

-- Dropping All Packages-----------------------------------------------------

DROP PACKAGE Wm_Wip_Imp_Handler_Pkg
/

-- DROP SYNONYMS in APPS----------------------------------------------------

DROP SYNONYM wm_wip_group_id_s
/
DROP SYNONYM wm_wip_header_id_s
/

/* Connecting to Custom WebMethods Schema for uninstalling objects in WebMethods Schema */

--define CustomUser		= "&CustomUser" -- User to Connect to webMethods Schema
--define CustomPwd		= "& CustomPwd" -- Pwd to connect to webMethods schema

CONNECT &&Custom_User/&&Custom_pwd@&&DB_Name

REM "Uninstalling Sequences....."

-- DROP Sequences in Custom Schema--------------------------------------------

DROP SEQUENCE wm_wip_group_id_s
/
DROP SEQUENCE wm_wip_header_id_s
/


clear buffer

SHOW ERRORS

prompt UnInstall Complete FOR WIP work order transaction Inbound
