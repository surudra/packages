/*  ***************************************************************************
    *    $Date:   14 Aug 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *                           - COPYRIGHT NOTICE -
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Creates Tables for Price Request Query
    * Program Name:         wm_from_priceRequest_tbl.sql
    * Version #:            1.0
    * Title:                Custom Tables for Price Request API
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Creates WM_LINE_TBL table in Custom (webmethods) Schema.
    * 			    Creates WM_QUAL_TBL table in Custom (webmethods) Schema.    
    * 			    Creates WM_LINE_ATTR_TBL table in Custom (webmethods) Schema.    
    * 			    Creates WM_LINE_DETAIL_TBL table in Custom (webmethods) Schema.    
    * 			    Creates WM_LINE_DETAIL_QUAL_TBL table in Custom (webmethods) Schema.    
    * 			    Creates WM_LINE_DETAIL_ATTR_TBL table in Custom (webmethods) Schema.    
    * 			    Creates WM_RELATED_LINES_TBL table in Custom (webmethods) Schema.    
    *
    * Tables usage:             
    *   
    *
    * Procedures And Functions:         
    *
    *
    * Restart Information:      
    *
    *
    * Flexfields Used:          
    *
    *
    * Value Sets Used:          
    *
    *
    * Input Parameters:         
    *
    *           Param1: &SpoolFile     
    *           Param2: &CustomUser
    *           Param3: &CustomUser Password    
    *           Param4: &Custom Tablespace
    *           Param5: &Custom Indexspace
    *
    * Menu Responsibilities And path: 
    *
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:           
    *
    *==========================================================================
    * Date         | Name               | Remarks 
    *==========================================================================
    *15-NOV-2002    				Created
    ***************************************************************************
*/


set feedback    on
set verify              off
set newpage     0
set pause               off
set termout     on

prompt Program : wm_from_priceRequest_tbl.sql

-- 
-- Connect to Custom User Account And create the table and indexes
--

connect &&custom_user/&&custom_password@&&DBString

/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_LINE_TBL 
/*----------------------------------------------------------------------*/

DROP TABLE WM_LINE_TBL 
/

CREATE TABLE WM_LINE_TBL (
REQUEST_TYPE_CODE       VARCHAR2(30)  ,
 PRICING_EVENT           VARCHAR2(30)  ,
 HEADER_ID               NUMBER        ,
 LINE_INDEX              NUMBER        ,
 LINE_ID                 NUMBER        ,
 LINE_TYPE_CODE          VARCHAR2(30)  ,
 PRICING_EFFECTIVE_DATE  DATE          ,
 ACTIVE_DATE_FIRST       DATE          ,
 ACTIVE_DATE_FIRST_TYPE  VARCHAR2(30)  ,
 ACTIVE_DATE_SECOND      DATE          ,
 ACTIVE_DATE_SECOND_TYPE VARCHAR2(30)  ,
 LINE_QUANTITY           NUMBER        ,
 LINE_UOM_CODE           VARCHAR2(30)  ,
 UOM_QUANTITY            NUMBER        ,
 PRICED_QUANTITY         NUMBER        ,
 PRICED_UOM_CODE         VARCHAR2(30)  ,
 CURRENCY_CODE           VARCHAR2(30)  ,
 UNIT_PRICE              NUMBER        ,
 PERCENT_PRICE           NUMBER        ,
 ADJUSTED_UNIT_PRICE     NUMBER        ,
 UPDATED_ADJUSTED_UNIT_PRICE     NUMBER        ,
 PARENT_PRICE            NUMBER        ,
 PARENT_QUANTITY         NUMBER        ,
 ROUNDING_FACTOR         NUMBER        ,
 PARENT_UOM_CODE         VARCHAR2(30)  ,
 PRICING_PHASE_ID        NUMBER        ,
 PRICE_FLAG              VARCHAR2(1)   ,
 PROCESSED_CODE          VARCHAR2(240)   ,
 PRICE_REQUEST_CODE      VARCHAR2(240)   ,
 HOLD_CODE               VARCHAR2(240) ,
 HOLD_TEXT               VARCHAR2(2000) ,
 STATUS_CODE             VARCHAR2(30)  ,
 STATUS_TEXT             VARCHAR2(2000)  ,
 USAGE_PRICING_TYPE      VARCHAR2(30) ,
 LINE_CATEGORY           VARCHAR2(30) )TABLESPACE &&custom_tablespace
/

/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_QUAL_TBL 
/*----------------------------------------------------------------------*/

