/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall Objects for Manufacturing BOM Outbound Transactions
    * Program Name:         wm_drop_from_mfgbom.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Manufacturing BOM Outbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Manufacturing BOM Outbound Transactions    			
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
     19-oct-02	Indrani Das			Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  --define SPOOL_FILE             	= "&&SpoolFile" -- Spool File Name
  define dbAppUser			= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd				= "&&dbAppPwd"
  define DB_Name            		= "&&DBString" -- Database Instance in Oracle Apps

  define Custom_User			= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd			= "&&Custom_pwd"  

  --spool &&SPOOL_FILE

  prompt Program : wm_drop_from_mfgbom.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Triggers....."


-- Dropping All Triggers------------------------------------------------------

DROP TRIGGER &&dbAppUser..wm_bom_bill_of_mtls_iud_trg
/
DROP TRIGGER &&dbAppUser..wm_mtl_item_rev_iud_trg
/
DROP TRIGGER &&dbAppUser..wm_bom_inv_comps_iud_trg
/
DROP TRIGGER &&dbAppUser..wm_bom_sub_comps_iud_trg
/
DROP TRIGGER &&dbAppUser..wm_bom_ref_desgs_iud_trg
/

-- DROP VIEWS in APPS------------------------------------------------------

DROP VIEW WM_BOM_BILL_OF_MTLS_VW
/
DROP VIEW WM_BOM_ITEM_REVISIONS_VW
/
DROP VIEW WM_BOM_INVENTORY_COMPS_VW
/
DROP VIEW WM_BOM_SUBSTITUTE_COMPS_VW
/
DROP VIEW WM_BOM_REFERENCE_DESGS_VW
/
DROP VIEW WM_BOM_BILL_OF_MTLS_QRY_VW
/

clear buffer

SHOW ERRORS

prompt UnInstall Complete for Manufacturing BOM Outbound
