/*  ***************************************************************************
    *    $Date:   24 Sep 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for AP Invoice outbound in Application Schema  
    * Program Name:         wm_from_apinvoice_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for AP Invoice Outbound
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
     24-SEP-02	   Rajib Naha   	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_apinvoice_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."


/*----------------------------------------------------------------------*/
--      Create View WM_AP_INVOICES_VW 
/*----------------------------------------------------------------------*/

create or replace view wm_ap_invoices_vw 
(
	web_transaction_id, 
	document_type,
	document_status,
	invoice_id,
	invoice_num ,
	invoice_type,
	invoice_date ,
	po_number ,
	vendor_number ,
	vendor_name ,
	vendor_site_address_line1,
	vendor_site_address_line2,
	vendor_site_address_line3,
	vendor_town_or_city,
	vendor_county,
	vendor_state,
	vendor_postal_code,
	vendor_country,
	invoice_amount ,
	invoice_currency_code ,
	exchange_rate ,
      	exchange_rate_type ,
      	terms_name ,
      	exchange_rate_date ,
      	description ,
	awt_group_name ,
	source ,
      	payment_cross_rate_type ,
      	payment_cross_rate_date ,
	payment_cross_rate ,
	payment_currency_code ,
	workflow,
	doc_category_code ,
	voucher_num ,
	payment_method_lookup_code ,
	pay_group_lookup_code ,
	goods_received_date ,
	invoice_received_date ,
	gl_date ,
	liability_account,
	ussgl_transaction_code ,
	exclusive_payment ,
	organization_name,
	amount_applicable_to_discount ,
	prepay_num,
	prepay_dist_num,
	prepay_apply_amount,
	prepay_gl_date 
) as
select
	wmtc.web_transaction_id web_transaction_id, 
	wmtc.transaction_type  document_type,
	decode(wmtc.transaction_status,0,'UPDATE',1,'INSERT',2,'DELETE')  document_status,
	ai.invoice_id invoice_id,
	ai.invoice_num invoice_num ,
	ai.invoice_type_lookup_code invoice_type_lookup_code ,
	ai.invoice_date invoice_date ,
	ap_invoices_pkg.get_po_number( ai.invoice_id) po_number ,
	pv.segment1 vendor_number ,
	pv.vendor_name vendor_name ,
	pvs.address_line1 address_line1,
	pvs.address_line2 address_line2,
	pvs.address_line3 address_line3,
	pvs.city  city,
	pvs.county county,
	pvs.state state,
	pvs.zip zip,
	pvs.country country,
	ai.invoice_amount invoice_amount ,
	ai.invoice_currency_code invoice_currency_code ,
      	ai.exchange_rate exchange_rate ,
      	ai.exchange_rate_type exchange_rate_type ,
      	at.name terms_name ,
      	ai.exchange_date exchange_date ,
      	ai.description description ,
	awt.name awt_group_name ,
	ai.source source ,
      	ai.payment_cross_rate_type payment_cross_rate_type,
      	ai.payment_cross_rate_date payment_cross_rate_date,
	ai.payment_cross_rate payment_cross_rate ,
	ai.payment_currency_code payment_currency_code ,
	null workflow, -- y -->'to be processed', s --> 'processing', d --> 'processed', null --> 'not applicable'
	ai.doc_category_code doc_category_code ,
	ai.voucher_num voucher_num ,
	ai.payment_method_lookup_code payment_method_lookup_code ,
	ai.pay_group_lookup_code pay_group_lookup_code ,
	ai.goods_received_date goods_received_date ,
	ai.invoice_received_date invoice_received_date ,
	ai.gl_date gl_date ,
	glcl.concatenated_segments liability_account,	  
	ai.ussgl_transaction_code ussgl_transaction_code ,
	ai.exclusive_payment_flag exclusive_payment_flag ,
	haotl.name org_name,
	ai.amount_applicable_to_discount amount_applicable_to_discount ,
	null prepay_invoice_num , --aip.invoice_num
	null prepay_dist_num, --aidp.distribution_line_number
	null  prepay_apply_amount , --aidp.prepay_amount_remaining
	null prepay_accounting_date --ai.gl_date
from 
      	ap_invoices_all ai,
      	ap_terms at,
      	po_vendors pv,
      	po_vendor_sites_all pvs,
      	ap_lookup_codes alc1,
      	ap_lookup_codes alc2,
	ap_awt_groups awt,
	hr_all_organization_units_tl haotl,	  
	gl_code_combinations_kfv glcl,	  
	wm_track_changes_vw wmtc	  
