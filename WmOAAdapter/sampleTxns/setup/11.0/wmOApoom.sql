REM ==============================Release 11====================================
REM ==============================PO HEADERS======================================
REM ==============================PO HEADERS======================================

CREATE OR REPLACE VIEW WM_POO_HEADERS_V
AS
(
SELECT
PH.ORG_ID,                 
PH.TYPE_LOOKUP_CODE DOCUMENT_TYPE, 
PH.SEGMENT1 DOCUMENT_CODE, 
SYSDATE TRANSACTION_DATE, 
PH.SEGMENT1 PO_NUMBER, 
0 POR_RELEASE_ID, 
0 POR_RELEASE_NUM, 
TO_DATE(NULL) POR_RELEASE_DATE, 
PH.CREATION_DATE CREATION_DATE, 
PH.REVISION_NUM REVISION_NUM, 
PH.REVISED_DATE REVISED_DATE , 
PH.COMMENTS COMMENTS, 
PH.TYPE_LOOKUP_CODE PO_TYPE, 
T.NAME PAYMENT_TERMS, 
FCC.CURRENCY_CODE CURRENCY_CODE, 
PH.RATE CURRENCY_RATE, 
PH.SHIP_VIA_LOOKUP_CODE SHIP_VIA, 
PH.FOB_LOOKUP_CODE FOB_CODE, 
PH.FREIGHT_TERMS_LOOKUP_CODE FREIGHT_TERMS, 
PH.CANCEL_FLAG CANCEL_FLAG, 
PH.ACCEPTANCE_REQUIRED_FLAG ACCEPTANCE_REQUIRED_FLAG, 
PH.ACCEPTANCE_DUE_DATE ACCEPTANCE_DUE_DATE, 
PH.CONFIRMING_ORDER_FLAG CONFIRMING_ORDER_FLAG, 
PH.START_DATE BLANKET_START_DATE, 
PH.END_DATE BLANKET_END_DATE, 
NVL(PH.BLANKET_TOTAL_AMOUNT,'') BLANKET_TOTAL_AMOUNT, 
VN.SEGMENT1 SUPPLIER_NUMBER, 
VN.VENDOR_NAME SUPPLIER_NAME, 
PH.NOTE_TO_VENDOR NOTE_TO_VENDOR, 
PH.ATTRIBUTE_CATEGORY PO_ATTRIBUTE_CATEGORY, 
PH.ATTRIBUTE1 PO_ATTRIBUTE1, 
PH.ATTRIBUTE2 PO_ATTRIBUTE2, 
PH.ATTRIBUTE3 PO_ATTRIBUTE3, 
PH.ATTRIBUTE4 PO_ATTRIBUTE4, 
PH.ATTRIBUTE5 PO_ATTRIBUTE5, 
PH.ATTRIBUTE6 PO_ATTRIBUTE6, 
PH.ATTRIBUTE7 PO_ATTRIBUTE7, 
PH.ATTRIBUTE8 PO_ATTRIBUTE8, 
PH.ATTRIBUTE9 PO_ATTRIBUTE9, 
PH.ATTRIBUTE10 PO_ATTRIBUTE10, 
PH.ATTRIBUTE11 PO_ATTRIBUTE11, 
PH.ATTRIBUTE12 PO_ATTRIBUTE12, 
PH.ATTRIBUTE13 PO_ATTRIBUTE13, 
PH.ATTRIBUTE14 PO_ATTRIBUTE14, 
PH.ATTRIBUTE15 PO_ATTRIBUTE15, 
VN.ATTRIBUTE_CATEGORY SU_ATTRIBUTE_CATEGORY, 
VN.ATTRIBUTE1 SU_ATTRIBUTE1, 
VN.ATTRIBUTE2 SU_ATTRIBUTE2, 
VN.ATTRIBUTE3 SU_ATTRIBUTE3, 
VN.ATTRIBUTE4 SU_ATTRIBUTE4, 
VN.ATTRIBUTE5 SU_ATTRIBUTE5, 
VN.ATTRIBUTE6 SU_ATTRIBUTE6, 
VN.ATTRIBUTE7 SU_ATTRIBUTE7,  
VN.ATTRIBUTE8 SU_ATTRIBUTE8, 
VN.ATTRIBUTE9 SU_ATTRIBUTE9, 
VN.ATTRIBUTE10 SU_ATTRIBUTE10, 
VN.ATTRIBUTE11 SU_ATTRIBUTE11, 
VN.ATTRIBUTE12 SU_ATTRIBUTE12, 
VN.ATTRIBUTE13 SU_ATTRIBUTE13, 
VN.ATTRIBUTE14 SU_ATTRIBUTE14, 
VN.ATTRIBUTE15 SU_ATTRIBUTE15, 
PVS.ATTRIBUTE_CATEGORY SS_ATTRIBUTE_CATEGORY, 
PVS.ATTRIBUTE1 SS_ATTRIBUTE1, 
PVS.ATTRIBUTE2 SS_ATTRIBUTE2,
PVS.ATTRIBUTE3 SS_ATTRIBUTE3, 
PVS.ATTRIBUTE4 SS_ATTRIBUTE4, 
PVS.ATTRIBUTE5 SS_ATTRIBUTE5, 
PVS.ATTRIBUTE6 SS_ATTRIBUTE6, 
PVS.ATTRIBUTE7 SS_ATTRIBUTE7, 
PVS.ATTRIBUTE8 SS_ATTRIBUTE8, 
PVS.ATTRIBUTE9 SS_ATTRIBUTE9, 
PVS.ATTRIBUTE10 SS_ATTRIBUTE10, 
PVS.ATTRIBUTE11 SS_ATTRIBUTE11, 
PVS.ATTRIBUTE12 SS_ATTRIBUTE12, 
PVS.ATTRIBUTE13 SS_ATTRIBUTE13, 
PVS.ATTRIBUTE14 SS_ATTRIBUTE14,                    
PVS.ATTRIBUTE15 SS_ATTRIBUTE15, 
VN.CUSTOMER_NUM CUSTOMER_NUMBER, 
PH.VENDOR_SITE_ID VENDOR_SITE_ID, 
PVS.ADDRESS_LINE1 SU_ADDRESS_LINE1, 
PVS.ADDRESS_LINE2 SU_ADDRESS_LINE2, 
PVS.ADDRESS_LINE3 SU_ADDRESS_LINE3, 
'' SU_ADDRESS_LINE4, 
PVS.CITY SU_CITY, 
PVS.ZIP SU_ZIP, 
PVS.COUNTRY SU_COUNTRY, 
PVS.STATE SU_STATE, 
PVS.PROVINCE SU_PROVINCE, 
PVS.AREA_CODE SU_AREA_CODE, 
PVS.PHONE SU_PHONE, 
PVS.FAX_AREA_CODE SU_FAX_AREA_CODE, 
PVS.FAX SU_FAX, 
PVS.TELEX SU_TELEX, 
PVC.LAST_NAME CN_LAST_NAME,                    
PVC.FIRST_NAME CN_FIRST_NAME, 
PVC.AREA_CODE CN_AREA_CODE, 
PVC.PHONE CN_PHONE, 
PH.SHIP_TO_LOCATION_ID ST_LOCATION_ID, 
HRA.LAST_NAME ST_CONTACT_LAST_NAME,
HRA.FIRST_NAME ST_CONTACT_FIRST_NAME, 
LC.DESCRIPTION ST_NAME, 
LC.ADDRESS_LINE_1 ST_ADDRESS_LINE1, 
LC.ADDRESS_LINE_2 ST_ADDRESS_LINE2, 
LC.ADDRESS_LINE_3 ST_ADDRESS_LINE3, 
LC.TOWN_OR_CITY ST_CITY, 
LC.POSTAL_CODE ST_POSTAL_CODE, 
LC.COUNTRY ST_COUNTRY, 
LC.REGION_1 ST_REGION1, 
LC.REGION_2 ST_REGION2, 
LC.REGION_3 ST_REGION3, 
LC.TELEPHONE_NUMBER_1 ST_PHONE1, 
LC.TELEPHONE_NUMBER_2 ST_PHONE2, 
LC.TELEPHONE_NUMBER_3 ST_PHONE3, 
PH.BILL_TO_LOCATION_ID BT_LOCATION_ID,
HRB.LAST_NAME BT_CONTACT_LAST_NAME , 
HRB.FIRST_NAME BT_CONTACT_FIRST_NAME , 
LC2.DESCRIPTION BT_NAME , 
LC2.ADDRESS_LINE_1 BT_ADDRESS_LINE1, 
LC2.ADDRESS_LINE_2 BT_ADDRESS_LINE2, 
LC2.ADDRESS_LINE_3 BT_ADDRESS_LINE3, 
LC2.TOWN_OR_CITY BT_CITY, 
LC2.POSTAL_CODE BT_POSTAL_CODE, 
LC2.COUNTRY BT_COUNTRY, 
LC2.REGION_1 BT_REGION1, 
LC2.REGION_2 BT_REGION2, 
LC2.REGION_3 BT_REGION3, 
LC2.TELEPHONE_NUMBER_1 BT_PHONE1, 
LC2.TELEPHONE_NUMBER_2 BT_PHONE2, 
LC2.TELEPHONE_NUMBER_3 BT_PHONE3, 
PPF.LAST_NAME BUYER_LAST_NAME, 
PPF.FIRST_NAME BUYER_FIRST_NAME,
PPF.EMAIL_ADDRESS BUYER_EMAIL_ADDRESS, 
PPF.WORK_TELEPHONE BUYER_WORK_TELEPHONE, 
PA.TELEPHONE_NUMBER_1 BUYER_MISC_TELEPHONE1, 
PA.TELEPHONE_NUMBER_2 BUYER_MISC_TELEPHONE2, 
PA.TELEPHONE_NUMBER_3 BUYER_MISC_TELEPHONE3, 
PH.PO_HEADER_ID PO_HEADER_ID,
FSP.INVENTORY_ORGANIZATION_ID FSP_INVENTORY_ORGANIZATION_ID 
FROM 
FND_CURRENCIES_VL FCC, 
PO_VENDORS VN, 
PO_VENDOR_SITES_ALL PVS, 
PO_VENDOR_CONTACTS PVC,
PER_ADDRESSES PA, 
PER_PEOPLE_F PPF, 
HR_EMPLOYEES HRA, 
HR_EMPLOYEES HRB, 
HR_LOCATIONS LC, 
HR_LOCATIONS LC2, 
AP_TERMS T, 
PO_HEADERS_ALL PH,
PO_HEADERS_ARCHIVE_ALL PHA, 
FINANCIALS_SYSTEM_PARAMS_ALL FSP 
WHERE  
PH.TYPE_LOOKUP_CODE in ('BLANKET','STANDARD') 
AND VN.VENDOR_ID = PH.VENDOR_ID 
AND PVS.VENDOR_SITE_ID = PH.VENDOR_SITE_ID 
AND PH.VENDOR_CONTACT_ID = PVC.VENDOR_CONTACT_ID (+) 
AND LC.LOCATION_ID = PH.SHIP_TO_LOCATION_ID 
AND LC2.LOCATION_ID = PH.BILL_TO_LOCATION_ID 
AND PPF.PERSON_ID = PH.AGENT_ID 
AND PA.PERSON_ID (+) = PPF.PERSON_ID 
AND PA.PRIMARY_FLAG (+) = 'Y' 
AND PA.DATE_FROM (+) <= TRUNC(SYSDATE) 
AND NVL(PA.DATE_TO (+),TRUNC(SYSDATE)) >= TRUNC(SYSDATE) 
AND PPF.EMPLOYEE_NUMBER IS NOT NULL 
AND TRUNC(SYSDATE) BETWEEN PPF.EFFECTIVE_START_DATE AND PPF.EFFECTIVE_END_DATE 
AND HRA.EMPLOYEE_ID (+) = LC.DESIGNATED_RECEIVER_ID 
AND HRB.EMPLOYEE_ID(+) = LC2.DESIGNATED_RECEIVER_ID
AND PH.TERMS_ID = T.TERM_ID (+) 
AND FCC.CURRENCY_CODE = PH.CURRENCY_CODE 
AND PH.PO_HEADER_ID = PHA.PO_HEADER_ID 
AND PH.REVISION_NUM = PHA.REVISION_NUM                    
AND PHA.LATEST_EXTERNAL_FLAG = 'Y' 
AND NVL(PH.PRINT_COUNT,0) = 0 
AND NVL(PH.APPROVED_FLAG,'N') = 'Y' 
AND NVL(PH.CANCEL_FLAG,'N') = 'N' 
AND NVL(PH.USER_HOLD_FLAG,'N') = 'N' 
AND PH.ORG_ID = FSP.ORG_ID
AND PH.ORG_ID = PVS.ORG_ID
 					UNION ALL
SELECT 
PH.ORG_ID,
'RELEASE' DOCUMENT_TYPE, 
PH.SEGMENT1 DOCUMENT_CODE, 
SYSDATE TRANSACTION_DATE, 
PH.SEGMENT1 PO_NUMBER, 
PR.PO_RELEASE_ID POR_RELEASE_ID, 
PR.RELEASE_NUM POR_RELEASE_NUM, 
PR.RELEASE_DATE POR_RELEASE_DATE, 
PR.CREATION_DATE CREATION_DATE, 
PR.REVISION_NUM REVISION_NUM,
PR.REVISED_DATE REVISED_DATE,
PH.COMMENTS COMMENTS, 
PH.TYPE_LOOKUP_CODE PO_TYPE, 
T.NAME PAYMENT_TERMS, 
FCC.CURRENCY_CODE CURRENCY_CODE, 
PH.RATE CURRENCY_RATE, 
PH.SHIP_VIA_LOOKUP_CODE SHIP_VIA, 
PH.FOB_LOOKUP_CODE FOB_CODE, 
PH.FREIGHT_TERMS_LOOKUP_CODE FREIGHT_TERMS, 
PR.CANCEL_FLAG CANCEL_FLAG, 
PR.ACCEPTANCE_REQUIRED_FLAG ACCEPTANCE_REQUIRED_FLAG, 
PR.ACCEPTANCE_DUE_DATE ACCEPTANCE_DUE_DATE, 
'' CONFIRMING_ORDER_FLAG, 
TO_DATE(NULL) BLANKET_START_DATE, 
TO_DATE(NULL) BLANKET_END_DATE, 
TO_NUMBER(NULL) BLANKET_TOTAL_AMOUNT, 
VN.SEGMENT1 SUPPLIER_NUMBER, 
VN.VENDOR_NAME SUPPLIER_NAME, 
PH.NOTE_TO_VENDOR NOTE_TO_VENDOR, 
PH.ATTRIBUTE_CATEGORY PO_ATTRIBUTE_CATEGORY, 
PH.ATTRIBUTE1 PO_ATTRIBUTE1, 
PH.ATTRIBUTE2 PO_ATTRIBUTE2, 
PH.ATTRIBUTE3 PO_ATTRIBUTE3, 
PH.ATTRIBUTE4 PO_ATTRIBUTE4, 
PH.ATTRIBUTE5 PO_ATTRIBUTE5, 
PH.ATTRIBUTE6 PO_ATTRIBUTE6, 
PH.ATTRIBUTE7 PO_ATTRIBUTE7, 
PH.ATTRIBUTE8 PO_ATTRIBUTE8, 
PH.ATTRIBUTE9 PO_ATTRIBUTE9, 
PH.ATTRIBUTE10 PO_ATTRIBUTE10, 
PH.ATTRIBUTE11 PO_ATTRIBUTE11, 
PH.ATTRIBUTE12 PO_ATTRIBUTE12, 
PH.ATTRIBUTE13 PO_ATTRIBUTE13, 
PH.ATTRIBUTE14 PO_ATTRIBUTE14, 
PH.ATTRIBUTE15 PO_ATTRIBUTE15, 
VN.ATTRIBUTE_CATEGORY SU_ATTRIBUTE_CATEGORY, 
VN.ATTRIBUTE1 SU_ATTRIBUTE1, 
VN.ATTRIBUTE2 SU_ATTRIBUTE2, 
VN.ATTRIBUTE3 SU_ATTRIBUTE3,
VN.ATTRIBUTE4 SU_ATTRIBUTE4, 
VN.ATTRIBUTE5 SU_ATTRIBUTE5, 
VN.ATTRIBUTE6 SU_ATTRIBUTE6, 
VN.ATTRIBUTE7 SU_ATTRIBUTE7, 
VN.ATTRIBUTE8 SU_ATTRIBUTE8, 
VN.ATTRIBUTE9 SU_ATTRIBUTE9, 
VN.ATTRIBUTE10 SU_ATTRIBUTE10, 
VN.ATTRIBUTE11 SU_ATTRIBUTE11, 
VN.ATTRIBUTE12 SU_ATTRIBUTE12, 
VN.ATTRIBUTE13 SU_ATTRIBUTE13, 
VN.ATTRIBUTE14 SU_ATTRIBUTE14, 
VN.ATTRIBUTE15 SU_ATTRIBUTE15, 
PVS.ATTRIBUTE_CATEGORY SS_ATTRIBUTE_CATEGORY, 
PVS.ATTRIBUTE1 SS_ATTRIBUTE1, 
PVS.ATTRIBUTE2 SS_ATTRIBUTE2, 
PVS.ATTRIBUTE3 SS_ATTRIBUTE3, 
PVS.ATTRIBUTE4 SS_ATTRIBUTE4, 
PVS.ATTRIBUTE5 SS_ATTRIBUTE5, 
PVS.ATTRIBUTE6 SS_ATTRIBUTE6, 
PVS.ATTRIBUTE7 SS_ATTRIBUTE7, 
PVS.ATTRIBUTE8 SS_ATTRIBUTE8, 
PVS.ATTRIBUTE9 SS_ATTRIBUTE9, 
PVS.ATTRIBUTE10 SS_ATTRIBUTE10, 
PVS.ATTRIBUTE11 SS_ATTRIBUTE11, 
PVS.ATTRIBUTE12 SS_ATTRIBUTE12, 
PVS.ATTRIBUTE13 SS_ATTRIBUTE13,                     
PVS.ATTRIBUTE14 SS_ATTRIBUTE14, 
PVS.ATTRIBUTE15 SS_ATTRIBUTE15, 
VN.CUSTOMER_NUM CUSTOMER_NUMBER, 
PH.VENDOR_SITE_ID VENDOR_SITE_ID, 
PVS.ADDRESS_LINE1 SU_ADDRESS_LINE1, 
PVS.ADDRESS_LINE2 SU_ADDRESS_LINE2, 
PVS.ADDRESS_LINE3 SU_ADDRESS_LINE3, 
'' SU_ADDRESS_LINE4, 
PVS.CITY SU_CITY, 
PVS.ZIP SU_ZIP, 
PVS.COUNTRY SU_COUNTRY, 
PVS.STATE SU_STATE, 
PVS.PROVINCE SU_PROVINCE, 
PVS.AREA_CODE SU_AREA_CODE, 
PVS.PHONE SU_PHONE, 
PVS.FAX_AREA_CODE SU_FAX_AREA_CODE, 
PVS.FAX SU_FAX, PVS.TELEX SU_TELEX, 
PVC.LAST_NAME CN_LAST_NAME, 
PVC.FIRST_NAME CN_FIRST_NAME, 
PVC.AREA_CODE CN_AREA_CODE, 
PVC.PHONE CN_PHONE, 
PH.SHIP_TO_LOCATION_ID ST_LOCATION_ID,
HRA.LAST_NAME ST_CONTACT_LAST_NAME, 
HRA.FIRST_NAME ST_CONTACT_FIRST_NAME,                    
LC.DESCRIPTION ST_NAME, 
LC.ADDRESS_LINE_1 ST_ADDRESS_LINE1, 
LC.ADDRESS_LINE_2 ST_ADDRESS_LINE2, 
LC.ADDRESS_LINE_3 ST_ADDRESS_LINE3, 
LC.TOWN_OR_CITY ST_CITY, 
LC.POSTAL_CODE ST_POSTAL_CODE, 
LC.COUNTRY ST_COUNTRY, 
LC.REGION_1 ST_REGION1, 
LC.REGION_2 ST_REGION2, 
LC.REGION_3 ST_REGION3, 
LC.TELEPHONE_NUMBER_1 ST_PHONE1, 
LC.TELEPHONE_NUMBER_2 ST_PHONE2, 
LC.TELEPHONE_NUMBER_3 ST_PHONE3, 
PH.BILL_TO_LOCATION_ID BT_LOCATION_ID,
HRB.LAST_NAME BT_CONTACT_LAST_NAME, 
HRB.FIRST_NAME BT_CONTACT_FIRST_NAME, 
LC2.DESCRIPTION BT_NAME, 
LC2.ADDRESS_LINE_1 BT_ADDRESS_LINE1, 
LC2.ADDRESS_LINE_2 BT_ADDRESS_LINE2, 
LC2.ADDRESS_LINE_3 BT_ADDRESS_LINE3, 
LC2.TOWN_OR_CITY BT_CITY, 
LC2.POSTAL_CODE BT_POSTAL_CODE, 
LC2.COUNTRY BT_COUNTRY, 
LC2.REGION_1 BT_REGION1, 
LC2.REGION_2 BT_REGION2, 
LC2.REGION_3 BT_REGION3, 
LC2.TELEPHONE_NUMBER_1 BT_PHONE1, 
LC2.TELEPHONE_NUMBER_2 BT_PHONE2, 
LC2.TELEPHONE_NUMBER_3 BT_PHONE3, 
PPF.LAST_NAME BUYER_LAST_NAME, 
PPF.FIRST_NAME BUYER_FIRST_NAME,
PPF.EMAIL_ADDRESS BUYER_EMAIL_ADDRESS , 
PPF.WORK_TELEPHONE BUYER_WORK_TELEPHONE , 
PA.TELEPHONE_NUMBER_1 BUYER_MISC_TELEPHONE1 , 
PA.TELEPHONE_NUMBER_2 BUYER_MISC_TELEPHONE2 ,                     
PA.TELEPHONE_NUMBER_3 BUYER_MISC_TELEPHONE3 , 
PH.PO_HEADER_ID PO_HEADER_ID,
FSP.INVENTORY_ORGANIZATION_ID FSP_INVENTORY_ORGANIZATION_ID  
FROM 
FND_CURRENCIES_VL FCC, 
PO_VENDORS VN,
PO_VENDOR_SITES_ALL PVS, 
PO_VENDOR_CONTACTS PVC,
PER_ADDRESSES PA,  
PER_PEOPLE_F PPF,
HR_EMPLOYEES HRA, 
HR_EMPLOYEES HRB, 
HR_LOCATIONS LC, 
HR_LOCATIONS LC2, 
AP_TERMS T, 
PO_RELEASES_ARCHIVE_ALL PRA, 
PO_RELEASES_ALL PR, 
PO_HEADERS_ALL PH, 
FINANCIALS_SYSTEM_PARAMS_ALL FSP
WHERE 
VN.VENDOR_ID = PH.VENDOR_ID 
AND PVS.VENDOR_SITE_ID = PH.VENDOR_SITE_ID 
AND PH.VENDOR_CONTACT_ID = PVC.VENDOR_CONTACT_ID (+) 
AND LC.LOCATION_ID = PH.SHIP_TO_LOCATION_ID 
AND LC2.LOCATION_ID = PH.BILL_TO_LOCATION_ID 
AND PPF.PERSON_ID = PR.AGENT_ID 
AND PA.PERSON_ID (+) = PPF.PERSON_ID 
AND PA.PRIMARY_FLAG (+) = 'Y' 
AND PA.DATE_FROM (+) <= TRUNC(SYSDATE) 
AND NVL(PA.DATE_TO (+),TRUNC(SYSDATE)) >= TRUNC(SYSDATE) 
AND PPF.EMPLOYEE_NUMBER IS NOT NULL 
AND TRUNC(SYSDATE) BETWEEN PPF.EFFECTIVE_START_DATE AND PPF.EFFECTIVE_END_DATE 
AND HRA.EMPLOYEE_ID (+) = LC.DESIGNATED_RECEIVER_ID 
AND HRB.EMPLOYEE_ID(+) = LC2.DESIGNATED_RECEIVER_ID
AND PH.TERMS_ID = T.TERM_ID (+) 
AND FCC.CURRENCY_CODE = PH.CURRENCY_CODE 
AND PH.PO_HEADER_ID = PR.PO_HEADER_ID 
AND PR.PO_RELEASE_ID = PRA.PO_RELEASE_ID 
AND PR.REVISION_NUM = PRA.REVISION_NUM 
AND PRA.LATEST_EXTERNAL_FLAG = 'Y' 
AND NVL(PR.PRINT_COUNT,0) = 0 
AND NVL(PR.APPROVED_FLAG,'N') = 'Y' 
AND NVL(PR.CANCEL_FLAG,'N') = 'N' 
AND NVL(PR.HOLD_FLAG,'N') = 'N' 
AND FSP.ORG_ID = PH.ORG_ID
AND PH.ORG_ID = PVS.ORG_ID
)                                                   
/
REM ==============================PO LINES======================================
REM ==============================PO LINES======================================
REM ==============================PO LINES======================================

