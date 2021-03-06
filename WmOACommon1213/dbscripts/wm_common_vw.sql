/*  ***************************************************************************
        $Date:   09 Apr 2009 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2009, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create custom views common for the transactions of all packages
    * Program Name:         ra_addresses_all_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 6.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         Create custom views common for the transactions of all packages.      
    *
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
    
    *   
    *
    * Menu Responsibilities and path: 
    *
    *
*/

set feedback  on
set verify            off
set newpage   0
set pause             off
set termout   on

connect &&apps_user/&&appspwd@&&DBString 

REM "Creating View WM_RA_ADDRESSES_ALL_VW"


CREATE OR REPLACE VIEW APPS.WM_RA_ADDRESSES_ALL_VW
(
PARTY_SITE_ID,
PARTY_ID,
PARTY_LOCATION_ID,
KEY_ACCOUNT_FLAG,
PROGRAM_UPDATE_DATE,
TERRITORY_ID,
ADDRESS_KEY,
BILL_TO_FLAG,
MARKET_FLAG,
SHIP_TO_FLAG,
ATTRIBUTE11,
ATTRIBUTE12,
ATTRIBUTE13,
ATTRIBUTE14,
ATTRIBUTE15,
LOCATION_ID,
SERVICE_TERRITORY_ID,
PRIMARY_SPECIALIST_ID,
SECONDARY_SPECIALIST_ID,
CUSTOMER_CATEGORY_CODE,
CUSTOMER_GROUP_CODE,
CUSTOMER_SUBGROUP_CODE ,
REFERENCE_USE_FLAG,
ANALYSIS_FY,
FISCAL_YEAREND_MONTH,
NET_WORTH,
NUM_OF_EMPLOYEES,
POTENTIAL_REVENUE_CURR_FY,
POTENTIAL_REVENUE_NEXT_FY,
RANK,
COMPETITOR_FLAG,
THIRD_PARTY_FLAG,
YEAR_ESTABLISHED,
DO_NOT_MAIL_FLAG,
ADDRESS_STYLE,
LANGUAGE,
ADDRESS_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE,
CREATED_BY,
CUSTOMER_ID,
STATUS,
ORIG_SYSTEM_REFERENCE,
ORG_ID,
COUNTRY,
ADDRESS1,
ADDRESS2,
ADDRESS3,
ADDRESS4,
CITY,
POSTAL_CODE,
STATE,
PROVINCE,
COUNTY,
LAST_UPDATE_LOGIN,
ATTRIBUTE_CATEGORY,
ATTRIBUTE1,
ATTRIBUTE2,
ATTRIBUTE3,
ATTRIBUTE4,
ATTRIBUTE5,
ATTRIBUTE6,
ATTRIBUTE7,
ATTRIBUTE8,
ATTRIBUTE9,
ATTRIBUTE10,
REQUEST_ID,             
PROGRAM_APPLICATION_ID,
PROGRAM_ID, 
ADDRESS_LINES_PHONETIC,
GLOBAL_ATTRIBUTE1,
GLOBAL_ATTRIBUTE2,
GLOBAL_ATTRIBUTE3,
GLOBAL_ATTRIBUTE4,
GLOBAL_ATTRIBUTE5,
GLOBAL_ATTRIBUTE6,
GLOBAL_ATTRIBUTE7,
GLOBAL_ATTRIBUTE8,
GLOBAL_ATTRIBUTE9,
GLOBAL_ATTRIBUTE10,
GLOBAL_ATTRIBUTE11,
GLOBAL_ATTRIBUTE12,
GLOBAL_ATTRIBUTE13,
GLOBAL_ATTRIBUTE14,
GLOBAL_ATTRIBUTE15,
GLOBAL_ATTRIBUTE16,
GLOBAL_ATTRIBUTE17,
GLOBAL_ATTRIBUTE18,
GLOBAL_ATTRIBUTE19,
GLOBAL_ATTRIBUTE_CATEGORY,
TP_HEADER_ID , 
WH_UPDATE_DATE,
GLOBAL_ATTRIBUTE20,
ECE_TP_LOCATION_CODE,
SALES_TAX_GEOCODE,
SALES_TAX_INSIDE_CITY_LIMITS,
TERRITORY,
TRANSLATED_CUSTOMER_NAME,
ADDRESS_TEXT, 
SITE_NUMBER, 
IDENTIFYING_ADDRESS_FLAG,
ATTRIBUTE16,
ATTRIBUTE17,
ATTRIBUTE18,
ATTRIBUTE19,
ATTRIBUTE20,
PARTY_SITE_LAST_UPDATE_DATE,
LOC_LAST_UPDATE_DATE,
ADDRESSEE)
AS
SELECT
CUST_ACCT.PARTY_SITE_ID,
PARTY_SITE.PARTY_ID,
LOCATION.LOCATION_ID,
CUST_ACCT.KEY_ACCOUNT_FLAG,
CUST_ACCT.PROGRAM_UPDATE_DATE,
CUST_ACCT.TERRITORY_ID,
LOCATION.ADDRESS_KEY,
CUST_ACCT.BILL_TO_FLAG,
CUST_ACCT.MARKET_FLAG,
CUST_ACCT.SHIP_TO_FLAG,
CUST_ACCT.ATTRIBUTE11,
CUST_ACCT.ATTRIBUTE12,
CUST_ACCT.ATTRIBUTE13,
CUST_ACCT.ATTRIBUTE14,
CUST_ACCT.ATTRIBUTE15,
PARTY_SITE.LOCATION_ID,
CUST_ACCT.SERVICE_TERRITORY_ID,
CUST_ACCT.PRIMARY_SPECIALIST_ID,
CUST_ACCT.SECONDARY_SPECIALIST_ID,
CUST_ACCT.CUSTOMER_CATEGORY_CODE,
NULL /*CUSTOMER_GROUP_CODE*/,
NULL /*CUSTOMER_SUBGROUP_CODE*/ ,
PARTY.REFERENCE_USE_FLAG,
DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.ANALYSIS_FY, NULL),
DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.FISCAL_YEAREND_MONTH , NULL),
TO_NUMBER(NULL) /*NET_WORTH*/,
DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.EMPLOYEES_TOTAL, TO_NUMBER(NULL)),
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.CURR_FY_POTENTIAL_REVENUE, TO_NUMBER(NULL)),
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.NEXT_FY_POTENTIAL_REVENUE, TO_NUMBER(NULL)),
NULL /*RANK*/,
PARTY.COMPETITOR_FLAG,
PARTY.THIRD_PARTY_FLAG,
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.YEAR_ESTABLISHED , TO_NUMBER(NULL)),
PARTY.DO_NOT_MAIL_FLAG,
LOCATION.ADDRESS_STYLE,
CUST_ACCT.LANGUAGE,
CUST_ACCT.CUST_ACCT_SITE_ID,
CUST_ACCT.LAST_UPDATE_DATE,
CUST_ACCT.LAST_UPDATED_BY,
CUST_ACCT.CREATION_DATE,
CUST_ACCT.CREATED_BY,
CUST_ACCT.CUST_ACCOUNT_ID,
CUST_ACCT.STATUS,
CUST_ACCT.ORIG_SYSTEM_REFERENCE,
CUST_ACCT.ORG_ID,
LOCATION.COUNTRY,
LOCATION.ADDRESS1,
LOCATION.ADDRESS2,
LOCATION.ADDRESS3,
LOCATION.ADDRESS4,
LOCATION.CITY,
LOCATION.POSTAL_CODE,
LOCATION.STATE,
LOCATION.PROVINCE,
LOCATION.COUNTY,
CUST_ACCT.LAST_UPDATE_LOGIN,
CUST_ACCT.ATTRIBUTE_CATEGORY,
CUST_ACCT.ATTRIBUTE1,
CUST_ACCT.ATTRIBUTE2,
CUST_ACCT.ATTRIBUTE3,
CUST_ACCT.ATTRIBUTE4,
CUST_ACCT.ATTRIBUTE5,
CUST_ACCT.ATTRIBUTE6,
CUST_ACCT.ATTRIBUTE7,
CUST_ACCT.ATTRIBUTE8,
CUST_ACCT.ATTRIBUTE9,
CUST_ACCT.ATTRIBUTE10,
CUST_ACCT.REQUEST_ID,             
CUST_ACCT.PROGRAM_APPLICATION_ID,
CUST_ACCT.PROGRAM_ID, 
LOCATION.ADDRESS_LINES_PHONETIC,
CUST_ACCT.GLOBAL_ATTRIBUTE1,
CUST_ACCT.GLOBAL_ATTRIBUTE2,
CUST_ACCT.GLOBAL_ATTRIBUTE3,
CUST_ACCT.GLOBAL_ATTRIBUTE4,
CUST_ACCT.GLOBAL_ATTRIBUTE5,
CUST_ACCT.GLOBAL_ATTRIBUTE6,
CUST_ACCT.GLOBAL_ATTRIBUTE7,
CUST_ACCT.GLOBAL_ATTRIBUTE8,
CUST_ACCT.GLOBAL_ATTRIBUTE9,
CUST_ACCT.GLOBAL_ATTRIBUTE10,
CUST_ACCT.GLOBAL_ATTRIBUTE11,
CUST_ACCT.GLOBAL_ATTRIBUTE12,
CUST_ACCT.GLOBAL_ATTRIBUTE13,
CUST_ACCT.GLOBAL_ATTRIBUTE14,
CUST_ACCT.GLOBAL_ATTRIBUTE15,
CUST_ACCT.GLOBAL_ATTRIBUTE16,
CUST_ACCT.GLOBAL_ATTRIBUTE17,
CUST_ACCT.GLOBAL_ATTRIBUTE18,
CUST_ACCT.GLOBAL_ATTRIBUTE19,
CUST_ACCT.GLOBAL_ATTRIBUTE_CATEGORY,
CUST_ACCT.TP_HEADER_ID , 
CUST_ACCT.WH_UPDATE_DATE,
CUST_ACCT.GLOBAL_ATTRIBUTE20,
CUST_ACCT.ECE_TP_LOCATION_CODE,
LOCATION.SALES_TAX_GEOCODE,
LOCATION.SALES_TAX_INSIDE_CITY_LIMITS,
CUST_ACCT.TERRITORY,
CUST_ACCT.TRANSLATED_CUSTOMER_NAME,
CUST_ACCT.ADDRESS_TEXT, 
PARTY_SITE.PARTY_SITE_NUMBER, 
PARTY_SITE.IDENTIFYING_ADDRESS_FLAG,
CUST_ACCT.ATTRIBUTE16,
CUST_ACCT.ATTRIBUTE17,
CUST_ACCT.ATTRIBUTE18,
CUST_ACCT.ATTRIBUTE19,
CUST_ACCT.ATTRIBUTE20,
PARTY_SITE.LAST_UPDATE_DATE,
LOCATION.LAST_UPDATE_DATE,
PARTY_SITE.ADDRESSEE
FROM
HZ_CUST_ACCT_SITES_ALL CUST_ACCT, HZ_PARTY_SITES PARTY_SITE, HZ_LOCATIONS LOCATION, HZ_PARTIES PARTY
WHERE
LOCATION.LOCATION_ID=PARTY_SITE.LOCATION_ID AND PARTY_SITE.PARTY_ID=PARTY.PARTY_ID and CUST_ACCT.PARTY_SITE_ID=PARTY_SITE.PARTY_SITE_ID