where
      	ai.terms_id = at.term_id (+) and
      	alc1.lookup_type (+) = 'INVOICE TYPE' and
      	alc1.lookup_code (+) = ai.invoice_type_lookup_code and
      	alc2.lookup_type (+) = 'PAYEMENT METHOD' and
      	alc2.lookup_code (+) = ai.payment_method_lookup_code and
      	ai.vendor_id = pv.vendor_id (+) and
      	ai.vendor_site_id = pvs.vendor_site_id (+) and
	ai.awt_group_id = awt.group_id (+) and
	ai.accts_pay_code_combination_id = glcl.code_combination_id (+) and
	ai.org_id = haotl.organization_id (+) and	 
	ai.org_id = pvs.org_id (+) and
      	ai.invoice_id = wmtc.transaction_id and
      	transaction_status <= 2 and
      	wmtc.transaction_type = 'APINVOICE' and
	ai.invoice_id in 
	(select invoice_id from ap_invoice_distributions_all
	 where match_status_flag = 'A')
      	order by
      	wmtc.web_transaction_id
  
/

/*----------------------------------------------------------------------*/
--      Create View WM_AP_INVOICES_LINES_VW
/*----------------------------------------------------------------------*/

create or replace view wm_ap_invoices_lines_vw
(
      	invoice_id,
	line_number ,	  
      	line_type ,
      	line_group_number,
	status,
      	amount ,
      	accounting_date ,
      	description , 
	amount_includes_tax_flag,
      	tax_codes ,
	prorate_accross_flag, -- used for inbound only
      	po_number ,
      	po_line_number ,
      	po_shipment_num,
      	po_distribution_num ,
      	po_unit_of_measure ,
      	item_description, 
	quantity_invoiced ,
      	ship_to_loc_address_line_1 ,
      	ship_to_loc_address_line_2 ,
      	ship_to_loc_address_line_3 ,
      	ship_to_loc_town_or_city,
      	ship_to_loc_county,
      	ship_to_loc_state,
      	ship_to_loc_postal_code,
      	ship_to_loc_country,
      	unit_price ,
      	distribution_set_name ,--used for inbound only
      	dist_code_concatenated,
      	awt_group_name ,
	release_num,
	account_segment, --used for inbound only
	balancing_segment, --used for inbound only
	cost_center_segment, --used for inbound only
      	project_name ,
      	task ,
      	expenditure_type ,
      	expenditure_item_date ,
      	expenditure_organization_name ,
	project_accounting_context,
	pa_addition_flag,
	pa_quantity, 
      	ussgl_transaction_code ,
      	stat_amount ,
      	type_1099 ,
      	income_tax_region_name ,
      	organization_name,
      	receipt_number,
      	receipt_line_num,
	rcv_transaction_id,
	--rcv_transaction_id,
      	--rcv_transaction_type,
	pa_cc_ar_invoice_id,
	pa_cc_ar_invoice_line_number,
	pa_reference1,
	pa_reference2,
	pa_cc_processed_code,
      	match_option,
      	packing_slip,
      	tax_recovery_rate,
	tax_recovery_override_flag,
	tax_recoverable_flag,
	tax_override_flag,
	credit_card_trx_id,
	award_name,
	asset_tracking_flag,
	price_correction_flag
) as
select
      	aid.invoice_id,
	aid.distribution_line_number line_number ,	  
      	aid.line_type_lookup_code line_type ,
      	aid.line_group_number line_group_number,
	decode(UPPER(aid.match_status_flag) , null,'NEVER APPROVED', 'N', 'NEVER APPROVED', 'T', 'NEEDS REAPPROVAL', 'A', 'APPROVED', 'S', 'NEVER APPROVED') status,
      	aid.amount amount ,
      	aid.accounting_date accounting_date ,
      	aid.description description , 
	aid.amount_includes_tax_flag amount_includes_tax_flag,
      	tc.tax_type tax_codes ,
	null prorate_accross_flag, -- used for inbound only
      	ph.segment1 po_number ,
      	pl.line_num po_line_number ,
      	pll.shipment_num shipment_num,
      	pd.distribution_num distribution_num ,
      	pl.unit_meas_lookup_code unit_meas_lookup_code ,
      	msi.description item_description, 
	aid.quantity_invoiced quantity_invoiced ,
      	hrl.address_line_1 ship_to_loc_address_line_1 ,
      	hrl.address_line_2 ship_to_loc_address_line_2 ,
      	hrl.address_line_3 ship_to_loc_address_line_3 ,
      	hrl.town_or_city ship_to_loc_town_or_city,
      	hrl.region_1 ship_to_loc_county,
      	hrl.region_2 ship_to_loc_state,
      	hrl.postal_code ship_to_loc_postal_code,
      	hrl.country ship_to_loc_country,
      	aid.unit_price unit_price ,
      	null distribution_set_name ,--used for inbound only
      	glcd.concatenated_segments dist_code_concatenated,
      	awt.name awt_group_name ,
	ph.revision_num release_num,
	null account_segment, --used for inbound only
	null balancing_segment, --used for inbound only
	null cost_center_segment, --used for inbound only
      	pap.segment1 project ,
      	pat.task_name task ,
      	aid.expenditure_type expenditure_type ,
      	aid.expenditure_item_date expenditure_item_date ,
      	haotl.name expenditure_organization_name ,
	aid.project_accounting_context project_accounting_context,
	aid.pa_addition_flag pa_addition_flag,
	aid.pa_quantity pa_quantity, 
      	aid.ussgl_transaction_code ussgl_transaction_code ,
      	aid.stat_amount stat_amount ,
      	aid.type_1099 type_1099 ,
      	aitr.region_long_name income_tax_region_name ,
      	haotl.name org_name,
      	rsh.receipt_num receipt_number,
      	rsl.line_num receipt_line_num,
	aid.rcv_transaction_id rcv_transaction_id,
	--rtxns.transaction_id rcv_transaction_id,
      	--rtxns.transaction_type rcv_transaction_type,
	aid.pa_cc_ar_invoice_id pa_cc_ar_invoice_id,
	aid.pa_cc_ar_invoice_line_num pa_cc_ar_invoice_line_number,
	aid.reference_1 pa_reference1,
	aid.reference_2 pa_reference2,
	aid.pa_cc_processed_code pa_cc_processed_code,
      	decode(UPPER(pll.match_option), 'P','MATCH TO PURCHASE ORDER','R','MATCH TO RECEIPT',null) match_option,
      	rsh.packing_slip packing_slip,
      	aid.tax_recovery_rate tax_recovery_rate,
	aid.tax_recovery_override_flag tax_recovery_override_flag,
	aid.tax_recoverable_flag tax_recoverable_flag,
	aid.tax_code_override_flag tax_override_flag,
	aid.credit_card_trx_id credit_card_trx_id,
	gaa.award_full_name award_name,
	aid.assets_tracking_flag asset_tracking_flag,
	aid.price_adjustment_flag price_correction_flag
