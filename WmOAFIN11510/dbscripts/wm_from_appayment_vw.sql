/*  ***************************************************************************
    *	 $Date:	  24 Sep 2002 10:56:36	$
    *	 $Revision:   1.0  $
    *	 $Author:   TCS	 $
    *	 Copyright (c) 2002, webMethods	Inc. All Rights	Reserved
    *
    ***************************************************************************	
    ***************************************************************************
    * Application:	    webMethods
    * Process Name:	    Create Custom Views	for Ap Invoice outbound	in Application Schema  
    * Program Name:	    wm_from_appayment_vw.sql
    * Version #:	    1.0
    * Title:		    View Installation Script for webMethods Oracle Apps	Adapter	3.0
    * Utility:		    SQL*Plus
    * Created by:	    
    * Creation	 Date:	    
    *
    * Description:		
    *
    *		Create Views in	APPS schema for	AP Payments Outbound
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
    *		Param1:	&SpoolFile     
    *		Param2:	&Apps User Password
    *	       
    *	
    *
    * Menu Responsibilities and	path: 
    *
    *
    * Technical	Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date	 | Name			 | Remarks
    *==========================================================================
     24-SEP-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback	on
  set verify		off
  set newpage	0
  set pause		off
  set termout	on

 prompt	Program	: wm_from_appayments_vw.sql

  
connect	&&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."


/*----------------------------------------------------------------------*/
--	Create View WM_AP_CHECKS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AP_CHECKS_VW 
(
	WEB_TRANSACTION_ID, 
	DOCUMENT_TYPE,
	DOCUMENT_STATUS,
	CHECK_ID,
	ORGANIZATION_NAME,
	CHECK_NUMBER,
	CURRENCY_CODE ,
	AMOUNT ,
	CHECK_DATE ,
	BATCH_NAME ,
	CHECK_VOUCHER_NUM ,
	CHECK_STATUS ,	
	CLEARED_AMOUNT ,
	CLEARED_BASE_AMOUNT ,
	CLEARED_DATE ,
	CLEARED_EXCHANGE_DATE ,
	CLEARED_EXCHANGE_RATE ,
	CLEARED_EXCHANGE_RATE_TYPE ,
	VOID_DATE ,
	MATURITY_EXCHANGE_DATE ,
	MATURITY_EXCHANGE_RATE_TYPE ,
	MATURITY_EXCHANGE_RATE ,
	MATURITY_USER_RATE_TYPE	,
	VENDOR_NAME ,
	VENDOR_ADDRESS_LINE1,
	VENDOR_ADDRESS_LINE2,
	VENDOR_ADDRESS_LINE3,
	VENDOR_CITY,
	VENDOR_COUNTY,
	VENDOR_STATE,
	VENDOR_ZIP,
	VENDOR_COUNTRY,
	BANK_NAME ,
	CURRENT_BANK_ACCOUNT_NAME ,
	BANK_CURRENCY_CODE ,
	CHECK_STOCK_NAME ,
	PAYMENT_TYPE ,
	PAYMENT_METHOD ,
	BANK_ACCOUNT_NAME ,
	BANK_ACCOUNT_NUM ,
	BANK_ACCOUNT_TYPE ,
	BANK_NUM ,
	BASE_AMOUNT ,
	PAYMENT_ADDRESS_STYLE	,
	PAYMENT_ADDRESS_LINE1 ,
	PAYMENT_ADDRESS_LINE2 ,
	PAYMENT_ADDRESS_LINE3 ,
	PAYMENT_ADDRESS_LINE4 ,
	PAYMENT_CITY ,
	PAYMENT_COUNTY ,
	PAYMENT_STATE ,
	PAYMENT_ZIP ,
	PAYMENT_COUNTRY ,
	DOC_SEQUENCE_NAME ,
	DOC_CATEGORY_NAME ,
	EXCHANGE_DATE ,
	EXCHANGE_RATE ,
	EXCHANGE_RATE_TYPE ,
	FUTURE_PAY_DUE_DATE ,
	RELEASED_DATE ,
	RELEASED_BY ,
	STOPPED_DATE ,
	STOPPED_BY ,
	TREASURY_PAY_DATE ,
	TREASURY_PAY_NUMBER ,
	USSGL_TRANSACTION_CODE ,
	USSGL_TRX_CODE_CONTEXT ,
	SET_OF_BOOKS_NAME,
	CHECK_FORMAT_NAME ,
	TERRITORY_SHORT_NAME ,
	USER_RATE_TYPE ,
	POSITIVE_PAY_STATUS_CODE ,
	TRANSFER_PRIORITY ,
	EXTERNAL_BANK_ACCOUNT_NAME,
	STAMP_DUTY_AMT ,
	STAMP_DUTY_BASE_AMT ,
	FUTURE_DATED_PAYMENT_FLAG ,
	DESCRIPTION ,
	ANTICIPATED_VALUE_DATE ,
	ACTUAL_VALUE_DATE,
	OBSOLETE_FLAG 
) AS
SELECT 
	WMTC.WEB_TRANSACTION_ID	WEB_TRANSACTION_ID, 
	WMTC.TRANSACTION_TYPE  DOCUMENT_TYPE,
	DECODE(WMTC.TRANSACTION_STATUS,0,'UPDATE',1,'INSERT',2,'DELETE')  DOCUMENT_STATUS,
	AC.CHECK_ID CHECK_ID,
	HAOTL.NAME ORGANIZATION_NAME,
	AC.CHECK_NUMBER	CHECK_NUMBER ,
	AC.CURRENCY_CODE CURRENCY_CODE ,
	AC.AMOUNT AMOUNT ,
	AC.CHECK_DATE	CHECK_DATE ,
	AC.CHECKRUN_NAME BATCH_NAME ,
	AC.CHECK_VOUCHER_NUM CHECK_VOUCHER_NUM ,
	ALC3.DISPLAYED_FIELD CHECK_STATUS ,  
	AC.CLEARED_AMOUNT CLEARED_AMOUNT ,
	AC.CLEARED_BASE_AMOUNT CLEARED_BASE_AMOUNT ,
	AC.CLEARED_DATE CLEARED_DATE ,
	AC.CLEARED_EXCHANGE_DATE CLEARED_EXCHANGE_DATE ,
	AC.CLEARED_EXCHANGE_RATE CLEARED_EXCHANGE_RATE ,
	AC.CLEARED_EXCHANGE_RATE_TYPE	CLEARED_EXCHANGE_RATE_TYPE ,
	AC.VOID_DATE VOID_DATE ,
	AC.MATURITY_EXCHANGE_DATE ,
	AC.MATURITY_EXCHANGE_RATE_TYPE ,
	AC.MATURITY_EXCHANGE_RATE ,
	GDCT1.USER_CONVERSION_TYPE MATURITY_USER_RATE_TYPE ,
	AC.VENDOR_NAME VENDOR_NAME ,
	PVS.ADDRESS_LINE1 ADDRESS_LINE1,
	PVS.ADDRESS_LINE2 ADDRESS_LINE2,
	PVS.ADDRESS_LINE3 ADDRESS_LINE3,
	PVS.CITY  CITY,
	PVS.COUNTY COUNTY,
	PVS.STATE STATE,
	PVS.ZIP ZIP,
	PVS.COUNTRY COUNTRY,
	ABB.BANK_NAME	BANK_NAME ,
	ABA.BANK_ACCOUNT_NAME	CURRENT_BANK_ACCOUNT_NAME ,
	ABA.CURRENCY_CODE BANK_CURRENCY_CODE ,
	ACS.NAME CHECK_STOCK_NAME ,
	ALC1.DISPLAYED_FIELD PAYMENT_TYPE ,
	ALC2.DISPLAYED_FIELD PAYMENT_METHOD ,
	AC.BANK_ACCOUNT_NAME BANK_ACCOUNT_NAME ,
	AC.BANK_ACCOUNT_NUM BANK_ACCOUNT_NUM ,
	AC.BANK_ACCOUNT_TYPE BANK_ACCOUNT_TYPE ,
	AC.BANK_NUM BANK_NUM ,
	AC.BASE_AMOUNT BASE_AMOUNT ,
	NVL(AC.ADDRESS_STYLE,'DEFAULT') ADDRESS_STYLE	,
	AC.ADDRESS_LINE1 ADDRESS_LINE1 ,
	AC.ADDRESS_LINE2 ADDRESS_LINE2 ,
	AC.ADDRESS_LINE3 ADDRESS_LINE3 ,
	AC.ADDRESS_LINE4 ADDRESS_LINE4 ,
	AC.CITY CITY ,
	AC.COUNTY COUNTY ,
	AC.STATE STATE ,
	AC.ZIP ZIP ,
	AC.COUNTRY COUNTRY ,
	FDS.NAME DOC_SEQUENCE_NAME ,
	FDSC.NAME DOC_CATEGORY_NAME ,
	AC.EXCHANGE_DATE EXCHANGE_DATE ,
	AC.EXCHANGE_RATE EXCHANGE_RATE ,
	AC.EXCHANGE_RATE_TYPE	EXCHANGE_RATE_TYPE ,
	AC.FUTURE_PAY_DUE_DATE FUTURE_PAY_DUE_DATE ,
	AC.RELEASED_DATE RELEASED_DATE ,
	PPF1.FULL_NAME RELEASED_BY ,
	AC.STOPPED_DATE STOPPED_DATE ,
	PPF2.FULL_NAME	STOPPED_BY ,
	AC.TREASURY_PAY_DATE TREASURY_PAY_DATE ,
	AC.TREASURY_PAY_NUMBER TREASURY_PAY_NUMBER ,
	AC.USSGL_TRANSACTION_CODE USSGL_TRANSACTION_CODE ,
	AC.USSGL_TRX_CODE_CONTEXT USSGL_TRX_CODE_CONTEXT ,
	GSOB.NAME SET_OF_BOOKS_NAME,
	ACF.NAME CHECK_FORMAT_NAME ,
	FT.TERRITORY_SHORT_NAME TERRITORY_SHORT_NAME ,
	GDCT.USER_CONVERSION_TYPE USER_RATE_TYPE ,
	AC.POSITIVE_PAY_STATUS_CODE ,
	AC.TRANSFER_PRIORITY ,
	ABA1.BANK_ACCOUNT_NAME EXTERNAL_BANK_ACCOUNT_NAME,
	AC.STAMP_DUTY_AMT ,
	AC.STAMP_DUTY_BASE_AMT ,
	DECODE(AC.FUTURE_PAY_DUE_DATE, NULL,'N','Y' )	FUTURE_DATED_PAYMENT_FLAG ,
	AC.DESCRIPTION ,
	AC.ANTICIPATED_VALUE_DATE ,
	AC.ACTUAL_VALUE_DATE ,
	FT.OBSOLETE_FLAG
