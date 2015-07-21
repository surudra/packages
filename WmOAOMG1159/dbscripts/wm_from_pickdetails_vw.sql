/*  ***************************************************************************
    *    $Date:   17 Oct 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Pick Details outbound in Application Schema  
    * Program Name:         wm_from_pickdetails_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Pick Details Outbound
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
     17-OCT-02	 Gautam Naha  Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_pickdetails_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."


/*----------------------------------------------------------------------*/
--      Create View WM_PICK_DETAILS_VW  
/*----------------------------------------------------------------------*/



CREATE OR REPLACE VIEW WM_PICK_DETAILS_VW ( 
WEB_TRANSACTION_ID,DOCUMENT_TYPE, DOCUMENT_STATUS,TRANSACTION_ID,MOVE_ORDER_NUMBER,SCHEDULED_SHIP_DATE,  
ACCT_PERIOD_NAME, ACTUAL_COST, COST_GROUP_NAME, COSTED_FLAG, 
CURRENCY_CODE, CURRENCY_CONVERSION_DATE, CURRENCY_CONVERSION_RATE, CURRENCY_CONVERSION_TYPE, 
DEPARTMENT_CODE, DISTRIBUTION_ACCOUNT_NUMBER, EMPLOYEE_CODE, ENCUMBRANCE_ACCOUNT, 
ENCUMBRANCE_AMOUNT, EXPENDITURE_TYPE, FLOW_SCHEDULE, FREIGHT_CODE, 
INVENTORY_ITEM_CODE, INVOICED_FLAG, TO_LOCATION_DESCRIPTION, LPN_NUMBER, 
MASTER_SCHEDULE_UPDATE_CODE, MATERIAL_ACCOUNT, MATERIAL_OVERHEAD_ACCOUNT, MOVE_ORDER_TYPE_NAME, 
NEW_COST, NUMBER_OF_CONTAINERS, OPERATION_SEQ_NUM, TO_ORGANIZATION_NAME, 
OUTSIDE_PROCESSING_ACCOUNT, OVERCOMPLETION_PRIMARY_QTY, PICKING_RULE_NAME, PICK_SLIP_NUMBER, 
PRIMARY_QUANTITY, PRIOR_COST, PRIOR_COSTED_QUANTITY, 
PROJECT_NAME, QUANTITY_ADJUSTED, REASON_NAME, RECEIVING_DOCUMENT, 
RESOURCE_ACCOUNT, REVISION, SHIPMENT_COSTED, SHIPMENT_NUMBER, 
TO_SUBINVENTORY_CODE, TASK_NAME, TO_PROJECT_NAME, TO_TASK_NAME, 
TRANSACTION_ACTION_NAME, TRANSACTION_COST, TRANSACTION_DATE, TRANSACTION_QUANTITY, 
TRANSACTION_REFERENCE, TRANSACTION_SOURCE_NAME, TRANSACTION_SOURCE_TYPE_NAME, TRANSACTION_TYPE_NAME, 
TRANSACTION_UOM, FROM_COST, FROM_COST_DIST_ACCOUNT, FROM_COST_GROUP_NAME,FROM_LOCATION_DESCRIPTION,FROM_ORGANIZATION_NAME, 
FROM_SUBINVENTORY_CODE, TRANSPORTATION_COST, TRANSPORTATION_DIST_ACCOUNT, USSGL_TRANSACTION_CODE, 
VALUE_CHANGE, VARIANCE_AMOUNT, VENDOR_LOT_NUMBER, WAYBILL_AIRBILL
 ) AS SELECT  
