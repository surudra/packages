REM ======================== Release 11 ======================
REM ========================Invoice header ===================
REM ==========================================================

CREATE OR REPLACE VIEW WM_INO_HEADER_V
AS
SELECT
RCT1.ORG_ID,
RCTT.TYPE Document_Type, 
RCTT.NAME Invoice_Name,
RCT1.TRX_NUMBER DOCUMENT_NUMBER, 
SYSDATE Transaction_Date,
RA1.ORIG_SYSTEM_REFERENCE Bill_To_Customer_Code_Int, 
RC1.CUSTOMER_NAME Bill_To_Customer_Name, 
RA1.ADDRESS1 Bill_To_Address1, 
RA1.ADDRESS2 Bill_To_Address2, 
RA1.ADDRESS3 Bill_To_Address3, 
RA1.ADDRESS4 Bill_To_Address4, 
RA1.CITY Bill_To_City, 
RA1.POSTAL_CODE Bill_To_Postal_Code, 
RA1.COUNTRY Bill_To_Country, 
RA1.STATE Bill_To_State, 
RA1.PROVINCE Bill_To_Province, 
RA1.COUNTY Bill_To_County, 
RC1.SIC_CODE Bill_To_Customer_SIC_Code,
RC1.SALES_CHANNEL_CODE Bill_To_Customer_Sales_Channel, 
RCO1.LAST_NAME Bill_To_Contact_Last_Name, 
RCO1.FIRST_NAME Bill_To_Contact_First_Name, 
RCO1.JOB_TITLE Bill_To_Contact_Job_Title, 
RC1.ATTRIBUTE_CATEGORY Bill_To_Customer_Att_Category,
RC1.ATTRIBUTE1 Bill_To_Customer_Attribute1,
RC1.ATTRIBUTE2 Bill_To_Customer_Attribute2, 
RC1.ATTRIBUTE3 Bill_To_Customer_Attribute3, 
RC1.ATTRIBUTE4 Bill_To_Customer_Attribute4, 
RC1.ATTRIBUTE5 Bill_To_Customer_Attribute5, 
RC1.ATTRIBUTE6 Bill_To_Customer_Attribute6, 
RC1.ATTRIBUTE7 Bill_To_Customer_Attribute7, 
RC1.ATTRIBUTE8 Bill_To_Customer_Attribute8, 
RC1.ATTRIBUTE9 Bill_To_Customer_Attribute9, 
RC1.ATTRIBUTE10 Bill_To_Customer_Attribute10, 
RC1.ATTRIBUTE11 Bill_To_Customer_Attribute11, 
RC1.ATTRIBUTE12 Bill_To_Customer_Attribute12, 
RC1.ATTRIBUTE13 Bill_To_Customer_Attribute13,
RC1.ATTRIBUTE14 Bill_To_Customer_Attribute14, 
RC1.ATTRIBUTE15 Bill_To_Customer_Attribute15, 
RSU1.SITE_USE_CODE Site_Use_Code, 
RSU1.ATTRIBUTE_CATEGORY Bill_To_Site_Att_Category, 
RSU1.ATTRIBUTE1 Bill_To_Site_Attribute1, 
RSU1.ATTRIBUTE2 Bill_To_Site_Attribute2, 
RSU1.ATTRIBUTE3 Bill_To_Site_Attribute3, 
RSU1.ATTRIBUTE4 Bill_To_Site_Attribute4, 
RSU1.ATTRIBUTE5 Bill_To_Site_Attribute5, 
RSU1.ATTRIBUTE6 Bill_To_Site_Attribute6, 
RSU1.ATTRIBUTE7 Bill_To_Site_Attribute7, 
RSU1.ATTRIBUTE8 Bill_To_Site_Attribute8, 
RSU1.ATTRIBUTE9 Bill_To_Site_Attribute9, 
RSU1.ATTRIBUTE10 Bill_To_Site_Attribute10, 
RSU1.ATTRIBUTE11 Bill_To_Site_Attribute11, 
RSU1.ATTRIBUTE12 Bill_To_Site_Attribute12,
RSU1.ATTRIBUTE13 Bill_To_Site_Attribute13, 
RSU1.ATTRIBUTE14 Bill_To_Site_Attribute14, 
RSU1.ATTRIBUTE15 Bill_To_Site_Attribute15, 
RA2.ORIG_SYSTEM_REFERENCE Ship_To_Customer_Code_Int, 
RC2.CUSTOMER_NAME Ship_To_Customer_Name, 
RA2.ADDRESS1 Ship_To_Address1, 
RA2.ADDRESS2 Ship_To_Address2, 
RA2.ADDRESS3 Ship_To_Address3, 
RA2.ADDRESS4 Ship_To_Address4, 
RA2.CITY Ship_To_City, 
RA2.POSTAL_CODE Ship_To_Postal_Code, 
RA2.COUNTRY Ship_To_Country, 
RA2.STATE Ship_To_State, 
RA2.PROVINCE Ship_To_Province, 
RA2.COUNTY Ship_To_County, 
RC2.SIC_CODE Ship_To_Customer_Sic_Code, 
RC2.SALES_CHANNEL_CODE Ship_To_Customer_Sales_Channel, 
RCO2.LAST_NAME Ship_To_Contact_Last_Name, 
RCO2.FIRST_NAME Ship_To_Contact_First_Name, 
RCO2.JOB_TITLE Ship_To_Contact_Job_Title, 
RA3.ORIG_SYSTEM_REFERENCE Sold_To_Customer_Code_Int, 
RC3.CUSTOMER_NAME Sold_To_Customer_Name, 
RA3.ADDRESS1 Sold_To_Address1, 
RA3.ADDRESS2 Sold_To_Address2, 
RA3.ADDRESS3 Sold_To_Address3, 
RA3.ADDRESS4 Sold_To_Address4, 
RA3.CITY Sold_To_City, 
RA3.POSTAL_CODE Sold_To_Postal_Code, 
RA3.COUNTRY Sold_To_Country, 
RA3.STATE Sold_To_State, 
RA3.PROVINCE Sold_To_Province, 
RA3.COUNTY Sold_To_County, 
RC3.SIC_CODE Sold_To_Customer_Sic_Code, 
RC3.SALES_CHANNEL_CODE Sold_To_Customer_Sales_Channel, 
RCO3.LAST_NAME Sold_To_Contact_Last_Name, 
RCO3.FIRST_NAME Sold_To_Contact_First_Name, 
RCO3.JOB_TITLE Sold_To_Contact_Job_Title, 
RCT1.TRX_NUMBER TRANSACTION_NUMBER, 
RCT2.TRX_NUMBER Credited_Invoice_Number, 
RCT4.TRX_NUMBER Reference_Invoice_Number, 
RCT3.TRX_NUMBER Parent_Invoice_Number, 
RCT1.SHIP_DATE_ACTUAL Shipment_Date, 
RCT1.PURCHASE_ORDER Purchase_Order_Number, 
RCT1.CREATION_DATE Creation_Date, 
RCT1.PURCHASE_ORDER_REVISION Purchase_Order_Revision_Number, 
RCT1.START_DATE_COMMITMENT Commitment_Start_Date, 
RCT1.PURCHASE_ORDER_DATE Purchase_Order_Date, 
RCT1.END_DATE_COMMITMENT Commitment_End_Date, 
RCT1.TRX_DATE INV_TRANSACTION_DATE, 
RCT1.LAST_UPDATE_DATE Last_Update_Date, 
DECODE(RCTT.ACCOUNTING_AFFECT_FLAG, 'Y',APS.DUE_DATE, DECODE (RTL.DUE_DAYS, NULL, NVL(RTL.DUE_DATE, 
DECODE(LEAST(TO_NUMBER(TO_CHAR(RCT1.TRX_DATE,'DD')), NVL(RT.DUE_CUTOFF_DAY,32)), 
RT.DUE_CUTOFF_DAY, LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE, RTL.DUE_MONTHS_FORWARD)) + 
LEAST(RTL.DUE_DAY_OF_MONTH, TO_NUMBER(TO_CHAR(LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE, 
RTL.DUE_MONTHS_FORWARD + 1)), 'DD'))), LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE,
(RTL.DUE_MONTHS_FORWARD - 1))) + LEAST(RTL.DUE_DAY_OF_MONTH,TO_NUMBER(TO_CHAR(LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE, RTL.DUE_MONTHS_FORWARD)), 'DD'))))), 
RCT1.TRX_DATE + RTL.DUE_DAYS)) Due_Date, 
RCT1.REASON_CODE Credit_Memo_Reason, 
RT.PRINTING_LEAD_DAYS Transmission_Lead_Days, 
ABS.NAME Transaction_Source, 
NVL(RTL.SEQUENCE_NUM,1) Installment_Number, 
RCT1.WAYBILL_NUMBER Shipment_Waybill_Number, 
RCT1.SHIP_VIA Ship_Via, 
RCT1.FOB_POINT Shipment_FOB_Point, 
RCT1.INVOICE_CURRENCY_CODE Currency_Code, 
NVL(RCT1.EXCHANGE_RATE,1) Currency_Exchange_Rate, 
GLB.CURRENCY_CODE Base_Currency_Code, 
RT.NAME Payment_Term_Name, 
DECODE(RS.SALESREP_ID,-3,NULL,-2,NULL,-1,NULL,RS.NAME) Primary_Salesrep_Name, 
RCT1.INTERNAL_NOTES Comments,
RA1.ADDRESS_ID Bill_To_Address_Id, 
RSU1.LOCATION Bill_To_CUSTOMER_Location, 
RC1.CUSTOMER_NUMBER Bill_To_Customer_Number, 
RA2.ADDRESS_ID Ship_To_Address_Id, 
RSU2.LOCATION Ship_To_CUSTOMER_Location, 
RC2.CUSTOMER_NUMBER Ship_To_Customer_Number, 
RA3.ADDRESS_ID Sold_To_Address_Id, 
RSU3.LOCATION Sold_To_CUSTOMER_Location, 
RC3.CUSTOMER_NUMBER Sold_To_Customer_Number, 
RCT1.CUSTOMER_TRX_ID Transaction_ID, 
RT.TERM_ID Payment_Term_ID, 
RCT1.BILL_TO_CUSTOMER_ID Bill_To_Customer_Id, 
RCT1.BILL_TO_SITE_USE_ID Bill_To_Site_Use_Id, 
RCT1.SHIP_TO_CUSTOMER_ID Ship_To_Customer_Id, 
RCT1.SHIP_TO_SITE_USE_ID Ship_To_Site_Use_Id, 
RCT1.SOLD_TO_CUSTOMER_ID Sold_To_Customer_Id, 
RCT1.SOLD_TO_SITE_USE_ID Sold_To_Site_Use_Id, 
RT.DUE_CUTOFF_DAY Term_Due_Cutoff_Day, 
RTL.DUE_DATE Term_Due_Date,
RTL.DUE_DAYS Term_Due_Days, 
RTL.DUE_DAY_OF_MONTH Term_Due_Day_of_Month, 
RTL.DUE_MONTHS_FORWARD Term_Due_Months_Forward, 
(NVL(RTL.RELATIVE_AMOUNT,0)/NVL(RT.BASE_AMOUNT,1)) * 100 Term_Due_Percent
FROM 
RA_CUSTOMERS RC1,
RA_CUSTOMERS RC2, 
RA_CUSTOMERS RC3, 
RA_CONTACTS RCO1, 
RA_CONTACTS RCO2, 
RA_CONTACTS RCO3, 
RA_ADDRESSES_ALL RA1, 
RA_ADDRESSES_ALL RA2, 
RA_ADDRESSES_ALL RA3, 
RA_SITE_USES_ALL RSU1, 
RA_SITE_USES_ALL RSU2,
RA_SITE_USES_ALL RSU3, 
AR_SYSTEM_PARAMETERS_ALL ASP, 
GL_SETS_OF_BOOKS GLB, 
RA_CUST_TRX_TYPES_ALL RCTT, 
RA_SALESREPS_ALL RS, 
RA_TERMS RT, RA_TERMS_LINES RTL, 
AR_PAYMENT_SCHEDULES_ALL APS, 
AR_BATCH_SOURCES_ALL ABS, 
RA_CUSTOMER_TRX_ALL RCT4, RA_CUSTOMER_TRX_ALL RCT3, 
RA_CUSTOMER_TRX_ALL RCT2, RA_CUSTOMER_TRX_ALL RCT1 
WHERE 
RCT1.COMPLETE_FLAG = 'Y' 
AND RCT1.PRINTING_PENDING = 'Y' 
AND RCT1.PRINTING_OPTION = 'PRI' 
AND RCTT.TYPE = 'INV' 
AND RCT1.BILL_TO_CUSTOMER_ID = RC1.CUSTOMER_ID
AND RCT1.BILL_TO_CONTACT_ID = RCO1.CONTACT_ID (+) 
AND RCT1.BILL_TO_SITE_USE_ID = RSU1.SITE_USE_ID 
AND RSU1.ADDRESS_ID = RA1.ADDRESS_ID 
AND RCT1.SHIP_TO_CUSTOMER_ID = RC2.CUSTOMER_ID (+) 
AND RCT1.SHIP_TO_CONTACT_ID = RCO2.CONTACT_ID (+) 
AND RCT1.SHIP_TO_SITE_USE_ID = RSU2.SITE_USE_ID (+) 
AND RSU2.ADDRESS_ID = RA2.ADDRESS_ID (+) 
AND RCT1.SOLD_TO_CUSTOMER_ID = RC3.CUSTOMER_ID (+) 
AND RCT1.SOLD_TO_CONTACT_ID = RCO3.CONTACT_ID (+) 
AND RCT1.SOLD_TO_SITE_USE_ID = RSU3.SITE_USE_ID (+) 
AND RSU3.ADDRESS_ID = RA3.ADDRESS_ID (+) 
AND ASP.SET_OF_BOOKS_ID = GLB.SET_OF_BOOKS_ID 
AND RCT1.CUST_TRX_TYPE_ID = RCTT.CUST_TRX_TYPE_ID 
AND RCT1.PRIMARY_SALESREP_ID = RS.SALESREP_ID (+) 
AND RCT1.PREVIOUS_CUSTOMER_TRX_ID = RCT2.CUSTOMER_TRX_ID (+) 
AND RCT1.INITIAL_CUSTOMER_TRX_ID = RCT3.CUSTOMER_TRX_ID (+) 
AND RCT1.RELATED_CUSTOMER_TRX_ID = RCT4.CUSTOMER_TRX_ID (+) 
AND RCT1.TERM_ID = RT.TERM_ID (+) 
AND RT.TERM_ID = RTL.TERM_ID (+) 
AND RCT1.BATCH_SOURCE_ID = ABS.BATCH_SOURCE_ID (+) 
AND NVL(RCT1.LAST_PRINTED_SEQUENCE_NUM,0) < NVL(RTL.SEQUENCE_NUM,1) 
AND RCT1.CUSTOMER_TRX_ID = APS.CUSTOMER_TRX_ID (+) 
AND NVL(APS.TERMS_SEQUENCE_NUMBER, NVL(RTL.SEQUENCE_NUM,0)) = NVL(RTL.SEQUENCE_NUM, 
							NVL(APS.TERMS_SEQUENCE_NUMBER,0)) 
