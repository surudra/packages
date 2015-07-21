/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Supplier outbound in Application Schema  
    * Program Name:         wm_from_supplier_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Vendor Outbound
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
     19-OCT-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_supplier_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      Create View WM_PO_SUPPLIER_QRY_VW
/*----------------------------------------------------------------------*/

create or replace view &&apps_user..wm_po_supplier_qry_vw as
SELECT  null web_transaction_id,
'SUPPLIER' document_type,
'QUERY' document_status,
pov.vendor_id,
pov.segment1 vendor_number,
pov.vendor_name vendor_name,
pov.vendor_name_alt alternate_vendor_name,
pov.vendor_type_lookup_code vendor_type,
pov.customer_num customer_number,
pov.one_time_flag one_time_flag,
pov_parent.segment1 parent_vendor_number,
pov_parent.vendor_name parent_vendor_name,
pov.min_order_amount minimum_order_amount,
--hr_loc_bill.location_code Bill_To_location_Code,
hr_loc_bill.address_line_1 Bill_Loc_Address_Line1,
hr_loc_bill.address_line_2 Bill_Loc_Address_Line2,
hr_loc_bill.address_line_3 Bill_Loc_Address_Line3,
hr_loc_bill.town_or_city Bill_Loc_town_or_city,
hr_loc_bill.region_2 Bill_Loc_Region2,
hr_loc_bill.postal_code Bill_Loc_Postal_Code,
hr_loc_bill.country Bill_Loc_Country,
hr_loc_bill.region_1 Bill_Loc_Region1,
--hr_loc_bill.region_3 Bill_Loc_Region3,
--hr_loc_ship.location_code ship_To_location_Code,
hr_loc_ship.address_line_1 ship_Loc_Address_Line1,
hr_loc_ship.address_line_2 ship_Loc_Address_Line2,
hr_loc_ship.address_line_3 ship_Loc_Address_Line3,
hr_loc_ship.town_or_city ship_Loc_town_or_city,
hr_loc_ship.region_2 ship_Loc_Region2,
hr_loc_ship.postal_code ship_Loc_Postal_Code,
hr_loc_ship.region_1 ship_Loc_Region1,
hr_loc_ship.country ship_Loc_Country,
--hr_loc_ship.region_3 ship_Loc_Region3,
pov.ship_via_lookup_code ship_via,
pov.freight_terms_lookup_code freight_terms,
pov.fob_lookup_code fob,
term.name terms,
gls.name set_of_books_name,
gls.short_name set_of_books_short_name,
pov.credit_status_lookup_code credit_status,
pov.credit_limit credit_limit,
pov.always_take_disc_flag always_discount_flag,
pov.pay_date_basis_lookup_code pay_date_basis,
pov.pay_group_lookup_code pay_group,
pov.payment_priority payment_priority,
pov.invoice_currency_code invoice_currency_code,
pov.payment_currency_code payment_currency_code,
pov.invoice_amount_limit invoice_amount_limit,
pov.exchange_date_lookup_code exchange_date_code,
pov.hold_all_payments_flag hold_all_payments,
pov.hold_future_payments_flag hold_future_payments,
pov.hold_reason hold_reason,
apds.distribution_set_name distribution_set_name,
glc.concatenated_segments supplier_liability_account,
pov.num_1099 Number_1099,
pov.type_1099 Type_1099,
pov.withholding_status_lookup_code withholding_status,
pov.withholding_start_date withholding_start_date,
pov.organization_type_lookup_code IRS_Organization_type,
pov.vat_code vat_code,
pov.start_date_active start_date_active,
pov.end_date_active end_date_active,
pov.minority_group_lookup_code minority_group,
pov.payment_method_lookup_code payment_method,
pov.bank_account_name bank_account_name,
pov.bank_account_num bank_account_number,
pov.bank_number bank_number,
pov.bank_account_type bank_account_type,
pov.women_owned_flag women_owned,
pov.small_business_flag small_business,
pov.standard_industry_class standard_industry_class,
pov.hold_flag hold_flag,
pov.purchasing_hold_reason purchasing_hold_reason,
per_hold_by.employee_number hold_by_employee_number,
per_hold_by.full_name per_hold_by_full_name,
pov.hold_date hold_date,
pov.terms_date_basis terms_date_basis,
pov.price_tolerance price_tolerance,
pov.inspection_required_flag inspection_required,
pov.receipt_required_flag receipt_required_flag,
pov.qty_rcv_tolerance quantity_received_tolerance,
pov.days_early_receipt_allowed days_early_receipt_allowed,
pov.days_late_receipt_allowed days_late_receipt_allowed,
pov.allow_substitute_receipts_flag allow_substitute_receipts,
pov.allow_unordered_receipts_flag allow_unordered_receipts,
pov.hold_unmatched_invoices_flag hold_unmatched_invoices,
pov.exclusive_payment_flag exclusive_payment,
pov.tax_verification_date tax_verification_date,
pov.state_reportable_flag state_reportable,
pov.federal_reportable_flag federal_reportable,
pov.offset_vat_code offset_vat,
pov.vat_registration_num vat_registration_number,
pov.auto_calculate_interest_flag auto_calculate_interest,
pov.validation_number validation_number,
pov.exclude_freight_from_discount exclude_freight_from_discount,
pov.tax_reporting_name tax_reporting_name,
pov.check_digits check_digits,
pov.bank_num bank_num,
pov.auto_tax_calc_flag  auto_tax_calculation,
pov.auto_tax_calc_override auto_tax_calculation_override,
pov.amount_includes_tax_flag amount_includes_tax,
pov.bank_charge_bearer bank_charge_bearer,
pov.bank_branch_type bank_branch_type,
pov.match_option match_option,
gls_f.concatenated_segments future_dated_payments_account,
pov.create_debit_memo_flag create_debit_memo,
pov.offset_tax_flag offset_flag
FROM AP_SUPPLIERS pov,
AP_SUPPLIERS pov_parent,
ap_terms term,
gl_sets_of_books gls,
ap_distribution_sets_all apds,
gl_code_combinations_kfv glc,
per_all_people_f per_hold_by,
gl_code_combinations_kfv gls_f,
hr_locations hr_loc_bill,
hr_locations hr_loc_ship
WHERE
pov.parent_vendor_id=pov_parent.vendor_id(+)
AND  pov.terms_id = term.term_id(+)
AND  pov.accts_pay_code_combination_id = glc.code_combination_id(+)
AND  pov.set_of_books_id= gls.set_of_books_id(+)
AND  pov.hold_by = per_hold_by.person_id(+)
--AND  NVL(per_hold_by.effective_end_date,SYSDATE+1) > SYSDATE
AND  pov.future_dated_payment_ccid=gls_f.code_combination_id(+)
AND  pov.distribution_set_id=apds.distribution_set_id(+)
AND  pov.bill_to_location_id=hr_loc_bill.location_id(+)
AND  pov.ship_to_location_id=hr_loc_ship.location_id(+)
/