FROM 
	AP_BANK_ACCOUNTS_ALL ABA,
	AP_BANK_ACCOUNTS_ALL ABA1,
	AP_BANK_BRANCHES ABB,
	AP_CHECK_FORMATS ACF,
	AP_CHECK_STOCKS_ALL ACS,
	AP_LOOKUP_CODES ALC1,
	AP_LOOKUP_CODES ALC2,
	AP_LOOKUP_CODES ALC3,
	AP_PAYMENT_PROGRAMS APP1,
	AP_PAYMENT_PROGRAMS APP2,
	FND_DOCUMENT_SEQUENCES FDS,
	FND_DOC_SEQUENCE_CATEGORIES FDSC,
	FND_TERRITORIES_VL FT,
	GL_DAILY_CONVERSION_TYPES GDCT,
	PO_VENDORS PV,
	PO_VENDOR_SITES_ALL PVS,
	CE_STATEMENT_RECONCILS_ALL CSR,
	CE_STATEMENT_HEADERS_ALL CSH,
	CE_STATEMENT_LINES CSL,
	AP_CHECKS_ALL	AC,
	GL_DAILY_CONVERSION_TYPES GDCT1,
	HR_ALL_ORGANIZATION_UNITS_TL HAOTL,
	GL_SETS_OF_BOOKS GSOB,
	PER_PEOPLE_F PPF1,
	PER_PEOPLE_F PPF2,
	WM_TRACK_CHANGES_VW WMTC
