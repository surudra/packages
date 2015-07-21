/*  ***************************************************************************
        $Date:   08 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserve
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Synonyms for WIP move Transaction Inbound in Application Schema  
    * Program Name:         wm_into_movetrans_syn.sql
    * Version #:            1.0
    * Title:                Synonyms Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Synonyms in APPS schema for WIP inbound Sequences
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
     08-OCT-2002	 Gautam Naha        Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON


  prompt Program : wm_into_movetrans_syn.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  CONNECT &&apps_user/&&AppsPwd@&&DBString

  ----------------------------------------------------------------------------
  --    Create synonyms for required custom data objects in APPS schema       
  ----------------------------------------------------------------------------

DROP SYNONYM wm_wip_trans_id_s
/

CREATE SYNONYM wm_wip_trans_id_s FOR &&custom_user..wm_wip_trans_id_s
/