/*----------------------------------------------------------------------*/
--      Create View WM_PO_SUPPLIER_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW wm_po_supplier_vw AS
SELECT  wmtc.web_transaction_id,
wmtc.transaction_type document_type,
DECODE((wmtc.transaction_status),0,'UPDATE',1,'INSERT',2,'DELETE','REJECT') document_status,
pov.vendor_id,
pov.segment1 vendor_number,
pov.vendor_name vendor_name,
pov.vendor_name_alt alternate_vendor_name,
pov.vendor_type_lookup_code vendor_type,
pov.customer_num customer_number,
pov.one_time_flag one_time_flag,
pov_parent.segment1 parent_vendor_number,
pov_parent.vendor_name parent_vendor_name,
pov.min_order_amount minimum_order_amount,
--hr_loc_bill.location_code Bill_To_location_Code,
hr_loc_bill.address_line_1 Bill_Loc_Address_Line1,
hr_loc_bill.address_line_2 Bill_Loc_Address_Line2,
hr_loc_bill.address_line_3 Bill_Loc_Address_Line3,
hr_loc_bill.town_or_city Bill_Loc_town_or_city,
hr_loc_bill.region_2 Bill_Loc_Region2,
hr_loc_bill.postal_code Bill_Loc_Postal_Code,
hr_loc_bill.country Bill_Loc_Country,
hr_loc_bill.region_1 Bill_Loc_Region1,
--hr_loc_bill.region_3 Bill_Loc_Region3,
--hr_loc_ship.location_code ship_To_location_Code,
hr_loc_ship.address_line_1 ship_Loc_Address_Line1,
hr_loc_ship.address_line_2 ship_Loc_Address_Line2,
hr_loc_ship.address_line_3 ship_Loc_Address_Line3,
hr_loc_ship.town_or_city ship_Loc_town_or_city,
hr_loc_ship.region_2 ship_Loc_Region2,
hr_loc_ship.postal_code ship_Loc_Postal_Code,
hr_loc_ship.region_1 ship_Loc_Region1,
hr_loc_ship.country ship_Loc_Country,
--hr_loc_ship.region_3 ship_Loc_Region3,
pov.ship_via_lookup_code ship_via,
pov.freight_terms_lookup_code freight_terms,
pov.fob_lookup_code fob,
term.name terms,
gls.name set_of_books_name,
gls.short_name set_of_books_short_name,
pov.credit_status_lookup_code credit_status,
pov.credit_limit credit_limit,
pov.always_take_disc_flag always_discount_flag,
pov.pay_date_basis_lookup_code pay_date_basis,
pov.pay_group_lookup_code pay_group,
pov.payment_priority payment_priority,
pov.invoice_currency_code invoice_currency_code,
pov.payment_currency_code payment_currency_code,
pov.invoice_amount_limit invoice_amount_limit,
pov.exchange_date_lookup_code exchange_date_code,
pov.hold_all_payments_flag hold_all_payments,
pov.hold_future_payments_flag hold_future_payments,
pov.hold_reason hold_reason,
apds.distribution_set_name distribution_set_name,
glc.concatenated_segments supplier_liability_account,
pov.num_1099 Number_1099,
pov.type_1099 Type_1099,
pov.withholding_status_lookup_code withholding_status,
pov.withholding_start_date withholding_start_date,
pov.organization_type_lookup_code IRS_Organization_type,
pov.vat_code vat_code,
pov.start_date_active start_date_active,
pov.end_date_active end_date_active,
pov.minority_group_lookup_code minority_group,
pov.payment_method_lookup_code payment_method,
pov.bank_account_name bank_account_name,
pov.bank_account_num bank_account_number,
pov.bank_number bank_number,
pov.bank_account_type bank_account_type,
pov.women_owned_flag women_owned,
pov.small_business_flag small_business,
pov.standard_industry_class standard_industry_class,
pov.hold_flag hold_flag,
pov.purchasing_hold_reason purchasing_hold_reason,
per_hold_by.employee_number hold_by_employee_number,
per_hold_by.full_name per_hold_by_full_name,
pov.hold_date hold_date,
pov.terms_date_basis terms_date_basis,
pov.price_tolerance price_tolerance,
pov.inspection_required_flag inspection_required,
pov.receipt_required_flag receipt_required_flag,
pov.qty_rcv_tolerance quantity_received_tolerance,
pov.days_early_receipt_allowed days_early_receipt_allowed,
pov.days_late_receipt_allowed days_late_receipt_allowed,
pov.allow_substitute_receipts_flag allow_substitute_receipts,
pov.allow_unordered_receipts_flag allow_unordered_receipts,
pov.hold_unmatched_invoices_flag hold_unmatched_invoices,
pov.exclusive_payment_flag exclusive_payment,
pov.tax_verification_date tax_verification_date,
pov.state_reportable_flag state_reportable,
pov.federal_reportable_flag federal_reportable,
pov.offset_vat_code offset_vat,
pov.vat_registration_num vat_registration_number,
pov.auto_calculate_interest_flag auto_calculate_interest,
pov.validation_number validation_number,
pov.exclude_freight_from_discount exclude_freight_from_discount,
pov.tax_reporting_name tax_reporting_name,
pov.check_digits check_digits,
pov.bank_num bank_num,
pov.auto_tax_calc_flag  auto_tax_calculation,
pov.auto_tax_calc_override auto_tax_calculation_override,
pov.amount_includes_tax_flag amount_includes_tax,
pov.bank_charge_bearer bank_charge_bearer,
pov.bank_branch_type bank_branch_type,
pov.match_option match_option,
gls_f.concatenated_segments future_dated_payments_account,
pov.create_debit_memo_flag create_debit_memo,
pov.offset_tax_flag offset_flag
FROM AP_SUPPLIERS pov,
AP_SUPPLIERS pov_parent,
ap_terms term,
gl_sets_of_books gls,
ap_distribution_sets_all apds,
gl_code_combinations_kfv glc,
per_all_people_f per_hold_by,
gl_code_combinations_kfv gls_f,
hr_locations hr_loc_bill,
hr_locations hr_loc_ship,
wm_track_changes_vw wmtc
WHERE
pov.parent_vendor_id=pov_parent.vendor_id(+)
AND  pov.terms_id = term.term_id(+)
AND  pov.accts_pay_code_combination_id = glc.code_combination_id(+)
AND  pov.set_of_books_id= gls.set_of_books_id(+)
AND  pov.hold_by = per_hold_by.person_id(+)
AND  NVL(per_hold_by.effective_end_date,SYSDATE+1) > SYSDATE
AND  pov.future_dated_payment_ccid=gls_f.code_combination_id(+)
AND  pov.distribution_set_id=apds.distribution_set_id(+)
AND  pov.bill_to_location_id=hr_loc_bill.location_id(+)
AND  pov.ship_to_location_id=hr_loc_ship.location_id(+)
AND  pov.vendor_id = wmtc.transaction_id
AND  wmtc.transaction_type = 'SUPPLIER'
AND  wmtc.transaction_status <=2
ORDER BY wmtc.web_transaction_id
/

