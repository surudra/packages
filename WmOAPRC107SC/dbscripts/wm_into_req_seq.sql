/*  ***************************************************************************
    *    $Date:   04 Nov 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Creates Sequences for Requisition Inbound webMethods schema
    * Program Name:         wm_into_req_seq.sql
    * Version #:            1.0
    * Title:                Sequences used for Requisition Inbound
    * Utility:              SQL*Plus
    * Created by:           in 
    * Creation   Date:      
    *
    * Description:          Creates sequence wm_req_batch_s
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
    * 04-NOV-2002    Rajib Naha		   Created
    ***************************************************************************
*/


set feedback    on
set verify              off
set newpage     0
set pause               off
set termout     on

prompt Program : wm_into_req_seq.sql

-- 
-- Connect to Custom User Account And create the table and indexes
--

connect &&custom_user/&&custom_password@&&DBString

/*----------------------------------------------------------------------*/
--      Create Sequences
/*----------------------------------------------------------------------*/

DROP SEQUENCE wm_req_batch_s
/
CREATE SEQUENCE wm_req_batch_s increment by 1 start with 1000
nomaxvalue nocycle cache 10 order
/

/*----------------------------------------------------------------------*/
--      Give grant all on custom data objects to APPS User
/*----------------------------------------------------------------------*/

grant all on wm_req_batch_s to &&apps_user with grant option
/


