/*  ***************************************************************************
    *    $Date:   08 Nov 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Customer outbound in Application Schema  
    * Program Name:         wm_from_customer_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Customer Outbound
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
     08-NOV-02	 Gautam Naha   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_customer_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."


/*----------------------------------------------------------------------*/
--      Create View WM_AR_CUSTOMERS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AR_CUSTOMERS_VW ( WEB_TRANSACTION_ID,DOCUMENT_TYPE,DOCUMENT_STATUS, CUSTOMER_ID, CUSTOMER_NAME, 
CUSTOMER_NUMBER, CUSTOMER_KEY,   CUSTOMER_STATUS, ORIG_SYSTEM_REFERENCE, 
CUSTOMER_PROSPECT_CODE, CUSTOMER_CATEGORY_CODE,   CUSTOMER_CATEGORY_MEANING, 
CUSTOMER_CLASS_CODE, CUSTOMER_CLASS_MEANING, CUSTOMER_TYPE,   
CUSTOMER_TYPE_MEANING, PRIMARY_SALESREP_ID, PRIMARY_SALESREP_NAME, SIC_CODE,   
TAX_REFERENCE, TAX_CODE, FOB_POINT, FOB_POINT_MEANING,   SHIP_VIA, 
GSA_INDICATOR, SHIP_PARTIAL, TAXPAYER_ID,   PRICE_LIST_ID, PRICE_LIST_NAME, 
FREIGHT_TERM, FREIGHT_TERM_MEANING,   ORDER_TYPE_ID, ORDER_TYPE_NAME, 
SALES_CHANNEL_CODE, SALES_CHANNEL_MEANING,   WAREHOUSE_ID, WAREHOUSE_NAME, 
MISSION_STATEMENT, NUM_OF_EMPLOYEES,   POTENTIAL_REVENUE_CURR_FY, 
POTENTIAL_REVENUE_NEXT_FY, FISCAL_YEAREND_MONTH, YEAR_ESTABLISHED,   
ANALYSIS_FY, COMPETITOR_FLAG, REFERENCE_USE_FLAG, THIRD_PARTY_FLAG,   
CUSTOMER_PROFILE_CLASS_ID, PROFILE_CLASS_NAME, 
CUSTOMER_NAME_PHONETIC,   TAX_HEADER_LEVEL_FLAG, TAX_ROUNDING_RULE ) 
AS SELECT 
  wmtc.web_transaction_id   web_transaction_id ,
  wmtc.transaction_type     document_type,
  DECODE((wmtc.transaction_status),0,'UPDATE',1,'INSERT',2,'DELETE') document_status,
  cust.customer_id			customer_id,
  cust.customer_name			customer_name,
  cust.customer_number			customer_number,
  cust.customer_key			customer_key,
  cust.status				status,
  cust.orig_system_reference		orig_system_reference,
  cust.customer_prospect_code		customer_prospect_code,
  cust.customer_category_code		customer_category_code,
  l_cat.meaning				customer_category_meaning,
  cust.customer_class_code		customer_class_code,
  l_class.meaning				customer_class_meaning,
  cust.customer_type			customer_type,
  l_type.meaning				customer_type_meaning,
  cust.primary_salesrep_id		primary_salesrep_id,
  rep.name				primary_salesrep_name,
  cust.sic_code				sic_code,
  cust.tax_reference			tax_reference,
  cust.tax_code				tax_code,
  cust.fob_point				fob_point,
  l_fob.meaning				fob_point_meaning,
  cust.ship_via				ship_via,
  cust.gsa_indicator			gsa_indicator,
  cust.ship_partial			ship_partial,
  cust.jgzz_fiscal_code			taxpayer_id,
  cust.price_list_id			price_list_id,
  pl.name					price_list_name,
  cust.freight_term			freight_term,
  l_ft.meaning				freight_term_meaning,
  cust.order_type_id			order_type_id,
  ot.name					order_type_name,
  cust.sales_channel_code			sales_channel_code,
  l_sc.meaning				sales_channel_meaning,
  cust.warehouse_id			warehouse_id,
  org.name				warehouse_name,
  cust.mission_statement			mission_statement,
  cust.num_of_employees			num_of_employees,
  cust.potential_revenue_curr_fy		potential_revenue_curr_fy,
  cust.potential_revenue_next_fy		potential_revenue_next_fy,
  cust.fiscal_yearend_month		fiscal_yearend_month,
  cust.year_established			year_established,
  cust.analysis_fy			analysis_fy,
  cust.competitor_flag			competitor_flag,
  cust.reference_use_flag			reference_use_flag,
  cust.third_party_flag			third_party_flag,
  cpc.customer_profile_class_id		customer_profile_class_id,
  cpc.name				profile_class_name,
  cust.customer_name_phonetic             customer_name_phonetic,
  cust.tax_header_level_flag              tax_header_level_flag,
  cust.tax_rounding_rule                  tax_rounding_rule
FROM 
  ar_lookups   l_cat,
  ar_lookups   l_class,
  ar_lookups   l_type,
  ra_salesreps_all rep,
  ar_lookups l_fob,
  so_price_lists pl,
  so_lookups l_ft,
  so_order_types_all ot,
  so_lookups l_sc,
  hr_organization_units org,
  ar_customer_profile_classes cpc,
  ar_customer_profiles cp,
  ra_customers cust,
  wm_track_changes_vw wmtc
