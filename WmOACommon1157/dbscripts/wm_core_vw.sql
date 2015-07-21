/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author: 
    *  Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Core Custom objects (Views) in Application Module Schema  
    * Program Name:         wm_core_vw.sql
    * Version #:            1.0
    * Title:                Core View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema 
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
    *           Param1: &SpoolFile     
    *           Param2: &Apps User Password
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
     12-AUG-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_core_vw.sql
  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Core Views....."

/*----------------------------------------------------------------------*/
--      Create View WM_TRACK_CHANGES_VW
/*----------------------------------------------------------------------*/

create or replace view wm_track_changes_vw as 
select transaction_type,transaction_id, 
max(web_transaction_id) web_transaction_id,sum(transaction_status) transaction_status
from wm_trackchanges 
where processed_flag='N'
group by transaction_type, transaction_id
/
  
SHOW ERRORS

