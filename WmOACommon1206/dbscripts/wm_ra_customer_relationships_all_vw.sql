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
    * Program Name:         ra_customer_relationships_all_vw.sql
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

prompt Program : ra_customer_relationships_all_vw.sql
  
connect &&apps_user/&&appspwd@&&DBString 

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