/


REM "Creating View WM_RA_CONTACTS_VW"

CREATE OR REPLACE VIEW APPS.WM_RA_CONTACTS_VW
(CONTACT_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE,
CREATED_BY,
CUSTOMER_ID,
STATUS,
ORIG_SYSTEM_REFERENCE,
LAST_NAME,
LAST_UPDATE_LOGIN,
TITLE,
FIRST_NAME,
JOB_TITLE,
MAIL_STOP,
ADDRESS_ID,
ATTRIBUTE_CATEGORY,
ATTRIBUTE1,
ATTRIBUTE2,
ATTRIBUTE3,
ATTRIBUTE4,
ATTRIBUTE5,
ATTRIBUTE6,
ATTRIBUTE7,
ATTRIBUTE8,
ATTRIBUTE9,
ATTRIBUTE10,
REQUEST_ID,
PROGRAM_APPLICATION_ID,
PROGRAM_ID,
PROGRAM_UPDATE_DATE,
CONTACT_KEY,
CONTACT_PERSONAL_INFORMATION,
DECISION_MAKER_FLAG,
JOB_TITLE_CODE,
MANAGED_BY,
NATIVE_LANGUAGE,
REFERENCE_USE_FLAG,
CONTACT_NUMBER,
ATTRIBUTE11,
ATTRIBUTE25,
OTHER_LANGUAGE_1,
OTHER_LANGUAGE_2,
RANK,
PRIMARY_ROLE,
ATTRIBUTE12,
ATTRIBUTE13,
ATTRIBUTE14,
ATTRIBUTE15,
ATTRIBUTE16,
ATTRIBUTE17,
ATTRIBUTE18,
ATTRIBUTE19,
ATTRIBUTE20,
ATTRIBUTE21,
ATTRIBUTE22,
ATTRIBUTE23,
ATTRIBUTE24,
DO_NOT_MAIL_FLAG,
SUFFIX,
EMAIL_ADDRESS,
MAILING_ADDRESS_ID,
MATCH_GROUP_ID,
SEX_CODE,
SALUTATION,
DEPARTMENT_CODE,
DEPARTMENT,
LAST_NAME_ALT,
FIRST_NAME_ALT,
CONTACT_PARTY_ID,
ORG_CONTACT_ID,
PARTY_LAST_UPDATE_DATE,
REL_LAST_UPDATE_DATE,
ORG_CONT_LAST_UPDATE_DATE,
PARTY_RELATIONSHIP_ID
) AS 
 SELECT 
