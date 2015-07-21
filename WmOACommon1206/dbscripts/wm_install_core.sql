/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:     $
    * Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Core Objects Installation Script
    * Program Name:         wm_install_core.sql
    * Version #:            1.0
    * Title:                Master Installation Script
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         This script calls all other core install scripts used for installing 
    *				   custom objects.      
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
     16-AUG-02	Gautam Naha   Created
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


prompt Installing Sequences
@@wm_core_seq.sql

  
prompt Installing Custom Tables 
@@wm_core_tbl.sql


prompt Installing Synonyms...
@@wm_core_syn.sql


prompt Installing Views...
@@wm_core_vw.sql
@@wm_ra_site_uses_all_vw.sql
@@wm_ra_contacts_vw.sql
@@wm_ra_customers_vw.sql
@@wm_ra_addresses_all_vw.sql
@@wm_ra_customer_relationships_all_vw.sql


prompt Installing Packages.....
@@wm_core_pkg.sql
/* @@wm_conc_request_pkg.pkg
@@wm_journal_imp_handler_Pkg.pkg
@@wm_openpo_imp_handler_pkg.pkg */

/*
prompt Installing Triggers.....
@@wm_triggers.trg
*/

prompt Installing Seed Data...
@@wm_core_dml.sql

SHOW ERRORS


prompt Install Completed for Core components