from
      	ap_invoice_distributions_all aid,
      	ap_awt_groups awt,
      	ap_income_tax_regions aitr,
      	ap_lookup_codes alc1,
      	ap_lookup_codes alc2,
      	ap_lookup_codes alc3,
      	ap_lookup_codes alc4,
      	ap_tax_codes_all tc,
      	hr_all_organization_units_tl haotl,
	gl_code_combinations_kfv glcd,
	hr_locations hrl,
	mtl_system_items msi,
      	pa_projects_all pap,
      	pa_tasks pat,
      	po_headers_all ph,
      	po_lines_all pl,
      	po_line_locations_all pll, 
	po_distributions_all pd,
      	rcv_transactions rtxns,
      	rcv_shipment_headers rsh,
      	rcv_shipment_lines rsl,
	gms_awards_all gaa
where
      	aid.income_tax_region = aitr.region_short_name (+) and
      	alc1.lookup_type (+) = 'INVOICE DISTRIBUTION TYPE' and
      	alc1.lookup_code (+) = aid.line_type_lookup_code and
        alc2.lookup_type (+) = 'NLS TRANSLATION' and
        alc2.lookup_code (+) = decode(UPPER(aid.match_status_flag) , null,'NEVER APPROVED', 'N', 'NEVER APPROVED', 'T', 'NEEDS REAPPROVAL', 'A', 'APPROVED', 'S', 'NEVER APPROVED') and
        alc3.lookup_type (+) = 'AWT FLAG' and
        alc3.lookup_code (+) = aid.awt_flag and
        alc4.lookup_type (+) = 'POSTING STATUS' and
        alc4.lookup_code (+) = ap_invoice_distributions_pkg .get_posted_status( aid.accrual_posted_flag, aid.cash_posted_flag, aid.posted_flag) and
      	aid.project_id = pap.project_id (+) and
      	aid.task_id = pat.task_id (+) and
      	aid.expenditure_organization_id = haotl.organization_id (+) and
      	aid.po_distribution_id = pd.po_distribution_id (+) and
      	pd.po_header_id = ph.po_header_id (+) and
      	pd.line_location_id = pll.line_location_id (+) and
      	pll.po_line_id = pl.po_line_id (+) and
      	aid.awt_group_id = awt.group_id (+) and
      	aid.tax_code_id = tc.tax_id (+) and
      	aid.rcv_transaction_id = rtxns.transaction_id (+) and
      	rtxns.shipment_line_id = rsl.shipment_line_id (+) and
      	rsl.shipment_header_id = rsh.shipment_header_id (+) and
      	-- tcs addition starts
	pl.item_id  = msi.inventory_item_id (+) and
	aid.org_id = 	haotl.organization_id (+) and
	aid.dist_code_combination_id = glcd.code_combination_id (+) and
	pll.ship_to_location_id = hrl.location_id (+) and
	aid.award_id = gaa.award_id (+)
/
 
