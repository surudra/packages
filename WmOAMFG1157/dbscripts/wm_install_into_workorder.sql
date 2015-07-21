/*  ***************************************************************************
        $Date:   08 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Installation Script for wip work order Transaction Inbound
    * Program Name:         wm_install_into_workorder.sql
    * Version #:            1.0
    * Title:                Installation Script for wip work order Transaction
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         This script calls all other scripts used for installing Components
    *				   for wip work order inbound Trnsaction.      
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
     08-OCT-02	 Gautam Naha          Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON

  define apps_user  			= "&&apps_user" -- APPS User Id
  define appspwd    			= "&&appspwd"
  
  define custom_user 			= "&custom_user"
  define custom_password 		= "&&custom_password" 
  
  define custom_tablespace        	= "&&Tablespace" -- Custom User Table tablespace
  define custom_indexspace        	= "&&Indexspace" -- Custom User Index tablespace
  define DBString    			= "&&DBString" -- Database Instance in Oracle Apps 


prompt Installing Sequences...
@@wm_into_workorder_seq.sql

prompt Installing Synonyms...
@@wm_into_workorder_syn.sql

prompt Installing Packages.....
@@wm_into_workorder_pkg.sql

SHOW ERRORS

prompt Install Completed FOR WIP work order TRANSACTION Inbound

