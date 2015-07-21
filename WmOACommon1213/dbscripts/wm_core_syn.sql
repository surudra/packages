/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Synonyms in Application Schema  
    * Program Name:         wm_core_syn.sql
    * Version #:            1.0
    * Title:                Core Synonyms Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Synonyms in APPS schema for the Custom Tables and Sequences
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
     22-AUG-02	Koushik Chakraborty	Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_core_syn.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

  ----------------------------------------------------------------------------
  --    Create synonyms for required custom data objects in APPS schema       
  ----------------------------------------------------------------------------

drop synonym wm_trackchanges
/

create synonym wm_trackchanges FOR &&custom_user..wm_trackchanges
/

drop synonym wm_control
/

create synonym wm_control FOR &&custom_user..wm_control
/

drop synonym wm_web_transaction_s
/

create synonym wm_web_transaction_s FOR &&custom_user..wm_web_transaction_s
/

drop synonym WM_SEND_REFERENCE_T
/

create synonym WM_SEND_REFERENCE_T FOR &&custom_user..WM_SEND_REFERENCE_T
/
