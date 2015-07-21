/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Inventory On-Hand Quantity outbound in Application Schema  
    * Program Name:         wm_from_onhandquantity_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Inventory On-Hand Quantity  Outbound
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
     20-SEP-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_onhandquantity_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      Create View WM_INV_ONHAND_QRY_VW
/*----------------------------------------------------------------------*/

create or replace view &&apps_user..wm_inv_onhand_qry_vw as
/*SELECT  web_transaction_id,
document_type,document_status, ORGANIZATION_ID, 
INVENTORY_ITEM_ID, CONCATENATED_SEGMENTS, REVISION, TOTAL_QOH, 
SUBINVENTORY_CODE, LOCATOR, ITEM_DESCRIPTION, PRIMARY_UOM_CODE, 
ORGANIZATION_CODE, ORGANIZATION_NAME, LOCATOR_TYPE, ITEM_REV_CONTROL, ITEM_LOCATOR_CONTROL, 
ITEM_LOT_CONTROL, ITEM_SERIAL_CONTROL ) AS*/ SELECT  
NULL web_transaction_id,
'INVONHAND' document_type,
'QUERY' document_status,
A.ORGANIZATION_ID ,  
A.INVENTORY_ITEM_ID ,  
B.CONCATENATED_SEGMENTS ,  
A.REVISION ,  
SUM(A.PRIMARY_TRANSACTION_QUANTITY) TOTAL_QOH ,  
A.SUBINVENTORY_CODE ,  
F.CONCATENATED_SEGMENTS LOCATOR ,  
B.DESCRIPTION ITEM_DESCRIPTION ,  
B.PRIMARY_UOM_CODE ,  
C.ORGANIZATION_CODE ,  
E.NAME ORGANIZATION_NAME ,  
D.LOCATOR_TYPE ,  
B.REVISION_QTY_CONTROL_CODE ITEM_REV_CONTROL ,  
B.LOCATION_CONTROL_CODE ITEM_LOCATOR_CONTROL ,  
B.LOT_CONTROL_CODE ITEM_LOT_CONTROL ,  
B.SERIAL_NUMBER_CONTROL_CODE ITEM_SERIAL_CONTROL  
FROM  
MTL_ONHAND_QUANTITIES_DETAIL A,  
MTL_SYSTEM_ITEMS_KFV B,  
MTL_PARAMETERS C,  
MTL_SECONDARY_INVENTORIES D,  
HR_ORGANIZATION_UNITS E,  
MTL_ITEM_LOCATIONS_KFV F  
WHERE  
A.INVENTORY_ITEM_ID = B.INVENTORY_ITEM_ID AND  
A.SUBINVENTORY_CODE = D.SECONDARY_INVENTORY_NAME AND  
A.ORGANIZATION_ID = B.ORGANIZATION_ID AND  
A.ORGANIZATION_ID = C.ORGANIZATION_ID AND  
A.ORGANIZATION_ID = D.ORGANIZATION_ID AND  
A.ORGANIZATION_ID = E.ORGANIZATION_ID AND  
A.IS_CONSIGNED = 2 AND  
A.ORGANIZATION_ID = F.ORGANIZATION_ID (+) AND  
A.LOCATOR_ID = F.INVENTORY_LOCATION_ID (+)  
GROUP BY A.ORGANIZATION_ID, A.INVENTORY_ITEM_ID, 
A.REVISION, A.SUBINVENTORY_CODE, F.CONCATENATED_SEGMENTS,  
B.CONCATENATED_SEGMENTS, B.DESCRIPTION, B.PRIMARY_UOM_CODE, C.ORGANIZATION_CODE, E.NAME,  
D.AVAILABILITY_TYPE, D.RESERVABLE_TYPE, D.INVENTORY_ATP_CODE, D.LOCATOR_TYPE, B.REVISION_QTY_CONTROL_CODE,  
B.LOCATION_CONTROL_CODE, B.LOT_CONTROL_CODE, B.SERIAL_NUMBER_CONTROL_CODE

/
  
SHOW ERRORS