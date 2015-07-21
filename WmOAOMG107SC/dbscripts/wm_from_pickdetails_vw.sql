/*  ***************************************************************************
    *    $Date:   26 Nov 2002 10:56:36  $
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
     26-NOV-02	 Gautam Naha  				Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON

 prompt Program : wm_from_pickdetails_vw.SQL

  
CONNECT &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."


/*----------------------------------------------------------------------*/
--      Create View WM_SO_PICKING_HEADERS_VW 
/*----------------------------------------------------------------------*/



CREATE OR REPLACE VIEW WM_SO_PICKING_HEADERS_VW ( WEB_TRANSACTION_ID, 
DOCUMENT_TYPE, DOCUMENT_STATUS, PICKING_HEADER_ID, BATCH_NAME, 
ORDER_NUMBER, ORDER_CATEGORY,PICK_SLIP_RULE, ORDER_CURRENCY_CODE, CUSTOMER_NAME, 
FREIGHT_TERMS, ORDER_TYPE_NAME, FROM_ORGANIZATION_NAME, SHIP_TO_SITE_USE_LOCATION, 
STATUS_CODE, PICK_SLIP_NUMBER, WAYBILL_NUM, PICKER_NAME, 
PACKER_NAME, WEIGHT, WEIGHT_UNIT_CODE, NUMBER_OF_BOXES, 
SHIP_METHOD_CODE, SHIP_METHOD_NAME, INVOICED_LINES, 
DATE_RELEASED, DATE_SHIPPED, DATE_CONFIRMED, 
EXPECTED_ARRIVAL_DATE ) AS SELECT  
WMTC.WEB_TRANSACTION_ID,  
WMTC.TRANSACTION_TYPE DOCUMENT_TYPE,  
DECODE((WMTC.TRANSACTION_STATUS),0,'UPDATE',1,'INSERT',2, 'DELETE') DOCUMENT_STATUS,  
SPH.PICKING_HEADER_ID ,  
SPB.NAME BATCH_NAME ,  
SH.ORDER_NUMBER ,  
SH.ORDER_CATEGORY ,  
WPSR.NAME PICK_SLIP_RULE,
SH.CURRENCY_CODE ORDER_CURRENCY_CODE ,  
RC.CUSTOMER_NAME ,  
SOLUP.MEANING FREIGHT_TERMS ,  
ST.NAME ORDER_TYPE_NAME ,  
ORG.NAME FROM_ORGANIZATION_NAME ,  
RSU.LOCATION SHIP_TO_SITE_USE_LOCATION , /* name */  
SPH.STATUS_CODE ,  
SPH.PICK_SLIP_NUMBER ,  
SPH.WAYBILL_NUM ,  
FU1.USER_NAME PICKER_NAME ,  
FU2.USER_NAME PACKER_NAME ,  
SPH.WEIGHT ,  
SPH.WEIGHT_UNIT_CODE ,  
SPH.NUMBER_OF_BOXES ,  
SPH.SHIP_METHOD_CODE ,  
NVL(FRG.DESCRIPTION,FRG.FREIGHT_CODE) SHIP_METHOD_NAME ,  
Shp_Picking_Headers_Pkg.INVOICED_LINES(SPH.PICKING_HEADER_ID) INVOICED_LINES ,  
SPH.DATE_RELEASED ,  
SPH.DATE_SHIPPED ,  
SPH.DATE_CONFIRMED ,  
SPH.EXPECTED_ARRIVAL_DATE  
FROM  
SO_LOOKUPS SOLUP,  
FND_USER FU1,  
FND_USER FU2,  
HR_ORGANIZATION_UNITS ORG,  
MTL_PARAMETERS MP,  
ORG_FREIGHT FRG,  
RA_CUSTOMERS RC,  
RA_ADDRESSES_ALL RA,  
RA_SITE_USES_ALL RSU,  
SO_ORDER_TYPES_ALL ST,  
SO_HEADERS_ALL SH,  
SO_PICKING_BATCHES_ALL SPB,  
SO_PICKING_HEADERS_ALL SPH ,
WSH_PICK_SLIP_RULES WPSR,  
WM_TRACK_CHANGES_VW WMTC  
WHERE  
SPB.BATCH_ID = SPH.BATCH_ID AND  
SH.HEADER_ID = SPH.ORDER_HEADER_ID AND  
RSU.SITE_USE_ID = SPH.SHIP_TO_SITE_USE_ID  AND  
RA.ADDRESS_ID = RSU.ADDRESS_ID AND  
RC.CUSTOMER_ID = NVL(SH.CUSTOMER_ID,RA.CUSTOMER_ID) AND  
ORG.ORGANIZATION_ID = SPH.WAREHOUSE_ID AND  
MP.ORGANIZATION_ID = SPH.WAREHOUSE_ID AND  
ST.ORDER_TYPE_ID = SH.ORDER_TYPE_ID AND  
FU1.USER_ID (+) = NVL(SPH.PICKED_BY_ID,-99) AND  
FU2.USER_ID (+) = NVL(SPH.PACKED_BY_ID,-99) AND  
SOLUP.LOOKUP_TYPE (+) = 'FREIGHT_TERMS' AND  
SOLUP.LOOKUP_CODE (+) = NVL(SH.FREIGHT_TERMS_CODE,-99) AND  
FRG.FREIGHT_CODE (+) = NVL(SPH.SHIP_METHOD_CODE,-99) AND  
FRG.ORGANIZATION_ID (+) = Fnd_Profile.VALUE_SPECIFIC('SO_ORGANIZATION_ID') AND  
WPSR.PICK_SLIP_RULE_ID (+) = SPB.PICK_SLIP_RULE_ID AND
SPH.PICKING_HEADER_ID = WMTC.TRANSACTION_ID AND  
TRANSACTION_STATUS <= 2 AND  
WMTC.TRANSACTION_TYPE = 'PICKDETAIL'
/