/*----------------------------------------------------------------------*/
--      Create View WM_PO_SUPPLIER_SITES_ALL_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW
WM_PO_SUPPLIER_SITES_ALL_VW
AS SELECT  
povs.vendor_id,  
povs.vendor_site_id,  
povs.vendor_site_code vendor_site_code,  
povs.purchasing_site_flag purchasing_site,  
povs.rfq_only_site_flag rfq_only_site,  
povs.pay_site_flag pay_site,  
povs.attention_ar_flag attention_ar,  
povs.address_line1 address_line1,  
povs.address_line2 address_line2,  
povs.address_line3 address_line3,  
povs.city city,  
povs.state state,  
povs.zip zip,  
povs.province province,  
povs.country country,  
povs.area_code area_code,  
povs.phone phone,  
povs.customer_num customer_number,  
hr_loc_bill.location_code Bill_To_location_Code,
hr_loc_bill.address_line_1 Bill_Loc_Address_Line1,
hr_loc_bill.address_line_2 Bill_Loc_Address_Line2,
hr_loc_bill.address_line_3 Bill_Loc_Address_Line3,
hr_loc_bill.town_or_city Bill_Loc_town_or_city,
hr_loc_bill.region_2 Bill_Loc_Region2,
hr_loc_bill.postal_code Bill_Loc_Postal_Code,
hr_loc_bill.country Bill_Loc_Country,
hr_loc_bill.region_1 Bill_Loc_Region1,
--hr_loc_bill.region_3 Bill_Loc_Region3,
hr_loc_ship.location_code ship_To_location_Code,
hr_loc_ship.address_line_1 ship_Loc_Address_Line1,
hr_loc_ship.address_line_2 ship_Loc_Address_Line2,
hr_loc_ship.address_line_3 ship_Loc_Address_Line3,
hr_loc_ship.town_or_city ship_Loc_town_or_city,
hr_loc_ship.region_2 ship_Loc_Region2,
hr_loc_ship.postal_code ship_Loc_Postal_Code,
hr_loc_ship.region_1 ship_Loc_Region1,
hr_loc_ship.country ship_Loc_Country,
--hr_loc_ship.region_3 ship_Loc_Region3,
povs.ship_via_lookup_code ship_via,  
povs.freight_terms_lookup_code freight_terms,  
povs.fob_lookup_code fob,  
povs.inactive_date inactive_date,  
povs.fax fax,  
povs.fax_area_code fax_area_code,  
povs.telex telex,  
povs.payment_method_lookup_code payment_method,  
povs.bank_account_name bank_account_name,  
povs.bank_account_num bank_account_number,  
povs.bank_num bank_num,  
povs.bank_account_type bank_account_type,  
povs.terms_date_basis terms_date_basis,  
--povs.current_catalog_num current_catalog_number,  
povs.vat_code vat_code,  
apds.distribution_set_name distribution_set_name,  
glc.concatenated_segments supplier_liability_account,  
glc_pre.concatenated_segments prepay_account,  
povs.pay_group_lookup_code pay_group,  
povs.payment_priority payment_priority,  
terms.name terms,  
povs.invoice_amount_limit invoice_amount_limit,  
povs.pay_date_basis_lookup_code pay_date_basis,  
povs.always_take_disc_flag always_discount_flag,  
povs.invoice_currency_code invoice_currency_code,  
povs.payment_currency_code payment_currency_code,  
povs.hold_all_payments_flag hold_all_payments,  
povs.hold_future_payments_flag hold_future_payments,  
povs.hold_reason hold_reason,  
povs.hold_unmatched_invoices_flag hold_unmatched_invoices,  
povs.exclusive_payment_flag exclusive_payment,  
povs.tax_reporting_site_flag tax_reporting_site,  
povs.validation_number validation_number,  
povs.exclude_freight_from_discount exclude_freight_from_discount,  
povs.vat_registration_num vat_registration_number,  
povs.offset_vat_code offset_vat,  
hou.name organization_name,  
org.organization_code organization_code,  
povs.check_digits check_digits,  
povs.bank_number bank_number,  
povs.address_line4 address_line4,  
povs.county county,  
povs.address_style address_style,  
--povs.language language,  
povs.allow_awt_flag allow_awt,  
--awt_group_id,  -- Use AP_AWT_GROUPS
awt.name  witholding_tax_group,
povs.vendor_site_code_alt alternate_vendor_site_code,  
povs.address_lines_alt alternate_address_line,  
povs.ap_tax_rounding_rule ap_tax_rounding_rule,  
povs.auto_tax_calc_flag  auto_tax_calculation,  
povs.auto_tax_calc_override auto_tax_calculation_override,  
povs.amount_includes_tax_flag amount_includes_tax,  
povs.bank_charge_bearer bank_charge_bearer,  
povs.bank_branch_type bank_branch_type,  
povs.pay_on_code pay_on_code,  
--deualt_pay_site_id,  
povs.pay_on_receipt_summary_code pay_on_receipt_summary_code,  
povs.pcard_site_flag pcard_site,  
povs.match_option match_option,  
povs.country_of_origin_code country_of_origin,  
glc_f.concatenated_segments future_dated_payment_account,  
povs.create_debit_memo_flag create_debit_memo,  
povs.offset_tax_flag offset_tax,
povs.selling_company_identifier,
povs.gapless_inv_num_flag  
FROM AP_SUPPLIER_SITES_ALL povs,  
hr_locations hr_loc_bill,  
hr_locations hr_loc_ship,  
ap_distribution_sets apds,  
gl_code_combinations_kfv glc,  
gl_code_combinations_kfv glc_pre,  
ap_terms_tl terms,  
ap_awt_groups awt,
hr_operating_units hou,  
gl_code_combinations_kfv glc_f,  
org_organization_definitions org  
WHERE  
povs.terms_id = terms.term_id(+)  
AND  povs.distribution_set_id=apds.distribution_set_id(+)  
AND  povs.bill_to_location_id=hr_loc_bill.location_id(+)  
AND  povs.ship_to_location_id=hr_loc_ship.location_id(+)  
AND  povs.accts_pay_code_combination_id=glc.code_combination_id(+)  
AND  povs.prepay_code_combination_id=glc_pre.code_combination_id(+)  
AND  povs.future_dated_payment_ccid=glc_f.code_combination_id(+)  
AND  povs.awt_group_id=awt.group_id(+)
AND  povs.org_id=hou.organization_id  
AND  hou.organization_id=org.organization_id
/

