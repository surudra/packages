/*  ***************************************************************************
        $Date:   04 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Synonyms for Requisition inbound in Application Schema  
    * Program Name:         wm_into_req_syn.sql
    * Version #:            1.0
    * Title:                Synonyms Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Synonyms in APPS schema for Requisition inbound Sequences
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
    *           Param2: &Apps User Password  
    *           Param3: &CustomUser 
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
    * 04-NOV-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_req_syn.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

  ----------------------------------------------------------------------------
  --    Create synonyms for required custom data objects in APPS schema       
  ----------------------------------------------------------------------------

drop synonym wm_req_batch_s
/

create synonym wm_req_batch_s FOR &&custom_user..wm_req_batch_s
/