ACCT_ROLE.CUST_ACCOUNT_ROLE_ID,
ACCT_ROLE.LAST_UPDATE_DATE,
ACCT_ROLE.LAST_UPDATED_BY,
ACCT_ROLE.CREATION_DATE,
ACCT_ROLE.CREATED_BY,
ACCT_ROLE.CUST_ACCOUNT_ID,
ACCT_ROLE.STATUS,
ACCT_ROLE.ORIG_SYSTEM_REFERENCE,
substrb( PARTY.PERSON_LAST_NAME,1,50) LAST_NAME,
ORG_CONT.LAST_UPDATE_LOGIN,
PARTY.PERSON_PRE_NAME_ADJUNCT,
substrb(PARTY.PERSON_FIRST_NAME,1,40) FIRST_NAME,
ORG_CONT.JOB_TITLE,
ORG_CONT.MAIL_STOP,
ACCT_ROLE.CUST_ACCT_SITE_ID /* ADDRESS_ID */,
ACCT_ROLE.ATTRIBUTE_CATEGORY,
ACCT_ROLE.ATTRIBUTE1,
ACCT_ROLE.ATTRIBUTE2,
ACCT_ROLE.ATTRIBUTE3,
ACCT_ROLE.ATTRIBUTE4,
ACCT_ROLE.ATTRIBUTE5,
ACCT_ROLE.ATTRIBUTE6,
ACCT_ROLE.ATTRIBUTE7,
ACCT_ROLE.ATTRIBUTE8,
ACCT_ROLE.ATTRIBUTE9,
ACCT_ROLE.ATTRIBUTE10,
ACCT_ROLE.REQUEST_ID,
ACCT_ROLE.PROGRAM_APPLICATION_ID,
ACCT_ROLE.PROGRAM_ID,
ACCT_ROLE.PROGRAM_UPDATE_DATE,
PARTY.CUSTOMER_KEY,
null /*CONTACT_PERSONAL_INFORMATION*/,
ORG_CONT.DECISION_MAKER_FLAG,
ORG_CONT.JOB_TITLE_CODE,
ORG_CONT.MANAGED_BY,
PARTY.LANGUAGE_NAME NATIVE_LANGUAGE,
ORG_CONT.REFERENCE_USE_FLAG,
ORG_CONT.CONTACT_NUMBER,
ACCT_ROLE.ATTRIBUTE11,
ACCT_ROLE.ATTRIBUTE25,
null /*OTHER_LANGUAGE_1*/,
null /*OTHER_LANGUAGE_2*/,
ORG_CONT.RANK,
ACCT_ROLE.PRIMARY_FLAG,
ACCT_ROLE.ATTRIBUTE12,
ACCT_ROLE.ATTRIBUTE13,
ACCT_ROLE.ATTRIBUTE14,
ACCT_ROLE.ATTRIBUTE15,
ACCT_ROLE.ATTRIBUTE16,
ACCT_ROLE.ATTRIBUTE17,
ACCT_ROLE.ATTRIBUTE18,
ACCT_ROLE.ATTRIBUTE19,
ACCT_ROLE.ATTRIBUTE20,
ACCT_ROLE.ATTRIBUTE21,
ACCT_ROLE.ATTRIBUTE22,
ACCT_ROLE.ATTRIBUTE23,
ACCT_ROLE.ATTRIBUTE24,
PARTY.DO_NOT_MAIL_FLAG,
PARTY.PERSON_NAME_SUFFIX SUFFIX,
REL_PARTY.EMAIL_ADDRESS,
ORG_CONT.MAILING_ADDRESS_ID,
ORG_CONT.MATCH_GROUP_ID,
null /*SEX_CODE*/,
null /*SALUTATION*/,
ORG_CONT.DEPARTMENT_CODE,
ORG_CONT.DEPARTMENT,
NULL /*LAST_NAME_ALT*/,
NULL /*FIRST_NAME_ALT*/,
NULL /*CONTACT_PARTY_ID*/,
ORG_CONT.ORG_CONTACT_ID,
PARTY.LAST_UPDATE_DATE,
REL_PARTY.LAST_UPDATE_DATE,
ORG_CONT.LAST_UPDATE_DATE,
ORG_CONT.PARTY_RELATIONSHIP_ID
FROM 
HZ_CUST_ACCOUNT_ROLES ACCT_ROLE,
HZ_PARTIES PARTY,
HZ_RELATIONSHIPS REL,
HZ_ORG_CONTACTS ORG_CONT,
HZ_PARTIES REL_PARTY,
HZ_CUST_ACCOUNTS ACCT WHERE ACCT_ROLE.PARTY_ID = REL.PARTY_ID AND ACCT_ROLE.ROLE_TYPE = 'CONTACT' AND ORG_CONT.PARTY_RELATIONSHIP_ID = REL.RELATIONSHIP_ID AND REL.SUBJECT_TABLE_NAME = 'HZ_PARTIES' AND REL.OBJECT_TABLE_NAME = 'HZ_PARTIES' AND REL.SUBJECT_ID = PARTY.PARTY_ID AND REL.PARTY_ID = REL_PARTY.PARTY_ID AND REL.OBJECT_ID = ACCT.PARTY_ID AND ACCT.CUST_ACCOUNT_ID = ACCT_ROLE.CUST_ACCOUNT_ID
/