WMTC.WEB_TRANSACTION_ID,  
WMTC.TRANSACTION_TYPE DOCUMENT_TYPE,  
DECODE((WMTC.TRANSACTION_STATUS),0,'UPDATE',1,'INSERT',2, 'DELETE') DOCUMENT_STATUS, 	
MMT.TRANSACTION_SET_ID TRANSACTION_ID,
MTRH.REQUEST_NUMBER MOVE_ORDER_NUMBER,
OOLA.SCHEDULE_SHIP_DATE SCHEDULED_SHIP_DATE,
OAP.PERIOD_NAME ACCT_PERIOD_NAME,  
MMT.ACTUAL_COST ACTUAL_COST,  
CCG.COST_GROUP COST_GROUP_NAME,  
MMT.COSTED_FLAG COSTED_FLAG,  
MMT.CURRENCY_CODE CURRENCY_CODE,  
MMT.CURRENCY_CONVERSION_DATE CURRENCY_CONVERSION_DATE,  
MMT.CURRENCY_CONVERSION_RATE CURRENCY_CONVERSION_RATE,  
MMT.CURRENCY_CONVERSION_TYPE CURRENCY_CONVERSION_TYPE,  
BD.DEPARTMENT_CODE DEPARTMENT_CODE ,  
GCCK.CONCATENATED_SEGMENTS DISTRIBUTION_ACCOUNT_NUMBER,  
MMT.EMPLOYEE_CODE EMPLOYEE_CODE,  
MMT.ENCUMBRANCE_ACCOUNT ENCUMBRANCE_ACCOUNT,  
MMT.ENCUMBRANCE_AMOUNT ENCUMBRANCE_AMOUNT,  
MMT.EXPENDITURE_TYPE EXPENDITURE_TYPE,  
MMT.FLOW_SCHEDULE FLOW_SCHEDULE,  
MMT.FREIGHT_CODE FREIGHT_CODE,  
MSIK.CONCATENATED_SEGMENTS INVENTORY_ITEM_CODE,  
MMT.INVOICED_FLAG INVOICED_FLAG,  
IIL.DESCRIPTION TO_LOCATION_DESCRIPTION,  
WLPN.LICENSE_PLATE_NUMBER  LPN_NUMBER,  
MMT.MASTER_SCHEDULE_UPDATE_CODE MASTER_SCHEDULE_UPDATE_CODE,  
MMT.MATERIAL_ACCOUNT MATERIAL_ACCOUNT,  
MMT.MATERIAL_OVERHEAD_ACCOUNT MATERIAL_OVERHEAD_ACCOUNT,  
MFG1.MEANING MOVE_ORDER_TYPE_NAME,  
MMT.NEW_COST NEW_COST,  
MMT.NUMBER_OF_CONTAINERS NUMBER_OF_CONTAINERS,  
MMT.OPERATION_SEQ_NUM OPERATION_SEQ_NUM,  
ORG.ORGANIZATION_NAME ORGANIZATION_NAME,  
MMT.OUTSIDE_PROCESSING_ACCOUNT OUTSIDE_PROCESSING_ACCOUNT,  
MMT.OVERCOMPLETION_PRIMARY_QTY OVERCOMPLETION_PRIMARY_QTY,  
MPR.PICKING_RULE_NAME PICKING_RULE_NAME ,  
MMT.PICK_SLIP_NUMBER PICK_SLIP_NUMBER,  
MMT.PRIMARY_QUANTITY PRIMARY_QUANTITY,  
MMT.PRIOR_COST PRIOR_COST,  
MMT.PRIOR_COSTED_QUANTITY PRIOR_COSTED_QUANTITY,  
PPA.NAME PROJECT_NAME,  
MMT.QUANTITY_ADJUSTED QUANTITY_ADJUSTED,  
MTR.REASON_NAME REASON_NAME,  
MMT.RECEIVING_DOCUMENT RECEIVING_DOCUMENT,  
MMT.RESOURCE_ACCOUNT RESOURCE_ACCOUNT,  
MMT.REVISION REVISION,  
MMT.SHIPMENT_COSTED SHIPMENT_COSTED,  
MMT.SHIPMENT_NUMBER SHIPMENT_NUMBER,  
MMT.SUBINVENTORY_CODE TO_SUBINVENTORY_CODE,  
PT.TASK_NAME TASK_NAME,  
TO_PPA.NAME TO_PROJECT_NAME,  
TO_PT.TASK_NAME TO_TASK_NAME,  
MFG2.MEANING TRANSACTION_ACTION_NAME,  
MMT.TRANSACTION_COST TRANSACTION_COST,  
MMT.TRANSACTION_DATE TRANSACTION_DATE,  
MMT.TRANSACTION_QUANTITY TRANSACTION_QUANTITY,  
MMT.TRANSACTION_REFERENCE TRANSACTION_REFERENCE,  
MMT.TRANSACTION_SOURCE_NAME TRANSACTION_SOURCE_NAME,  
MTST.TRANSACTION_SOURCE_TYPE_NAME TRANSACTION_SOURCE_TYPE_NAME,  
MTT.TRANSACTION_TYPE_NAME TRANSACTION_TYPE_NAME,  
MMT.TRANSACTION_UOM TRANSACTION_UOM,  
MMT.TRANSFER_COST FROM_COST,  
MMT.TRANSFER_COST_DIST_ACCOUNT FROM_COST_DIST_ACCOUNT,  
TRS_CCG.COST_GROUP FROM_COST_GROUP_NAME,
FROM_IIL.DESCRIPTION FROM_LOCATION_DESCRIPTION ,
FROM_ORG.ORGANIZATION_NAME FROM_ORGANIZATION_NAME, 
MMT.TRANSFER_SUBINVENTORY FROM_SUBINVENTORY_CODE,  
MMT.TRANSPORTATION_COST TRANSPORTATION_COST,  
MMT.TRANSPORTATION_DIST_ACCOUNT TRANSPORTATION_DIST_ACCOUNT,  
MMT.USSGL_TRANSACTION_CODE USSGL_TRANSACTION_CODE,  
MMT.VALUE_CHANGE VALUE_CHANGE,  
MMT.VARIANCE_AMOUNT VARIANCE_AMOUNT,  
MMT.VENDOR_LOT_NUMBER VENDOR_LOT_NUMBER,  
MMT.WAYBILL_AIRBILL WAYBILL_AIRBILL  
FROM  
MTL_MATERIAL_TRANSACTIONS MMT,  
ORG_ACCT_PERIODS OAP,  
CST_COST_GROUPS CCG,  
BOM_DEPARTMENTS BD,  
GL_CODE_COMBINATIONS_KFV GCCK,  
MTL_SYSTEM_ITEMS_B_KFV MSIK,  
MTL_ITEM_LOCATIONS IIL,  
WMS_LICENSE_PLATE_NUMBERS WLPN,  
MTL_TXN_REQUEST_HEADERS MTRH,  
MTL_TXN_REQUEST_LINES MTRL,  
MFG_LOOKUPS MFG1,  
ORG_ORGANIZATION_DEFINITIONS ORG,  
MTL_PICKING_RULES MPR,  
PA_PROJECTS_ALL PPA,  
MTL_TRANSACTION_REASONS MTR,  
PA_TASKS PT,  
PA_PROJECTS_ALL TO_PPA,  
PA_TASKS TO_PT,  
MFG_LOOKUPS MFG2,  
MTL_TXN_SOURCE_TYPES MTST,  
MTL_TRANSACTION_TYPES MTT,  
CST_COST_GROUPS TRS_CCG,
MTL_ITEM_LOCATIONS FROM_IIL,
ORG_ORGANIZATION_DEFINITIONS FROM_ORG,
OE_ORDER_LINES_ALL OOLA,
WM_TRACK_CHANGES_VW WMTC 
WHERE  
MMT.TRX_SOURCE_LINE_ID = OOLA.LINE_ID (+) AND
MMT.ACCT_PERIOD_ID = OAP.ACCT_PERIOD_ID (+) AND 
MMT.ORGANIZATION_ID = OAP.ORGANIZATION_ID (+) AND   
MMT.COST_GROUP_ID = CCG.COST_GROUP_ID (+) AND  
MMT.ORGANIZATION_ID = CCG.ORGANIZATION_ID (+) AND  
MMT.DEPARTMENT_ID = BD.DEPARTMENT_ID (+) AND  
MMT.ORGANIZATION_ID = BD.ORGANIZATION_ID (+) AND  
MMT.DISTRIBUTION_ACCOUNT_ID = GCCK.CODE_COMBINATION_ID (+) AND  
MMT.INVENTORY_ITEM_ID = MSIK.INVENTORY_ITEM_ID (+) AND  
MMT.ORGANIZATION_ID = MSIK.ORGANIZATION_ID (+) AND  
MMT.LOCATOR_ID = IIL.INVENTORY_LOCATION_ID (+) AND  
MMT.ORGANIZATION_ID = IIL.ORGANIZATION_ID (+) AND
MMT.LPN_ID = WLPN.LPN_ID (+) AND  
MFG1.LOOKUP_TYPE = 'MOVE_ORDER_TYPE' AND  
MFG1.LOOKUP_CODE = MTRH.MOVE_ORDER_TYPE AND  
MMT.MOVE_ORDER_LINE_ID = MTRL.LINE_ID (+)AND 
MMT.ORGANIZATION_ID = MTRL.ORGANIZATION_ID (+) AND 
MTRH.HEADER_ID = MTRL.HEADER_ID  AND  
MMT.ORGANIZATION_ID = ORG.ORGANIZATION_ID (+) AND  
MMT.PICK_RULE_ID = MPR.PICKING_RULE_ID AND  
MMT.PROJECT_ID = PPA.PROJECT_ID (+) AND 
MMT.ORGANIZATION_ID = PPA.ORG_ID (+) AND 
MMT.REASON_ID = MTR.REASON_ID (+) AND  
MMT.TASK_ID = PT.TASK_ID (+) AND  
MMT.PROJECT_ID = TO_PPA.PROJECT_ID (+) AND 
MMT.ORGANIZATION_ID = TO_PPA.ORG_ID (+) AND 
MMT.TASK_ID = TO_PT.TASK_ID (+) AND  
MFG2.LOOKUP_TYPE = 'MTL_TRANSACTION_ACTION' AND  
MFG2.LOOKUP_CODE = MTT.TRANSACTION_ACTION_ID AND  
MMT.TRANSACTION_TYPE_ID = MTT.TRANSACTION_TYPE_ID (+) AND  
MMT.TRANSACTION_SOURCE_TYPE_ID = MTST.TRANSACTION_SOURCE_TYPE_ID (+) AND  
MMT.TRANSFER_COST_GROUP_ID = TRS_CCG.COST_GROUP_ID (+) AND  
MMT.ORGANIZATION_ID = TRS_CCG.ORGANIZATION_ID (+) AND
MMT.TRANSFER_LOCATOR_ID = FROM_IIL.INVENTORY_LOCATION_ID (+) AND
MMT.ORGANIZATION_ID = FROM_IIL.ORGANIZATION_ID (+) AND
MMT.TRANSFER_ORGANIZATION_ID = FROM_ORG.ORGANIZATION_ID (+) AND
MMT.TRANSACTION_QUANTITY > 0 AND
MMT.TRANSACTION_SET_ID = WMTC.TRANSACTION_ID AND  
TRANSACTION_STATUS <= 2 AND  
WMTC.TRANSACTION_TYPE = 'PICKDETAIL'  
ORDER BY WMTC.WEB_TRANSACTION_ID
/


