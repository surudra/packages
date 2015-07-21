/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Master Installation Script
    * Program Name:         wm_install_all.sql
    * Version #:            1.0
    * Title:                Master Installation Script
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         This script calls all other scripts used for installing 
    *				   Custom objects for All Trnsactions.      
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
     09-SEP-02	Koushik Chakraborty   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  define SPOOL_FILE = "&SPOOLFILE" 
  define apps_user  = "&apps_user" -- APPS User Id
  accept appspwd prompt 'Apps Password:' hide  
  
  define custom_user = "&custom_user"
  accept custom_password prompt 'Custom Password:' hide 
  
  define custom_tablespace        = "&Tablespace" -- Custom User Table tablespace
  define custom_indexspace        = "&Indexspace" -- Custom User Index tablespace
  define DBString    = "&DBString" -- Database Instance in Oracle Apps 
  spool &&SPOOL_FILE

/******************************************************************************
   Installing Core Components Shared by all Transactions 
******************************************************************************/

-- Installing Core components
@@wm_install_core.sql


/******************************************************************************
   Installing OUTBOUND Transaction components
******************************************************************************/

-- Installing Vendor Outbound components
@@wm_install_from_vendor.sql


-- Installing Customer Outbound components
@@wm_install_from_customer.sql



/******************************************************************************
   Installing INBOUND Transaction components
******************************************************************************/

-- Installing PO Inbound components
@@wm_install_into_po.sql

-- Installing GL Journal Inbound components
@@wm_install_into_journal.sql

-- Installing Bank Statement Inbound components
@@wm_install_into_bankstmt.sql

-- Installing PO Receiving Inbound components
@@wm_install_into_rcv.sql 

-- Installing FA Budget Inbound components -- commented as FA Budget DB Components not required
--@@wm_install_into_fabudget.sql

-- Installing GL Budget Inbound components -- commented as GL Budget DB Components not required
--@@wm_install_into_glbudget.sql

-- Installing PA Labor Inbound components
@@wm_install_into_labor.sql

-- Installing AR Auto Invoice Inbound components
@@wm_install_into_autoinvoice.sql

-- Installing AP Invoice Inbound components
@@wm_install_into_apinvoice.sql

-- Installing FA Mass Additions Inbound components
@@wm_install_into_massadditions.sql

-- Installing Employee Inbound components
@@wm_install_into_employee.sql


SHOW ERRORS

prompt Install Completed

SPOOL OFF

EXIT