WHERE 
  cust.customer_category_code	= l_cat.lookup_code(+)  AND
  l_cat.lookup_type(+)		= 'CUSTOMER_CATEGORY'  AND
  cust.customer_class_code	= l_class.lookup_code(+)  AND
  l_class.lookup_type(+)		= 'CUSTOMER CLASS'  AND
  cust.customer_type	        = l_type.lookup_code(+)  AND
  l_type.lookup_type(+)		= 'CUSTOMER_TYPE'  AND
  cust.primary_salesrep_id	= rep.salesrep_id(+)  AND
  cust.fob_point			= l_fob.lookup_code(+)  AND
  l_fob.lookup_type(+) 		= 'FOB'  AND
  cust.price_list_id              = pl.price_list_id(+)  AND
  cust.freight_term		= l_ft.lookup_code(+)  AND
  l_ft.lookup_type(+)		= 'FREIGHT_TERMS'  AND
  cust.order_type_id              = ot.order_type_id(+)  AND
  cust.sales_channel_code		= l_sc.lookup_code(+)  AND
  l_sc.lookup_type(+)		= 'SALES_CHANNEL'  AND
  cust.warehouse_id		= org.organization_id(+)  AND
  cp.customer_id			= cust.customer_id  AND
  cp.site_use_id			IS NULL  AND
  cp.customer_profile_class_id    = cpc.customer_profile_class_id(+) AND
  cust.customer_id = wmtc.transaction_id AND
  transaction_status <= 2 AND
  wmtc.transaction_type = 'CUSTOMER'
/


/*----------------------------------------------------------------------*/
--      Create View WM_CUST_PHONES_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_CUST_PHONES_VW ( 
PHONE_ID, PHONE_NUMBER, STATUS, PHONE_TYPE, 
CUSTOMER_ID, ADDRESS_ID, 
CONTACT_ID, AREA_CODE, EXTENSION, PRIMARY_FLAG, 
ORIG_SYSTEM_REFERENCE ) 
AS SELECT
   phon.phone_id
    ,phon.phone_number
    ,phon.status
    ,phon.phone_type
    ,phon.customer_id
    ,phon.address_id
    ,phon.contact_id
    ,phon.area_code
    ,phon.extension
    ,phon.primary_flag
    ,phon.orig_system_reference
   FROM ra_phones  phon,
     ar_lookups  look
WHERE phon.phone_type     = look.lookup_code
AND   look.lookup_type    = 'COMMUNICATION_TYPE'
/

/*----------------------------------------------------------------------*/
--      Create View WM_CONT_PHONES_VW 
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_CONT_PHONES_VW ( 
PHONE_ID, PHONE_NUMBER, STATUS, PHONE_TYPE, 
CUSTOMER_ID, ADDRESS_ID, 
CONTACT_ID, AREA_CODE, EXTENSION, PRIMARY_FLAG, 
ORIG_SYSTEM_REFERENCE ) 
AS SELECT
   phon.phone_id
    ,phon.phone_number
    ,phon.status
    ,phon.phone_type
    ,phon.customer_id
    ,phon.address_id
    ,phon.contact_id
    ,phon.area_code
    ,phon.extension
    ,phon.primary_flag
    ,phon.orig_system_reference
   FROM ra_phones  phon,
     ar_lookups  look