WHERE 
	AC.BANK_ACCOUNT_ID = ABA.BANK_ACCOUNT_ID  AND
	AC.MATURITY_EXCHANGE_RATE_TYPE = GDCT1.CONVERSION_TYPE(+) AND
	ABB.BANK_BRANCH_ID = ABA.BANK_BRANCH_ID  AND
	AC.CHECK_FORMAT_ID = ACF.CHECK_FORMAT_ID(+) AND
	AC.CHECK_STOCK_ID = ACS.CHECK_STOCK_ID(+) AND
	ALC1.LOOKUP_TYPE = 'PAYMENT TYPE' AND
	ALC1.LOOKUP_CODE = AC.PAYMENT_TYPE_FLAG AND
	ALC2.LOOKUP_TYPE = 'PAYMENT METHOD' AND
	ALC2.LOOKUP_CODE = AC.PAYMENT_METHOD_LOOKUP_CODE AND
	ALC3.LOOKUP_TYPE (+) = 'CHECK	STATE' AND
	ALC3.LOOKUP_CODE (+) = AC.STATUS_LOOKUP_CODE AND
	APP1.PROGRAM_ID (+) =	ACF.FORMAT_PAYMENTS_PROGRAM_ID AND
	APP2.PROGRAM_ID (+) =	ACF.REMITTANCE_ADVICE_PROGRAM_ID AND
	AC.DOC_SEQUENCE_ID = FDS.DOC_SEQUENCE_ID (+) AND
	FDSC.APPLICATION_ID(+) = 200 AND
	AC.DOC_CATEGORY_CODE = FDSC.CODE (+) AND
	AC.COUNTRY = FT.TERRITORY_CODE (+) AND
	AC.EXCHANGE_RATE_TYPE	= GDCT.CONVERSION_TYPE (+) AND
	AC.VENDOR_ID = PV.VENDOR_ID (+) AND
	AC.VENDOR_SITE_ID = PVS.VENDOR_SITE_ID (+) AND
	CSR.REFERENCE_TYPE (+) = 'PAYMENT' AND
	CSR.REFERENCE_ID (+) = AC.CHECK_ID AND
	CSR.CURRENT_RECORD_FLAG (+) =	'Y' AND
	CSR.STATEMENT_LINE_ID	= CSL.STATEMENT_LINE_ID	(+) AND
	CSL.STATEMENT_HEADER_ID = CSH.STATEMENT_HEADER_ID (+)	AND
	DECODE(AC.VENDOR_ID,'',-1,AC.VENDOR_ID) = DECODE(AC.STATUS_LOOKUP_CODE,'SET UP',-1,'SPOILED',-1,AC.VENDOR_ID)	AND
	AC.ORG_ID = HAOTL.ORGANIZATION_ID (+)	AND
	AC.VENDOR_SITE_ID = PVS.VENDOR_SITE_ID (+) AND
	AC.EXTERNAL_BANK_ACCOUNT_ID  =  ABA1.BANK_ACCOUNT_ID (+)  AND
	ABA.SET_OF_BOOKS_ID =	GSOB.SET_OF_BOOKS_ID (+) AND
	AC.RELEASED_BY = PPF1.PERSON_ID (+) AND
	AC.STOPPED_BY = PPF2.PERSON_ID (+) AND
	AC.CHECK_ID = WMTC.TRANSACTION_ID AND
	TRANSACTION_STATUS <= 2	AND
	WMTC.TRANSACTION_TYPE =	'APPAYMENT'
	ORDER BY
	WMTC.WEB_TRANSACTION_ID

