/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Installation Script for Vendor Outbound
    * Program Name:         wm_install_from_vendor.sql
    * Version #:            1.0
    * Title:                Installation Script for Vendor Outbound
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         This script calls all other scripts used for installing compenents 
    *				   for Vendor Outbound Trnsactions.      
    *
    *           
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
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
     16-AUG-02	Koushik Chakraborty   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  define apps_user  = "&&apps_user" -- APPS User Id
  define appspwd    = "&&appspwd"
  
  define custom_user = "&&custom_user"
  define custom_password = "&&custom_password" 
  
  define custom_tablespace        = "&&Tablespace" -- Custom User Table tablespace
  define custom_indexspace        = "&&Indexspace" -- Custom User Index tablespace
  define DBString    = "&&DBString" -- Database Instance in Oracle Apps 


prompt Installing Views...
@@wm_from_vendor_vw.sql

prompt Installing Triggers.....
@@wm_from_vendor_trg.sql

prompt Installing Packages.....
@@wm_from_vendor_pkg.sql

SHOW ERRORS

prompt Install Completed for Vendor Outbound