WHERE phon.phone_type     = look.lookup_code
AND   look.lookup_type    = 'COMMUNICATION_TYPE'
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_SITE_USES_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AR_SITE_USES_VW (  
SITE_USE_ID, SITE_USE_CODE, SITE_USE_MEANING, ADDRESS_ID, 
PRIMARY_FLAG, STATUS, LOCATION, CONTACT_ID, CONTACT_NAME, BILL_TO_SITE_USE_ID, BILL_TO_LOCATION, 
ORIG_SYSTEM_REFERENCE, SIC_CODE, PAYMENT_TERM_ID, PAYMENT_TERM_NAME, 
GSA_INDICATOR, SHIP_PARTIAL, SHIP_VIA, FOB_POINT, 
FOB_POINT_MEANING, ORDER_TYPE_ID, ORDER_TYPE_NAME, PRICE_LIST_ID, 
PRICE_LIST_NAME, FREIGHT_TERM, FREIGHT_TERM_MEANING, WAREHOUSE_ID, 
WAREHOUSE_NAME, TERRITORY_ID, TAX_REFERENCE, TAX_CODE, DEMAND_CLASS_CODE, DEMAND_CLASS_MEANING, 
INVENTORY_LOCATION_ID, INVENTORY_LOCATION_CODE, INVENTORY_ORGANIZATION_ID, INVENTORY_ORGANIZATION_NAME, 
TAX_CLASSIFICATION, TAX_HEADER_LEVEL_FLAG, TAX_ROUNDING_RULE ) 
AS SELECT
     su.site_use_id
     ,su.site_use_code
     ,l_su.meaning
     ,su.address_id
     ,su.primary_flag
     ,su.status
     ,su.location
     ,su.contact_id
     ,DECODE(cont.contact_id,NULL,NULL,cont.last_name || ', ' || cont.first_name)
     ,su.bill_to_site_use_id
     ,su_bill.location
     ,su.orig_system_reference
     ,su.sic_code
     ,su.payment_term_id
     ,term.name
     ,su.gsa_indicator
     ,su.ship_partial
     ,su.ship_via
     ,su.fob_point
     ,l_fob.meaning
     ,su.order_type_id
     ,ordt.name
     ,su.price_list_id
     ,list.name
     ,su.freight_term
     ,l_ft.meaning
     ,su.warehouse_id
     ,org.name
     ,su.territory_id
     ,su.tax_reference
     ,su.tax_code
     ,su.demand_class_code
     ,comm.meaning
     ,hrl.location_id
     ,hrl.location_code
     ,inv_org.organization_id
     ,inv_org.name
     ,su.tax_classification
     ,su.tax_header_level_flag
     ,su.tax_rounding_rule
   FROM
    ra_site_uses_all  su,
    ra_site_uses_all  su_bill,
    ar_lookups	  l_su,
    ra_terms      term,
    ar_lookups    l_fob,
    ra_contacts   cont,
    fnd_common_lookups  comm,
    so_lookups    l_ft,
    hr_organization_units  org,
    so_order_types_all  ordt,
    so_price_lists  list,
    po_location_associations pla,
    hr_locations hrl,
    hr_organization_units inv_org
 WHERE su.bill_to_site_use_id 		= su_bill.site_use_id(+)
 AND   su.site_use_code 		= l_su.lookup_code(+)
 AND   l_su.lookup_type(+) 		= 'SITE_USE_CODE'
 AND   su.payment_term_id 		= term.term_id(+)
 AND   su.fob_point 			= l_fob.lookup_code(+)
 AND   l_fob.lookup_type(+) 		= 'FOB'
 AND   su.contact_id 			= cont.contact_id(+)
 AND   su.demand_class_code 		= comm.lookup_code(+)
 AND   comm.lookup_type(+) 		= 'DEMAND_CLASS'
 AND   su.freight_term 			= l_ft.lookup_code(+)
 AND   l_ft.lookup_type(+) 		= 'FREIGHT_TERMS'
 AND   su.warehouse_id 			= org.organization_id(+)
 AND   su.order_type_id 		= ordt.order_type_id(+)
 AND   su.price_list_id	 		= list.price_list_id(+)
 AND   su.site_use_id			= pla.site_use_id(+)
 AND   pla.location_id			= hrl.location_id(+)
 AND   pla.organization_id		= inv_org.organization_id(+)
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_CUST_RELATIONSHIPS_VW 
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_AR_CUST_RELATIONSHIPS_VW ( 
RELATED_CUSTOMER_ID, 
CUSTOMER_ID, 
RELATIONSHIP_TYPE_CODE, 
RELATED_CUSTOMER_NAME, 
RELATED_CUSTOMER_NUMBER, 
STATUS, 
COMMENTS, 
CUSTOMER_RECIPROCAL_FLAG, 
RELATIONSHIP_TYPE, 
RELATIONSHIP_TYPE_MEANING 
) AS SELECT
     REL.RELATED_CUSTOMER_ID
     ,REL.CUSTOMER_ID
     ,REL.RELATIONSHIP_TYPE
     ,CUST.CUSTOMER_NAME
     ,CUST.CUSTOMER_NUMBER
     ,REL.STATUS
     ,REL.COMMENTS
     ,REL.CUSTOMER_RECIPROCAL_FLAG
     ,rel.relationship_type
     ,l.meaning
    FROM
    RA_CUSTOMER_RELATIONSHIPS_ALL  REL,
    RA_CUSTOMERS  CUST,
    ar_lookups l
 WHERE REL.RELATED_CUSTOMER_ID = CUST.CUSTOMER_ID
 AND l.lookup_code	= rel.relationship_type
 AND l.lookup_type	= 'RELATIONSHIP_TYPE'
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_CUST_RECEIPT_METHODS_VW
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_AR_CUST_RECEIPT_METHODS_VW ( CUST_RECEIPT_METHOD_ID, 
CUSTOMER_ID, SITE_USE_ID, PRIMARY_FLAG, RECEIPT_METHOD_ID, 
RECEIPT_METHOD_NAME, START_DATE, END_DATE, CHECK_RELATION_ID ) AS SELECT   
CRM.CUST_RECEIPT_METHOD_ID ,   
CRM.CUSTOMER_ID ,  
CRM.SITE_USE_ID ,  
CRM.PRIMARY_FLAG ,   
CRM.RECEIPT_METHOD_ID ,   
RM.NAME ,   
CRM.START_DATE ,   
CRM.END_DATE,
DECODE(CRM.SITE_USE_ID,NULL,CRM.CUSTOMER_ID,NULL)  
FROM   
RA_CUST_RECEIPT_METHODS CRM,   
AR_RECEIPT_METHODS RM   
WHERE   
RM.RECEIPT_METHOD_ID = CRM.RECEIPT_METHOD_ID
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_CUST_BANK_ACCOUNTS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AR_CUST_BANK_ACCOUNTS_VW ( BANK_ACCOUNT_USES_ID, 
CUSTOMER_ID, BANK_ACCOUNT_ID, BANK_BRANCH_ID, CUSTOMER_SITE_USE_ID, 
EXTERNAL_BANK_ACCOUNT_ID, START_DATE, END_DATE, PRIMARY_FLAG, 
BANK_NUMBER, BANK_NAME, BANK_BRANCH_NAME, BANK_BRANCH_NUM, 
BANK_BRANCH_DESCRIPTION, BANK_ACCOUNT_NAME, BANK_ACCOUNT_NUM, BANK_ACCOUNT_DESCRIPTION, 
BANK_CURRENCY_CODE, BANK_ACCOUNT_INACTIVE_DATE, BANK_BRANCH_ADDRESS1, BANK_BRANCH_ADDRESS2, 
BANK_BRANCH_ADDRESS3, BANK_BRANCH_ADDRESS4, BANK_BRANCH_CITY, BANK_BRANCH_STATE, 
BANK_BRANCH_ZIP, BANK_BRANCH_PROVINCE, BANK_BRANCH_COUNTRY, BANK_BRANCH_AREA_CODE, 
BANK_BRANCH_PHONE, BANK_BRANCH_COUNTY, BANK_BRANCH_EFT_USER_NUMBER, BANK_ACCOUNT_CHECK_DIGITS,
CHECK_RELATION_ID
 ) AS SELECT  