AND NVL(DECODE(RCTT.ACCOUNTING_AFFECT_FLAG, 'Y', APS.DUE_DATE, DECODE(RTL.DUE_DAYS, NULL,
NVL(RTL.DUE_DATE, DECODE(LEAST(TO_NUMBER(TO_CHAR(RCT1.TRX_DATE,'DD ')),
NVL(RT.DUE_CUTOFF_DAY,32)), RT.DUE_CUTOFF_DAY, LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE, 
RTL.DUE_MONTHS_FORWARD)) + LEAST(RTL.DUE_DAY_OF_MONTH, 
TO_NUMBER(TO_CHAR(LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE, RTL.DUE_MONTHS_FORWARD + 1)), 'DD'))),                     
LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE,(RTL.DUE_MONTHS_FORWARD- 1))) 
+ LEAST(RTL.DUE_DAY_OF_MONTH, TO_NUMBER(TO_CHAR(LAST_DAY(ADD_MONTHS(RCT1.TRX_DATE, 
RTL.DUE_MONTHS_FORWARD)), 'DD'))))), RCT1.TRX_DATE + RTL.DUE_DAYS)) ,SYSDATE)
 - NVL(RT.PRINTING_LEAD_DAYS,356) <= SYSDATE      
AND RCT1.ORG_ID = ASP.ORG_ID     
AND RCT1.ORG_ID = RCTT.ORG_ID
AND RCT1.ORG_ID = RS.ORG_ID                                                             
/
REM =============================Invoice Lines ===============
REM ==========================================================

