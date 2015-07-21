/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Master Removal Script
    * Program Name:         wm_drop_all.sql
    * Version #:            1.0
    * Title:                Master Removal Script
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         This script calls all other scripts used for dropping 
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

  define SPOOL_FILE           = "&&SpoolFile" -- Spool File Name
  define DB_Name              = "&&DBString" -- Database Instance in Oracle Apps
  define dbAppUser		= "&&dbAppUser" -- User to Connect to Apps Schema
  define dbAppPwd			= "&&dbAppPwd"
  define Custom_User		= "&&CustomUser" -- User to Connect to Apps Schema
  define Custom_pwd		= "&&Custom_pwd"
  
  spool &&SPOOL_FILE

/******************************************************************************
   Dropping Core Components Shared by all Transactions 
******************************************************************************/

-- Dropping Core components
@@wm_drop_core.sql


/******************************************************************************
   Dropping OUTBOUND Transaction components
******************************************************************************/

-- Dropping Vendor Outbound components
@@wm_drop_from_vendor.sql

-- Dropping Customer Outbound components
@@wm_drop_from_customer.sql



/******************************************************************************
   Dropping INBOUND Transaction components
******************************************************************************/

-- Dropping PO Inbound components
@@wm_drop_into_po.sql

-- Dropping GL Journal components
@@wm_drop_into_journal.sql

-- Dropping Bank Statement Inbound components
@@wm_drop_into_bankstmt.sql 

-- Dropping PO Receiving Inbound components
@@wm_drop_into_rcv.sql 

-- Dropping FA Budget Inbound components -- commented as FA Budget DB Components not required
--@@wm_drop_into_fabudget.sql 

-- Dropping GL Budget Inbound components -- commented as GL Budget DB Components not required
--@@wm_drop_into_glbudget.sql 

-- Dropping PA Labor Inbound components
@@wm_drop_into_labor.sql 

-- Dropping AR Auto Invoice Inbound components
@@wm_drop_into_autoinvoice.sql

-- Dropping AP Invoice Inbound components
@@wm_drop_into_apinvoice.sql

-- Dropping FA Mass Additions Inbound components
@@wm_drop_into_massadditions.sql

-- Dropping Employee Inbound components
@@wm_drop_into_employee.sql


SHOW ERRORS

prompt Uninstall Completed

SPOOL OFF

EXIT