CREATE OR REPLACE VIEW WM_POO_LINES_V
AS
SELECT 
POL.ORG_ID,
POL.LINE_NUM LINE_NUM , 
POL.QUANTITY QUANTITY , 
POL.UNIT_MEAS_LOOKUP_CODE UOM_CODE , 
POL.ITEM_ID ITEM_ID , 
POL.ITEM_REVISION ITEM_REVISION , 
POL.VENDOR_PRODUCT_NUM VENDOR_PRODUCT_NUMBER , 
POL.UNIT_PRICE UNIT_PRICE , 
POL.ITEM_DESCRIPTION ITEM_DESCRIPTION , 
PH2.SEGMENT1 PO_NUMBER , 
PH2.QUOTE_VENDOR_QUOTE_NUMBER VENDOR_QUOTE_NUMBER , 
POL.CANCEL_FLAG CANCEL_FLAG , 
POL.CANCEL_DATE CANCEL_DATE ,                     
POL.QUANTITY_COMMITTED QUANTITY_COMMITTED , 
POL.COMMITTED_AMOUNT COMMITTED_AMOUNT , 
POL.LIST_PRICE_PER_UNIT LIST_PRICE_PER_UNIT , 
POL.MARKET_PRICE MARKET_PRICE, 
POL.NOT_TO_EXCEED_PRICE NOT_TO_EXCEED_PRICE , 
POL.NEGOTIATED_BY_PREPARER_FLAG NEGOTIATED_BY_PREPARER_FLAG , 
POL.TAXABLE_FLAG TAXABLE_FLAG , 
POL.TRANSACTION_REASON_CODE TRANSACTION_REASON_CODE , 
PLT.ORDER_TYPE_LOOKUP_CODE LINE_TYPE , 
PHC.HAZARD_CLASS HAZARD_CLASS , 
PUN.UN_NUMBER UN_NUMBER , 
PUN.DESCRIPTION UN_DESCRIPTION , 
POL.NOTE_TO_VENDOR NOTE_TO_VENDOR , 
POL.ATTRIBUTE_CATEGORY POL_ATTRIBUTE_CATEGORY , 
POL.ATTRIBUTE1 POL_ATTRIBUTE1 , 
POL.ATTRIBUTE2 POL_ATTRIBUTE2 , 
POL.ATTRIBUTE3 POL_ATTRIBUTE3 , 
POL.ATTRIBUTE4 POL_ATTRIBUTE4 , 
POL.ATTRIBUTE5 POL_ATTRIBUTE5 , 
POL.ATTRIBUTE6 POL_ATTRIBUTE6 , 
POL.ATTRIBUTE7 POL_ATTRIBUTE7 , 
POL.ATTRIBUTE8 POL_ATTRIBUTE8 , 
POL.ATTRIBUTE9 POL_ATTRIBUTE9 , 
POL.ATTRIBUTE10 POL_ATTRIBUTE10 , 
POL.ATTRIBUTE11 POL_ATTRIBUTE11 , 
POL.ATTRIBUTE12 POL_ATTRIBUTE12 , 
POL.ATTRIBUTE13 POL_ATTRIBUTE13 , 
POL.ATTRIBUTE14 POL_ATTRIBUTE14 , 
POL.ATTRIBUTE15 POL_ATTRIBUTE15 , 
MTL.ORGANIZATION_ID MTL_ORGANIZATION_ID , 
MTL.ATTRIBUTE_CATEGORY LP_ATTRIBUTE_CATEGORY , 
MTL.ATTRIBUTE1 LP_ATTRIBUTE1 , 
MTL.ATTRIBUTE2 LP_ATTRIBUTE2 , 
MTL.ATTRIBUTE3 LP_ATTRIBUTE3 , 
MTL.ATTRIBUTE4 LP_ATTRIBUTE4 , 
MTL.ATTRIBUTE5 LP_ATTRIBUTE5 , 
MTL.ATTRIBUTE6 LP_ATTRIBUTE6 , 
MTL.ATTRIBUTE7 LP_ATTRIBUTE7 , 
MTL.ATTRIBUTE8 LP_ATTRIBUTE8 , 
MTL.ATTRIBUTE9 LP_ATTRIBUTE9 , 
MTL.ATTRIBUTE10 LP_ATTRIBUTE10 , 
MTL.ATTRIBUTE11 LP_ATTRIBUTE11,
MTL.ATTRIBUTE12 LP_ATTRIBUTE12 , 
MTL.ATTRIBUTE13 LP_ATTRIBUTE13 , 
MTL.ATTRIBUTE14 LP_ATTRIBUTE14 , 
MTL.ATTRIBUTE15 LP_ATTRIBUTE15 , 
MTL.SEGMENT1 LP_SEGMENT1 ,                    
MTL.SEGMENT2 LP_SEGMENT2 , 
MTL.SEGMENT3 LP_SEGMENT3 , 
MTL.SEGMENT4 LP_SEGMENT4, 
MTL.SEGMENT5 LP_SEGMENT5 , 
MTL.SEGMENT6 LP_SEGMENT6 , 
MTL.SEGMENT7 LP_SEGMENT7 , 
MTL.SEGMENT8 LP_SEGMENT8 , 
MTL.SEGMENT9 LP_SEGMENT9 , 
MTL.SEGMENT10 LP_SEGMENT10 , 
MTL.SEGMENT11 LP_SEGMENT11 , 
MTL.SEGMENT12 LP_SEGMENT12 , 
MTL.SEGMENT13 LP_SEGMENT13 , 
MTL.SEGMENT14 LP_SEGMENT14 , 
MTL.SEGMENT15 LP_SEGMENT15 , 
MTL.SEGMENT16 LP_SEGMENT16 , 
MTL.SEGMENT17 LP_SEGMENT17 , 
MTL.SEGMENT18 LP_SEGMENT18 , 
MTL.SEGMENT19 LP_SEGMENT19 , 
MTL.SEGMENT20 LP_SEGMENT20 , 
0 POR_RELEASE_ID , 
0 POR_RELEASE_NUM , 
TO_NUMBER(NULL) POR_SOURCE_LINE_NUM , 
PH2.PO_HEADER_ID PO_HEADER_ID , 
POL.PO_LINE_ID PO_LINE_ID , 
'NON-RELEASE' SHIPMENT_TYPE 
FROM 
MTL_ITEM_FLEXFIELDS MTL, 
PO_HAZARD_CLASSES PHC, 
PO_UN_NUMBERS PUN, 
PO_HEADERS_ALL PH2, 
PO_LINE_TYPES PLT, 
PO_LINES_ALL POL 
WHERE 
POL.LINE_TYPE_ID = PLT.LINE_TYPE_ID 
AND POL.PO_HEADER_ID = PH2.PO_HEADER_ID 
AND POL.HAZARD_CLASS_ID = PHC.HAZARD_CLASS_ID (+) 
AND POL.UN_NUMBER_ID = PUN.UN_NUMBER_ID (+) 
AND POL.ITEM_ID = MTL.ITEM_ID (+) 
AND NVL(POL.CANCEL_FLAG,'N') <> 'Y' 
AND PH2.ORG_ID = POL.ORG_ID
				UNION ALL