CREATE OR REPLACE VIEW WM_INO_LINE_V
AS
SELECT 
RCT.ORG_ID,
RCT.CUSTOMER_TRX_ID Transaction_ID, RCTL1.LINE_NUMBER Line_Number, 
RCTL1.SALES_ORDER Sales_Order_Number, 
RCTL1.SALES_ORDER_REVISION Sales_Order_Revision_Number, 
RCTL1.SALES_ORDER_LINE Sales_Order_Line_Number, 
RCTL1.SALES_ORDER_DATE Sales_Order_Date, 
RCTL1.SALES_ORDER_SOURCE Sales_Channel, 
RCTL1.INVENTORY_ITEM_ID Item_ID, 
MCI.CUSTOMER_ITEM_NUMBER Customer_Item_Number, 
MCI.CUSTOMER_ITEM_DESC Customer_Item_Desc,                     
RCTL1.DESCRIPTION Item_Description, RCTL1.UOM_CODE UOM_Code, 
NVL(RCTL1.QUANTITY_ORDERED, RCTL1.QUANTITY_INVOICED) Ordered_Quantity, 
NVL(RCTL1.QUANTITY_INVOICED,RCTL1.QUANTITY_CREDITED) Quantity, 
RCTL1.UNIT_STANDARD_PRICE Unit_Standard_Price, 
RCTL1.UNIT_SELLING_PRICE Unit_Selling_Price, 
NVL(RCTL1.EXTENDED_AMOUNT,0) Line_Amount, RCTL1.REASON_CODE Credit_Memo_Reason, 
RCTL2.LINE_NUMBER Credited_Line_Number, 
SOL.S4 Ship_Order_Status_Int, 
RDL.REQUIREMENT_EXT Transaction_Reference_Key,
RCTL1.INTERFACE_LINE_CONTEXT Interface_Line_Category, 
RCTL1.INTERFACE_LINE_ATTRIBUTE1 Interface_Line_Attribute1, 
RCTL1.INTERFACE_LINE_ATTRIBUTE2 Interface_Line_Attribute2, 
RCTL1.INTERFACE_LINE_ATTRIBUTE3 Interface_Line_Attribute3, 
RCTL1.INTERFACE_LINE_ATTRIBUTE4 Interface_Line_Attribute4, 
RCTL1.INTERFACE_LINE_ATTRIBUTE5 Interface_Line_Attribute5, 
RCTL1.INTERFACE_LINE_ATTRIBUTE6 Interface_Line_Attribute6, 
RCTL1.INTERFACE_LINE_ATTRIBUTE7 Interface_Line_Attribute7, 
RCTL1.INTERFACE_LINE_ATTRIBUTE8 Interface_Line_Attribute8, 
RCTL1.INTERFACE_LINE_ATTRIBUTE9 Interface_Line_Attribute9, 
RCTL1.INTERFACE_LINE_ATTRIBUTE10 Interface_Line_Attribute10, 
RCTL1.INTERFACE_LINE_ATTRIBUTE11 Interface_Line_Attribute11, 
RCTL1.INTERFACE_LINE_ATTRIBUTE12 Interface_Line_Attribute12, 
RCTL1.INTERFACE_LINE_ATTRIBUTE13 Interface_Line_Attribute13, 
RCTL1.INTERFACE_LINE_ATTRIBUTE14 Interface_Line_Attribute14, 
RCTL1.INTERFACE_LINE_ATTRIBUTE15 Interface_Line_Attribute15, 
RCTL1.ATTRIBUTE_CATEGORY Line_Attribute_Category, 
RCTL1.ATTRIBUTE1 Line_Attribute1, RCTL1.ATTRIBUTE2 Line_Attribute2, 
RCTL1.ATTRIBUTE3 Line_Attribute3, RCTL1.ATTRIBUTE4 Line_Attribute4, 
RCTL1.ATTRIBUTE5 Line_Attribute5, RCTL1.ATTRIBUTE6 Line_Attribute6, 
RCTL1.ATTRIBUTE7 Line_Attribute7, RCTL1.ATTRIBUTE8 Line_Attribute8,                     
RCTL1.ATTRIBUTE9 Line_Attribute9, RCTL1.ATTRIBUTE10 Line_Attribute10, 
RCTL1.ATTRIBUTE11 Line_Attribute11, RCTL1.ATTRIBUTE12 Line_Attribute12, 
RCTL1.ATTRIBUTE13 Line_Attribute13, RCTL1.ATTRIBUTE14 Line_Attribute14, 
RCTL1.ATTRIBUTE15 Line_Attribute15 
FROM 
SO_PICKING_LINES_ALL SPL, 
MTL_CUSTOMER_ITEMS MCI, 
SO_LINES_ALL SOL, 
RLA_DEMAND_LINES_ALL RDL, 
RA_CUSTOMER_TRX_ALL RCT, 
RA_CUSTOMER_TRX_LINES_ALL RCTL2, 
RA_CUSTOMER_TRX_LINES_ALL RCTL1 
WHERE 
RCTL1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID                    
AND RCTL1.PREVIOUS_CUSTOMER_TRX_LINE_ID = RCTL2.CUSTOMER_TRX_LINE_ID(+) 
AND RCTL1.LINE_TYPE != 'FREIGHT' 
AND RCTL1.LINE_TYPE != 'TAX' 
AND RCTL1.INTERFACE_LINE_ATTRIBUTE7 = TO_CHAR(SPL.PICKING_LINE_ID(+)) 
AND SPL.CUSTOMER_ITEM_ID = MCI.CUSTOMER_ITEM_ID(+) 
AND SPL.ORDER_LINE_ID = SOL.LINE_ID(+) 
AND SOL.DEMAND_STREAM_ID = RDL.DEMAND_LINE_ID(+)                                                                                                                                                                      
/
REM =============================Invoice tax Lines ===============
REM ==============================================================