BAUSES.BANK_ACCOUNT_USES_ID ,  
BAUSES.CUSTOMER_ID ,  
BACCT.BANK_ACCOUNT_ID ,  
BBNCH.BANK_BRANCH_ID ,  
BAUSES.CUSTOMER_SITE_USE_ID ,  
BAUSES.EXTERNAL_BANK_ACCOUNT_ID ,  
BAUSES.START_DATE ,  
BAUSES.END_DATE ,  
BAUSES.PRIMARY_FLAG ,  
BBNCH.BANK_NUMBER ,  
BBNCH.BANK_NAME ,  
BBNCH.BANK_BRANCH_NAME ,  
BBNCH.BANK_NUM ,  
BBNCH.DESCRIPTION ,  
BACCT.BANK_ACCOUNT_NAME ,  
BACCT.BANK_ACCOUNT_NUM,  
BACCT.DESCRIPTION ,  
BACCT.CURRENCY_CODE,  
BACCT.INACTIVE_DATE,  
BBNCH.ADDRESS_LINE1,  
BBNCH.ADDRESS_LINE2,  
BBNCH.ADDRESS_LINE3,  
BBNCH.ADDRESS_LINE4,  
BBNCH.CITY,  
BBNCH.STATE,  
BBNCH.ZIP,  
BBNCH.PROVINCE,  
BBNCH.COUNTRY,  
BBNCH.AREA_CODE,  
BBNCH.PHONE,  
BBNCH.COUNTY,  
BBNCH.EFT_USER_NUMBER,  
BACCT.CHECK_DIGITS,
DECODE(BAUSES.CUSTOMER_SITE_USE_ID,NULL,BAUSES.CUSTOMER_ID,NULL)
FROM  
AP_BANK_ACCOUNT_USES_ALL BAUSES,  
AP_BANK_BRANCHES BBNCH,  
AP_BANK_ACCOUNTS_ALL BACCT  
WHERE  
BAUSES.EXTERNAL_BANK_ACCOUNT_ID = BACCT.BANK_ACCOUNT_ID AND  
BACCT.BANK_BRANCH_ID = BBNCH.BANK_BRANCH_ID
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_CUSTOMER_PROF_AMTS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AR_CUSTOMER_PROF_AMTS_VW ( CUSTOMER_PROFILE_AMOUNT_ID, 
CUSTOMER_PROFILE_ID, CUSTOMER_ID, CUSTOMER_SITE_USE_ID, CURRENCY_CODE, 
TRX_CREDIT_LIMIT, OVERALL_CREDIT_LIMIT, MIN_DUNNING_AMOUNT, MIN_DUNNING_INVOICE_AMOUNT, 
MAX_INTEREST_CHARGE, MIN_STATEMENT_AMOUNT, AUTO_REC_MIN_RECEIPT_AMOUNT, INTEREST_RATE, 
MIN_FC_BALANCE_AMOUNT, MIN_FC_INVOICE_AMOUNT, CHECK_RELATION_ID ) AS SELECT   
CUSTOMER_PROFILE_AMOUNT_ID,
CUSTOMER_PROFILE_ID ,  
CUSTOMER_ID  ,   
CUSTOMER_SITE_USE_ID  ,  
CURRENCY_CODE ,   
TRX_CREDIT_LIMIT ,   
OVERALL_CREDIT_LIMIT ,   
MIN_DUNNING_AMOUNT ,   
MIN_DUNNING_INVOICE_AMOUNT ,   
MAX_INTEREST_CHARGE ,   
MIN_STATEMENT_AMOUNT ,   
AUTO_REC_MIN_RECEIPT_AMOUNT ,   
INTEREST_RATE ,   
MIN_FC_BALANCE_AMOUNT ,   
MIN_FC_INVOICE_AMOUNT,
DECODE(CUSTOMER_SITE_USE_ID,NULL,CUSTOMER_PROFILE_ID,NULL)   
FROM   
AR_CUSTOMER_PROFILE_AMOUNTS
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_CUSTOMER_PROFILES_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AR_CUSTOMER_PROFILES_VW (  
CUSTOMER_PROFILE_ID, CUSTOMER_ID, SITE_USE_ID, CUSTOMER_PROFILE_CLASS_ID, 
STATUS, PROFILE_CLASS_NAME, PROFILE_CLASS_DESCRIPTION, 
COLLECTOR_ID, COLLECTOR_NAME, CREDIT_CHECKING, TOLERANCE, 
DISCOUNT_TERMS, DUNNING_LETTERS, INTEREST_CHARGES, STATEMENTS, 
CREDIT_BALANCE_STATEMENTS, CREDIT_HOLD, CREDIT_RATING, CREDIT_RATING_MEANING, 
RISK_CODE, RISK_MEANING, STANDARD_TERMS, STANDARD_TERMS_NAME, 
OVERRIDE_TERMS, DUNNING_LETTER_SET_ID, DUNNING_LETTER_SET_NAME, INTEREST_PERIOD_DAYS, 
PAYMENT_GRACE_DAYS, DISCOUNT_GRACE_DAYS, STATEMENT_CYCLE_ID, STATEMENT_CYCLE_NAME, 
ACCOUNT_STATUS, ACCOUNT_STATUS_MEANING, AUTOCASH_HIERARCHY_ID, AUTOCASH_HIERARCHY_NAME, 
AUTO_REC_INCL_DISPUTED_FLAG, TAX_PRINTING_OPTION, TAX_PRINTING_OPTION_MEANING, CHARGE_ON_FINANCE_CHARGE_FLAG, 
GROUPING_RULE_ID, GROUPING_RULE_NAME, CONS_INV_FLAG, CONS_INV_TYPE, 
PERCENT_COLLECTABLE, CLEARING_DAYS) 
AS SELECT
	cp.customer_profile_id			customer_profile_id,
	cp.customer_id				customer_id,
	cp.site_use_id				site_use_id,
	cp.customer_profile_class_id		customer_profile_class_id,
    cp.status				status,
	cpc.name				profile_class_name,
	cpc.description				profile_class_description,
	cp.collector_id				collector_id,
	col.name				collector_name,
	cp.credit_checking			credit_checking,
	cp.tolerance				tolerance,
	cp.discount_terms			discount_terms,
	cp.dunning_letters			dunning_letters,
	cp.interest_charges			interest_charges,
	cp.statements				statements,
	cp.credit_balance_statements		credit_balance_statements,
	cp.credit_hold				credit_hold,
	cp.credit_rating			credit_rating ,
	l_cr.meaning				credit_rating_meaning,
	cp.risk_code				risk_code,
	l_risk.meaning				risk_meaning,
	cp.standard_terms			standard_terms,
	term.name				standard_terms_name,
	cp.override_terms			override_terms,
	cp.dunning_letter_set_id		dunning_letter_set_id,
	dun_set.name				dunning_letter_set_name,
	cp.interest_period_days			interest_period_days,
	cp.payment_grace_days			payment_grace_days,
	cp.discount_grace_days			discount_grace_days,
	cp.statement_cycle_id			statement_cycle_id,
	cyc.name				statement_cycle_name,
	cp.account_status			account_status,
	l_as.meaning				account_status_meaning,
	cp.autocash_hierarchy_id		autocash_hierarchy_id,
	hier.hierarchy_name			autocash_hierarchy_name,
	cp.auto_rec_incl_disputed_flag		auto_rec_incl_disputed_flag,
	cp.tax_printing_option			tax_printing_option,
	l_tax.meaning				tax_printing_option_meaning,
	cp.charge_on_finance_charge_flag	charge_on_finance_charge_flag,
	cp.grouping_rule_id			grouping_rule_id,
	grp.name				grouping_rule_name,
        NVL(cp.cons_inv_flag, 'N' )             cons_inv_flag,
        cp.cons_inv_type                        cons_inv_type,
        cp.percent_collectable			percent_collectable,
	cp.clearing_days			clearing_days