SELECT 
POL.ORG_ID,
POLL.SHIPMENT_NUM LINE_NUM, 
POLL.QUANTITY QUANTITY, 
POL.UNIT_MEAS_LOOKUP_CODE UOM_CODE, 
POL.ITEM_ID ITEM_ID, POL.ITEM_REVISION ITEM_REVISION,
POL.VENDOR_PRODUCT_NUM VENDOR_PRODUCT_NUMBER, 
POLL.PRICE_OVERRIDE UNIT_PRICE, 
POL.ITEM_DESCRIPTION ITEM_DESCRIPTION, 
PH2.SEGMENT1 PO_NUMBER, 
PH2.QUOTE_VENDOR_QUOTE_NUMBER VENDOR_QUOTE_NUMBER, 
POLL.CANCEL_FLAG CANCEL_FLAG, 
POLL.CANCEL_DATE CANCEL_DATE, 
TO_NUMBER(NULL) QUANTITY_COMMITTED, 
TO_NUMBER(NULL) COMMITTED_AMOUNT, 
POL.LIST_PRICE_PER_UNIT LIST_PRICE_PER_UNIT, 
POL.MARKET_PRICE MARKET_PRICE, 
POL.NOT_TO_EXCEED_PRICE NOT_TO_EXCEED_PRICE, 
POL.NEGOTIATED_BY_PREPARER_FLAG NEGOTIATED_BY_PREPARER_FLAG, 
POLL.TAXABLE_FLAG TAXABLE_FLAG, 
POL.TRANSACTION_REASON_CODE TRANSACTION_REASON_CODE,                     
PLT.ORDER_TYPE_LOOKUP_CODE LINE_TYPE, 
PHC.HAZARD_CLASS HAZARD_CLASS, 
PUN.UN_NUMBER UN_NUMBER, 
PUN.DESCRIPTION UN_DESCRIPTION, 
POL.NOTE_TO_VENDOR NOTE_TO_VENDOR,                    
POLL.ATTRIBUTE_CATEGORY POL_ATTRIBUTE_CATEGORY, 
POLL.ATTRIBUTE1 POL_ATTRIBUTE1,                    
POLL.ATTRIBUTE2 POL_ATTRIBUTE2, 
POLL.ATTRIBUTE3 POL_ATTRIBUTE3, 
POLL.ATTRIBUTE4 POL_ATTRIBUTE4, 
POLL.ATTRIBUTE5 POL_ATTRIBUTE5, 
POLL.ATTRIBUTE6 POL_ATTRIBUTE6,                    
POLL.ATTRIBUTE7 POL_ATTRIBUTE7, 
POLL.ATTRIBUTE8 POL_ATTRIBUTE8, 
POLL.ATTRIBUTE9 POL_ATTRIBUTE9, 
POLL.ATTRIBUTE10 POL_ATTRIBUTE10, 
POLL.ATTRIBUTE11 POL_ATTRIBUTE11, 
POLL.ATTRIBUTE12 POL_ATTRIBUTE12, 
POLL.ATTRIBUTE13 POL_ATTRIBUTE13, 
POLL.ATTRIBUTE14 POL_ATTRIBUTE14, 
POLL.ATTRIBUTE15 POL_ATTRIBUTE15, 
MTL.ORGANIZATION_ID MTL_ORGANIZATION_ID, 
MTL.ATTRIBUTE_CATEGORY LP_ATTRIBUTE_CATEGORY, 
MTL.ATTRIBUTE1 LP_ATTRIBUTE1, 
MTL.ATTRIBUTE2 LP_ATTRIBUTE2, 
MTL.ATTRIBUTE3 LP_ATTRIBUTE3, 
MTL.ATTRIBUTE4 LP_ATTRIBUTE4, 
MTL.ATTRIBUTE5 LP_ATTRIBUTE5, 
MTL.ATTRIBUTE6 LP_ATTRIBUTE6, 
MTL.ATTRIBUTE7 LP_ATTRIBUTE7, 
MTL.ATTRIBUTE8 LP_ATTRIBUTE8, 
MTL.ATTRIBUTE9 LP_ATTRIBUTE9, 
MTL.ATTRIBUTE10 LP_ATTRIBUTE10, 
MTL.ATTRIBUTE11 LP_ATTRIBUTE11,                   
MTL.ATTRIBUTE12 LP_ATTRIBUTE12, 
MTL.ATTRIBUTE13 LP_ATTRIBUTE13, 
MTL.ATTRIBUTE14 LP_ATTRIBUTE14, 
MTL.ATTRIBUTE15 LP_ATTRIBUTE15, 
MTL.SEGMENT1 LP_SEGMENT1, 
MTL.SEGMENT2 LP_SEGMENT2, 
MTL.SEGMENT3 LP_SEGMENT3, 
MTL.SEGMENT4 LP_SEGMENT4, 
MTL.SEGMENT5 LP_SEGMENT5, 
MTL.SEGMENT6 LP_SEGMENT6, 
MTL.SEGMENT7 LP_SEGMENT7, 
MTL.SEGMENT8 LP_SEGMENT8, 
MTL.SEGMENT9 LP_SEGMENT9, 
MTL.SEGMENT10 LP_SEGMENT10, 
MTL.SEGMENT11 LP_SEGMENT11, 
MTL.SEGMENT12 LP_SEGMENT12, 
MTL.SEGMENT13 LP_SEGMENT13, 
MTL.SEGMENT14 LP_SEGMENT14, 
MTL.SEGMENT15 LP_SEGMENT15, 
MTL.SEGMENT16 LP_SEGMENT16,                     
MTL.SEGMENT17 LP_SEGMENT17, 
MTL.SEGMENT18 LP_SEGMENT18, 
MTL.SEGMENT19 LP_SEGMENT19, 
MTL.SEGMENT20 LP_SEGMENT20, 
POR.PO_RELEASE_ID POR_RELEASE_ID, 
POR.RELEASE_NUM POR_RELEASE_NUM, 
POL.LINE_NUM POR_SOURCE_LINE_NUM, 
POR.PO_HEADER_ID PO_HEADER_ID, 
POL.PO_LINE_ID PO_LINE_ID, 
POLL.SHIPMENT_TYPE SHIPMENT_TYPE 
FROM 
MTL_ITEM_FLEXFIELDS MTL, 
PO_HAZARD_CLASSES PHC, 
PO_UN_NUMBERS PUN, 
PO_HEADERS_ALL PH2, 
PO_LINE_LOCATIONS_ALL POLL, 
PO_LINE_TYPES PLT, 
PO_LINES_ALL POL, 
PO_RELEASES_ALL POR 
WHERE 
POL.PO_LINE_ID = POLL.PO_LINE_ID 
AND POLL.PO_RELEASE_ID = POR.PO_RELEASE_ID 
AND POR.PO_HEADER_ID = PH2.PO_HEADER_ID 
AND POL.LINE_TYPE_ID = PLT.LINE_TYPE_ID 
AND POL.HAZARD_CLASS_ID = PHC.HAZARD_CLASS_ID (+) 
AND POL.UN_NUMBER_ID = PUN.UN_NUMBER_ID(+)                     
AND POL.ITEM_ID = MTL.ITEM_ID (+) 
AND NVL(POLL.CANCEL_FLAG,'N') <> 'Y'
AND PH2.ORG_ID = POL.ORG_ID
AND PH2.ORG_ID = POR.ORG_ID                              
AND POR.ORG_ID = POLL.ORG_ID
/
REM ==============================PO LINE SHIPMENTS======================================
REM ==============================PO LINE SHIPMENTS======================================
REM ==============================PO LINE SHIPMENTS======================================