CREATE OR REPLACE VIEW WM_INO_LINE_TAX_V
AS
SELECT
RCT.ORG_ID,
RCT.CUSTOMER_TRX_ID Transaction_ID, 
RCTL1.LINE_NUMBER Line_Number,
RCTL2.CUSTOMER_TRX_LINE_ID Customer_Trx_Line_Id,
RCTL2.LINE_NUMBER Tax_Line_Number,
RCTL2.LINE_TYPE Line_Type,
RCTL2.EXTENDED_AMOUNT Tax_Amount, 
RCTL2.TAX_RATE Tax_Rate,
RCTL2.TAX_PRECEDENCE Tax_Precedence, 
AVT.TAX_CODE Tax_Code,
RCTL2.LINK_TO_CUST_TRX_LINE_ID Link_To_Cust_Trx_Line_Id,
RCTL2.ATTRIBUTE_CATEGORY Tax_Attribute_Category, 
RCTL2.ATTRIBUTE1 Tax_Attribute1,
RCTL2.ATTRIBUTE2 Tax_Attribute2, 
RCTL2.ATTRIBUTE3 Tax_Attribute3,
RCTL2.ATTRIBUTE4 Tax_Attribute4, 
RCTL2.ATTRIBUTE5 Tax_Attribute5,
RCTL2.ATTRIBUTE6 Tax_Attribute6, 
RCTL2.ATTRIBUTE7 Tax_Attribute7,
RCTL2.ATTRIBUTE8 Tax_Attribute8, 
RCTL2.ATTRIBUTE9 Tax_Attribute9,
RCTL2.ATTRIBUTE10 Tax_Attribute10, 
RCTL2.ATTRIBUTE11 Tax_Attribute11,
RCTL2.ATTRIBUTE12 Tax_Attribute12, 
RCTL2.ATTRIBUTE13 Tax_Attribute13,
RCTL2.ATTRIBUTE14 Tax_Attribute14, 
RCTL2.ATTRIBUTE15 Tax_Attribute15,
RCTL2.TAX_EXEMPT_FLAG Tax_Exempt_Flag, 
RCTL2.TAX_EXEMPT_NUMBER Tax_Exempt_Number, 
RCTL2.TAX_EXEMPT_REASON_CODE Tax_Exempt_Reason_Code, 
AVT.TAX_TYPE Tax_Type, 
AVT.DESCRIPTION Description, 
AVT.LOCATION Location, 
AVT.TAX_CLASSIFICATION Tax_Classification, 
AVT.VAT_TRANSACTION_TYPE Vat_Transaction_Type, 
AVT.ATTRIBUTE_CATEGORY Vat_Tax_Attribute_Category, 
AVT.ATTRIBUTE1 Vat_Tax_Attribute1, 
AVT.ATTRIBUTE2 Vat_Tax_Attribute2, 
AVT.ATTRIBUTE3 Vat_Tax_Attribute3, 
AVT.ATTRIBUTE4 Vat_Tax_Attribute4, 
AVT.ATTRIBUTE5 Vat_Tax_Attribute5, 
AVT.ATTRIBUTE6 Vat_Tax_Attribute6, 
AVT.ATTRIBUTE7 Vat_Tax_Attribute7, 
AVT.ATTRIBUTE8 Vat_Tax_Attribute8, 
AVT.ATTRIBUTE9 Vat_Tax_Attribute9, 
AVT.ATTRIBUTE10 Vat_Tax_Attribute10, 
AVT.ATTRIBUTE11 Vat_Tax_Attribute11, 
AVT.ATTRIBUTE12 Vat_Tax_Attribute12, 
AVT.ATTRIBUTE13 Vat_Tax_Attribute13, 
AVT.ATTRIBUTE14 Vat_Tax_Attribute14, 
AVT.ATTRIBUTE15 Vat_Tax_Attribute15 
FROM
RA_CUSTOMER_TRX_LINES_ALL RCTL1,
RA_CUSTOMER_TRX_ALL RCT,
RA_CUSTOMER_TRX_LINES_ALL RCTL2,
AR_VAT_TAX AVT
WHERE
RCTL1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID
AND RCTL1.CUSTOMER_TRX_LINE_ID = RCTL2.LINK_TO_CUST_TRX_LINE_ID
AND RCTL2.VAT_TAX_ID = AVT.VAT_TAX_ID (+)
AND RCTL1.LINE_TYPE != 'TAX'
AND RCTL2.LINE_TYPE IN ('CHARGE', 'FREIGHT','TAX');