/*----------------------------------------------------------------------*/
--      Create View WM_SO_PICKING_LINES_VW 
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_SO_PICKING_LINES_VW ( PICKING_LINE_ID, 
PICKING_HEADER_ID, PICK_SLIP_NUMBER, PICKING_RULE_NAME,SEQUENCE_NUMBER, COMPONENT_CODE, 
COMPONENT_RATIO, REQUESTED_QUANTITY, ITEM_DESCRIPTION, SUBINV_RESTRICTED_FLAG, 
REVISION_CONTROL_FLAG, LOT_CONTROL_FLAG, SERIAL_NUMBER_CONTROL_FLAG, INCLUDED_ITEM_FLAG, 
RESERVABLE_FLAG, DATE_REQUESTED, ORIGINAL_REQUESTED_QUANTITY, ORGANIZATION_NAME, 
SHIPPED_QUANTITY, CANCELLED_QUANTITY, SHIPMENT_PRIORITY_CODE, SHIP_METHOD_CODE, 
DATE_CONFIRMED, INVOICED_QUANTITY, INVENTORY_STATUS, UNIT_CODE, 
PRIMARY_UOM_CODE, SCHEDULE_DATE, DEMAND_CLASS_CODE, CONFIGURATION_ITEM_FLAG, 
LATEST_ACCEPTABLE_DATE ) AS SELECT DISTINCT  
SPL.PICKING_LINE_ID ,  
SPL.PICKING_HEADER_ID ,  
SPH.PICK_SLIP_NUMBER ,  
MPR.PICKING_RULE_NAME,
SPL.SEQUENCE_NUMBER ,  
SPL.COMPONENT_CODE ,  
SPL.COMPONENT_RATIO ,  
SPL.REQUESTED_QUANTITY ,  
MSI.DESCRIPTION ITEM_DESCRIPTION ,  
DECODE(MSI.RESTRICT_SUBINVENTORIES_CODE,1,'Y','N') SUBINV_RESTRICTED_FLAG ,  
DECODE(MSI.REVISION_QTY_CONTROL_CODE,2,'Y','N') REVISION_CONTROL_FLAG ,  
DECODE(MSI.LOT_CONTROL_CODE,2,'Y',3,'Y','N') LOT_CONTROL_FLAG ,  
DECODE(MSI.SERIAL_NUMBER_CONTROL_CODE,2,'Y',5,'Y',6, DECODE(SOH.ORDER_CATEGORY,'P','N','D'),'N') SERIAL_NUMBER_CONTROL_FLAG ,  
SPL.INCLUDED_ITEM_FLAG ,  
DECODE(MSI.RESERVABLE_TYPE,1,'Y','N') RESERVABLE_FLAG ,  
SPL.DATE_REQUESTED ,  
SPL.ORIGINAL_REQUESTED_QUANTITY ,  
HOU.NAME ORGANIZATION_NAME ,  
SPL.SHIPPED_QUANTITY ,  
SPL.CANCELLED_QUANTITY ,  
SPL.SHIPMENT_PRIORITY_CODE ,  
SPL.SHIP_METHOD_CODE ,  
SPL.DATE_CONFIRMED ,  
SPL.INVOICED_QUANTITY ,  
SPL.INVENTORY_STATUS ,  
SPL.UNIT_CODE ,  
MSI.PRIMARY_UOM_CODE ,  
SPL.SCHEDULE_DATE ,  
SPL.DEMAND_CLASS_CODE ,  
SPL.CONFIGURATION_ITEM_FLAG ,  
SPL.LATEST_ACCEPTABLE_DATE  
FROM  
MTL_PARAMETERS MP,  
SO_HEADERS_ALL SOH,  
MTL_SYSTEM_ITEMS MSI,  
SO_PICKING_HEADERS_ALL SPH,  
SO_PICKING_LINES_ALL SPL ,  
-- change begins  
HR_ORGANIZATION_UNITS HOU  ,
MTL_PICKING_RULES MPR
WHERE  
MSI.INVENTORY_ITEM_ID = SPL.INVENTORY_ITEM_ID AND  
MSI.ORGANIZATION_ID = NVL(SPL.WAREHOUSE_ID,SPH.WAREHOUSE_ID) AND  
SPH.PICKING_HEADER_ID = SPL.PICKING_HEADER_ID AND  
SOH.HEADER_ID = SPH.ORDER_HEADER_ID AND  
MP.ORGANIZATION_ID = SPL.WAREHOUSE_ID AND  
--- change begins  
HOU.ORGANIZATION_ID  = MP.ORGANIZATION_ID AND
MPR.PICKING_RULE_ID (+) = MSI.PICKING_RULE_ID 
/