REM "Creating View WM_RA_CUSTOMER_REL_ALL_VW"

CREATE OR REPLACE VIEW APPS.WM_RA_CUSTOMER_REL_ALL_VW
(
RELATED_CUSTOMER_ID,
CUSTOMER_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE,
CREATED_BY,
LAST_UPDATE_LOGIN,
RELATIONSHIP_TYPE,
COMMENTS,
ATTRIBUTE_CATEGORY,
ATTRIBUTE1,
ATTRIBUTE2,
ATTRIBUTE3,
ATTRIBUTE4,
ATTRIBUTE5,
ATTRIBUTE6,
ATTRIBUTE7,
ATTRIBUTE8,
ATTRIBUTE9,
ATTRIBUTE10,
REQUEST_ID,
PROGRAM_APPLICATION_ID,
PROGRAM_ID,
PROGRAM_UPDATE_DATE,
CUSTOMER_RECIPROCAL_FLAG,
STATUS,
ATTRIBUTE11,
ATTRIBUTE12,
ATTRIBUTE13,
ATTRIBUTE14,
ATTRIBUTE15,
ORG_ID,
BILL_TO_FLAG,
SHIP_TO_FLAG
)
AS
SELECT
RELATED_CUST_ACCOUNT_ID,
CUST_ACCOUNT_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE,
CREATED_BY,
LAST_UPDATE_LOGIN,
RELATIONSHIP_TYPE,
COMMENTS,
ATTRIBUTE_CATEGORY,
ATTRIBUTE1,
ATTRIBUTE2,
ATTRIBUTE3,
ATTRIBUTE4,
ATTRIBUTE5,
ATTRIBUTE6,
ATTRIBUTE7,
ATTRIBUTE8,
ATTRIBUTE9,
ATTRIBUTE10,
REQUEST_ID,
PROGRAM_APPLICATION_ID,
PROGRAM_ID,
PROGRAM_UPDATE_DATE,
CUSTOMER_RECIPROCAL_FLAG,
STATUS,
ATTRIBUTE11,
ATTRIBUTE12,
ATTRIBUTE13,
ATTRIBUTE14,
ATTRIBUTE15,
ORG_ID,
BILL_TO_FLAG,
SHIP_TO_FLAG
FROM
HZ_CUST_ACCT_RELATE_ALL
/