/*----------------------------------------------------------------------*/
--      Create View WM_PICK_DETAILS_QRY_VW  
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_PICK_DETAILS_QRY_VW ( 
WEB_TRANSACTION_ID,DOCUMENT_TYPE, DOCUMENT_STATUS,TRANSACTION_ID,MOVE_ORDER_NUMBER, SCHEDULED_SHIP_DATE, 
ACCT_PERIOD_NAME, ACTUAL_COST, COST_GROUP_NAME, COSTED_FLAG, 
CURRENCY_CODE, CURRENCY_CONVERSION_DATE, CURRENCY_CONVERSION_RATE, CURRENCY_CONVERSION_TYPE, 
DEPARTMENT_CODE, DISTRIBUTION_ACCOUNT_NUMBER, EMPLOYEE_CODE, ENCUMBRANCE_ACCOUNT, 
ENCUMBRANCE_AMOUNT, EXPENDITURE_TYPE, FLOW_SCHEDULE, FREIGHT_CODE, 
INVENTORY_ITEM_CODE, INVOICED_FLAG, TO_LOCATION_DESCRIPTION, LPN_NUMBER, 
MASTER_SCHEDULE_UPDATE_CODE, MATERIAL_ACCOUNT, MATERIAL_OVERHEAD_ACCOUNT, MOVE_ORDER_TYPE_NAME, 
NEW_COST, NUMBER_OF_CONTAINERS, OPERATION_SEQ_NUM, TO_ORGANIZATION_NAME, 
OUTSIDE_PROCESSING_ACCOUNT, OVERCOMPLETION_PRIMARY_QTY, PICKING_RULE_NAME, PICK_SLIP_NUMBER, 
PRIMARY_QUANTITY, PRIOR_COST, PRIOR_COSTED_QUANTITY, 
PROJECT_NAME, QUANTITY_ADJUSTED, REASON_NAME, RECEIVING_DOCUMENT, 
RESOURCE_ACCOUNT, REVISION, SHIPMENT_COSTED, SHIPMENT_NUMBER, 
TO_SUBINVENTORY_CODE, TASK_NAME, TO_PROJECT_NAME, TO_TASK_NAME, 
TRANSACTION_ACTION_NAME, TRANSACTION_COST, TRANSACTION_DATE, TRANSACTION_QUANTITY, 
TRANSACTION_REFERENCE, TRANSACTION_SOURCE_NAME, TRANSACTION_SOURCE_TYPE_NAME, TRANSACTION_TYPE_NAME, 
TRANSACTION_UOM, FROM_COST, FROM_COST_DIST_ACCOUNT, FROM_COST_GROUP_NAME,FROM_LOCATION_DESCRIPTION,FROM_ORGANIZATION_NAME, 
FROM_SUBINVENTORY_CODE, TRANSPORTATION_COST, TRANSPORTATION_DIST_ACCOUNT, USSGL_TRANSACTION_CODE, 
VALUE_CHANGE, VARIANCE_AMOUNT, VENDOR_LOT_NUMBER, WAYBILL_AIRBILL
 ) AS SELECT  