/

/*----------------------------------------------------------------------*/
--	Create View WM_AP_INVOICE_PAYMENTS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AP_INVOICE_PAYMENTS_VW
(
	CHECK_ID,
	INVOICE_NUM ,
	AMOUNT ,
	ACCOUNTING_DATE ,
	DESCRIPTION ,
	CHECK_DATE ,
	INVOICE_DATE ,
	ACCRUAL_POSTED_FLAG ,
	ACCTS_PAY_ACCOUNT_NUMBER,
	ASSETS_ADDITION_FLAG ,
	ASSET_ACCOUNT_NUMBER,
	BANK_ACCOUNT_NUM ,
	BANK_ACCOUNT_TYPE ,
	BANK_NUM ,
	CASH_POSTED_FLAG ,
	DISCOUNT_LOST ,
	DISCOUNT_TAKEN ,
	EXCHANGE_DATE ,
	EXCHANGE_RATE ,
	EXCHANGE_RATE_TYPE ,
	GAIN_ACCOUNT_NUMBER,
	INVOICE_BASE_AMOUNT ,
	LOSS_ACCOUNT_NUMBER,
	PAYMENT_BASE_AMOUNT ,
	PAYMENT_NUM ,
	PERIOD_NAME ,
	POSTED_FLAG ,
	SET_OF_BOOKS_NAME,
	INVOICE_PAYMENT_TYPE ,
	OTHER_INVOICE_NUM ,
	CHECK_NUMBER ,
	CHECK_AMOUNT ,
	CHECK_TYPE ,
	CHECK_STATUS ,
	PAYMENT_TYPE ,
	INVOICE_AMOUNT ,
	AMOUNT_PAID ,
	EXTERNAL_BANK_ACCOUNT_NUMBER,
	APS_EXTRNL_BANK_ACCOUNT_NUMBER
)AS
SELECT 
	AIP.CHECK_ID,
	AI.INVOICE_NUM INVOICE_NUM ,
	AIP.AMOUNT AMOUNT ,
	AIP.ACCOUNTING_DATE ACCOUNTING_DATE ,
	AI.DESCRIPTION DESCRIPTION ,
	AC.CHECK_DATE CHECK_DATE ,
	AI.INVOICE_DATE INVOICE_DATE ,
	AIP.ACCRUAL_POSTED_FLAG ACCRUAL_POSTED_FLAG ,
	GCCK1.CONCATENATED_SEGMENTS ACCTS_PAY_ACCOUNT_NUMBER,
	AIP.ASSETS_ADDITION_FLAG ASSETS_ADDITION_FLAG ,
	GCCK2.CONCATENATED_SEGMENTS ASSET_ACCOUNT_NUMBER,
	AIP.BANK_ACCOUNT_NUM BANK_ACCOUNT_NUM ,
	AIP.BANK_ACCOUNT_TYPE BANK_ACCOUNT_TYPE ,
	AIP.BANK_NUM BANK_NUM ,
	AIP.CASH_POSTED_FLAG CASH_POSTED_FLAG ,
	AIP.DISCOUNT_LOST DISCOUNT_LOST ,
	AIP.DISCOUNT_TAKEN DISCOUNT_TAKEN ,
	AIP.EXCHANGE_DATE EXCHANGE_DATE ,
	AIP.EXCHANGE_RATE EXCHANGE_RATE ,
	AIP.EXCHANGE_RATE_TYPE EXCHANGE_RATE_TYPE ,
	GCCK4.CONCATENATED_SEGMENTS GAIN_ACCOUNT_NUMBER,
	AIP.INVOICE_BASE_AMOUNT INVOICE_BASE_AMOUNT ,
	GCCK5.CONCATENATED_SEGMENTS LOSS_ACCOUNT_NUMBER,
	AIP.PAYMENT_BASE_AMOUNT PAYMENT_BASE_AMOUNT ,
	AIP.PAYMENT_NUM PAYMENT_NUM ,
	AIP.PERIOD_NAME PERIOD_NAME ,
	AIP.POSTED_FLAG POSTED_FLAG ,
	GSOB.NAME SET_OF_BOOKS_NAME,
	AIP.INVOICE_PAYMENT_TYPE INVOICE_PAYMENT_TYPE ,
	AI1.INVOICE_NUM OTHER_INVOICE_NUM ,
	AC.CHECK_NUMBER CHECK_NUMBER ,
	AC.AMOUNT CHECK_AMOUNT ,
	ALC1.DISPLAYED_FIELD CHECK_TYPE ,
	ALC2.DISPLAYED_FIELD CHECK_STATUS ,
	ALC3.DISPLAYED_FIELD PAYMENT_TYPE ,
	AI.INVOICE_AMOUNT INVOICE_AMOUNT ,
	AI.AMOUNT_PAID AMOUNT_PAID ,
	ABA1.BANK_ACCOUNT_NUM,
	ABA2.BANK_ACCOUNT_NUM
