/*  ***************************************************************************
    *    $Date:   27 NOV 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for RFQ outbound in Application Schema  
    * Program Name:         wm_from_rfq_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for RFQ Outbound
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
     27-NOV-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_out_po_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_RFQ_HEADERS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_RFQ_HEADERS_VW
AS
SELECT 
  WMTC.WEB_TRANSACTION_ID WEB_TRANSACTION_ID,
  WMTC.TRANSACTION_TYPE DOCUMENT_TYPE,
  DECODE(WMTC.TRANSACTION_STATUS,0,'UPDATE',1,'INSERT',2,'DELETE') DOCUMENT_STATUS,
  POH.PO_HEADER_ID||'-'||PRV.VENDOR_SITE_ID RFQ_ID,
  POH.PO_HEADER_ID PO_HEADER_ID,
  POH.SEGMENT1 RFQ_NUMBER,
  PDTT.TYPE_NAME DOCUMENT_TYPE_NAME,
  POH.CREATION_DATE CREATED,
  POH.TYPE_LOOKUP_CODE TYPE_LOOKUP_CODE,
  POLC.DISPLAYED_FIELD RFQ_STATUS,
  POH.REVISION_NUM REVISION_NUM,
  HRL1.ADDRESS_LINE_1 SHIP_TO_LOCATION_ADD_LINE_1,
  HRL1.ADDRESS_LINE_2 SHIP_TO_LOCATION_ADD_LINE_2,
  HRL1.ADDRESS_LINE_3 SHIP_TO_LOCATION_ADD_LINE_3,
  HRL1.TOWN_OR_CITY SHIP_TO_LOCATION_TOWN_OR_CITY,
  HRL1.REGION_1 SHIP_TO_LOCATION_COUNTY,
  HRL1.REGION_2 SHIP_TO_LOCATION_STATE,
  HRL1.REGION_3 SHIP_TO_LOCATION_REGION_3,
  HRL1.POSTAL_CODE SHIP_TO_LOCATION_POSTAL_CODE,
  HRL1.COUNTRY SHIP_TO_LOCATION_COUNTRY,
  HRL2.ADDRESS_LINE_1 BILL_TO_LOCATION_ADD_LINE_1,
  HRL2.ADDRESS_LINE_2 BILL_TO_LOCATION_ADD_LINE_2,
  HRL2.ADDRESS_LINE_3 BILL_TO_LOCATION_ADD_LINE_3,
  HRL2.TOWN_OR_CITY BILL_TO_LOCATION_TOWN_OR_CITY,
  HRL2.REGION_1 BILL_TO_LOCATION_COUNTY,
  HRL2.REGION_2 BILL_TO_LOCATION_STATE,
  HRL2.REGION_3 BILL_TO_LOCATION_REGION_3,
  HRL2.POSTAL_CODE BILL_TO_LOCATION_POSTAL_CODE,
  HRL2.COUNTRY BILL_TO_LOCATION_COUNTRY,
  PPF.FULL_NAME AGENT_NAME,
  POH.COMMENTS COMMENTS,
  POH.QUOTE_VENDOR_QUOTE_NUMBER QUOTE_VENDOR_QUOTE_NUMBER,
  POH.FROM_TYPE_LOOKUP_CODE FROM_TYPE_LOOKUP_CODE,
  POH2.SEGMENT1 FROM_RFQ_NUMBER,
  POH.RFQ_CLOSE_DATE RFQ_CLOSE_DATE,
  POH.REPLY_METHOD_LOOKUP_CODE REPLY_VIA,
  POH.REPLY_DATE REPLY_DATE,
  POH.START_DATE START_DATE,
  POH.END_DATE END_DATE,
  POH.APPROVAL_REQUIRED_FLAG APPROVAL_REQUIRED_FLAG,
  POH.CURRENCY_CODE CURRENCY_CODE,
  GLC.USER_CONVERSION_TYPE USER_CONVERSION_TYPE,
  POH.RATE_TYPE RATE_TYPE,
  POH.RATE_DATE RATE_DATE,
  POH.RATE RATE,
  APT.NAME TERMS_NAME,
  POLC3.DISPLAYED_FIELD FREIGHT_TERMS,
  POH.SHIP_VIA_LOOKUP_CODE SHIP_VIA_LOOKUP_CODE,
  POLC2.DISPLAYED_FIELD FOB,
  POH.NOTE_TO_VENDOR NOTE_TO_VENDOR,
  POH.QUOTE_WARNING_DELAY QUOTE_WARNING_DELAY,
  POH.QUOTATION_CLASS_CODE QUOTATION_CLASS_CODE,
  POH.REVISED_DATE REVISED_DATE,
  POH.CLOSED_DATE CLOSED_DATE,
  POH.QUOTE_TYPE_LOOKUP_CODE QUOTE_TYPE_LOOKUP_CODE,
  POH.SUMMARY_FLAG SUMMARY_FLAG,
  POH.ENABLED_FLAG ENABLED_FLAG,
  PRV.SEQUENCE_NUM VENDOR_SEQUENCE_NUM,
  POV.VENDOR_NAME VENDOR_NAME,
  PVS.ADDRESS_LINE1 VENDOR_ADDRESS_LINE1 ,
  PVS.ADDRESS_LINE2 VENDOR_ADDRESS_LINE2 ,
  PVS.ADDRESS_LINE3 VENDOR_ADDRESS_LINE3 ,
 PVS.CITY VENDOR_CITY,
  PVS.STATE VENDOR_STATE,
  PVS.ZIP VENDOR_ZIP,
  PVS.COUNTRY VENDOR_COUNTRY,
  PVS.AREA_CODE||PVS.PHONE VENDOR_PHONE,
  PVS.FAX_AREA_CODE||PVS.FAX VENDOR_FAX,
  DECODE(PRV.VENDOR_CONTACT_ID,NULL, NULL, PVC.LAST_NAME || ',' || PVC.FIRST_NAME) VENDOR_CONTACT_NAME,
  PRV.PRINT_FLAG VENDOR_PRINT_FLAG,
  PRV.PRINT_COUNT VENDOR_PRINT_COUNT,
  PRV.PRINTED_DATE VENDOR_PRINTED_DATE,
  POV.HOLD_FLAG HOLD_FLAG
FROM   
  PO_VENDORS POV,
  PO_RFQ_VENDORS PRV,
  PO_VENDOR_SITES_ALL PVS,
  PO_VENDOR_CONTACTS PVC,
  PO_HEADERS_ALL POH,
  PER_ALL_PEOPLE_F PPF,
  AP_TERMS_TL APT,
  HR_LOCATIONS_ALL HRL1,
  HR_LOCATIONS_ALL HRL2,
  GL_DAILY_CONVERSION_TYPES GLC,
  PO_LOOKUP_CODES POLC,
  PO_LOOKUP_CODES POLC2,
  PO_LOOKUP_CODES POLC3,
  PO_DOCUMENT_TYPES_ALL_TL PDTT,
  PO_DOCUMENT_TYPES_ALL_B PDTB,
  PO_HEADERS POH2,
  WM_TRACK_CHANGES_VW WMTC
WHERE 
  PPF.PERSON_ID = POH.AGENT_ID AND
  TRUNC(SYSDATE) BETWEEN PPF.EFFECTIVE_START_DATE AND  PPF.EFFECTIVE_END_DATE AND
  APT.TERM_ID(+) = POH.TERMS_ID AND
  HRL1.LOCATION_ID(+) = POH.SHIP_TO_LOCATION_ID AND
  HRL2.LOCATION_ID(+) = POH.BILL_TO_LOCATION_ID AND
  GLC.CONVERSION_TYPE(+) = POH.RATE_TYPE AND
  POLC.LOOKUP_TYPE = 'RFQ/QUOTE STATUS' AND
  POLC.LOOKUP_CODE (+) = POH.STATUS_LOOKUP_CODE AND
  POLC2.LOOKUP_CODE (+) = POH.FOB_LOOKUP_CODE AND
  POLC2.LOOKUP_TYPE (+) = 'FOB' AND
  POLC3.LOOKUP_CODE (+) = POH.FREIGHT_TERMS_LOOKUP_CODE AND
  POLC3.LOOKUP_TYPE (+) = 'FREIGHT TERMS' AND
  POH2.PO_HEADER_ID(+) = POH.FROM_HEADER_ID AND
  PDTB.DOCUMENT_TYPE_CODE = PDTT.DOCUMENT_TYPE_CODE AND
  PDTB.DOCUMENT_SUBTYPE = PDTT.DOCUMENT_SUBTYPE AND
  NVL(PDTB.ORG_ID, -99) = NVL(PDTT.ORG_ID, -99) AND
  PDTB.ORG_ID  = POH.ORG_ID AND
  PDTT.DOCUMENT_TYPE_CODE  = POH.TYPE_LOOKUP_CODE AND
  PDTT.DOCUMENT_SUBTYPE = POH.QUOTE_TYPE_LOOKUP_CODE AND
  PDTB.QUOTATION_CLASS_CODE = POH.QUOTATION_CLASS_CODE AND
  POH.TYPE_LOOKUP_CODE IN ('RFQ', 'QUOTATION') AND
  POH.STATUS_LOOKUP_CODE NOT IN  ('I','C') AND
  POV.VENDOR_ID  = PRV.VENDOR_ID AND
  PVS.VENDOR_SITE_ID  = PRV.VENDOR_SITE_ID AND
  PVC.VENDOR_CONTACT_ID(+) = PRV.VENDOR_CONTACT_ID AND
  POH.PO_HEADER_ID = PRV.PO_HEADER_ID AND
  PRV.PO_HEADER_ID||'-'||PRV.VENDOR_SITE_ID = WMTC.TRANSACTION_ID AND
  WMTC.TRANSACTION_STATUS <= 2 AND
  WMTC.TRANSACTION_TYPE = 'RFQ'
/

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_RFQ_LINES_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_RFQ_LINES_VW
(
  PO_HEADER_ID,
  PO_LINE_ID,
  LINE_NUM,
  LINE_TYPE,
  ITEM_NUMBER,
  ITEM_REVISION,
  ITEM_CATEGORY,
  ITEM_DESCRIPTION,
  UNIT_MEAS_LOOKUP_CODE,
  UOM_CLASS,
  UNIT_PRICE,
  VENDOR_PRODUCT_NUM,
  UN_NUMBER,
  HAZARD_CLASS,
  MIN_ORDER_QUANTITY,
  MAX_ORDER_QUANTITY,
  NOTE_TO_VENDOR,
  FROM_RFQ_NUMBER,
  FROM_LINE_NUMBER,
  TAXABLE_FLAG,
  QUANTITY,
  ALLOW_ITEM_DESC_UPDATE_FLAG,
  ALLOWED_UNITS_LOOKUP_CODE,
  ORDER_TYPE_LOOKUP_CODE,
  OUTSIDE_OPERATION_FLAG,
  PROJECT_NAME,
  TASK_NAME,
  QC_GRADE,
  BASE_UOM,
  BASE_QTY,
  SECONDARY_UOM,
  SECONDARY_QTY 
) AS
SELECT 
  POL.PO_HEADER_ID PO_HEADER_ID,
  POL.PO_LINE_ID PO_LINE_ID,
  POL.LINE_NUM LINE_NUM,
  PLT.LINE_TYPE LINE_TYPE,
  MSI.SEGMENT1 ITEM_NUMBER,
  POL.ITEM_REVISION ITEM_REVISION,
  MCKFV.CONCATENATED_SEGMENTS ITEM_CATEGORY,
  POL.ITEM_DESCRIPTION ITEM_DESCRIPTION,
  POL.UNIT_MEAS_LOOKUP_CODE UNIT_MEAS_LOOKUP_CODE,
  MUOM.UOM_CLASS UOM_CLASS,
  POL.UNIT_PRICE UNIT_PRICE,
  POL.VENDOR_PRODUCT_NUM VENDOR_PRODUCT_NUM,
  PUN.UN_NUMBER UN_NUMBER,
  PHC.HAZARD_CLASS HAZARD_CLASS,
  POL.MIN_ORDER_QUANTITY MIN_ORDER_QUANTITY,
  POL.MAX_ORDER_QUANTITY MAX_ORDER_QUANTITY,
  POL.NOTE_TO_VENDOR NOTE_TO_VENDOR,
  POH.SEGMENT1 FROM_RFQ_NUMBER,
  POL1.LINE_NUM FROM_LINE_NUMBER,
  POL.TAXABLE_FLAG TAXABLE_FLAG,
  POL.QUANTITY QUANTITY,
  MSI.ALLOW_ITEM_DESC_UPDATE_FLAG ALLOW_ITEM_DESC_UPDATE_FLAG,
  MSI.ALLOWED_UNITS_LOOKUP_CODE ALLOWED_UNITS_LOOKUP_CODE,
  PLT.ORDER_TYPE_LOOKUP_CODE ORDER_TYPE_LOOKUP_CODE,
  NVL(PLT.OUTSIDE_OPERATION_FLAG,'N') OUTSIDE_OPERATION_FLAG,
  PP.NAME PROJECT_NAME,
  PT.TASK_NAME TASK_NAME,
  POL.QC_GRADE QC_GRADE,
  POL.BASE_UOM BASE_UOM,
  POL.BASE_QTY BASE_QTY,
  POL.SECONDARY_UOM SECONDARY_UOM,
  POL.SECONDARY_QTY SECONDARY_QTY 
FROM 
  PO_LINES_ALL POL ,
  PO_LINE_TYPES PLT ,
  MTL_UNITS_OF_MEASURE_TL MUOM,
  PO_UN_NUMBERS PUN ,
  PO_HAZARD_CLASSES PHC ,
  MTL_SYSTEM_ITEMS MSI ,
  FINANCIALS_SYSTEM_PARAMS_ALL FSP,
  MTL_CATEGORIES_KFV MCKFV,
  PA_TASKS PT,
  PA_PROJECTS_ALL PP,
  PO_LINES_ALL POL1 ,
  PO_HEADERS_ALL POH
WHERE 
  PLT.LINE_TYPE_ID (+) = POL.LINE_TYPE_ID AND
  PUN.UN_NUMBER_ID (+) = POL.UN_NUMBER_ID AND
  PHC.HAZARD_CLASS_ID (+) = POL.HAZARD_CLASS_ID AND
  MUOM.UNIT_OF_MEASURE (+) = POL.UNIT_MEAS_LOOKUP_CODE AND
  POL.ITEM_ID = MSI.INVENTORY_ITEM_ID (+) AND
  PUN.UN_NUMBER_ID (+) = POL.UN_NUMBER_ID AND
  PHC.HAZARD_CLASS_ID (+) = POL.HAZARD_CLASS_ID AND
  NVL(MSI.ORGANIZATION_ID,FSP.INVENTORY_ORGANIZATION_ID) = FSP.INVENTORY_ORGANIZATION_ID AND
  FSP.ORG_ID (+) = POL.ORG_ID AND
  POL.CATEGORY_ID = MCKFV.CATEGORY_ID (+) AND
  POL.PROJECT_ID = PP.PROJECT_ID (+) AND 
  POL.TASK_ID = PT.TASK_ID (+) AND
  POL1.PO_LINE_ID (+) = POL.FROM_LINE_ID AND
  POL.FROM_HEADER_ID  = POH.PO_HEADER_ID (+) 

/

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_RFQ_PRICE_BREAKS_VW 
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_RFQ_PRICE_BREAKS_VW
(
  PO_LINE_ID,
  SHIPMENT_NUM,
  SHIPMENT_TYPE,
  SHIP_TO_ORG_NAME,
  QUANTITY,
  QUANTITY_ACCEPTED,
  QUANTITY_BILLED,
  QUANTITY_CANCELLED,
  QUANTITY_RECEIVED,
  QUANTITY_REJECTED,
  UOM,
  PRICE_OVERRIDE,
  UNIT_PRICE,
  NOT_TO_EXCEED_PRICE,
  ALLOW_PRICE_OVERRIDE_FLAG,
  PRICE_BREAK_LOOKUP_CODE,
  PRICE,
  LAST_ACCEPT_DATE,
  NEED_BY_DATE,
  PROMISED_DATE,
  FIRM_STATUS_LOOKUP_CODE,
  PRICE_DISCOUNT,
  START_DATE,
  END_DATE,
  LEAD_TIME,
  LEAD_TIME_UNIT,
  TERMS_NAME,
  FREIGHT_TERMS_LOOKUP_CODE,
  FOB_LOOKUP_CODE,
  SHIP_VIA_LOOKUP_CODE,
  TAX_NAME,
  TAXABLE_FLAG,
  INSPECTION_REQUIRED_FLAG,
  RECEIPT_REQUIRED_FLAG,
  RECEIVE_CLOSE_TOLERANCE,
  INVOICE_CLOSE_TOLERANCE,
  QTY_RCV_EXCEPTION_CODE,
  DAYS_EARLY_RECEIPT_ALLOWED,
  DAYS_LATE_RECEIPT_ALLOWED,
  QTY_RCV_TOLERANCE,
  ROUTING_NAME,
  ENFORCE_SHIP_TO_LOCATION_CODE,
  RECEIPT_DAYS_EXCEPTION_CODE,
  ACCRUE_ON_RECEIPT_FLAG,
  ALLOW_SUBSTITUTE_RECEIPTS_FLAG,
  FROM_PO_HEADER_NUM ,
  FROM_PO_LINE_NUM,  
  ENCUMBERED_FLAG,
  ENCUMBERED_DATE,
  APPROVED_FLAG,
  CLOSED_CODE,
  CANCEL_FLAG,
  CANCEL_DATE,
  CANCEL_REASON,
  CANCELLED_BY_PERSON_NAME,
  CLOSED_BY_PERSON_NAME,
  CLOSED_DATE,
  CLOSED_REASON,
  USSGL_TRANSACTION_CODE,
  GOVERNMENT_CONTEXT,
  LINE_TYPE,
  OUTSIDE_OPERATION_FLAG,
  RECEIVING_FLAG,
  ITEM_NUMBER,
  ITEM_DESCRIPTION,
  ITEM_REVISION,
  PLANNING_CODE,
  STOCK_ENABLED_FLAG,
  OUTSIDE_OPERATION_UOM_TYPE,
  CATEGORY_NAME,
  VENDOR_PRODUCT_NUM,
  COUNTRY_OF_ORIGIN_CODE,
  TAX_USER_OVERRIDE_FLAG,
  MATCH_OPTION,
  CALCULATE_TAX_FLAG,
  NOTE_TO_RECEIVER,
  SECONDARY_UNIT_OF_MEASURE,
  SECONDARY_QUANTITY,
  PREFERRED_GRADE,
  SECONDARY_QUANTITY_RECEIVED,
  SECONDARY_QUANTITY_ACCEPTED,
  SECONDARY_QUANTITY_REJECTED,
  SECONDARY_QUANTITY_CANCELLED
) AS
SELECT 
  PLL.PO_LINE_ID PO_LINE_ID,
  PLL.SHIPMENT_NUM SHIPMENT_NUM,
  PLL.SHIPMENT_TYPE SHIPMENT_TYPE,
  OOD.ORGANIZATION_NAME SHIP_TO_ORG_NAME,
  PLL.QUANTITY QUANTITY,
  PLL.QUANTITY_ACCEPTED QUANTITY_ACCEPTED,
  PLL.QUANTITY_BILLED QUANTITY_BILLED,
  PLL.QUANTITY_CANCELLED QUANTITY_CANCELLED,
  PLL.QUANTITY_RECEIVED QUANTITY_RECEIVED,
  PLL.QUANTITY_REJECTED QUANTITY_REJECTED,
  DECODE(PLL.SHIPMENT_TYPE,'RFQ',PLL.UNIT_MEAS_LOOKUP_CODE,'QUOTATION',PLL.UNIT_MEAS_LOOKUP_CODE,POL.UNIT_MEAS_LOOKUP_CODE) UOM,
  PLL.PRICE_OVERRIDE PRICE_OVERRIDE,
  POL.UNIT_PRICE UNIT_PRICE,
  POL.NOT_TO_EXCEED_PRICE NOT_TO_EXCEED_PRICE,
  POL.ALLOW_PRICE_OVERRIDE_FLAG ALLOW_PRICE_OVERRIDE_FLAG,
  POL.PRICE_BREAK_LOOKUP_CODE PRICE_BREAK_LOOKUP_CODE,
  PLL.QUANTITY*PLL.PRICE_OVERRIDE PRICE,
  PLL.LAST_ACCEPT_DATE LAST_ACCEPT_DATE,
  PLL.NEED_BY_DATE NEED_BY_DATE,
  PLL.PROMISED_DATE PROMISED_DATE,
  PLL.FIRM_STATUS_LOOKUP_CODE FIRM_STATUS_LOOKUP_CODE,
  PLL.PRICE_DISCOUNT PRICE_DISCOUNT,
  PLL.START_DATE START_DATE,
  PLL.END_DATE END_DATE,
  PLL.LEAD_TIME LEAD_TIME,
  PLL.LEAD_TIME_UNIT LEAD_TIME_UNIT,
  APT.NAME TERMS_NAME,
  PLL.FREIGHT_TERMS_LOOKUP_CODE FREIGHT_TERMS_LOOKUP_CODE,
  PLL.FOB_LOOKUP_CODE FOB_LOOKUP_CODE,
  PLL.SHIP_VIA_LOOKUP_CODE SHIP_VIA_LOOKUP_CODE,
  ATC.NAME TAX_NAME,
  PLL.TAXABLE_FLAG TAXABLE_FLAG,
  PLL.INSPECTION_REQUIRED_FLAG INSPECTION_REQUIRED_FLAG,
  PLL.RECEIPT_REQUIRED_FLAG RECEIPT_REQUIRED_FLAG,
  PLL.RECEIVE_CLOSE_TOLERANCE RECEIVE_CLOSE_TOLERANCE,
  PLL.INVOICE_CLOSE_TOLERANCE INVOICE_CLOSE_TOLERANCE,
  PLL.QTY_RCV_EXCEPTION_CODE QTY_RCV_EXCEPTION_CODE,
  PLL.DAYS_EARLY_RECEIPT_ALLOWED DAYS_EARLY_RECEIPT_ALLOWED,
  PLL.DAYS_LATE_RECEIPT_ALLOWED DAYS_LATE_RECEIPT_ALLOWED,
  PLL.QTY_RCV_TOLERANCE QTY_RCV_TOLERANCE,
  RRH.ROUTING_NAME ROUTING_NAME,
  PLL.ENFORCE_SHIP_TO_LOCATION_CODE ENFORCE_SHIP_TO_LOCATION_CODE,
  PLL.RECEIPT_DAYS_EXCEPTION_CODE RECEIPT_DAYS_EXCEPTION_CODE,
  PLL.ACCRUE_ON_RECEIPT_FLAG ACCRUE_ON_RECEIPT_FLAG,
  PLL.ALLOW_SUBSTITUTE_RECEIPTS_FLAG ALLOW_SUBSTITUTE_RECEIPTS_FLAG,
  POH1.SEGMENT1 FROM_PO_HEADER_NUM ,
  POL1.LINE_NUM FROM_PO_LINE_NUM,  
  NVL(PLL.ENCUMBERED_FLAG, 'N') ENCUMBERED_FLAG,
  PLL.ENCUMBERED_DATE ENCUMBERED_DATE,
  PLL.APPROVED_FLAG APPROVED_FLAG,
  PLL.CLOSED_CODE CLOSED_CODE,
  PLL.CANCEL_FLAG CANCEL_FLAG,
  PLL.CANCEL_DATE CANCEL_DATE,
  PLL.CANCEL_REASON CANCEL_REASON,
  DECODE(PLL.CANCELLED_BY,NULL, NULL, PER.LAST_NAME || ',' || PER.FIRST_NAME) CANCELLED_BY_PERSON_NAME,
  DECODE(PLL.CLOSED_BY,NULL, NULL, PER1.LAST_NAME || ',' || PER1.FIRST_NAME) CLOSED_BY_PERSON_NAME,
  PLL.CLOSED_DATE CLOSED_DATE,
  PLL.CLOSED_REASON CLOSED_REASON,
  PLL.USSGL_TRANSACTION_CODE USSGL_TRANSACTION_CODE,
  PLL.GOVERNMENT_CONTEXT GOVERNMENT_CONTEXT,
  PLT.LINE_TYPE LINE_TYPE,
  PLT.OUTSIDE_OPERATION_FLAG OUTSIDE_OPERATION_FLAG,
  PLT.RECEIVING_FLAG RECEIVING_FLAG,
  MSI.SEGMENT1 ITEM_NUMBER,
  POL.ITEM_DESCRIPTION ITEM_DESCRIPTION,
  POL.ITEM_REVISION ITEM_REVISION,
  DECODE(MSI.MRP_PLANNING_CODE, 3, 'Y', 4,'Y', DECODE(MSI.INVENTORY_PLANNING_CODE, 1, 'Y', 2, 'Y', 'N')) PLANNING_CODE,
  MSI.STOCK_ENABLED_FLAG STOCK_ENABLED_FLAG,
  MSI.OUTSIDE_OPERATION_UOM_TYPE OUTSIDE_OPERATION_UOM_TYPE,
  MCA.CONCATENATED_SEGMENTS CATEGORY_NAME,
  POL.VENDOR_PRODUCT_NUM VENDOR_PRODUCT_NUM,
  PLL.COUNTRY_OF_ORIGIN_CODE COUNTRY_OF_ORIGIN_CODE,
  PLL.TAX_USER_OVERRIDE_FLAG TAX_USER_OVERRIDE_FLAG,
  PLL.MATCH_OPTION MATCH_OPTION,
  PLL.CALCULATE_TAX_FLAG CALCULATE_TAX_FLAG,
  PLL.NOTE_TO_RECEIVER NOTE_TO_RECEIVER,
  POL.SECONDARY_UNIT_OF_MEASURE SECONDARY_UNIT_OF_MEASURE,
  PLL.SECONDARY_QUANTITY SECONDARY_QUANTITY,
  PLL.PREFERRED_GRADE PREFERRED_GRADE,
  PLL.SECONDARY_QUANTITY_RECEIVED SECONDARY_QUANTITY_RECEIVED,
  PLL.SECONDARY_QUANTITY_ACCEPTED SECONDARY_QUANTITY_ACCEPTED,
  PLL.SECONDARY_QUANTITY_REJECTED SECONDARY_QUANTITY_REJECTED,
  PLL.SECONDARY_QUANTITY_CANCELLED SECONDARY_QUANTITY_CANCELLED
FROM 
  PO_LINE_TYPES PLT,
  PO_LOOKUP_CODES POLC1,
  PO_LOOKUP_CODES POLC2,
  HR_LOCATIONS_ALL HRL,
  ORG_ORGANIZATION_DEFINITIONS OOD,
  AP_TERMS APT,
  AP_TAX_CODES_ALL ATC,
  MTL_SYSTEM_ITEMS MSI,
  FINANCIALS_SYSTEM_PARAMS_ALL FSP,
  MTL_CATEGORIES_KFV MCA,
  PO_LINES_ALL POL,
  PO_LINE_LOCATIONS_ALL PLL,
  PO_HEADERS_ALL POH1,
  PO_LINES_ALL POL1,
  RCV_ROUTING_HEADERS RRH,
  PER_ALL_PEOPLE_F PER,
  PER_ALL_PEOPLE_F PER1
WHERE 
  PLL.PO_LINE_ID = POL.PO_LINE_ID AND
  POL.ITEM_ID = MSI.INVENTORY_ITEM_ID (+) AND
  NVL(MSI.ORGANIZATION_ID,FSP.INVENTORY_ORGANIZATION_ID) = FSP.INVENTORY_ORGANIZATION_ID AND
  POL.CATEGORY_ID = MCA.CATEGORY_ID AND
  PLL.SHIPMENT_TYPE IN ('STANDARD', 'PLANNED', 'PRICE BREAK','RFQ', 'QUOTATION') AND
  HRL.LOCATION_ID (+) = PLL.SHIP_TO_LOCATION_ID AND
  OOD.ORGANIZATION_ID(+) = PLL.SHIP_TO_ORGANIZATION_ID AND
  APT.TERM_ID (+) = PLL.TERMS_ID AND
  POL.LINE_TYPE_ID = PLT.LINE_TYPE_ID AND
  POLC1.LOOKUP_TYPE(+) = 'DOCUMENT STATE' AND
  POLC1.LOOKUP_CODE(+) = NVL(PLL.CLOSED_CODE, 'OPEN') AND
  POLC2.LOOKUP_TYPE (+) = 'DOCUMENT STATE' AND
  POLC2.LOOKUP_CODE (+) = 'CANCELLED' AND
  PLL.TAX_CODE_ID = ATC.TAX_ID(+) AND
  FSP.ORG_ID (+) = POL.ORG_ID AND
  RRH.ROUTING_HEADER_ID (+) = PLL.RECEIVING_ROUTING_ID AND
  POH1.PO_HEADER_ID (+) =   PLL.FROM_HEADER_ID AND
  POL1.PO_LINE_ID (+) =  PLL.FROM_LINE_ID  AND
  PER.PERSON_ID (+) = PLL.CANCELLED_BY AND
  PER1.PERSON_ID (+) = PLL.CLOSED_BY
/

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_RFQ_QRY_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_RFQ_QRY_VW
AS
SELECT 
  NULL WEB_TRANSACTION_ID,
  'RFQ' DOCUMENT_TYPE,
  'QUERY' DOCUMENT_STATUS,
  POH.PO_HEADER_ID||'-'||PRV.VENDOR_SITE_ID RFQ_ID,
  POH.PO_HEADER_ID PO_HEADER_ID,
  POH.SEGMENT1 RFQ_NUMBER,
  PDTT.TYPE_NAME DOCUMENT_TYPE_NAME,
  POH.CREATION_DATE CREATED,
  POH.TYPE_LOOKUP_CODE TYPE_LOOKUP_CODE,
  POLC.DISPLAYED_FIELD RFQ_STATUS,
  POH.REVISION_NUM REVISION_NUM,
  HRL1.ADDRESS_LINE_1 SHIP_TO_LOCATION_ADD_LINE_1,
  HRL1.ADDRESS_LINE_2 SHIP_TO_LOCATION_ADD_LINE_2,
  HRL1.ADDRESS_LINE_3 SHIP_TO_LOCATION_ADD_LINE_3,
  HRL1.TOWN_OR_CITY SHIP_TO_LOCATION_TOWN_OR_CITY,
  HRL1.REGION_1 SHIP_TO_LOCATION_COUNTY,
  HRL1.REGION_2 SHIP_TO_LOCATION_STATE,
  HRL1.REGION_3 SHIP_TO_LOCATION_REGION_3,
  HRL1.POSTAL_CODE SHIP_TO_LOCATION_POSTAL_CODE,
  HRL1.COUNTRY SHIP_TO_LOCATION_COUNTRY,
  HRL2.ADDRESS_LINE_1 BILL_TO_LOCATION_ADD_LINE_1,
  HRL2.ADDRESS_LINE_2 BILL_TO_LOCATION_ADD_LINE_2,
  HRL2.ADDRESS_LINE_3 BILL_TO_LOCATION_ADD_LINE_3,
  HRL2.TOWN_OR_CITY BILL_TO_LOCATION_TOWN_OR_CITY,
  HRL2.REGION_1 BILL_TO_LOCATION_COUNTY,
  HRL2.REGION_2 BILL_TO_LOCATION_STATE,
  HRL2.REGION_3 BILL_TO_LOCATION_REGION_3,
  HRL2.POSTAL_CODE BILL_TO_LOCATION_POSTAL_CODE,
  HRL2.COUNTRY BILL_TO_LOCATION_COUNTRY,
  PPF.FULL_NAME AGENT_NAME,
  POH.COMMENTS COMMENTS,
  POH.QUOTE_VENDOR_QUOTE_NUMBER QUOTE_VENDOR_QUOTE_NUMBER,
  POH.FROM_TYPE_LOOKUP_CODE FROM_TYPE_LOOKUP_CODE,
  POH2.SEGMENT1 FROM_RFQ_NUMBER,
  POH.RFQ_CLOSE_DATE RFQ_CLOSE_DATE,
  POH.REPLY_METHOD_LOOKUP_CODE REPLY_VIA,
  POH.REPLY_DATE REPLY_DATE,
  POH.START_DATE START_DATE,
  POH.END_DATE END_DATE,
  POH.APPROVAL_REQUIRED_FLAG APPROVAL_REQUIRED_FLAG,
  POH.CURRENCY_CODE CURRENCY_CODE,
  GLC.USER_CONVERSION_TYPE USER_CONVERSION_TYPE,
  POH.RATE_TYPE RATE_TYPE,
  POH.RATE_DATE RATE_DATE,
  POH.RATE RATE,
  APT.NAME TERMS_NAME,
  POLC3.DISPLAYED_FIELD FREIGHT_TERMS,
  POH.SHIP_VIA_LOOKUP_CODE SHIP_VIA_LOOKUP_CODE,
  POLC2.DISPLAYED_FIELD FOB,
  POH.NOTE_TO_VENDOR NOTE_TO_VENDOR,
  POH.QUOTE_WARNING_DELAY QUOTE_WARNING_DELAY,
  POH.QUOTATION_CLASS_CODE QUOTATION_CLASS_CODE,
  POH.REVISED_DATE REVISED_DATE,
  POH.CLOSED_DATE CLOSED_DATE,
  POH.QUOTE_TYPE_LOOKUP_CODE QUOTE_TYPE_LOOKUP_CODE,
  POH.SUMMARY_FLAG SUMMARY_FLAG,
  POH.ENABLED_FLAG ENABLED_FLAG,
  PRV.SEQUENCE_NUM VENDOR_SEQUENCE_NUM,
  POV.VENDOR_NAME VENDOR_NAME,
  PVS.ADDRESS_LINE1 VENDOR_ADDRESS_LINE1 ,
  PVS.ADDRESS_LINE2 VENDOR_ADDRESS_LINE2 ,
  PVS.ADDRESS_LINE3 VENDOR_ADDRESS_LINE3 ,
 PVS.CITY VENDOR_CITY,
  PVS.STATE VENDOR_STATE,
  PVS.ZIP VENDOR_ZIP,
  PVS.COUNTRY VENDOR_COUNTRY,
  PVS.AREA_CODE||PVS.PHONE VENDOR_PHONE,
  PVS.FAX_AREA_CODE||PVS.FAX VENDOR_FAX,
  DECODE(PRV.VENDOR_CONTACT_ID,NULL, NULL, PVC.LAST_NAME || ',' || PVC.FIRST_NAME) VENDOR_CONTACT_NAME,
  PRV.PRINT_FLAG VENDOR_PRINT_FLAG,
  PRV.PRINT_COUNT VENDOR_PRINT_COUNT,
  PRV.PRINTED_DATE VENDOR_PRINTED_DATE,
  POV.HOLD_FLAG HOLD_FLAG
FROM   
  PO_VENDORS POV,
  PO_RFQ_VENDORS PRV,
  PO_VENDOR_SITES_ALL PVS,
  PO_VENDOR_CONTACTS PVC,
  PO_HEADERS_ALL POH,
  PER_ALL_PEOPLE_F PPF,
  AP_TERMS_TL APT,
  HR_LOCATIONS_ALL HRL1,
  HR_LOCATIONS_ALL HRL2,
  GL_DAILY_CONVERSION_TYPES GLC,
  PO_LOOKUP_CODES POLC,
  PO_LOOKUP_CODES POLC2,
  PO_LOOKUP_CODES POLC3,
  PO_DOCUMENT_TYPES_ALL_TL PDTT,
  PO_DOCUMENT_TYPES_ALL_B PDTB,
  PO_HEADERS POH2
WHERE 
  PPF.PERSON_ID = POH.AGENT_ID AND
  TRUNC(SYSDATE) BETWEEN PPF.EFFECTIVE_START_DATE AND  PPF.EFFECTIVE_END_DATE AND
  APT.TERM_ID(+) = POH.TERMS_ID AND
  HRL1.LOCATION_ID(+) = POH.SHIP_TO_LOCATION_ID AND
  HRL2.LOCATION_ID(+) = POH.BILL_TO_LOCATION_ID AND
  GLC.CONVERSION_TYPE(+) = POH.RATE_TYPE AND
  POLC.LOOKUP_TYPE = 'RFQ/QUOTE STATUS' AND
  POLC.LOOKUP_CODE (+) = POH.STATUS_LOOKUP_CODE AND
  POLC2.LOOKUP_CODE (+) = POH.FOB_LOOKUP_CODE AND
  POLC2.LOOKUP_TYPE (+) = 'FOB' AND
  POLC3.LOOKUP_CODE (+) = POH.FREIGHT_TERMS_LOOKUP_CODE AND
  POLC3.LOOKUP_TYPE (+) = 'FREIGHT TERMS' AND
  POH2.PO_HEADER_ID(+) = POH.FROM_HEADER_ID AND
  PDTB.DOCUMENT_TYPE_CODE = PDTT.DOCUMENT_TYPE_CODE AND
  PDTB.DOCUMENT_SUBTYPE = PDTT.DOCUMENT_SUBTYPE AND
  NVL(PDTB.ORG_ID, -99) = NVL(PDTT.ORG_ID, -99) AND
  PDTB.ORG_ID  = POH.ORG_ID AND
  PDTT.DOCUMENT_TYPE_CODE  = POH.TYPE_LOOKUP_CODE AND
  PDTT.DOCUMENT_SUBTYPE = POH.QUOTE_TYPE_LOOKUP_CODE AND
  PDTB.QUOTATION_CLASS_CODE = POH.QUOTATION_CLASS_CODE AND
  POH.TYPE_LOOKUP_CODE IN ('RFQ', 'QUOTATION') AND
  POV.VENDOR_ID  = PRV.VENDOR_ID AND
  PVS.VENDOR_SITE_ID  = PRV.VENDOR_SITE_ID AND
  PVC.VENDOR_CONTACT_ID(+) = PRV.VENDOR_CONTACT_ID AND
  POH.PO_HEADER_ID = PRV.PO_HEADER_ID
/

SHOW ERRORS

