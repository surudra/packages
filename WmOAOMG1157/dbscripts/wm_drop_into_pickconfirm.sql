/*  ***************************************************************************
        $Date:   23 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall objects for Pick Confirm inbound
    * Program Name:         wm_drop_into_pickconfirm.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Pick Confirm Inbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Pick Confirm Inbound Transactions    			
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
     23-OCT-02	   Gautam Naha             Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  define dbAppUser	= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd	= "&&dbAppPwd"
  define DB_Name        = "&&DBString" -- Database Instance in Oracle Apps
  define Custom_User	= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd	= "&&Custom_pwd"
  

  prompt Program : wm_drop_into_pickconfirm.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Packages....."

-- Dropping All Packages-----------------------------------------------------

DROP PACKAGE wm_pickconfirm_handler_pkg
/


clear buffer

SHOW ERRORS

prompt UnInstall Complete for Pick Confirm Inbound