FROM 
	AP_INVOICE_PAYMENTS_ALL AIP,
	AP_INVOICES_ALL AI,
	AP_INVOICES_ALL AI1,  
	AP_CHECKS_ALL AC,
	AP_LOOKUP_CODES ALC1,
	AP_LOOKUP_CODES ALC2,
	AP_LOOKUP_CODES ALC3,
	GL_SETS_OF_BOOKS GSOB,
	AP_PAYMENT_SCHEDULES_ALL APS,
	GL_CODE_COMBINATIONS_KFV GCCK1,
	GL_CODE_COMBINATIONS_KFV GCCK2,
	GL_CODE_COMBINATIONS_KFV GCCK4,
	GL_CODE_COMBINATIONS_KFV GCCK5,
	AP_BANK_ACCOUNTS_ALL ABA1,
	AP_BANK_ACCOUNTS_ALL ABA2
WHERE 
	AIP.INVOICE_ID = AI.INVOICE_ID AND
	AIP.CHECK_ID = AC.CHECK_ID AND
	ALC1.LOOKUP_TYPE = 'PAYMENT METHOD' AND
	ALC1.LOOKUP_CODE = AC.PAYMENT_METHOD_LOOKUP_CODE AND
	ALC2.LOOKUP_TYPE (+) = 'CHECK STATE' AND
	ALC2.LOOKUP_CODE (+) = AC.STATUS_LOOKUP_CODE AND
	ALC3.LOOKUP_TYPE (+) = 'NLS TRANSLATION' AND
	ALC3.LOOKUP_CODE (+) = AIP.INVOICE_PAYMENT_TYPE AND
	AIP.SET_OF_BOOKS_ID = GSOB.SET_OF_BOOKS_ID AND
	APS.INVOICE_ID = AIP.INVOICE_ID AND
	APS.PAYMENT_NUM = AIP.PAYMENT_NUM AND
	AC.CHECK_ID = AIP.CHECK_ID AND
	AIP.ACCTS_PAY_CODE_COMBINATION_ID = GCCK1.CODE_COMBINATION_ID (+) AND
	AIP.ASSET_CODE_COMBINATION_ID = GCCK2.CODE_COMBINATION_ID (+) AND
	AIP.GAIN_CODE_COMBINATION_ID = GCCK4.CODE_COMBINATION_ID (+) AND
	AIP.LOSS_CODE_COMBINATION_ID = GCCK5.CODE_COMBINATION_ID (+)  AND
	AIP.EXTERNAL_BANK_ACCOUNT_ID = ABA1.BANK_ACCOUNT_ID (+)  AND
	APS.EXTERNAL_BANK_ACCOUNT_ID = ABA2.BANK_ACCOUNT_ID (+)  AND
	AIP.OTHER_INVOICE_ID = AI1.INVOICE_ID (+)

