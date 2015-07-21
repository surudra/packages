/*  ***************************************************************************
    *    $Date:   08 Oct 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Creates Sequences for wip move transaction Inbound webMethods schema
    * Program Name:         wm_into_movetrans_seq.sql
    * Version #:            1.0
    * Title:                Sequences used for WIP move transaction Inbound
    * Utility:              SQL*Plus
    * Created by:           in 
    * Creation   Date:      
    *
    * Description:          Creates sequence wm_wip_trans_id_s
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
    *08-OCT-2002    Gautam Naha     Created
    ***************************************************************************
*/


SET feedback    ON
SET verify              OFF
SET newpage     0
SET pause               OFF
SET termout     ON

prompt Program : wm_into_movetrans_seq.SQL

-- 
-- Connect to Custom User Account And create the table and indexes
--

CONNECT &&custom_user/&&custom_password@&&DBString

/*----------------------------------------------------------------------*/
--      Create Sequences
/*----------------------------------------------------------------------*/
DROP SEQUENCE wm_wip_trans_id_s
/

CREATE SEQUENCE wm_wip_trans_id_s INCREMENT BY 1 START WITH 1000
NOMAXVALUE NOCYCLE CACHE 10 ORDER
/


/*----------------------------------------------------------------------*/
--      Give grant all on custom data objects to APPS User
/*----------------------------------------------------------------------*/
GRANT ALL ON wm_wip_trans_id_s TO &&apps_user WITH GRANT OPTION
/