/*----------------------------------------------------------------------*/
--      Create View WM_AP_INVOICES_QRY_VW
/*----------------------------------------------------------------------*/

create or replace view wm_ap_invoices_qry_vw 
(
	web_transaction_id, 
	document_type,
	document_status,
	invoice_id,
	invoice_num ,
	invoice_type,
	invoice_date ,
	po_number ,
	vendor_number ,
	vendor_name ,
	vendor_site_address_line1,
	vendor_site_address_line2,
	vendor_site_address_line3,
	vendor_town_or_city,
	vendor_county,
	vendor_state,
	vendor_postal_code,
	vendor_country,
	invoice_amount ,
	invoice_currency_code ,
	exchange_rate ,
      	exchange_rate_type ,
      	terms_name ,
      	exchange_rate_date ,
      	description ,
	awt_group_name ,
	source ,
      	payment_cross_rate_type ,
      	payment_cross_rate_date ,
	payment_cross_rate ,
	payment_currency_code ,
	workflow,
	doc_category_code ,
	voucher_num ,
	payment_method_lookup_code ,
	pay_group_lookup_code ,
	goods_received_date ,
	invoice_received_date ,
	gl_date ,
	liability_account,
	ussgl_transaction_code ,
	exclusive_payment ,
	organization_name,
	amount_applicable_to_discount ,
	prepay_num,
	prepay_dist_num,
	prepay_apply_amount,
	prepay_gl_date 
) as
select
	NULL, 
	'APINVOICE',
	'QUERY',
	ai.invoice_id,
	ai.invoice_num invoice_num ,
	ai.invoice_type_lookup_code invoice_type_lookup_code ,
	ai.invoice_date invoice_date ,
	ap_invoices_pkg.get_po_number( ai.invoice_id) po_number ,
	pv.segment1 vendor_number ,
	pv.vendor_name vendor_name ,
	pvs.address_line1 address_line1,
	pvs.address_line2 address_line2,
	pvs.address_line3 address_line3,
	pvs.city  city,
	pvs.county county,
	pvs.state state,
	pvs.zip zip,
	pvs.country country,
	ai.invoice_amount invoice_amount ,
	ai.invoice_currency_code invoice_currency_code ,
      	ai.exchange_rate exchange_rate ,
      	ai.exchange_rate_type exchange_rate_type ,
      	at.name terms_name ,
      	ai.exchange_date exchange_date ,
      	ai.description description ,
	awt.name awt_group_name ,
	ai.source source ,
      	ai.payment_cross_rate_type payment_cross_rate_type,
      	ai.payment_cross_rate_date payment_cross_rate_date,
	ai.payment_cross_rate payment_cross_rate ,
	ai.payment_currency_code payment_currency_code ,
	null workflow, -- y -->'to be processed', s --> 'processing', d --> 'processed', null --> 'not applicable'
	ai.doc_category_code doc_category_code ,
	ai.voucher_num voucher_num ,
	ai.payment_method_lookup_code payment_method_lookup_code ,
	ai.pay_group_lookup_code pay_group_lookup_code ,
	ai.goods_received_date goods_received_date ,
	ai.invoice_received_date invoice_received_date ,
	ai.gl_date gl_date ,
	glcl.concatenated_segments liability_account,	  
	ai.ussgl_transaction_code ussgl_transaction_code ,
	ai.exclusive_payment_flag exclusive_payment_flag ,
	haotl.name org_name,
	ai.amount_applicable_to_discount amount_applicable_to_discount ,
	null prepay_invoice_num , --aip.invoice_num
	null prepay_dist_num, --aidp.distribution_line_number
	null  prepay_apply_amount , --aidp.prepay_amount_remaining
	null prepay_accounting_date --ai.gl_date
from 
      	ap_invoices_all ai,
      	ap_terms at,
      	po_vendors pv,
      	po_vendor_sites_all pvs,
      	ap_lookup_codes alc1,
      	ap_lookup_codes alc2,
	ap_awt_groups awt,
	hr_all_organization_units_tl haotl,	  
	gl_code_combinations_kfv glcl
where
      	ai.terms_id = at.term_id (+) and
      	alc1.lookup_type (+) = 'INVOICE TYPE' and
      	alc1.lookup_code (+) = ai.invoice_type_lookup_code and
      	alc2.lookup_type (+) = 'PAYMENT METHOD' and
      	alc2.lookup_code (+) = ai.payment_method_lookup_code and
      	ai.vendor_id = pv.vendor_id (+) and
      	ai.vendor_site_id = pvs.vendor_site_id (+) and
	ai.awt_group_id = awt.group_id (+) and
	ai.accts_pay_code_combination_id = glcl.code_combination_id (+) and
	ai.org_id = haotl.organization_id (+) and	 
	ai.org_id = pvs.org_id (+)
/	

SHOW ERRORS