NULL WEB_TRANSACTION_ID,  
'PICK_DETAILS' DOCUMENT_TYPE,  
'QUERY' DOCUMENT_STATUS, 	
MMT.TRANSACTION_SET_ID TRANSACTION_ID,
MTRH.REQUEST_NUMBER MOVE_ORDER_NUMBER,
OOLA.SCHEDULE_SHIP_DATE SCHEDULED_SHIP_DATE,  
OAP.PERIOD_NAME ACCT_PERIOD_NAME,  
MMT.ACTUAL_COST ACTUAL_COST,  
CCG.COST_GROUP COST_GROUP_NAME,  
MMT.COSTED_FLAG COSTED_FLAG,  
MMT.CURRENCY_CODE CURRENCY_CODE,  
MMT.CURRENCY_CONVERSION_DATE CURRENCY_CONVERSION_DATE,  
MMT.CURRENCY_CONVERSION_RATE CURRENCY_CONVERSION_RATE,  
MMT.CURRENCY_CONVERSION_TYPE CURRENCY_CONVERSION_TYPE,  
BD.DEPARTMENT_CODE DEPARTMENT_CODE ,  
GCCK.CONCATENATED_SEGMENTS DISTRIBUTION_ACCOUNT_NUMBER,  
MMT.EMPLOYEE_CODE EMPLOYEE_CODE,  
MMT.ENCUMBRANCE_ACCOUNT ENCUMBRANCE_ACCOUNT,  
MMT.ENCUMBRANCE_AMOUNT ENCUMBRANCE_AMOUNT,  
MMT.EXPENDITURE_TYPE EXPENDITURE_TYPE,  
MMT.FLOW_SCHEDULE FLOW_SCHEDULE,  
MMT.FREIGHT_CODE FREIGHT_CODE,  
MSIK.CONCATENATED_SEGMENTS INVENTORY_ITEM_CODE,  
MMT.INVOICED_FLAG INVOICED_FLAG,  
IIL.DESCRIPTION TO_LOCATION_DESCRIPTION,  
WLPN.LICENSE_PLATE_NUMBER  LPN_NUMBER,  
MMT.MASTER_SCHEDULE_UPDATE_CODE MASTER_SCHEDULE_UPDATE_CODE,  
MMT.MATERIAL_ACCOUNT MATERIAL_ACCOUNT,  
MMT.MATERIAL_OVERHEAD_ACCOUNT MATERIAL_OVERHEAD_ACCOUNT,  
MFG1.MEANING MOVE_ORDER_TYPE_NAME,  
MMT.NEW_COST NEW_COST,  
MMT.NUMBER_OF_CONTAINERS NUMBER_OF_CONTAINERS,  
MMT.OPERATION_SEQ_NUM OPERATION_SEQ_NUM,  
ORG.ORGANIZATION_NAME ORGANIZATION_NAME,  
MMT.OUTSIDE_PROCESSING_ACCOUNT OUTSIDE_PROCESSING_ACCOUNT,  
MMT.OVERCOMPLETION_PRIMARY_QTY OVERCOMPLETION_PRIMARY_QTY,  
MPR.PICKING_RULE_NAME PICKING_RULE_NAME ,  
MMT.PICK_SLIP_NUMBER PICK_SLIP_NUMBER,  
MMT.PRIMARY_QUANTITY PRIMARY_QUANTITY,  
MMT.PRIOR_COST PRIOR_COST,  
MMT.PRIOR_COSTED_QUANTITY PRIOR_COSTED_QUANTITY,  
PPA.NAME PROJECT_NAME,  
MMT.QUANTITY_ADJUSTED QUANTITY_ADJUSTED,  
MTR.REASON_NAME REASON_NAME,  
MMT.RECEIVING_DOCUMENT RECEIVING_DOCUMENT,  
MMT.RESOURCE_ACCOUNT RESOURCE_ACCOUNT,  
MMT.REVISION REVISION,  
MMT.SHIPMENT_COSTED SHIPMENT_COSTED,  
MMT.SHIPMENT_NUMBER SHIPMENT_NUMBER,  
MMT.SUBINVENTORY_CODE TO_SUBINVENTORY_CODE,  
PT.TASK_NAME TASK_NAME,  
TO_PPA.NAME TO_PROJECT_NAME,  
TO_PT.TASK_NAME TO_TASK_NAME,  
--MFG2.MEANING TRANSACTION_ACTION_NAME,  
MTT.DESCRIPTION TRANSACTION_ACTION_NAME,
MMT.TRANSACTION_COST TRANSACTION_COST,  
MMT.TRANSACTION_DATE TRANSACTION_DATE,  
MMT.TRANSACTION_QUANTITY TRANSACTION_QUANTITY,  
MMT.TRANSACTION_REFERENCE TRANSACTION_REFERENCE,  
MMT.TRANSACTION_SOURCE_NAME TRANSACTION_SOURCE_NAME,  
MTST.TRANSACTION_SOURCE_TYPE_NAME TRANSACTION_SOURCE_TYPE_NAME,  
MTT.TRANSACTION_TYPE_NAME TRANSACTION_TYPE_NAME,  
MMT.TRANSACTION_UOM TRANSACTION_UOM,  
MMT.TRANSFER_COST FROM_COST,  
MMT.TRANSFER_COST_DIST_ACCOUNT FROM_COST_DIST_ACCOUNT,  
TRS_CCG.COST_GROUP FROM_COST_GROUP_NAME,
FROM_IIL.DESCRIPTION FROM_LOCATION_DESCRIPTION ,
FROM_ORG.ORGANIZATION_NAME FROM_ORGANIZATION_NAME, 
MMT.TRANSFER_SUBINVENTORY FROM_SUBINVENTORY_CODE,  
MMT.TRANSPORTATION_COST TRANSPORTATION_COST,  
MMT.TRANSPORTATION_DIST_ACCOUNT TRANSPORTATION_DIST_ACCOUNT,  
MMT.USSGL_TRANSACTION_CODE USSGL_TRANSACTION_CODE,  
MMT.VALUE_CHANGE VALUE_CHANGE,  
MMT.VARIANCE_AMOUNT VARIANCE_AMOUNT,  
MMT.VENDOR_LOT_NUMBER VENDOR_LOT_NUMBER,  
MMT.WAYBILL_AIRBILL WAYBILL_AIRBILL  
FROM  
MTL_MATERIAL_TRANSACTIONS MMT,  
ORG_ACCT_PERIODS OAP,  
CST_COST_GROUPS CCG,  
BOM_DEPARTMENTS BD,  
GL_CODE_COMBINATIONS_KFV GCCK,  
MTL_SYSTEM_ITEMS_B_KFV MSIK,  
MTL_ITEM_LOCATIONS IIL,  
WMS_LICENSE_PLATE_NUMBERS WLPN,  
MTL_TXN_REQUEST_HEADERS MTRH,  
MTL_TXN_REQUEST_LINES MTRL,  
MFG_LOOKUPS MFG1,
ORG_ORGANIZATION_DEFINITIONS ORG,  
MTL_PICKING_RULES MPR,  
PA_PROJECTS_ALL PPA,  
MTL_TRANSACTION_REASONS MTR,  
PA_TASKS PT,  
PA_PROJECTS_ALL TO_PPA,  
PA_TASKS TO_PT,  
--MFG_LOOKUPS MFG2,  
MTL_TXN_SOURCE_TYPES MTST,  
MTL_TRANSACTION_TYPES MTT,  
CST_COST_GROUPS TRS_CCG,
MTL_ITEM_LOCATIONS FROM_IIL,
ORG_ORGANIZATION_DEFINITIONS FROM_ORG,
OE_ORDER_LINES_ALL OOLA
WHERE  
MMT.TRX_SOURCE_LINE_ID = OOLA.LINE_ID (+) AND
MMT.ACCT_PERIOD_ID = OAP.ACCT_PERIOD_ID (+) AND 
MMT.ORGANIZATION_ID = OAP.ORGANIZATION_ID (+) AND   
MMT.COST_GROUP_ID = CCG.COST_GROUP_ID (+) AND  
MMT.ORGANIZATION_ID = CCG.ORGANIZATION_ID (+) AND  
MMT.DEPARTMENT_ID = BD.DEPARTMENT_ID (+) AND  
MMT.ORGANIZATION_ID = BD.ORGANIZATION_ID (+) AND  
MMT.DISTRIBUTION_ACCOUNT_ID = GCCK.CODE_COMBINATION_ID (+) AND  
MMT.INVENTORY_ITEM_ID = MSIK.INVENTORY_ITEM_ID (+) AND  
MMT.ORGANIZATION_ID = MSIK.ORGANIZATION_ID (+) AND  
MMT.LOCATOR_ID = IIL.INVENTORY_LOCATION_ID (+) AND  
MMT.ORGANIZATION_ID = IIL.ORGANIZATION_ID (+) AND
MMT.LPN_ID = WLPN.LPN_ID (+) AND  
MFG1.LOOKUP_TYPE = 'MOVE_ORDER_TYPE' AND  
MFG1.LOOKUP_CODE = MTRH.MOVE_ORDER_TYPE AND  
MMT.MOVE_ORDER_LINE_ID = MTRL.LINE_ID (+)AND 
MMT.ORGANIZATION_ID = MTRL.ORGANIZATION_ID (+) AND 
MTRH.HEADER_ID = MTRL.HEADER_ID  AND  
-- ** -- MMT.ORGANIZATION_ID = ORG.ORGANIZATION_ID (+) AND  
MMT.ORGANIZATION_ID = ORG.ORGANIZATION_ID AND  
MMT.PICK_RULE_ID = MPR.PICKING_RULE_ID AND  
MMT.PROJECT_ID = PPA.PROJECT_ID (+) AND 
MMT.ORGANIZATION_ID = PPA.ORG_ID (+) AND 
MMT.REASON_ID = MTR.REASON_ID (+) AND  
MMT.TASK_ID = PT.TASK_ID (+) AND  
MMT.PROJECT_ID = TO_PPA.PROJECT_ID (+) AND 
MMT.ORGANIZATION_ID = TO_PPA.ORG_ID (+) AND 
MMT.TASK_ID = TO_PT.TASK_ID (+) AND  
-- MFG2.LOOKUP_TYPE = 'MTL_TRANSACTION_ACTION' AND  
-- MFG2.LOOKUP_CODE = MTT.TRANSACTION_ACTION_ID AND 
MMT.TRANSACTION_TYPE_ID = MTT.TRANSACTION_TYPE_ID(+)  AND  
MMT.TRANSACTION_SOURCE_TYPE_ID = MTST.TRANSACTION_SOURCE_TYPE_ID (+) AND  
MMT.TRANSFER_COST_GROUP_ID = TRS_CCG.COST_GROUP_ID (+) AND  
MMT.ORGANIZATION_ID = TRS_CCG.ORGANIZATION_ID (+) AND
MMT.TRANSFER_LOCATOR_ID = FROM_IIL.INVENTORY_LOCATION_ID (+) AND
MMT.ORGANIZATION_ID = FROM_IIL.ORGANIZATION_ID (+) AND
MMT.TRANSFER_ORGANIZATION_ID = FROM_ORG.ORGANIZATION_ID (+) AND 
MMT.TRANSACTION_QUANTITY > 0
/

 
SHOW ERRORS