DROP TABLE WM_QUAL_TBL 
/

CREATE TABLE WM_QUAL_TBL (
LINE_INDEX		       NUMBER       ,
 QUALIFIER_CONTEXT             VARCHAR2(30) ,
 QUALIFIER_ATTRIBUTE           VARCHAR2(30) ,
 QUALIFIER_ATTR_VALUE_FROM     VARCHAR2(240) ,
 QUALIFIER_ATTR_VALUE_TO       VARCHAR2(240) ,
 COMPARISON_OPERATOR_CODE      VARCHAR2(30) ,
 VALIDATED_FLAG                VARCHAR2(1)  ,
 STATUS_CODE                   VARCHAR2(30) ,
 STATUS_TEXT                   VARCHAR2(240) )TABLESPACE &&custom_tablespace 
/

/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_LINE_ATTR_TBL 
/*----------------------------------------------------------------------*/

DROP TABLE WM_LINE_ATTR_TBL 
/

CREATE TABLE WM_LINE_ATTR_TBL (
LINE_INDEX         NUMBER        ,
 PRICING_CONTEXT    VARCHAR2(30)  ,
 PRICING_ATTRIBUTE  VARCHAR2(30)  ,
 PRICING_ATTR_VALUE_FROM VARCHAR2(240)  ,
 PRICING_ATTR_VALUE_TO   VARCHAR2(240)  ,
 VALIDATED_FLAG     VARCHAR2(1)  ,
 STATUS_CODE             VARCHAR2(30)  ,
 STATUS_TEXT             VARCHAR2(240)   )TABLESPACE &&custom_tablespace 
/


/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_LINE_DETAIL_TBL 
/*----------------------------------------------------------------------*/

DROP TABLE WM_LINE_DETAIL_TBL 
/

CREATE TABLE WM_LINE_DETAIL_TBL (
LINE_DETAIL_INDEX      NUMBER,
 LINE_DETAIL_ID         NUMBER,
 LINE_DETAIL_TYPE_CODE  VARCHAR2(30),
 LINE_INDEX             NUMBER,
 LIST_HEADER_ID         NUMBER,
 LIST_LINE_ID           NUMBER,
 LIST_LINE_TYPE_CODE    VARCHAR2(30),
 SUBSTITUTION_TYPE_CODE VARCHAR2(30),  --obsoleting
 SUBSTITUTION_FROM      VARCHAR2(240), --obsoleting
 SUBSTITUTION_TO        VARCHAR2(240),
 AUTOMATIC_FLAG         VARCHAR2(1),
 OPERAND_CALCULATION_CODE VARCHAR2(30),  --added for pricing engine internal use only
 OPERAND_VALUE          NUMBER,          --added for pricing engine internal use only
 PRICING_GROUP_SEQUENCE NUMBER,          --added for pricing engine internal use only
 PRICE_BREAK_TYPE_CODE  VARCHAR2(30),    --added for pricing engine internal use only
 CREATED_FROM_LIST_TYPE_CODE   VARCHAR2(30),
 PRICING_PHASE_ID       NUMBER,
 LIST_PRICE             NUMBER,
 LINE_QUANTITY          NUMBER,
 ADJUSTMENT_AMOUNT      NUMBER,
 APPLIED_FLAG           VARCHAR2(1),
 MODIFIER_LEVEL_CODE    VARCHAR2(30),
 STATUS_CODE            VARCHAR2(30),
 STATUS_TEXT            VARCHAR2(2000),
--new addition might need to add
 SUBSTITUTION_ATTRIBUTE VARCHAR2(240),
 ACCRUAL_FLAG           VARCHAR2(1),
 LIST_LINE_NO           VARCHAR2(240),
 ESTIM_GL_VALUE          NUMBER,
 ACCRUAL_CONVERSION_RATE NUMBER,
--Pass throuh components
 OVERRIDE_FLAG          VARCHAR2(1),
 PRINT_ON_INVOICE_FLAG  VARCHAR2(1),
 INVENTORY_ITEM_ID      NUMBER,
 ORGANIZATION_ID        NUMBER,
 RELATED_ITEM_ID        NUMBER,
 RELATIONSHIP_TYPE_ID   NUMBER,
 --ACCRUAL_QTY                NUMBER,
 --ACCRUAL_UOM_CODE           VARCHAR2(3),
 ESTIM_ACCRUAL_RATE           NUMBER,
 EXPIRATION_DATE              DATE,
 BENEFIT_PRICE_LIST_LINE_ID  NUMBER,
 RECURRING_FLAG               VARCHAR2(1),
 BENEFIT_LIMIT                NUMBER,
 CHARGE_TYPE_CODE             VARCHAR2(30),
 CHARGE_SUBTYPE_CODE          VARCHAR2(30),
 INCLUDE_ON_RETURNS_FLAG      VARCHAR2(1),
 BENEFIT_QTY                  NUMBER,
 BENEFIT_UOM_CODE             VARCHAR2(3),
 PRORATION_TYPE_CODE          VARCHAR2(30),
 SOURCE_SYSTEM_CODE           VARCHAR2(30),
 REBATE_TRANSACTION_TYPE_CODE VARCHAR2(30),
 SECONDARY_PRICELIST_IND      VARCHAR2(1),
 GROUP_VALUE                  NUMBER, -- This is used for LUMPSUM calculation for LINEGRP kind of modifiers
 COMMENTS                     VARCHAR2(2000),
 UPDATED_FLAG                 VARCHAR2(1),
 PROCESS_CODE                 VARCHAR2(30),
 LIMIT_CODE                   VARCHAR2(30),
 LIMIT_TEXT                   VARCHAR2(240),
 FORMULA_ID                   NUMBER,
 CALCULATION_CODE             VARCHAR2(30)
)TABLESPACE &&custom_tablespace 
/