/

/*----------------------------------------------------------------------*/
--	Create View WM_AP_CHECKS_QRY_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AP_CHECKS_QRY_VW 
(
	WEB_TRANSACTION_ID, 
	DOCUMENT_TYPE,
	DOCUMENT_STATUS,
	CHECK_ID,
	ORGANIZATION_NAME,
	CHECK_NUMBER,
	CURRENCY_CODE ,
	AMOUNT ,
	CHECK_DATE ,
	BATCH_NAME ,
	CHECK_VOUCHER_NUM ,
	CHECK_STATUS ,	
	CLEARED_AMOUNT ,
	CLEARED_BASE_AMOUNT ,
	CLEARED_DATE ,
	CLEARED_EXCHANGE_DATE ,
	CLEARED_EXCHANGE_RATE ,
	CLEARED_EXCHANGE_RATE_TYPE ,
	VOID_DATE ,
	MATURITY_EXCHANGE_DATE ,
	MATURITY_EXCHANGE_RATE_TYPE ,
	MATURITY_EXCHANGE_RATE ,
	MATURITY_USER_RATE_TYPE	,
	VENDOR_NAME ,
	VENDOR_ADDRESS_LINE1,
	VENDOR_ADDRESS_LINE2,
	VENDOR_ADDRESS_LINE3,
	VENDOR_CITY,
	VENDOR_COUNTY,
	VENDOR_STATE,
	VENDOR_ZIP,
	VENDOR_COUNTRY,
	BANK_NAME ,
	CURRENT_BANK_ACCOUNT_NAME ,
	BANK_CURRENCY_CODE ,
	CHECK_STOCK_NAME ,
	PAYMENT_TYPE ,
	PAYMENT_METHOD ,
	BANK_ACCOUNT_NAME ,
	BANK_ACCOUNT_NUM ,
	BANK_ACCOUNT_TYPE ,
	BANK_NUM ,
	BASE_AMOUNT ,
	PAYMENT_ADDRESS_STYLE	,
	PAYMENT_ADDRESS_LINE1 ,
	PAYMENT_ADDRESS_LINE2 ,
	PAYMENT_ADDRESS_LINE3 ,
	PAYMENT_ADDRESS_LINE4 ,
	PAYMENT_CITY ,
	PAYMENT_COUNTY ,
	PAYMENT_STATE ,
	PAYMENT_ZIP ,
	PAYMENT_COUNTRY ,
	DOC_SEQUENCE_NAME ,
	DOC_CATEGORY_NAME ,
	EXCHANGE_DATE ,
	EXCHANGE_RATE ,
	EXCHANGE_RATE_TYPE ,
	FUTURE_PAY_DUE_DATE ,
	RELEASED_DATE ,
	RELEASED_BY ,
	STOPPED_DATE ,
	STOPPED_BY ,
	TREASURY_PAY_DATE ,
	TREASURY_PAY_NUMBER ,
	USSGL_TRANSACTION_CODE ,
	USSGL_TRX_CODE_CONTEXT ,
	SET_OF_BOOKS_NAME,
	CHECK_FORMAT_NAME ,
	TERRITORY_SHORT_NAME ,
	USER_RATE_TYPE ,
	POSITIVE_PAY_STATUS_CODE ,
	TRANSFER_PRIORITY ,
	EXTERNAL_BANK_ACCOUNT_NAME,
	STAMP_DUTY_AMT ,
	STAMP_DUTY_BASE_AMT ,
	FUTURE_DATED_PAYMENT_FLAG ,
	DESCRIPTION ,
	ANTICIPATED_VALUE_DATE ,
	ACTUAL_VALUE_DATE,
	OBSOLETE_FLAG 
) AS
SELECT 
	NULL 	WEB_TRANSACTION_ID, 
	'AP_PAYMENTS' DOCUMENT_TYPE,
	'QUERY'	DOCUMENT_STATUS,
	AC.CHECK_ID CHECK_ID,
	HAOTL.NAME ORGANIZATION_NAME,
	AC.CHECK_NUMBER	CHECK_NUMBER ,
	AC.CURRENCY_CODE CURRENCY_CODE ,
	AC.AMOUNT AMOUNT ,
	AC.CHECK_DATE	CHECK_DATE ,
	AC.CHECKRUN_NAME BATCH_NAME ,
	AC.CHECK_VOUCHER_NUM CHECK_VOUCHER_NUM ,
	ALC3.DISPLAYED_FIELD CHECK_STATUS ,  
	AC.CLEARED_AMOUNT CLEARED_AMOUNT ,
	AC.CLEARED_BASE_AMOUNT CLEARED_BASE_AMOUNT ,
	AC.CLEARED_DATE CLEARED_DATE ,
	AC.CLEARED_EXCHANGE_DATE CLEARED_EXCHANGE_DATE ,
	AC.CLEARED_EXCHANGE_RATE CLEARED_EXCHANGE_RATE ,
	AC.CLEARED_EXCHANGE_RATE_TYPE	CLEARED_EXCHANGE_RATE_TYPE ,
	AC.VOID_DATE VOID_DATE ,
	AC.MATURITY_EXCHANGE_DATE ,
	AC.MATURITY_EXCHANGE_RATE_TYPE ,
	AC.MATURITY_EXCHANGE_RATE ,
	GDCT1.USER_CONVERSION_TYPE MATURITY_USER_RATE_TYPE ,
	AC.VENDOR_NAME VENDOR_NAME ,
	PVS.ADDRESS_LINE1 ADDRESS_LINE1,
	PVS.ADDRESS_LINE2 ADDRESS_LINE2,
	PVS.ADDRESS_LINE3 ADDRESS_LINE3,
	PVS.CITY  CITY,
	PVS.COUNTY COUNTY,
	PVS.STATE STATE,
	PVS.ZIP ZIP,
	PVS.COUNTRY COUNTRY,
	ABB.BANK_NAME	BANK_NAME ,
	ABA.BANK_ACCOUNT_NAME	CURRENT_BANK_ACCOUNT_NAME ,
	ABA.CURRENCY_CODE BANK_CURRENCY_CODE ,
	ACS.NAME CHECK_STOCK_NAME ,
	ALC1.DISPLAYED_FIELD PAYMENT_TYPE ,
	ALC2.DISPLAYED_FIELD PAYMENT_METHOD ,
	AC.BANK_ACCOUNT_NAME BANK_ACCOUNT_NAME ,
	AC.BANK_ACCOUNT_NUM BANK_ACCOUNT_NUM ,
	AC.BANK_ACCOUNT_TYPE BANK_ACCOUNT_TYPE ,
	AC.BANK_NUM BANK_NUM ,
	AC.BASE_AMOUNT BASE_AMOUNT ,
	NVL(AC.ADDRESS_STYLE,'DEFAULT') ADDRESS_STYLE	,
	AC.ADDRESS_LINE1 ADDRESS_LINE1 ,
	AC.ADDRESS_LINE2 ADDRESS_LINE2 ,
	AC.ADDRESS_LINE3 ADDRESS_LINE3 ,
	AC.ADDRESS_LINE4 ADDRESS_LINE4 ,
	AC.CITY CITY ,
	AC.COUNTY COUNTY ,
	AC.STATE STATE ,
	AC.ZIP ZIP ,
	AC.COUNTRY COUNTRY ,
	FDS.NAME DOC_SEQUENCE_NAME ,
	FDSC.NAME DOC_CATEGORY_NAME ,
	AC.EXCHANGE_DATE EXCHANGE_DATE ,
	AC.EXCHANGE_RATE EXCHANGE_RATE ,
	AC.EXCHANGE_RATE_TYPE	EXCHANGE_RATE_TYPE ,
	AC.FUTURE_PAY_DUE_DATE FUTURE_PAY_DUE_DATE ,
	AC.RELEASED_DATE RELEASED_DATE ,
	PPF1.FULL_NAME RELEASED_BY ,
	AC.STOPPED_DATE STOPPED_DATE ,
	PPF2.FULL_NAME	STOPPED_BY ,
	AC.TREASURY_PAY_DATE TREASURY_PAY_DATE ,
	AC.TREASURY_PAY_NUMBER TREASURY_PAY_NUMBER ,
	AC.USSGL_TRANSACTION_CODE USSGL_TRANSACTION_CODE ,
	AC.USSGL_TRX_CODE_CONTEXT USSGL_TRX_CODE_CONTEXT ,
	GSOB.NAME SET_OF_BOOKS_NAME,
	ACF.NAME CHECK_FORMAT_NAME ,
	FT.TERRITORY_SHORT_NAME TERRITORY_SHORT_NAME ,
	GDCT.USER_CONVERSION_TYPE USER_RATE_TYPE ,
	AC.POSITIVE_PAY_STATUS_CODE ,
	AC.TRANSFER_PRIORITY ,
	ABA1.BANK_ACCOUNT_NAME EXTERNAL_BANK_ACCOUNT_NAME,
	AC.STAMP_DUTY_AMT ,
	AC.STAMP_DUTY_BASE_AMT ,
	DECODE(AC.FUTURE_PAY_DUE_DATE, NULL,'N','Y' )	FUTURE_DATED_PAYMENT_FLAG ,
	AC.DESCRIPTION ,
	AC.ANTICIPATED_VALUE_DATE ,
	AC.ACTUAL_VALUE_DATE ,
	FT.OBSOLETE_FLAG