CREATE OR REPLACE VIEW APPS.WM_RA_CUSTOMERS_VW (
CUSTOMER_ID,
PARTY_ID,
PARTY_NUMBER,
PARTY_TYPE,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE,
CREATED_BY,
CUSTOMER_NAME,
CUSTOMER_NUMBER,
ORIG_SYSTEM_REFERENCE,
STATUS,
LAST_UPDATE_LOGIN,
CUSTOMER_TYPE,
CUSTOMER_PROSPECT_CODE,
CUSTOMER_CLASS_CODE,
PRIMARY_SALESREP_ID,
SALES_CHANNEL_CODE,
SIC_CODE,
ORDER_TYPE_ID,
PRICE_LIST_ID,
ATTRIBUTE_CATEGORY,
ATTRIBUTE1,
ATTRIBUTE2,
ATTRIBUTE3,
ATTRIBUTE4,
ATTRIBUTE5,
ATTRIBUTE6,
ATTRIBUTE7,
ATTRIBUTE8,
ATTRIBUTE9,
ATTRIBUTE10,
REQUEST_ID,
PROGRAM_APPLICATION_ID,
PROGRAM_ID,
PROGRAM_UPDATE_DATE,
ANALYSIS_FY,
CUSTOMER_CATEGORY_CODE,
CUSTOMER_GROUP_CODE,
CUSTOMER_KEY,
CUSTOMER_SUBGROUP_CODE,
FISCAL_YEAREND_MONTH,
NET_WORTH,
NUM_OF_EMPLOYEES,
POTENTIAL_REVENUE_CURR_FY,
POTENTIAL_REVENUE_NEXT_FY,
RANK,
REFERENCE_USE_FLAG,
TAX_CODE,
TAX_REFERENCE,
ATTRIBUTE11,
ATTRIBUTE12,
ATTRIBUTE13,
ATTRIBUTE14,
ATTRIBUTE15,
THIRD_PARTY_FLAG,
ACCESS_TEMPLATE_ENTITY_CODE,
PRIMARY_SPECIALIST_ID,
SECONDARY_SPECIALIST_ID,
COMPETITOR_FLAG,
DUNNING_SITE_USE_ID,
STATEMENT_SITE_USE_ID,
ORIG_SYSTEM,
YEAR_ESTABLISHED,
COTERMINATE_DAY_MONTH,
FOB_POINT,
FREIGHT_TERM,
GSA_INDICATOR,
SHIP_PARTIAL,
SHIP_VIA,
WAREHOUSE_ID,
PAYMENT_TERM_ID,
TAX_EXEMPT,
TAX_EXEMPT_NUM,
TAX_EXEMPT_REASON_CODE,
JGZZ_FISCAL_CODE,
DO_NOT_MAIL_FLAG,
MISSION_STATEMENT,
CUSTOMER_NAME_PHONETIC,
TAX_HEADER_LEVEL_FLAG,
TAX_ROUNDING_RULE,
WH_UPDATE_DATE,
GLOBAL_ATTRIBUTE1,
GLOBAL_ATTRIBUTE2,
GLOBAL_ATTRIBUTE3,
GLOBAL_ATTRIBUTE4,
GLOBAL_ATTRIBUTE5,
GLOBAL_ATTRIBUTE6,
GLOBAL_ATTRIBUTE7,
GLOBAL_ATTRIBUTE8,
GLOBAL_ATTRIBUTE9,
GppLOBAL_ATTRIBUTE10,
GLOBAL_ATTRIBUTE11,
GLOBAL_ATTRIBUTE12,
GLOBAL_ATTRIBUTE13,
GLOBAL_ATTRIBUTE14,
GLOBAL_ATTRIBUTE15,
GLOBAL_ATTRIBUTE16,
GLOBAL_ATTRIBUTE17,
GLOBAL_ATTRIBUTE18,
GLOBAL_ATTRIBUTE19,
GLOBAL_ATTRIBUTE20,
GLOBAL_ATTRIBUTE_CATEGORY,
URL,
LANGUAGE,
TRANSLATED_CUSTOMER_NAME,
PERSON_PRE_NAME_ADJUNCT,
PERSON_FIRST_NAME,
PERSON_MIDDLE_NAME,
PERSON_LAST_NAME,
PERSON_SUFFIX,
PERSON_FIRST_NAME_PHONETIC,
PERSON_LAST_NAME_PHONETIC,
SHIP_SETS_INCLUDE_LINES_FLAG,
ARRIVALSETS_INCLUDE_LINES_FLAG,
SCHED_DATE_PUSH_FLAG,
OVER_SHIPMENT_TOLERANCE,
UNDER_SHIPMENT_TOLERANCE,
OVER_RETURN_TOLERANCE,
UNDER_RETURN_TOLERANCE,
ITEM_CROSS_REF_PREF,
DATE_TYPE_PREFERENCE,
DATES_NEGATIVE_TOLERANCE,
DATES_POSITIVE_TOLERANCE,
INVOICE_QUANTITY_RULE,
ATTRIBUTE16,
ATTRIBUTE17,
ATTRIBUTE18,
ATTRIBUTE19,
ATTRIBUTE20,
DUNS_NUMBER,
DUNS_NUMBER_C,
PARTY_LAST_UPDATE_DATE,
SIC_CODE_TYPE)
AS 
SELECT 
CUST_ACCT.CUST_ACCOUNT_ID,
PARTY.PARTY_ID,
PARTY.PARTY_NUMBER,
PARTY.PARTY_TYPE,
 CUST_ACCT.LAST_UPDATE_DATE ,
 CUST_ACCT.LAST_UPDATED_BY ,
 CUST_ACCT.CREATION_DATE ,
 CUST_ACCT.CREATED_BY ,
 SUBSTRB(PARTY.PARTY_NAME, 1, 50)/*customer_name*/,
 CUST_ACCT.ACCOUNT_NUMBER /*customer_number*/,
 CUST_ACCT.ORIG_SYSTEM_REFERENCE ,
 CUST_ACCT.STATUS ,
 CUST_ACCT.LAST_UPDATE_LOGIN ,