/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_LINE_DETAIL_QUAL_TBL 
/*----------------------------------------------------------------------*/

DROP TABLE WM_LINE_DETAIL_QUAL_TBL 
/

CREATE TABLE WM_LINE_DETAIL_QUAL_TBL (
LINE_DETAIL_INDEX          NUMBER,
 QUALIFIER_CONTEXT          VARCHAR2(30),
 QUALIFIER_ATTRIBUTE        VARCHAR2(30),
 QUALIFIER_ATTR_VALUE_FROM  VARCHAR2(240),
 QUALIFIER_ATTR_VALUE_TO    VARCHAR2(240),
 COMPARISON_OPERATOR_CODE   VARCHAR2(30),
 VALIDATED_FLAG             VARCHAR2(1),
 STATUS_CODE             VARCHAR2(30),
 STATUS_TEXT             VARCHAR2(240)   )TABLESPACE &&custom_tablespace 
/


/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_LINE_DETAIL_ATTR_TBL 
/*----------------------------------------------------------------------*/

DROP TABLE WM_LINE_DETAIL_ATTR_TBL 
/

CREATE TABLE WM_LINE_DETAIL_ATTR_TBL (
LINE_DETAIL_INDEX      NUMBER,
 PRICING_CONTEXT     VARCHAR2(30),
 PRICING_ATTRIBUTE   VARCHAR2(30),
 PRICING_ATTR_VALUE_FROM  VARCHAR2(240),
 PRICING_ATTR_VALUE_TO  VARCHAR2(240),
 VALIDATED_FLAG      VARCHAR2(1),
 STATUS_CODE             VARCHAR2(30),
 STATUS_TEXT             VARCHAR2(240) )TABLESPACE &&custom_tablespace 
/


/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_RELATED_LINES_TBL 
/*----------------------------------------------------------------------*/

DROP TABLE WM_RELATED_LINES_TBL 
/

CREATE TABLE WM_RELATED_LINES_TBL (
LINE_INDEX              NUMBER,
 LINE_DETAIL_INDEX          NUMBER,
 RELATIONSHIP_TYPE_CODE  VARCHAR2(30),
 RELATED_LINE_INDEX         NUMBER,
 RELATED_LINE_DETAIL_INDEX     NUMBER,
 STATUS_CODE             VARCHAR2(30),
 STATUS_TEXT             VARCHAR2(240) )TABLESPACE &&custom_tablespace 
/


/*----------------------------------------------------------------------*/
--      Give grant all on custom data objects to APPS User
/*----------------------------------------------------------------------*/

grant all on WM_LINE_TBL to &&apps_user with grant option
/
grant all on WM_QUAL_TBL to &&apps_user with grant option
/
grant all on WM_LINE_ATTR_TBL to &&apps_user with grant option
/
grant all on WM_LINE_DETAIL_TBL to &&apps_user with grant option
/
grant all on WM_LINE_DETAIL_QUAL_TBL to &&apps_user with grant option
/
grant all on WM_LINE_DETAIL_ATTR_TBL to &&apps_user with grant option
/
grant all on WM_RELATED_LINES_TBL to &&apps_user with grant option
/