FROM 
	AP_BANK_ACCOUNTS_ALL ABA,
	AP_BANK_ACCOUNTS_ALL ABA1,
	AP_BANK_BRANCHES ABB,
	AP_CHECK_FORMATS ACF,
	AP_CHECK_STOCKS_ALL ACS,
	AP_LOOKUP_CODES ALC1,
	AP_LOOKUP_CODES ALC2,
	AP_LOOKUP_CODES ALC3,
	AP_PAYMENT_PROGRAMS APP1,
	AP_PAYMENT_PROGRAMS APP2,
	FND_DOCUMENT_SEQUENCES FDS,
	FND_DOC_SEQUENCE_CATEGORIES FDSC,
	FND_TERRITORIES_VL FT,
	GL_DAILY_CONVERSION_TYPES GDCT,
	PO_VENDORS PV,
	PO_VENDOR_SITES_ALL PVS,
	CE_STATEMENT_RECONCILS_ALL CSR,
	CE_STATEMENT_HEADERS_ALL CSH,
	CE_STATEMENT_LINES CSL,
	AP_CHECKS_ALL	AC,
	GL_DAILY_CONVERSION_TYPES GDCT1,
	HR_ALL_ORGANIZATION_UNITS_TL HAOTL,
	GL_SETS_OF_BOOKS GSOB,
	PER_PEOPLE_F PPF1,
	PER_PEOPLE_F PPF2
