/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Journal outbound in Application Schema  
    * Program Name:         wm_from_journal_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Journal Outbound
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
     03-oct-02	 Indrani Das 		Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_journal_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."


/*----------------------------------------------------------------------*/
--      Create View WM_GL_JOURNALS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_GL_JOURNALS_VW 
AS
SELECT
WMTC.WEB_TRANSACTION_ID WEB_TRANSACTION_ID,
WMTC.TRANSACTION_TYPE DOCUMENT_TYPE,
DECODE(WMTC.TRANSACTION_STATUS, 1, 'INSERT', NULL) DOCUMENT_STATUS,
WMTC.TRANSACTION_ID JE_LINE_ID,
GLBAT.ORG_ID ORG_ID,
decode(GLH.STATUS,'P','Posted','Unposted') STATUS,
GLS.SHORT_NAME  SET_OF_BOOKS_SHORT_NAME,
GLH.DATE_CREATED  ACCOUNTING_DATE,
GLH.CURRENCY_CODE CURRENCY_CODE,
GLH.DATE_CREATED  DATE_CREATED,
FNU.USER_NAME CREATED_BY,
PER.EMPLOYEE_NUMBER  CREATED_BY_EMPLOYEE_NUMBER,
PER.FULL_NAME CREATED_BY_NAME,
GLH.ACTUAL_FLAG  ACTUAL_FLAG,
GLH.JE_CATEGORY CATEGORY_NAME,
GLH.JE_SOURCE  SOURCE_NAME,
GLH.CURRENCY_CONVERSION_DATE  CURRENCY_CONVERSION_DATE,
GLET.ENCUMBRANCE_TYPE  ENCUMBRANCE_TYPE,
GLB.BUDGET_NAME  BUDGET_NAME,
GLH.CURRENCY_CONVERSION_TYPE  USER_CURRENCY_CONVERSION_TYPE,
GLH.CURRENCY_CONVERSION_RATE  CURRENCY_CONVERSION_RATE,
GLL.ENTERED_DR ENTERED_DR,
GLL.ENTERED_CR  ENTERED_CR,
GLL.ACCOUNTED_DR ACCOUNTED_DR,
GLL.ACCOUNTED_CR  ACCOUNTED_CR,
GLL.REFERENCE_1 REFERENCE,
GLBAT.NAME  BATCH_NAME,
GLH.PERIOD_NAME PERIOD_NAME,
GLDV.CONCATENATED_SEGMENTS  ACCOUNT_CODE,
GLL.STAT_AMOUNT STAT_AMOUNT,
GLL.INVOICE_DATE  INVOICE_DATE,
GLL.TAX_CODE TAX_CODE,
GLL.INVOICE_IDENTIFIER  INVOICE_IDENTIFIER,
GLL.INVOICE_AMOUNT  INVOICE_AMOUNT,
GLH.USSGL_TRANSACTION_CODE,
GLH.JGZZ_RECON_REF  JGZZ_RECON_REF,
GLBAT.AVERAGE_JOURNAL_FLAG  AVERAGE_JOURNAL,
GLH.POSTED_DATE POSTED_DATE
FROM
GL_JE_HEADERS GLH,
GL_JE_LINES  GLL,
GL_SETS_OF_BOOKS GLS,
PER_ALL_PEOPLE_F PER,
GL_ENCUMBRANCE_TYPES  GLET,
GL_BUDGET_VERSIONS GLB,
GL_JE_BATCHES  GLBAT,
GL_CODE_COMBINATIONS_KFV GLDV,
FND_USER FNU,
WM_TRACK_CHANGES_VW WMTC
WHERE
GLH.JE_HEADER_ID =  GLL.JE_HEADER_ID
AND GLL.SET_OF_BOOKS_ID=GLS.SET_OF_BOOKS_ID
AND GLH.CREATED_BY=FNU.USER_ID(+)
AND FNU.EMPLOYEE_ID = PER.PERSON_ID(+)
AND NVL(PER.EFFECTIVE_END_DATE,SYSDATE+1)  > SYSDATE
AND GLH.ENCUMBRANCE_TYPE_ID=GLET.ENCUMBRANCE_TYPE_ID(+)
AND GLH.BUDGET_VERSION_ID=GLB.BUDGET_VERSION_ID(+)
AND GLH.JE_BATCH_ID=GLBAT.JE_BATCH_ID
AND GLL.CODE_COMBINATION_ID=GLDV.CODE_COMBINATION_ID
AND GLL.JE_HEADER_ID||'-'||GLL.JE_LINE_NUM = WMTC.TRANSACTION_ID 
AND WMTC.TRANSACTION_STATUS <= 2 
AND WMTC.TRANSACTION_TYPE = 'JOURNAL' 
/