/*----------------------------------------------------------------------*/
--      Create View WM_PO_SUPPLIER_CONTACTS_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW
WM_PO_SUPPLIER_CONTACTS_VW
AS SELECT povc.vendor_site_id,  
povc.inactive_date inactive_date,  
povc.first_name first_name,  
povc.middle_name middle_name,  
povc.last_name last_name,  
povc.prefix prefix,  
povc.title title,  
povc.mail_stop mail_stop,  
povc.area_code area_code,  
povc.phone phone,  
povc.contact_name_alt alternate_contact_name,
povc.email_address,
povc.url,
povc.alt_area_code alternate_area_code,
povc.alt_phone alternate_phone  
FROM PO_VENDOR_CONTACTS povc
/

/*----------------------------------------------------------------------*/
--      Create View WM_BANK_ACC_USE_SUPP_SITES_VW
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW wm_bank_acc_use_supp_sites_vw 
( row_id, 
vendor_id, 
vendor_site_id, 
bank_account_name, 
bank_account_num, 
currency_code, 
bank_name, 
bank_number, 
bank_branch_name, 
bank_num,
end_date ,
start_date,
PRIMARY,
org_id,
organization_code,
organization_name
 ) 
AS SELECT  
  abau.ROWID row_id ,
  abau.vendor_id vendor_id , 
  abau.vendor_site_id vendor_site_id , 
  aba.bank_account_name bank_account_name , 
  aba.bank_account_num bank_account_num , 
  aba.currency_code currency_code , 
  abb.bank_name bank_name , 
  abb.bank_number bank_number , 
  abb.bank_branch_name bank_branch_name , 
  abb.bank_num bank_num , 
  abau.end_date end_date ,
  abau.start_date start_date,
  abau.primary_flag PRIMARY,
  abau.org_id,
  org.organization_code,
  org.organization_name
