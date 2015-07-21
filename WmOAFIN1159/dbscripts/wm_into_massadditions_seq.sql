/*  ***************************************************************************
    *    $Date:   14 Aug 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Creates Sequences for FA Mass Additions Inbound webMethods schema
    * Program Name:         wm_into_massadditions_seq.sql
    * Version #:            1.0
    * Title:                Sequences used for FA Mass Additions
    * Utility:              SQL*Plus
    * Created by:           in 
    * Creation   Date:      
    *
    * Description:          Creates sequence wm_fa_massadd_s and wm_fa_createbatch_s
    * 			    
    *			    
    *
    *           
    *
    * Tables usage:             
    *   
    *
    * Procedures And Functions:         
    *
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
    *           Param1: &SpoolFile     
    *           Param2: &CustomUser
    *           Param3: &CustomUser Password    
    *           Param4: &Custom Tablespace
    *           Param5: &Custom Indexspace
    *
    * Menu Responsibilities And path: 
    *
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:           
    *
    *==========================================================================
    * Date         | Name               | Remarks 
    *==========================================================================
    *17-SEP-2002    Sudip K Chaudhuri     Created
    ***************************************************************************
*/


set feedback    on
set verify              off
set newpage     0
set pause               off
set termout     on

prompt Program : wm_into_massadditions_seq.sql

-- 
-- Connect to Custom User Account And create the table and indexes
--

connect &&custom_user/&&custom_password@&&DBString

/*----------------------------------------------------------------------*/
--      Create Sequences
/*----------------------------------------------------------------------*/
DROP SEQUENCE wm_fa_massadd_s
/

CREATE SEQUENCE wm_fa_massadd_s increment by 1 start with 5000
nomaxvalue nocycle cache 10 order
/

DROP SEQUENCE wm_fa_createbatch_s
/

CREATE SEQUENCE wm_fa_createbatch_s increment by 1 start with 5000
nomaxvalue nocycle cache 10 order
/

/*----------------------------------------------------------------------*/
--      Give grant all on custom data objects to APPS User
/*----------------------------------------------------------------------*/
grant all on wm_fa_massadd_s to &&apps_user with grant option
/

grant all on wm_fa_createbatch_s to &&apps_user with grant option
/