CUST_ACCT.CUSTOMER_TYPE ,
 'CUSTOMER' ,
 CUST_ACCT.CUSTOMER_CLASS_CODE ,
 CUST_ACCT.PRIMARY_SALESREP_ID ,
 CUST_ACCT.SALES_CHANNEL_CODE ,
 DECODE(PARTY.PARTY_TYPE, 'OGANIZATION', PARTY.SIC_CODE , NULL),
 CUST_ACCT.ORDER_TYPE_ID ,
 CUST_ACCT.PRICE_LIST_ID ,
 CUST_ACCT.ATTRIBUTE_CATEGORY ,
 CUST_ACCT.ATTRIBUTE1 ,
 CUST_ACCT.ATTRIBUTE2 ,
 CUST_ACCT.ATTRIBUTE3 ,
 CUST_ACCT.ATTRIBUTE4 ,
 CUST_ACCT.ATTRIBUTE5 ,
 CUST_ACCT.ATTRIBUTE6 ,
 CUST_ACCT.ATTRIBUTE7 ,
 CUST_ACCT.ATTRIBUTE8 ,
 CUST_ACCT.ATTRIBUTE9 ,
 CUST_ACCT.ATTRIBUTE10 ,
 CUST_ACCT.REQUEST_ID ,
 CUST_ACCT.PROGRAM_APPLICATION_ID ,
 CUST_ACCT.PROGRAM_ID ,
 CUST_ACCT.PROGRAM_UPDATE_DATE ,
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.ANALYSIS_FY, NULL),
 PARTY.CATEGORY_CODE ,
 NULL /*CUSTMER_GROUP_CODE*/,
 PARTY.CUSTOMER_KEY ,
 NULL /*CUSTOMER_SUBGROUP_CODE*/ ,
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.FISCAL_YEAREND_MONTH , NULL),
 TO_NUMBER(NULL) /*NET_WORTH*/ ,
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.EMPLOYEES_TOTAL, TO_NUMBER(NULL)),
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.CURR_FY_POTENTIAL_REVENUE, TO_NUMBER(NULL)),
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.NEXT_FY_POTENTIAL_REVENUE, TO_NUMBER(NULL)),
 NULL /*RANK*/ ,
 PARTY.REFERENCE_USE_FLAG ,
CUST_ACCT.TAX_CODE ,
 PARTY.TAX_REFERENCE ,
 CUST_ACCT.ATTRIBUTE11 ,
 CUST_ACCT.ATTRIBUTE12 ,
 CUST_ACCT.ATTRIBUTE13 ,
 CUST_ACCT.ATTRIBUTE14 ,
 CUST_ACCT.ATTRIBUTE15,
 PARTY.THIRD_PARTY_FLAG ,
 NULL /*ACCESS_TEMPLATE_ENTITY_CODE*/ ,
 CUST_ACCT.PRIMARY_SPECIALIST_ID ,
 CUST_ACCT.SECONDARY_SPECIALIST_ID ,
 PARTY.COMPETITOR_FLAG ,
TO_NUMBER(NULL) /*DUNNING_SITE_USE_ID*/ ,
 TO_NUMBER(NULL) /*STATEMENT_SITE_USE_ID */,
 NULL /*ORIG_SYSTEM*/ ,
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.YEAR_ESTABLISHED , TO_NUMBER(NULL)),
 CUST_ACCT.COTERMINATE_DAY_MONTH ,
 CUST_ACCT.FOB_POINT ,
 CUST_ACCT.FREIGHT_TERM ,
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.GSA_INDICATOR_FLAG , 'N'),
 CUST_ACCT.SHIP_PARTIAL ,
 CUST_ACCT.SHIP_VIA ,
 CUST_ACCT.WAREHOUSE_ID ,
 CUST_ACCT.PAYMENT_TERM_ID ,
 NULL /*TAX_EXEMPT*/ ,
 NULL /*TAX_EXEMPT_NUM*/ ,
 NULL /*TAX_EXEMPT_REASON_CODE*/ ,
 PARTY.JGZZ_FISCAL_CODE ,
 PARTY.DO_NOT_MAIL_FLAG ,
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.MISSION_STATEMENT , NULL),
 DECODE(PARTY.PARTY_TYPE, 'ORGANIZATION', PARTY.ORGANIZATION_NAME_PHONETIC , NULL),
 CUST_ACCT.TAX_HEADER_LEVEL_FLAG ,
 CUST_ACCT.TAX_ROUNDING_RULE ,
 CUST_ACCT.WH_UPDATE_DATE ,
 CUST_ACCT.GLOBAL_ATTRIBUTE1,
 CUST_ACCT.GLOBAL_ATTRIBUTE2 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE3 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE4 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE5 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE6 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE7 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE8 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE9 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE10 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE11 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE12 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE13 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE14 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE15 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE16 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE17 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE18 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE19 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE20 ,
 CUST_ACCT.GLOBAL_ATTRIBUTE_CATEGORY ,
 PARTY.URL,