CREATE OR REPLACE VIEW WM_POO_SHIPMENTS_V
AS
SELECT 
POLL.ORG_ID,
POLL.SHIPMENT_NUM SHIPMENT_NUMBER, 
POLL.QUANTITY QUANTITY_ORIGINAL, 
POL.UNIT_MEAS_LOOKUP_CODE UOM_CODE , 
POLL.NEED_BY_DATE SHIPMENT_NEED_BY_DATE , 
POLL.PROMISED_DATE SHIPMENT_PROMISED_DATE , 
POLL.LAST_ACCEPT_DATE SHIPMENT_LAST_ACCEPTABLE_DATE , 
POLL.QUANTITY_CANCELLED QUANTITY_CANCELLED , 
POLL.QUANTITY_RECEIVED QUANTITY_RECEIVED , 
POLL.PRICE_OVERRIDE PRICE_OVERRIDE , 
POLL.CANCEL_FLAG CANCELLED_FLAG , 
POLL.CANCEL_DATE CANCELLED_DATE , 
POLL.SHIP_VIA_LOOKUP_CODE SHIP_VIA , 
POLL.FOB_LOOKUP_CODE FOB_CODE , 
POLL.FREIGHT_TERMS_LOOKUP_CODE FREIGHT_TERMS, 
POLL.TAXABLE_FLAG TAXABLE_FLAG , 
POLL.ATTRIBUTE_CATEGORY SHIPMENT_ATTRIBUTE_CATEGORY , 
POLL.ATTRIBUTE1 SHIPMENT_ATTRIBUTE1 , 
POLL.ATTRIBUTE2 SHIPMENT_ATTRIBUTE2 , 
POLL.ATTRIBUTE3 SHIPMENT_ATTRIBUTE3 , 
POLL.ATTRIBUTE4 SHIPMENT_ATTRIBUTE4, 
POLL.ATTRIBUTE5 SHIPMENT_ATTRIBUTE5 , 
POLL.ATTRIBUTE6 SHIPMENT_ATTRIBUTE6 , 
POLL.ATTRIBUTE7 SHIPMENT_ATTRIBUTE7 , 
POLL.ATTRIBUTE8 SHIPMENT_ATTRIBUTE8 , 
POLL.ATTRIBUTE9 SHIPMENT_ATTRIBUTE9 , 
POLL.ATTRIBUTE10 SHIPMENT_ATTRIBUTE10 , 
POLL.ATTRIBUTE11 SHIPMENT_ATTRIBUTE11 , 
POLL.ATTRIBUTE12 SHIPMENT_ATTRIBUTE12 , 
POLL.ATTRIBUTE13 SHIPMENT_ATTRIBUTE13 , 
POLL.ATTRIBUTE14 SHIPMENT_ATTRIBUTE14 , 
POLL.ATTRIBUTE15 SHIPMENT_ATTRIBUTE15 , 
POLL.SHIP_TO_LOCATION_ID SHIP_TO_LOCATION_ID , 
HRL.LOCATION_CODE SHIP_TO_LOCATION_CODE , 
HRE.LAST_NAME SHIP_TO_CONTACT_LAST_NAME , 
HRE.FIRST_NAME SHIP_TO_CONTACT_FIRST_NAME , 
HRL.ADDRESS_LINE_1 SHIP_TO_ADDRESS_LINE_1 , 
HRL.ADDRESS_LINE_2 SHIP_TO_ADDRESS_LINE_2 , 
HRL.ADDRESS_LINE_3 SHIP_TO_ADDRESS_LINE_3 , 
HRL.TOWN_OR_CITY SHIP_TO_CITY , 
HRL.POSTAL_CODE SHIP_TO_POSTAL_CODE , 
HRL.COUNTRY SHIP_TO_COUNTRY , 
HRL.REGION_1 SHIP_TO_REGION_1 , 
HRL.REGION_2 SHIP_TO_REGION_2 , 
HRL.REGION_3 SHIP_TO_REGION_3 ,
HRL.TELEPHONE_NUMBER_1 SHIP_TO_PHONE1 , 
HRL.TELEPHONE_NUMBER_2 SHIP_TO_PHONE2 ,
HRL.TELEPHONE_NUMBER_3 SHIP_TO_PHONE3 , 
POLL.PO_HEADER_ID PO_HEADER_ID , 
POLL.PO_LINE_ID PO_LINE_ID , 
0 POR_RELEASE_ID , 
0 POR_RELEASE_NUM , 
POLL.LINE_LOCATION_ID LINE_LOCATION_ID 
FROM                     
PO_LINE_LOCATIONS_ALL POLL, 
HR_EMPLOYEES HRE, 
HR_LOCATIONS HRL, 
PO_LINES_ALL POL 
WHERE 
POLL.SHIP_TO_LOCATION_ID = HRL.LOCATION_ID (+) 
AND HRE.EMPLOYEE_ID (+) = HRL.DESIGNATED_RECEIVER_ID 
AND POLL.PO_RELEASE_ID IS NULL 
AND POL.PO_LINE_ID = POLL.PO_LINE_ID 
AND NVL(POLL.CANCEL_FLAG,'N') <> 'Y' 
	UNION ALL 