WHERE 
	AC.BANK_ACCOUNT_ID = ABA.BANK_ACCOUNT_ID  AND
	AC.MATURITY_EXCHANGE_RATE_TYPE = GDCT1.CONVERSION_TYPE(+) AND
	ABB.BANK_BRANCH_ID = ABA.BANK_BRANCH_ID  AND
	AC.CHECK_FORMAT_ID = ACF.CHECK_FORMAT_ID(+) AND
	AC.CHECK_STOCK_ID = ACS.CHECK_STOCK_ID(+) AND
	ALC1.LOOKUP_TYPE = 'PAYMENT TYPE' AND
	ALC1.LOOKUP_CODE = AC.PAYMENT_TYPE_FLAG AND
	ALC2.LOOKUP_TYPE = 'PAYMENT METHOD' AND
	ALC2.LOOKUP_CODE = AC.PAYMENT_METHOD_LOOKUP_CODE AND
	ALC3.LOOKUP_TYPE (+) = 'CHECK	STATE' AND
	ALC3.LOOKUP_CODE (+) = AC.STATUS_LOOKUP_CODE AND
	APP1.PROGRAM_ID (+) =	ACF.FORMAT_PAYMENTS_PROGRAM_ID AND
	APP2.PROGRAM_ID (+) =	ACF.REMITTANCE_ADVICE_PROGRAM_ID AND
	AC.DOC_SEQUENCE_ID = FDS.DOC_SEQUENCE_ID (+) AND
	FDSC.APPLICATION_ID(+) = 200 AND
	AC.DOC_CATEGORY_CODE = FDSC.CODE (+) AND
	AC.COUNTRY = FT.TERRITORY_CODE (+) AND
	AC.EXCHANGE_RATE_TYPE	= GDCT.CONVERSION_TYPE (+) AND
	AC.VENDOR_ID = PV.VENDOR_ID (+) AND
	AC.VENDOR_SITE_ID = PVS.VENDOR_SITE_ID (+) AND
	CSR.REFERENCE_TYPE (+) = 'PAYMENT' AND
	CSR.REFERENCE_ID (+) = AC.CHECK_ID AND
	CSR.CURRENT_RECORD_FLAG (+) =	'Y' AND
	CSR.STATEMENT_LINE_ID	= CSL.STATEMENT_LINE_ID	(+) AND
	CSL.STATEMENT_HEADER_ID = CSH.STATEMENT_HEADER_ID (+)	AND
	DECODE(AC.VENDOR_ID,'',-1,AC.VENDOR_ID) = DECODE(AC.STATUS_LOOKUP_CODE,'SET UP',-1,'SPOILED',-1,AC.VENDOR_ID)	AND
	AC.ORG_ID = HAOTL.ORGANIZATION_ID (+)	AND
	AC.VENDOR_SITE_ID = PVS.VENDOR_SITE_ID (+) AND
	AC.EXTERNAL_BANK_ACCOUNT_ID  =  ABA1.BANK_ACCOUNT_ID (+)  AND
	ABA.SET_OF_BOOKS_ID =	GSOB.SET_OF_BOOKS_ID (+) AND
	AC.RELEASED_BY = PPF1.PERSON_ID (+) AND
	AC.STOPPED_BY = PPF2.PERSON_ID (+)

/

