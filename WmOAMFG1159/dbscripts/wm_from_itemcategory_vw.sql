/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Item Category outbound in Application Schema  
    * Program Name:         wm_from_itemcategory_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Inventory Item Category Query
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
     16-OCT-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_itemcategory_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      Create View WM_INV_ITEM_CATEGORY_QRY_VW
/*----------------------------------------------------------------------*/

create or replace view &&apps_user..wm_inv_item_category_qry_vw as
(
SELECT
NULL web_transaction_id,
'ITEMCATEGORY' document_type,
'QUERY' document_status,
cat.category_concat_segs category,
cat.structure_name structure,
cat.disable_date inactive_on_date,
cat.summary_flag summary_flag,
cat.enabled_flag enabled_flag,
cat.description category_description,
/*Following fields have been included as a result of Impact Analysis between 11.5.7 and 11.5.9*/
cat.supplier_enabled_flag supplier_enabled_flag,
cat.web_status
FROM
mtl_categories_v cat
)
/
  
SHOW ERRORS