/*----------------------------------------------------------------------*/
--      Create View WM_GL_JOURNALS_QRY_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_GL_JOURNALS_QRY_VW 
AS
SELECT 
TO_NUMBER(NULL) WEB_TRANSACTION_ID,
'JOURNAL' DOCUMENT_TYPE,
'QUERY' DOCUMENT_STATUS,
GLL.JE_HEADER_ID||'-'||GLL.JE_LINE_NUM JE_LINE_ID,
GLbat.ORG_ID ORG_ID,
decode(GLH.STATUS,'P','Posted','Unposted') STATUS,
GLS.SHORT_NAME  SET_OF_BOOKS_SHORT_NAME,
GLH.DATE_CREATED  ACCOUNTING_DATE,
GLH.CURRENCY_CODE CURRENCY_CODE,
GLH.DATE_CREATED  DATE_CREATED,
FNU.USER_NAME CREATED_BY,
PER.EMPLOYEE_NUMBER  CREATED_BY_EMPLOYEE_NUMBER,
PER.FULL_NAME CREATED_BY_NAME,
GLH.ACTUAL_FLAG  ACTUAL_FLAG,
GLH.JE_CATEGORY CATEGORY_NAME,
GLH.JE_SOURCE  SOURCE_NAME,
GLH.CURRENCY_CONVERSION_DATE  CURRENCY_CONVERSION_DATE,
GLET.ENCUMBRANCE_TYPE  ENCUMBRANCE_TYPE,
GLB.BUDGET_NAME  BUDGET_NAME,
GLH.CURRENCY_CONVERSION_TYPE  USER_CURRENCY_CONVERSION_TYPE,
GLH.CURRENCY_CONVERSION_RATE  CURRENCY_CONVERSION_RATE,
GLL.ENTERED_DR ENTERED_DR,
GLL.ENTERED_CR  ENTERED_CR,
GLL.ACCOUNTED_DR ACCOUNTED_DR,
GLL.ACCOUNTED_CR  ACCOUNTED_CR,
GLL.REFERENCE_1 REFERENCE,
GLBAT.NAME  BATCH_NAME,
GLH.PERIOD_NAME PERIOD_NAME,
GLDV.CONCATENATED_SEGMENTS  ACCOUNT_CODE,
GLL.STAT_AMOUNT STAT_AMOUNT,
GLL.INVOICE_DATE  INVOICE_DATE,
GLL.TAX_CODE TAX_CODE,
GLL.INVOICE_IDENTIFIER  INVOICE_IDENTIFIER,
GLL.INVOICE_AMOUNT  INVOICE_AMOUNT,
GLH.USSGL_TRANSACTION_CODE,
GLH.JGZZ_RECON_REF  JGZZ_RECON_REF,
GLbat.AVERAGE_JOURNAL_FLAG  AVERAGE_JOURNAL,
GLH.POSTED_DATE POSTED_DATE 
FROM
GL_JE_HEADERS GLH,
GL_JE_LINES  GLL,
GL_SETS_OF_BOOKS GLS,
PER_ALL_PEOPLE_F PER,
GL_ENCUMBRANCE_TYPES  GLET,
GL_BUDGET_VERSIONS GLB,
GL_JE_BATCHES  GLBAT,
GL_CODE_COMBINATIONS_KFV GLDV,
FND_USER FNU
WHERE
GLH.JE_HEADER_ID =  GLL.JE_HEADER_ID(+)
AND GLL.SET_OF_BOOKS_ID=GLS.SET_OF_BOOKS_ID
AND  GLH.CREATED_BY=FNU.USER_ID (+)
AND FNU.EMPLOYEE_ID = PER.PERSON_ID (+)
AND  NVL(PER.EFFECTIVE_END_DATE,SYSDATE+1)  > SYSDATE
AND GLH.ENCUMBRANCE_TYPE_ID=GLET.ENCUMBRANCE_TYPE_ID(+) 
AND  GLH.BUDGET_VERSION_ID=GLB.BUDGET_VERSION_ID(+) 
AND  GLH.JE_BATCH_ID=GLBAT.JE_BATCH_ID(+)
AND  GLL.CODE_COMBINATION_ID=GLDV.CODE_COMBINATION_ID 
/

 
SHOW ERRORS

