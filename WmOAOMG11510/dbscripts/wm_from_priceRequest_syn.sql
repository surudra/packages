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
    * Program Name:         wm_from_pricerequest_syn.sql
    * Version #:            1.0
    * Title:                Synonyms Installation Script for Price Request Outbound
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Synonyms in APPS schema for the Price Request Outbound Custom Tables
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
     16-NOV-02     Rajesh Prasad        	Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_from_pricerequest_syn.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

  ----------------------------------------------------------------------------
  --    Create synonyms for required custom data objects in APPS schema       
  ----------------------------------------------------------------------------

drop synonym WM_LINE_TBL
/

create synonym WM_LINE_TBL FOR &&custom_user..WM_LINE_TBL
/

drop synonym WM_QUAL_TBL
/

create synonym WM_QUAL_TBL FOR &&custom_user..WM_QUAL_TBL
/

drop synonym WM_LINE_ATTR_TBL
/

create synonym WM_LINE_ATTR_TBL FOR &&custom_user..WM_LINE_ATTR_TBL
/

drop synonym WM_LINE_DETAIL_TBL
/

create synonym WM_LINE_DETAIL_TBL FOR &&custom_user..WM_LINE_DETAIL_TBL
/

drop synonym WM_LINE_DETAIL_QUAL_TBL
/

create synonym WM_LINE_DETAIL_QUAL_TBL FOR &&custom_user..WM_LINE_DETAIL_QUAL_TBL
/

drop synonym WM_LINE_DETAIL_ATTR_TBL 
/

create synonym WM_LINE_DETAIL_ATTR_TBL FOR &&custom_user..WM_LINE_DETAIL_ATTR_TBL 
/

drop synonym WM_RELATED_LINES_TBL 
/

create synonym WM_RELATED_LINES_TBL FOR &&custom_user..WM_RELATED_LINES_TBL 
/