SELECT 
POLL.ORG_ID,
POLL.SHIPMENT_NUM SHIPMENT_NUMBER, 
POLL.QUANTITY QUANTITY_ORIGINAL, 
POL.UNIT_MEAS_LOOKUP_CODE UOM_CODE, 
POLL.NEED_BY_DATE SHIPMENT_NEED_BY_DATE, 
POLL.PROMISED_DATE SHIPMENT_PROMISED_DATE, 
POLL.LAST_ACCEPT_DATE SHIPMENT_LAST_ACCEPTABLE_DATE, 
POLL.QUANTITY_CANCELLED QUANTITY_CANCELLED, 
POLL.QUANTITY_RECEIVED QUANTITY_RECEIVED, 
POLL.PRICE_OVERRIDE PRICE_OVERRIDE, 
POLL.CANCEL_FLAG CANCELLED_FLAG, 
POLL.CANCEL_DATE CANCELLED_DATE, 
POLL.SHIP_VIA_LOOKUP_CODE SHIP_VIA, 
POLL.FOB_LOOKUP_CODE FOB_CODE, 
POLL.FREIGHT_TERMS_LOOKUP_CODE FREIGHT_TERMS, 
POLL.TAXABLE_FLAG TAXABLE_FLAG, 
POLL.ATTRIBUTE_CATEGORY SHIPMENT_ATTRIBUTE_CATEGORY, 
POLL.ATTRIBUTE1 SHIPMENT_ATTRIBUTE1, 
POLL.ATTRIBUTE2 SHIPMENT_ATTRIBUTE2, 
POLL.ATTRIBUTE3 SHIPMENT_ATTRIBUTE3, 
POLL.ATTRIBUTE4 SHIPMENT_ATTRIBUTE4, 
POLL.ATTRIBUTE5 SHIPMENT_ATTRIBUTE5, 
POLL.ATTRIBUTE6 SHIPMENT_ATTRIBUTE6, 
POLL.ATTRIBUTE7 SHIPMENT_ATTRIBUTE7, 
POLL.ATTRIBUTE8 SHIPMENT_ATTRIBUTE8, 
POLL.ATTRIBUTE9 SHIPMENT_ATTRIBUTE9, 
POLL.ATTRIBUTE10 SHIPMENT_ATTRIBUTE10, 
POLL.ATTRIBUTE11 SHIPMENT_ATTRIBUTE11, 
POLL.ATTRIBUTE12 SHIPMENT_ATTRIBUTE12, 
POLL.ATTRIBUTE13 SHIPMENT_ATTRIBUTE13, 
POLL.ATTRIBUTE14 SHIPMENT_ATTRIBUTE14, 
POLL.ATTRIBUTE15 SHIPMENT_ATTRIBUTE15, 
POLL.SHIP_TO_LOCATION_ID SHIP_TO_LOCATION_ID, 
HRL.LOCATION_CODE SHIP_TO_LOCATION_CODE, 
HRE.LAST_NAME SHIP_TO_CONTACT_LAST_NAME, 
HRE.FIRST_NAME SHIP_TO_CONTACT_FIRST_NAME, 
HRL.ADDRESS_LINE_1 SHIP_TO_ADDRESS_LINE_1, 
HRL.ADDRESS_LINE_2 SHIP_TO_ADDRESS_LINE_2, 
HRL.ADDRESS_LINE_3 SHIP_TO_ADDRESS_LINE_3, 
HRL.TOWN_OR_CITY SHIP_TO_CITY, 
HRL.POSTAL_CODE SHIP_TO_POSTAL_CODE, 
HRL.COUNTRY SHIP_TO_COUNTRY, 
HRL.REGION_1 SHIP_TO_REGION_1, 
HRL.REGION_2 SHIP_TO_REGION_2, 
HRL.REGION_3 SHIP_TO_REGION_3, 
HRL.TELEPHONE_NUMBER_1 SHIP_TO_PHONE1, 
HRL.TELEPHONE_NUMBER_2 SHIP_TO_PHONE2, 
HRL.TELEPHONE_NUMBER_3 SHIP_TO_PHONE3, 
POLL.PO_HEADER_ID PO_HEADER_ID, 
POLL.PO_LINE_ID PO_LINE_ID, 
POR.PO_RELEASE_ID POR_RELEASE_ID, 
POR.RELEASE_NUM POR_RELEASE_NUM, 
POLL.LINE_LOCATION_ID LINE_LOCATION_ID 
FROM 
PO_LINE_LOCATIONS_ALL POLL, 
PO_RELEASES_ALL POR, 
HR_EMPLOYEES HRE, 
HR_LOCATIONS HRL, 
PO_LINES_ALL POL 
WHERE 
POLL.SHIP_TO_LOCATION_ID = HRL.LOCATION_ID (+) 
AND HRE.EMPLOYEE_ID (+) = HRL.DESIGNATED_RECEIVER_ID 
AND POLL.PO_RELEASE_ID = POR.PO_RELEASE_ID 
AND POL.PO_LINE_ID = POLL.PO_LINE_ID 
AND NVL(POLL.CANCEL_FLAG,'N') <> 'Y'  
/