FROM	ar_customer_profiles            cp,
	ar_customer_profile_classes     cpc,
	ar_collectors                   col,
	ar_lookups                      l_cr,
	ar_lookups                      l_risk,
	ar_lookups                      l_as,
	ar_statement_cycles             cyc,
	ra_terms                        term,
	ar_dunning_letter_sets          dun_set,
	ar_autocash_hierarchies         hier,
	ar_lookups                      l_tax,
	ra_grouping_rules               grp
WHERE	cp.customer_profile_class_id 		= cpc.customer_profile_class_id(+)
AND	cp.collector_id				= col.collector_id
AND     cp.credit_rating			= l_cr.lookup_code(+)
AND	l_cr.lookup_type(+)			= 'CREDIT_RATING'
AND	cp.risk_code				= l_risk.lookup_code(+)
AND	l_risk.lookup_type(+)			= 'RISK_CODE'
AND     cp.statement_cycle_id			= cyc.statement_cycle_id(+)
AND 	cp.standard_terms			= term.term_id(+)
AND	cp.dunning_letter_set_id		= dun_set.dunning_letter_set_id(+)
AND	cp.account_status			= l_as.lookup_code(+)
AND	l_as.lookup_type(+)			= 'ACCOUNT_STATUS'
AND	cp.autocash_hierarchy_id		= hier.autocash_hierarchy_id(+)
AND	cp.tax_printing_option			= l_tax.lookup_code(+)
AND	l_tax.lookup_type(+) 			= 'TAX_PRINTING_OPTION'
AND	cp.grouping_rule_id			= grp.grouping_rule_id(+)
/