NULL, 				--PARTY.LANGUAGE,
NULL,
PARTY.PERSON_PRE_NAME_ADJUNCT,
PARTY.PERSON_FIRST_NAME,
PARTY.PERSON_MIDDLE_NAME,
PARTY.PERSON_LAST_NAME,
PARTY.PERSON_NAME_SUFFIX,
PARTY.PERSON_FIRST_NAME_PHONETIC,
PARTY.PERSON_LAST_NAME_PHONETIC,
CUST_ACCT.SHIP_SETS_INCLUDE_LINES_FLAG,
CUST_ACCT.ARRIVALSETS_INCLUDE_LINES_FLAG,
CUST_ACCT.SCHED_DATE_PUSH_FLAG,
CUST_ACCT.OVER_SHIPMENT_TOLERANCE,
CUST_ACCT.UNDER_SHIPMENT_TOLERANCE,
CUST_ACCT.OVER_RETURN_TOLERANCE,
CUST_ACCT.UNDER_RETURN_TOLERANCE,
CUST_ACCT.ITEM_CROSS_REF_PREF,
CUST_ACCT.DATE_TYPE_PREFERENCE,
CUST_ACCT.DATES_NEGATIVE_TOLERANCE,
CUST_ACCT.DATES_POSITIVE_TOLERANCE,
CUST_ACCT.INVOICE_QUANTITY_RULE,
CUST_ACCT.ATTRIBUTE16,
CUST_ACCT.ATTRIBUTE17,
CUST_ACCT.ATTRIBUTE18,
CUST_ACCT.ATTRIBUTE19,
CUST_ACCT.ATTRIBUTE20,
PARTY.DUNS_NUMBER,
PARTY.DUNS_NUMBER_C,
PARTY.LAST_UPDATE_DATE,
PARTY.SIC_CODE_TYPE
 FROM APPS.HZ_PARTIES PARTY,
 APPS.HZ_CUST_ACCOUNTS CUST_ACCT WHERE CUST_ACCT.PARTY_ID=PARTY.PARTY_ID
/

