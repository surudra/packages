/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall objects in GL schema
    * Program Name:         wm_drop_from_glbalance.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for GL Balance  Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for GL Balance Transactions    			
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

  --define SPOOL_FILE             	= "&&SpoolFile" -- Spool File Name
  define dbAppUser			= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd			="&&dbAppPwd"
  define DB_Name            		= "&&DBString" -- Database Instance in Oracle Apps

  define Custom_User			= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd			= "&&Custom_pwd"  

  --spool &&SPOOL_FILE

  prompt Program : wm_drop_from_glbalance.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Triggers....."


-- Dropping All Triggers------------------------------------------------------
-- None

-- DROP VIEWS in APPS------------------------------------------------------

DROP VIEW WM_GL_BALANCES_QRY_VW 
/
clear buffer

SHOW ERRORS

prompt UnInstall Complete for GL Balance Query