/*----------------------------------------------------------------------*/
--      Create View WM_AR_CONTACT_ROLES_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AR_CONTACT_ROLES_VW ( 
CONTACT_ROLE_ID, USAGE_CODE, CONTACT_ID, 
ORIG_SYSTEM_REFERENCE, PRIMARY_FLAG ) AS SELECT
     cr.contact_role_id
	 ,cr.usage_code
     ,cr.contact_id
     ,cr.orig_system_reference
     ,cr.primary_flag
FROM
    ra_contact_roles  cr,
    ar_lookups  arlkp1
 WHERE cr.usage_code = arlkp1.lookup_code(+)
 AND   arlkp1.lookup_type(+) = 'SITE_USE_CODE'
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_CONTACTS_VW 
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_AR_CONTACTS_VW (  
CONTACT_ID, CUSTOMER_ID, ADDRESS_ID,CONTACT_NUMBER, 
TITLE, TITLE_MEANING, FIRST_NAME, LAST_NAME, 
STATUS, JOB_TITLE, MAIL_STOP, ORIG_SYSTEM_REFERENCE, 
CONTACT_KEY,EMAIL_ADDRESS ) AS SELECT
    cont.contact_id			contact_id
     ,cont.customer_id			customer_id
     ,cont.address_id			address_id
	 ,cont.contact_number		contact_number
     ,cont.title			title
     ,l.meaning				title_meaning
     ,cont.first_name			first_name
     ,cont.last_name			last_name
     ,cont.status			status
     ,cont.job_title			job_title
     ,cont.mail_stop			mail_stop
     ,cont.orig_system_reference	orig_system_reference
     ,cont.contact_key			contact_key
	 ,cont.email_address		email_address
FROM
    ra_contacts  cont
    ,ar_lookups  l
WHERE  cont.title = l.lookup_code(+)
AND    l.lookup_type(+) 	= 'CONTACT_TITLE'
/


/*----------------------------------------------------------------------*/
--      Create View WM_AR_ADDRESSES_VW 
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_AR_ADDRESSES_VW ( ADDRESS_ID, 
CUSTOMER_ID, STATUS, ORIG_SYSTEM_REFERENCE, COUNTRY, 
TERRITORY_SHORT_NAME, ADDRESS_STYLE, ADDRESS1, ADDRESS2, 
ADDRESS3, ADDRESS4, CITY, COUNTY, 
STATE, PROVINCE, POSTAL_CODE, TERRITORY_ID, 
ADDRESS_KEY, SU_BILL_TO_FLAG, SU_BILL_TO_SITE_USE_ID, SU_SHIP_TO_FLAG, 
SHIP_TO_SITE_USE_ID, SU_MARKET_FLAG, MARKET_SITE_USES_ID, SU_DUN_FLAG, 
DUN_SITE_USE_ID, SU_STMT_FLAG, STMT_SITE_USE_ID, SU_LEGAL_FLAG, 
LEGAL_SITE_USE_ID, KEY_ACCOUNT_FLAG, LANGUAGE, LANGUAGE_DESCRIPTION, 
ADDRESS_LINES_PHONETIC, CUSTOMER_CATEGORY, CUSTOMER_CATEGORY_MEANING,ORGANIZATION_NAME ) AS SELECT  
addr.address_id			address_id,  
addr.customer_id		customer_id,  
addr.status			status,  
addr.orig_system_reference	orig_system_reference,  
addr.country			country,  
terr.territory_short_name 	territory_short_name,  
terr.address_style		address_style,  
addr.address1			address1,  
addr.address2			address2,  
addr.address3			address3,  
addr.address4			address4,  
addr.city			city,  
addr.county			county,  
addr.state			state,  
addr.province			province,  
addr.postal_code		postal_code,  
addr.territory_id		territory_id,  
addr.address_key,  
DECODE(su_bill.status,  
'A','Y',  
'N')		su_bill_to_flag,  
su_bill.site_use_id		su_bill_to_site_use_id,  
DECODE(su_ship.status,  
'A','Y',  
'N')		su_ship_to_flag,  
su_ship.site_use_id		ship_to_site_use_id,  
DECODE(su_market.status,  
'A','Y',  
'N')		su_market_flag,  
su_market.site_use_id		market_site_uses_id,  
DECODE(su_dun.status,  
'A','Y',  
'N')		su_dun_flag,  
su_dun.site_use_id		dun_site_use_id,  
DECODE(su_stmt.status,  
'A','Y',  
'N'  
)			su_stmt_flag,  
su_stmt.site_use_id		stmt_site_use_id,  
DECODE(su_legal.status,  
'A','Y',  
'N')		su_legal_flag,  
su_legal.site_use_id		legal_site_use_id,  
addr.key_account_flag		key_account_flag,  
addr.LANGUAGE			LANGUAGE,  
lang.description		language_description,  
addr.address_lines_phonetic     address_lines_phonetic,  
addr.customer_category_code     customer_category,  
l_cat.meaning                   customer_category_meaning  ,
org.name organization_name
FROM	ar_lookups   l_cat,  
fnd_territories terr,  
fnd_languages   lang,  
ra_site_uses_all su_ship,  
ra_site_uses_all su_stmt,  
ra_site_uses_all su_dun,  
ra_site_uses_all su_legal,  
ra_site_uses_all su_bill,  
ra_site_uses_all su_market,  
ra_addresses_all addr ,
hr_organization_units org
WHERE   addr.customer_category_code     = l_cat.lookup_code(+)  
AND     l_cat.lookup_type(+)            = 'ADDRESS_CATEGORY'  
AND     addr.address_id			= su_bill.address_id(+)  
AND	su_bill.site_use_code(+)	= 'BILL_TO'  
AND	su_bill.status(+)		= 'A'  
AND	addr.address_id			= su_ship.address_id(+)  
AND	su_ship.site_use_code(+)	= 'SHIP_TO'  
AND	su_ship.status(+)		= 'A'  
AND	addr.address_id			= su_market.address_id(+)  
AND	su_market.site_use_code(+)	= 'MARKET'  
AND	su_market.status(+)		= 'A'  
AND	addr.address_id			= su_stmt.address_id(+)  
AND	su_stmt.site_use_code(+)	= 'STMTS'  
AND	su_stmt.status(+)		= 'A'  
AND     addr.address_id			= su_dun.address_id(+)  
AND     su_dun.site_use_code(+)		= 'DUN'  
AND	su_dun.status(+)		= 'A'  
AND     addr.address_id			= su_legal.address_id(+)  
AND     su_legal.site_use_code(+)	= 'LEGAL'  
AND	su_legal.status(+)		= 'A'  
AND	addr.country			= terr.territory_code(+)  
AND	addr.LANGUAGE			= lang.nls_language(+)
AND addr.org_id = org.organization_id (+)
/