/*----------------------------------------------------------------------*/
--      Create View WM_SO_PICKING_HEADERS_QRY_VW  
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_SO_PICKING_HEADERS_QRY_VW ( WEB_TRANSACTION_ID, 
DOCUMENT_TYPE, DOCUMENT_STATUS, PICKING_HEADER_ID, BATCH_NAME, 
ORDER_NUMBER, ORDER_CATEGORY, PICK_SLIP_RULE, ORDER_CURRENCY_CODE, 
CUSTOMER_NAME, FREIGHT_TERMS, ORDER_TYPE_NAME, FROM_ORGANIZATION_NAME, 
SHIP_TO_SITE_USE_LOCATION, STATUS_CODE, PICK_SLIP_NUMBER, WAYBILL_NUM, 
PICKER_NAME, PACKER_NAME, WEIGHT, WEIGHT_UNIT_CODE, 
NUMBER_OF_BOXES, SHIP_METHOD_CODE, SHIP_METHOD_NAME, INVOICED_LINES, 
DATE_RELEASED, DATE_SHIPPED, 
DATE_CONFIRMED, EXPECTED_ARRIVAL_DATE ) AS SELECT  
NULL WEB_TRANSACTION_ID,  
'PICKDETAIL' DOCUMENT_TYPE,  
'QUERY' DOCUMENT_STATUS,  
SPH.PICKING_HEADER_ID ,  
SPB.NAME BATCH_NAME ,  
SH.ORDER_NUMBER ,  
SH.ORDER_CATEGORY ,  
WPSR.NAME PICK_SLIP_RULE,  
SH.CURRENCY_CODE ORDER_CURRENCY_CODE ,  
RC.CUSTOMER_NAME ,  
SOLUP.MEANING FREIGHT_TERMS ,  
ST.NAME ORDER_TYPE_NAME ,  
ORG.NAME FROM_ORGANIZATION_NAME ,  
RSU.LOCATION SHIP_TO_SITE_USE_LOCATION , /* name */  
SPH.STATUS_CODE ,  
SPH.PICK_SLIP_NUMBER ,  
SPH.WAYBILL_NUM ,  
FU1.USER_NAME PICKER_NAME ,  
FU2.USER_NAME PACKER_NAME ,  
SPH.WEIGHT ,  
SPH.WEIGHT_UNIT_CODE ,  
SPH.NUMBER_OF_BOXES ,  
SPH.SHIP_METHOD_CODE ,  
NVL(FRG.DESCRIPTION,FRG.FREIGHT_CODE) SHIP_METHOD_NAME ,  
Shp_Picking_Headers_Pkg.INVOICED_LINES(SPH.PICKING_HEADER_ID) INVOICED_LINES ,  
SPH.DATE_RELEASED ,  
SPH.DATE_SHIPPED ,  
SPH.DATE_CONFIRMED ,  
SPH.EXPECTED_ARRIVAL_DATE  
FROM  
SO_LOOKUPS SOLUP,  
FND_USER FU1,  
FND_USER FU2,  
HR_ORGANIZATION_UNITS ORG,  
MTL_PARAMETERS MP,  
ORG_FREIGHT FRG,  
RA_CUSTOMERS RC,  
RA_ADDRESSES_ALL RA,  
RA_SITE_USES_ALL RSU,  
SO_ORDER_TYPES_ALL ST,  
SO_HEADERS_ALL SH,  
SO_PICKING_BATCHES_ALL SPB,  
SO_PICKING_HEADERS_ALL SPH ,  
WSH_PICK_SLIP_RULES WPSR  
WHERE  
SPB.BATCH_ID = SPH.BATCH_ID AND  
SH.HEADER_ID = SPH.ORDER_HEADER_ID AND  
RSU.SITE_USE_ID = SPH.SHIP_TO_SITE_USE_ID  AND  
RA.ADDRESS_ID = RSU.ADDRESS_ID AND  
RC.CUSTOMER_ID = NVL(SH.CUSTOMER_ID,RA.CUSTOMER_ID) AND  
ORG.ORGANIZATION_ID = SPH.WAREHOUSE_ID AND  
MP.ORGANIZATION_ID = SPH.WAREHOUSE_ID AND  
ST.ORDER_TYPE_ID = SH.ORDER_TYPE_ID AND  
FU1.USER_ID (+) = NVL(SPH.PICKED_BY_ID,-99) AND  
FU2.USER_ID (+) = NVL(SPH.PACKED_BY_ID,-99) AND  
SOLUP.LOOKUP_TYPE (+) = 'FREIGHT_TERMS' AND  
SOLUP.LOOKUP_CODE (+) = NVL(SH.FREIGHT_TERMS_CODE,-99) AND  
FRG.FREIGHT_CODE (+) = NVL(SPH.SHIP_METHOD_CODE,-99) AND  
FRG.ORGANIZATION_ID (+) = Fnd_Profile.VALUE_SPECIFIC('SO_ORGANIZATION_ID') AND  
WPSR.PICK_SLIP_RULE_ID (+) = SPB.PICK_SLIP_RULE_ID
/

 
SHOW ERRORS