FROM  
  ap_bank_account_uses_all abau, 
  ap_bank_accounts_all aba, 
  ap_bank_branches abb, 
  AP_SUPPLIERS pv, 
  AP_SUPPLIER_SITES_ALL pvs,
  org_organization_definitions org
WHERE  
  abau.external_bank_account_id = aba.bank_account_id AND 
  aba.bank_branch_id = abb.bank_branch_id AND 
  abau.vendor_id = pv.vendor_id AND 
  abau.vendor_id = pvs.vendor_id AND 
  abau.vendor_site_id = pvs.vendor_site_id
  AND abau.org_id = aba.org_id
  AND aba.org_id = pvs.org_id
  AND abau.org_id=org.organization_id
/

/*----------------------------------------------------------------------*/
--      Create View WM_BANK_ACCOUNT_USES_SUPP_VW
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW wm_bank_account_uses_supp_vw 
( row_id, 
vendor_id, 
vendor_site_id, 
bank_account_name, 
bank_account_num, 
currency_code, 
bank_name, 
bank_number, 
bank_branch_name, 
bank_num,
end_date ,
start_date,
PRIMARY,
org_id,
organization_code,
organization_name
 ) 
AS SELECT  
  abau.ROWID row_id ,
  abau.vendor_id vendor_id , 
  abau.vendor_site_id,
    aba.bank_account_name bank_account_name , 
  aba.bank_account_num bank_account_num , 
  aba.currency_code currency_code , 
  abb.bank_name bank_name , 
  abb.bank_number bank_number , 
  abb.bank_branch_name bank_branch_name , 
  abb.bank_num bank_num , 
  abau.end_date end_date ,
  abau.start_date start_date,
  abau.primary_flag PRIMARY,
  abau.org_id,
  org.organization_code,
  org.organization_name
FROM  
  ap_bank_account_uses_all abau, 
  ap_bank_accounts_all aba, 
  ap_bank_branches abb, 
  AP_SUPPLIERS pv, 
  org_organization_definitions org
WHERE  
  abau.external_bank_account_id = aba.bank_account_id AND 
  aba.bank_branch_id = abb.bank_branch_id AND 
  abau.vendor_id = pv.vendor_id  
  AND abau.org_id = aba.org_id
  AND abau.org_id=org.organization_id
  AND abau.vendor_site_id IS NULL
/
  
SHOW ERRORS