/*----------------------------------------------------------------------*/
--      Create View WM_ADDR_PHONES_VW 
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_ADDR_PHONES_VW ( 
PHONE_ID, PHONE_NUMBER, STATUS, PHONE_TYPE, 
CUSTOMER_ID, ADDRESS_ID, 
CONTACT_ID, AREA_CODE, EXTENSION, PRIMARY_FLAG, 
ORIG_SYSTEM_REFERENCE ) 
AS SELECT
   phon.phone_id
    ,phon.phone_number
    ,phon.status
    ,phon.phone_type
    ,phon.customer_id
    ,phon.address_id
    ,phon.contact_id
    ,phon.area_code
    ,phon.extension
    ,phon.primary_flag
    ,phon.orig_system_reference
   FROM ra_phones  phon,
     ar_lookups  look
WHERE phon.phone_type     = look.lookup_code
AND   look.lookup_type    = 'COMMUNICATION_TYPE'
/

/*----------------------------------------------------------------------*/
--      Create View WM_AR_CUSTOMERS_QRY_VW View for Customer Query Transaction
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_AR_CUSTOMERS_QRY_VW ( WEB_TRANSACTION_ID,DOCUMENT_TYPE,DOCUMENT_STATUS, CUSTOMER_ID, CUSTOMER_NAME, 
CUSTOMER_NUMBER, 
ADDRESS1,ADDRESS2,ADDRESS3,ADDRESS4,CITY,COUNTY,STATE,COUNTRY,POSTAL_CODE,PROVINCE,
CUSTOMER_KEY,   CUSTOMER_STATUS, ORIG_SYSTEM_REFERENCE, 
CUSTOMER_PROSPECT_CODE, CUSTOMER_CATEGORY_CODE,   CUSTOMER_CATEGORY_MEANING, 
CUSTOMER_CLASS_CODE, CUSTOMER_CLASS_MEANING, CUSTOMER_TYPE,   
CUSTOMER_TYPE_MEANING, PRIMARY_SALESREP_ID, PRIMARY_SALESREP_NAME, SIC_CODE,   
TAX_REFERENCE, TAX_CODE, FOB_POINT, FOB_POINT_MEANING,   SHIP_VIA, 
GSA_INDICATOR, SHIP_PARTIAL, TAXPAYER_ID,   PRICE_LIST_ID, PRICE_LIST_NAME, 
FREIGHT_TERM, FREIGHT_TERM_MEANING,   ORDER_TYPE_ID, ORDER_TYPE_NAME, 
SALES_CHANNEL_CODE, SALES_CHANNEL_MEANING,   WAREHOUSE_ID, WAREHOUSE_NAME, 
MISSION_STATEMENT, NUM_OF_EMPLOYEES,   POTENTIAL_REVENUE_CURR_FY, 
POTENTIAL_REVENUE_NEXT_FY, FISCAL_YEAREND_MONTH, YEAR_ESTABLISHED,   
ANALYSIS_FY, COMPETITOR_FLAG, REFERENCE_USE_FLAG, THIRD_PARTY_FLAG,   
CUSTOMER_PROFILE_CLASS_ID, PROFILE_CLASS_NAME, 
CUSTOMER_NAME_PHONETIC,   TAX_HEADER_LEVEL_FLAG, TAX_ROUNDING_RULE ) 
AS SELECT 
  NULL   web_transaction_id ,
  'CUSTOMER'     document_type,
  'QUERY' document_status,
  cust.customer_id			customer_id,
  cust.customer_name			customer_name,
  cust.customer_number			customer_number,
  addr.address1					address1,
  addr.address2					address2,
  addr.address3					address3,
  addr.address4					address4,
  addr.city						city,
  addr.county					county,
  addr.state					state,
  addr.country					country,
  addr.postal_code				postal_code,
  addr.province					province,
  cust.customer_key			customer_key,
  cust.status				status,
  cust.orig_system_reference		orig_system_reference,
  cust.customer_prospect_code		customer_prospect_code,
  cust.customer_category_code		customer_category_code,
  l_cat.meaning				customer_category_meaning,
  cust.customer_class_code		customer_class_code,
  l_class.meaning				customer_class_meaning,
  cust.customer_type			customer_type,
  l_type.meaning				customer_type_meaning,
  cust.primary_salesrep_id		primary_salesrep_id,
  rep.name				primary_salesrep_name,
  cust.sic_code				sic_code,
  cust.tax_reference			tax_reference,
  cust.tax_code				tax_code,
  cust.fob_point				fob_point,
  l_fob.meaning				fob_point_meaning,
  cust.ship_via				ship_via,
  cust.gsa_indicator			gsa_indicator,
  cust.ship_partial			ship_partial,
  cust.jgzz_fiscal_code			taxpayer_id,
  cust.price_list_id			price_list_id,
  pl.name					price_list_name,
  cust.freight_term			freight_term,
  l_ft.meaning				freight_term_meaning,
  cust.order_type_id			order_type_id,
  ot.name					order_type_name,
  cust.sales_channel_code			sales_channel_code,
  l_sc.meaning				sales_channel_meaning,
  cust.warehouse_id			warehouse_id,
  org.name				warehouse_name,
  cust.mission_statement			mission_statement,
  cust.num_of_employees			num_of_employees,
  cust.potential_revenue_curr_fy		potential_revenue_curr_fy,
  cust.potential_revenue_next_fy		potential_revenue_next_fy,
  cust.fiscal_yearend_month		fiscal_yearend_month,
  cust.year_established			year_established,
  cust.analysis_fy			analysis_fy,
  cust.competitor_flag			competitor_flag,
  cust.reference_use_flag			reference_use_flag,
  cust.third_party_flag			third_party_flag,
  cpc.customer_profile_class_id		customer_profile_class_id,
  cpc.name				profile_class_name,
  cust.customer_name_phonetic             customer_name_phonetic,
  cust.tax_header_level_flag              tax_header_level_flag,
  cust.tax_rounding_rule                  tax_rounding_rule
