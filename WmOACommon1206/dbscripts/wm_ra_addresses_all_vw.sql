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
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     09-APR-09	Telagareddy Sriram Mohan   Created
    ***************************************************************************
*/

set feedback  on
set verify            off
set newpage   0
set pause             off
set termout   on

prompt Program : ra_contacts_vw.sql
  
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