CREATE OR REPLACE VIEW APPS.WM_RA_SITE_USES_ALL_VW
(
SITE_USE_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE, 
CREATED_BY,
SITE_USE_CODE,
ADDRESS_ID,  
PRIMARY_FLAG,
STATUS,
LOCATION,
LAST_UPDATE_LOGIN,
CONTACT_ID,
BILL_TO_SITE_USE_ID,
ORIG_SYSTEM_REFERENCE,
SIC_CODE,
PAYMENT_TERM_ID ,
GSA_INDICATOR  ,
SHIP_PARTIAL  ,
SHIP_VIA ,
FOB_POINT,
ORDER_TYPE_ID,
PRICE_LIST_ID,
FREIGHT_TERM ,
WAREHOUSE_ID,
TERRITORY_ID,
ATTRIBUTE_CATEGORY,
ATTRIBUTE1,
ATTRIBUTE2,
ATTRIBUTE3,
ATTRIBUTE4,
ATTRIBUTE5,
ATTRIBUTE6,
ATTRIBUTE7,
ATTRIBUTE8,
ATTRIBUTE9,
ATTRIBUTE10,
REQUEST_ID,
PROGRAM_APPLICATION_ID,
PROGRAM_ID,
PROGRAM_UPDATE_DATE,
TAX_REFERENCE,
SORT_PRIORITY,
TAX_CODE,
ATTRIBUTE11,
ATTRIBUTE12,
ATTRIBUTE13,
ATTRIBUTE14,
ATTRIBUTE15,
ATTRIBUTE16,
ATTRIBUTE17,
ATTRIBUTE18,
ATTRIBUTE19,
ATTRIBUTE20,
ATTRIBUTE21,
ATTRIBUTE22,
ATTRIBUTE23,
ATTRIBUTE24,
ATTRIBUTE25,
LAST_ACCRUE_CHARGE_DATE,
SECOND_LAST_ACCRUE_CHARGE_DATE,
LAST_UNACCRUE_CHARGE_DATE,
SECOND_LAST_UNACCRUE_CHRG_DATE,
DEMAND_CLASS_CODE,
TAX_EXEMPT ,   
TAX_EXEMPT_NUM,
TAX_EXEMPT_REASON_CODE ,
ORG_ID,
TAX_CLASSIFICATION, 
TAX_HEADER_LEVEL_FLAG,
TAX_ROUNDING_RULE,
WH_UPDATE_DATE  ,
GLOBAL_ATTRIBUTE1,
GLOBAL_ATTRIBUTE2,
GLOBAL_ATTRIBUTE3,
GLOBAL_ATTRIBUTE4,
GLOBAL_ATTRIBUTE5,
GLOBAL_ATTRIBUTE6,
GLOBAL_ATTRIBUTE7,
GLOBAL_ATTRIBUTE8,
GLOBAL_ATTRIBUTE9,
GLOBAL_ATTRIBUTE10,
GLOBAL_ATTRIBUTE11,
GLOBAL_ATTRIBUTE12,
GLOBAL_ATTRIBUTE13,
GLOBAL_ATTRIBUTE14,
GLOBAL_ATTRIBUTE15,
GLOBAL_ATTRIBUTE16,
GLOBAL_ATTRIBUTE17,
GLOBAL_ATTRIBUTE18 ,                              
GLOBAL_ATTRIBUTE19  ,                            
GLOBAL_ATTRIBUTE20   ,                         
GLOBAL_ATTRIBUTE_CATEGORY,
PRIMARY_SALESREP_ID,
FINCHRG_RECEIVABLES_TRX_ID,
GL_ID_REC,
GL_ID_REV,
GL_ID_TAX,
GL_ID_FREIGHT,
GL_ID_CLEARING,
GL_ID_UNBILLED,
GL_ID_UNEARNED,
GL_ID_UNPAID_REC,
GL_ID_REMITTANCE,
GL_ID_FACTOR,
DATES_NEGATIVE_TOLERANCE,
DATES_POSITIVE_TOLERANCE,
DATE_TYPE_PREFERENCE,
OVER_SHIPMENT_TOLERANCE ,
UNDER_SHIPMENT_TOLERANCE,
ITEM_CROSS_REF_PREF,
OVER_RETURN_TOLERANCE,
UNDER_RETURN_TOLERANCE,
SHIP_SETS_INCLUDE_LINES_FLAG,
ARRIVALSETS_INCLUDE_LINES_FLAG,
SCHED_DATE_PUSH_FLAG,
INVOICE_QUANTITY_RULE,
PRICING_EVENT
) AS 
SELECT 
SITE_USE_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY  ,                       
CREATION_DATE ,                         
CREATED_BY ,                           
SITE_USE_CODE ,                       
CUST_ACCT_SITE_ID,
PRIMARY_FLAG ,                      
STATUS ,                           
LOCATION ,                        
LAST_UPDATE_LOGIN ,              
CONTACT_ID ,                    
BILL_TO_SITE_USE_ID ,          
ORIG_SYSTEM_REFERENCE,        
SIC_CODE ,                   
PAYMENT_TERM_ID ,           
GSA_INDICATOR ,            
SHIP_PARTIAL ,            
SHIP_VIA ,               
FOB_POINT ,             
ORDER_TYPE_ID ,        
PRICE_LIST_ID,        
FREIGHT_TERM  ,     
WAREHOUSE_ID ,     
TERRITORY_ID ,                             
ATTRIBUTE_CATEGORY ,                               
ATTRIBUTE1 ,                                      
ATTRIBUTE2,                                      
ATTRIBUTE3,                                     
ATTRIBUTE4,                                    
ATTRIBUTE5,                                   
ATTRIBUTE6,                                  
ATTRIBUTE7,                                 
ATTRIBUTE8,                                
ATTRIBUTE9,                               
ATTRIBUTE10,                             
REQUEST_ID,                             
PROGRAM_APPLICATION_ID ,               
PROGRAM_ID ,                          
PROGRAM_UPDATE_DATE ,                
TAX_REFERENCE ,                     
SORT_PRIORITY ,                    
TAX_CODE ,                        
ATTRIBUTE11 ,                    
ATTRIBUTE12,                    
ATTRIBUTE13,                   
ATTRIBUTE14,                  
ATTRIBUTE15,                 
ATTRIBUTE16,                
ATTRIBUTE17,              
ATTRIBUTE18,             
ATTRIBUTE19,            
ATTRIBUTE20,           
ATTRIBUTE21,          
ATTRIBUTE22,         
ATTRIBUTE23,        
ATTRIBUTE24,       
ATTRIBUTE25,                                       
LAST_ACCRUE_CHARGE_DATE ,                         
SECOND_LAST_ACCRUE_CHARGE_DATE ,                 
LAST_UNACCRUE_CHARGE_DATE ,                     
SECOND_LAST_UNACCRUE_CHRG_DATE,                
DEMAND_CLASS_CODE ,                           
NULL /*TAX_EXEMPT*/,    
NULL /*TAX_EXEMPT_NUM  */,                       
NULL /*TAX_EXEMPT_REASON_CODE*/,                 
ORG_ID ,                                  
TAX_CLASSIFICATION ,                     
TAX_HEADER_LEVEL_FLAG ,                 
TAX_ROUNDING_RULE ,                    
WH_UPDATE_DATE,                       
GLOBAL_ATTRIBUTE1 ,                  
GLOBAL_ATTRIBUTE2 ,                 
GLOBAL_ATTRIBUTE3 ,                
GLOBAL_ATTRIBUTE4 ,               
GLOBAL_ATTRIBUTE5 ,              
GLOBAL_ATTRIBUTE6 ,             
GLOBAL_ATTRIBUTE7 ,            
GLOBAL_ATTRIBUTE8 ,           
GLOBAL_ATTRIBUTE9 ,          
GLOBAL_ATTRIBUTE10 ,        
GLOBAL_ATTRIBUTE11 ,       
GLOBAL_ATTRIBUTE12 ,      
GLOBAL_ATTRIBUTE13 ,     
GLOBAL_ATTRIBUTE14 ,    
GLOBAL_ATTRIBUTE15 ,   
GLOBAL_ATTRIBUTE16 ,  
GLOBAL_ATTRIBUTE17 ,                               
GLOBAL_ATTRIBUTE18 ,                              
GLOBAL_ATTRIBUTE19 ,                             
GLOBAL_ATTRIBUTE20 ,                           
GLOBAL_ATTRIBUTE_CATEGORY ,                   
PRIMARY_SALESREP_ID ,                        
FINCHRG_RECEIVABLES_TRX_ID ,                
GL_ID_REC ,                                
GL_ID_REV ,                               
GL_ID_TAX ,                              
GL_ID_FREIGHT ,                         
GL_ID_CLEARING ,                       
GL_ID_UNBILLED  ,                     
GL_ID_UNEARNED  ,                    
GL_ID_UNPAID_REC ,                  
GL_ID_REMITTANCE  ,                
GL_ID_FACTOR ,                    
DATES_NEGATIVE_TOLERANCE ,       
DATES_POSITIVE_TOLERANCE ,      
DATE_TYPE_PREFERENCE ,         
OVER_SHIPMENT_TOLERANCE ,     
UNDER_SHIPMENT_TOLERANCE ,   
ITEM_CROSS_REF_PREF ,       
OVER_RETURN_TOLERANCE ,    
UNDER_RETURN_TOLERANCE,   
SHIP_SETS_INCLUDE_LINES_FLAG ,                      
ARRIVALSETS_INCLUDE_LINES_FLAG,                    
SCHED_DATE_PUSH_FLAG ,                            
INVOICE_QUANTITY_RULE ,                          
PRICING_EVENT
FROM HZ_CUST_SITE_USES_ALL
/