FROM 
  ar_lookups   l_cat,
  ar_lookups   l_class,
  ar_lookups   l_type,
  ra_salesreps_all rep,
  ar_lookups l_fob,
  so_price_lists pl,
  so_lookups l_ft,
  so_order_types_all ot,
  so_lookups l_sc,
  hr_organization_units org,
  ar_customer_profile_classes cpc,
  ar_customer_profiles cp,
  ra_customers cust,
  ra_addresses_all addr
 WHERE 
  cust.customer_category_code	= l_cat.lookup_code(+)  AND
  l_cat.lookup_type(+)		= 'CUSTOMER_CATEGORY'  AND
  cust.customer_class_code	= l_class.lookup_code(+)  AND
  l_class.lookup_type(+)		= 'CUSTOMER CLASS'  AND
  cust.customer_type	        = l_type.lookup_code(+)  AND
  l_type.lookup_type(+)		= 'CUSTOMER_TYPE'  AND
  cust.primary_salesrep_id	= rep.salesrep_id(+)  AND
  cust.fob_point			= l_fob.lookup_code(+)  AND
  l_fob.lookup_type(+) 		= 'FOB'  AND
  cust.price_list_id              = pl.price_list_id(+)  AND
  cust.freight_term		= l_ft.lookup_code(+)  AND
  l_ft.lookup_type(+)		= 'FREIGHT_TERMS'  AND
  cust.order_type_id              = ot.order_type_id(+)  AND
  cust.sales_channel_code		= l_sc.lookup_code(+)  AND
  l_sc.lookup_type(+)		= 'SALES_CHANNEL'  AND
  cust.warehouse_id		= org.organization_id(+)  AND
  cp.customer_id			= cust.customer_id  AND
  cp.site_use_id			IS NULL  AND
  cp.customer_profile_class_id    = cpc.customer_profile_class_id(+) AND
  cust.customer_id = addr.customer_id
/



 
SHOW ERRORS

