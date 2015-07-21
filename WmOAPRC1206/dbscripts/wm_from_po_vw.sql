/*  ***************************************************************************
    *    $Date:   24 Sep 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for PO outbound in Application Schema  
    * Program Name:         wm_out_vendor_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for PO Outbound
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
     12-AUG-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_po_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_DISTRIBUTIONS_VW 
/*----------------------------------------------------------------------*/

create or replace view wm_po_distributions_vw 
( rate_date,   
  amount_billed, 
  encumbered_amount, 
  gl_encumbered_period_name,   
  wip_resource_seq_num, 
  destination_context, 
  ussgl_transaction_code,
  expenditure_type,  
  project_accounting_context,
  gl_closed_date,   
  accrue_on_receipt_flag, 
  expenditure_item_date, 
  quantity_ordered, 
  quantity_delivered, 
  quantity_cancelled,   
  quantity_billed, 
  req_header_reference_num, 
  req_line_reference_num, 
  rate, 
  accrued_flag, 
  encumbered_flag,   
  unencumbered_quantity, 
  unencumbered_amount, 
  gl_encumbered_date, 
  gl_cancelled_date,   
  destination_type_code, 
  destination_subinventory, 
  wip_operation_seq_num, 
  distribution_num, 
  prevent_encumbrance_flag, 
  recoverable_tax, 
  nonrecoverable_tax,   
  recovery_rate, 
  tax_recovery_override_flag, 
  delivery_to_location,
  delivery_to_person_full_name,
  destination_organization,
  set_of_books,
  charge_account, 
  budget_account,
  accural_account, 
  variance_account,
  wip_entity, 
  wip_repetitive_schedule,
  wip_line_code,
  bom_resource, 
  project_name,
  task_name,
  expenditure,
  expenditure_org_name, 
  project_related_flag,
  award_full_name,
  line_location_id
) as 
select 
  pod1.rate_date ,
  pod1.amount_billed ,
  pod1.encumbered_amount ,
  pod1.gl_encumbered_period_name ,
  pod1.wip_resource_seq_num ,
  pod1.destination_context ,
  pod1.ussgl_transaction_code ,
  pod1.expenditure_type ,
  pod1.project_accounting_context ,
  pod1.gl_closed_date ,
  pod1.accrue_on_receipt_flag ,
  pod1.expenditure_item_date ,
  pod1.quantity_ordered ,
  nvl(pod1.quantity_delivered,  0) ,
  pod1.quantity_cancelled ,
  nvl(pod1.quantity_billed,  0) ,
  decode(pod1.req_distribution_id,  null,  pod1.req_header_reference_num,  porh.segment1) ,  
  decode(pod1.req_distribution_id,  null,  pod1.req_line_reference_num,  porl.line_num) ,
  pod1.rate ,
  pod1.accrued_flag ,
  pod1.encumbered_flag ,
  pod1.unencumbered_quantity ,
  pod1.unencumbered_amount ,
  pod1.gl_encumbered_date ,
  pod1.gl_cancelled_date ,
  pod1.destination_type_code ,
  pod1.destination_subinventory ,
  pod1.wip_operation_seq_num ,
  pod1.distribution_num ,
  pod1.prevent_encumbrance_flag ,
  pod1.recoverable_tax ,
  pod1.nonrecoverable_tax ,
  pod1.recovery_rate ,
  pod1.tax_recovery_override_flag ,
  hl.location_code,
  dp.full_name,
  do.name,
  glsb.name, 
  glcc.concatenated_segments,
  glcb.concatenated_segments,
  glca.concatenated_segments,
  glcv.concatenated_segments,
  we.wip_entity_name,
  wrs.description, 
  wl.line_code,
  br.resource_code,
  pp.name,
  pt.task_name,
  pe.description,
  do.name,
  decode(pod1.expenditure_type,null,'n','y'),
  gaa.award_full_name,
  pod1.line_location_id
from 
  po_requisition_headers_all porh,
  po_requisition_lines_all porl,
  po_distributions_all pod1,
  hr_locations_all hl,
  per_people_f dp,
  po_lookup_codes polc,
  hr_all_organization_units do,
  gl_sets_of_books glsb,
  gl_code_combinations_kfv glcc,
  gl_code_combinations_kfv glcb,
  gl_code_combinations_kfv glca,
  gl_code_combinations_kfv glcv,
  wip_entities we,
  wip_lines wl,
  wip_repetitive_schedules wrs,
  bom_resources br,
  pa_projects_all pp,
  pa_tasks pt,
  pa_expenditure_types pe,
  gms_awards_all gaa
where 
  pod1.req_header_reference_num =  porh.segment1 (+) AND
  pod1.req_line_reference_num =  porl.line_num (+) AND
  pod1.deliver_to_location_id = hl.location_id (+) and
  pod1.deliver_to_person_id = dp.person_id (+) and
  pod1.destination_type_code = polc.lookup_code (+) and
  polc.lookup_type (+) = 'DESTINATION TYPE' and
  pod1.destination_organization_id =  do.organization_id (+) and
  pod1.set_of_books_id = glsb.set_of_books_id (+) and
  pod1.code_combination_id = glcc.code_combination_id (+) and
  pod1.budget_account_id = glcb.code_combination_id (+) and
  pod1.accrual_account_id = glca.code_combination_id (+) and
  pod1.variance_account_id = glcv.code_combination_id (+) and
  pod1.wip_entity_id = we.wip_entity_id (+) and
  pod1.org_id = we.organization_id (+) and
  pod1.wip_line_id = wl.line_id (+) and
  pod1.org_id = wl.organization_id (+) and
  pod1.wip_repetitive_schedule_id = wrs.repetitive_schedule_id (+) and
  pod1.org_id = wrs.organization_id (+) and
  pod1.bom_resource_id = br.resource_id (+) and
  pod1.project_id = pp.project_id (+) and 
  pod1.task_id = pt.task_id (+) and
  pod1.expenditure_type = pe.expenditure_type (+) and
  pod1.expenditure_organization_id =  do.organization_id (+) and
  pod1.award_id = gaa.award_id (+) 
/


/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_LINE_LOCATIONS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_PO_LINE_LOCATIONS_VW ( SHIPMENT_NUM, 
SHIP_TO_ORGANIZATION_NAME, SHIP_TO_LOCATION, SHIP_TO_LOC_ADDRESS_LINE_1, SHIP_TO_LOC_ADDRESS_LINE_2, 
SHIP_TO_LOC_ADDRESS_LINE_3, SHIP_TO_LOC_TOWN_OR_CITY, SHIP_TO_LOCATION_COUNTRY, SHIP_TO_LOCATION_POSTAL_CODE, 
SHIP_TO_LOCATION_REGION_1, SHIP_TO_LOCATION_REGION_2, SHIP_TO_LOCATION_REGION_3, NEED_BY_DATE, 
PROMISED_DATE, PRICE_DISCOUNT, EFFECTIVE_START_DATE, EXPIRATION_END_DATE, 
LEAD_TIME, LEAD_TIME_UNIT, INSPECTION_REQUIRED_FLAG, RECEIPT_REQUIRED_FLAG, 
RECEIVE_CLOSE_TOLERANCE, INVOICE_CLOSE_TOLERANCE, QTY_RCV_EXCEPTION_CODE, DAYS_EARLY_RECEIPT_ALLOWED, 
DAYS_LATE_RECEIPT_ALLOWED, ENFORCE_SHIP_TO_LOCATION_CODE, RECEIPT_DAYS_EXCEPTION_CODE, ACCRUE_ON_RECEIPT_FLAG, 
ALLOW_SUBSTITUTE_RECEIPTS_FLAG, TAX_USER_OVERRIDE_FLAG, LINE_LOCATION_ID, PO_LINE_ID, 
CANCEL_FLAG, CANCEL_REASON, CANCEL_DATE, CLOSED_FLAG, CLOSED_REASON, CLOSED_DATE ) AS select  
pll.shipment_num ,  
ood.organization_name,  
hrl.description,  
hrl.address_line_1,  
hrl.address_line_2,  
hrl.address_line_3,  
hrl.town_or_city,  
hrl.country,  
hrl.postal_code,  
hrl.region_1,  
hrl.region_2,  
hrl.region_3,  
pll.need_by_date ,  
pll.promised_date ,  
pll.price_discount ,  
pll.start_date ,  
pll.end_date ,  
pll.lead_time ,  
pll.lead_time_unit ,  
pll.inspection_required_flag ,  
pll.receipt_required_flag ,  
pll.receive_close_tolerance ,  
pll.invoice_close_tolerance ,  
pll.qty_rcv_exception_code ,  
pll.days_early_receipt_allowed ,  
pll.days_late_receipt_allowed ,  
pll.enforce_ship_to_location_code ,  
pll.receipt_days_exception_code ,  
pll.accrue_on_receipt_flag ,  
pll.allow_substitute_receipts_flag ,  
pll.tax_user_override_flag,  
pll.line_location_id,  
pll.po_line_id,
pll.cancel_flag,
pll.cancel_reason,
pll.cancel_date,
pll.closed_flag,
pll.closed_reason,
pll.closed_date    
from  
hr_locations hrl,  
po_lookup_codes polc1,  
po_lookup_codes polc2,  
org_organization_definitions ood,  
po_line_locations_all pll  
where  
pll.shipment_type in ('STANDARD', 'PLANNED', 'PRICE BREAK','RFQ', 'QUOTATION') and  
hrl.location_id (+) = pll.ship_to_location_id and  
ood.organization_id(+) = pll.ship_to_organization_id and  
polc1.lookup_type(+) = 'DOCUMENT STATE' and  
polc1.lookup_code(+) = nvl(pll.closed_code, 'OPEN') and  
polc2.lookup_type (+) = 'DOCUMENT STATE' and  
polc2.lookup_code (+) = 'CANCELLED'  
order by pll.shipment_num asc
/


/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_LINES_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_PO_LINES_VW ( LINE_NUM, 
LINE_TYPE, ITEM_REVISION, ITEM_DESCRIPTION, UNIT_MEAS_LOOKUP_CODE, 
COMMITTED_AMOUNT, ALLOW_PRICE_OVERRIDE_FLAG, NOT_TO_EXCEED_PRICE, LIST_PRICE_PER_UNIT, 
UNIT_PRICE, QUANTITY, VENDOR_PRODUCT_NUM, UN_NUMBER, 
HAZARD_CLASS, MIN_ORDER_QUANTITY, MAX_ORDER_QUANTITY, QTY_RCV_TOLERANCE, 
OVER_TOLERANCE_ERROR_FLAG, MARKET_PRICE, FIRM_STATUS_LOOKUP_CODE, NOTE_TO_VENDOR, 
TAXABLE_FLAG, TAX_NAME, TYPE_1099, CAPITAL_EXPENSE_FLAG, 
NEGOTIATED_BY_PREPARER_FLAG, MIN_RELEASE_AMOUNT, PRICE_TYPE_LOOKUP_CODE, PRICE_BREAK_LOOKUP_CODE, 
TRANSACTION_REASON_CODE, USSGL_TRANSACTION_CODE, ITEM, UOM_CODE, 
CATEGORY, FROM_HEADER_NUM, LINE_REFERENCE_NUM, UNIT_WEIGHT, 
WEIGHT_UOM_CODE, VOLUME_UOM_CODE, UNIT_VOLUME, PRICE_UPDATE_TOLERANCE, 
TEMPLATE_NAME, SOURCING_RULE_NAME, ACTION, PO_LINE_ID, 
PO_HEADER_ID, CANCEL_FLAG, CANCEL_REASON, CANCEL_DATE, CLOSED_FLAG, CLOSED_REASON, CLOSED_DATE ) AS select  
pol.line_num ,  
plt.line_type ,  
pol.item_revision ,  
pol.item_description ,  
pol.unit_meas_lookup_code ,  
pol.committed_amount ,  
pol.allow_price_override_flag ,  
pol.not_to_exceed_price ,  
pol.list_price_per_unit ,  
pol.unit_price ,  
pol.quantity ,  
pol.vendor_product_num ,  
poun.un_number ,  
phc.hazard_class ,  
pol.min_order_quantity ,  
pol.max_order_quantity ,  
pol.qty_rcv_tolerance ,  
pol.over_tolerance_error_flag ,  
pol.market_price ,  
pol.firm_status_lookup_code ,  
pol.note_to_vendor ,  
pol.taxable_flag ,  
atc.name ,  
pol.type_1099 ,  
pol.capital_expense_flag ,  
pol.negotiated_by_preparer_flag ,  
pol.min_release_amount ,  
pol.price_type_lookup_code ,  
pol.price_break_lookup_code ,  
pol.transaction_reason_code ,  
pol.ussgl_transaction_code ,  
msi.segment1,  
muom.uom_code,  
mckfv.concatenated_segments,  
poh.segment1,  
pol.line_reference_num,  
msi.unit_weight,  
msi.weight_uom_code,  
msi.volume_uom_code,  
msi.unit_volume,  
poh.price_update_tolerance,  
null,  
msr.sourcing_rule_name,  
null,  
pol.po_line_id,  
pol.po_header_id,
pol.cancel_flag,
pol.cancel_reason,
pol.cancel_date,
pol.closed_flag,
pol.closed_reason,
pol.closed_date  
from  
po_line_types plt,  
mtl_units_of_measure muom,  
ap_tax_codes_all atc,  
po_un_numbers poun,  
po_hazard_classes phc,  
po_lookup_codes polc1,  
po_lookup_codes polc2 ,  
mtl_system_items msi,  
financials_system_params_all fsp,  
po_lines_all pol,  
po_lines_all pol1,  
po_headers_all poh,  
mtl_categories_b_kfv mckfv,  
mrp_sourcing_rules msr  
where  
plt.line_type_id (+) = pol.line_type_id and  
muom.unit_of_measure (+) = pol.unit_meas_lookup_code and  
poun.un_number_id (+) = pol.un_number_id and  
phc.hazard_class_id (+) = pol.hazard_class_id and  
polc1.lookup_type (+) = 'PRICE TYPE' and  
polc1.lookup_code (+) = pol.price_type_lookup_code and  
polc2.lookup_type (+)= 'TRANSACTION REASON' and  
polc2.lookup_code (+)= pol.transaction_reason_code and  
msi.inventory_item_id (+) = pol.item_id and  
nvl(msi.organization_id,fsp.inventory_organization_id) = fsp.inventory_organization_id and  
pol.tax_code_id = atc.tax_id(+) and  
pol.taxable_flag = atc.enabled_flag (+) and  
pol.category_id = mckfv.category_id (+) and  
pol.from_header_id = poh.po_header_id (+) and  
pol.from_line_id = pol1.po_line_id (+) and  
msr.organization_id (+) = pol.org_id and  
fsp.org_id = pol.org_id  
Order by pol.line_num asc
/     


/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_HEADERS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_PO_HEADERS_VW ( WEB_TRANSACTION_ID, 
DOCUMENT_TYPE, DOCUMENT_STATUS, ORGANIZATION_NAME, COMMENTS, 
ACCEPTANCE_REQUIRED_FLAG, ACCEPTANCE_DUE_DATE, FIRM_STATUS_LOOKUP_CODE, FROZEN_FLAG, 
AMOUNT_LIMIT, MIN_RELEASE_AMOUNT, APPROVAL_REQUIRED_FLAG, CLOSED_CODE, 
SHIP_VIA_LOOKUP_CODE, FREIGHT_TERMS_LOOKUP_CODE, RATE_TYPE, RATE, 
FROM_TYPE_LOOKUP_CODE, END_DATE, STATUS, AUTHORIZATION_STATUS, REVISED_DATE, 
NOTE_TO_VENDOR, PRINT_COUNT, REPLY_DATE, DOCUMENT_NUM, CREATION_DATE,
SHIP_TO_ADDRESS_LINE_1, SHIP_TO_ADDRESS_LINE_2, SHIP_TO_ADDRESS_LINE_3, SHIP_TO_TOWN_OR_CITY, 
SHIP_TO_COUNTRY, SHIP_TO_POSTAL_CODE, SHIP_TO_REGION_1, SHIP_TO_REGION_2, 
SHIP_TO_REGION_3, BILL_TO_ADDRESS_LINE_1, BILL_TO_ADDRESS_LINE_2, BILL_TO_ADDRESS_LINE_3, 
BILL_TO_TOWN_OR_CITY, BILL_TO_COUNTRY, BILL_TO_POSTAL_CODE, BILL_TO_REGION_1, 
BILL_TO_REGION_2, BILL_TO_REGION_3, FOB_LOOKUP_CODE, CURRENCY_CODE, 
RATE_DATE, START_DATE, BLANKET_TOTAL_AMOUNT, REVISION_NUM, 
APPROVED_DATE, NOTE_TO_RECEIVER, PRINTED_DATE, CONFIRMING_ORDER_FLAG, 
REPLY_METHOD_LOOKUP_CODE, TYPE_LOOKUP_CODE, USSGL_TRANSACTION_CODE, CLOSED_DATE, 
RFQ_CLOSE_DATE, QUOTE_WARNING_DELAY, QUOTE_VENDOR_QUOTE_NUMBER, AGENT_NAME, 
DOC_SUBTYPE, VENDOR_NAME, ADDRESS_LINE1, ADDRESS_LINE2, 
ADDRESS_LINE3, CITY, STATE, ZIP, 
COUNTRY, PHONE, FAX, VENDOR_CONTACT, 
PAYMENT_TERMS, PCARD_NUM, PAY_ON_CODE, RELEASE_NUM, 
INTERFACE_SOURCE_CODE, PO_HEADER_ID ) AS select
  wmtc.web_transaction_id ,
  wmtc.transaction_type ,
  decode(wmtc.transaction_status,0,'UPDATE',1,'INSERT',2,'DELETE'),
  hou.name,
  poh.comments ,
  poh.acceptance_required_flag ,
  poh.acceptance_due_date ,
  poh.firm_status_lookup_code ,
  poh.frozen_flag ,
  poh.amount_limit ,
  poh.min_release_amount ,
  poh.approval_required_flag ,
  poh.closed_code ,
  poh.ship_via_lookup_code ,
  poh.freight_terms_lookup_code ,
  poh.rate_type ,
  poh.rate ,
  poh.from_type_lookup_code ,
  poh.end_date ,
  WM_ORDER_STATUS_PKG.GET_PO_STATUS(POH.PO_HEADER_ID) ,
  poh.authorization_status ,
  poh.revised_date ,
  poh.note_to_vendor ,
  poh.print_count ,
  poh.reply_date ,
  poh.segment1 ,
  poh.creation_date,
  hrl1.address_line_1,
  hrl1.address_line_2,
  hrl1.address_line_3,
  hrl1.town_or_city,
  hrl1.country,
  hrl1.postal_code,
  hrl1.region_1,
  hrl1.region_2,
  hrl1.region_3,
  hrl2.address_line_1,
  hrl2.address_line_2,
  hrl2.address_line_3,
  hrl2.town_or_city,
  hrl2.country,
  hrl2.postal_code,
  hrl2.region_1,
  hrl2.region_2,
  hrl2.region_3,
  poh.fob_lookup_code ,
  poh.currency_code ,
  poh.rate_date ,
  poh.start_date ,
  poh.blanket_total_amount ,
  poh.revision_num ,
  poh.approved_date ,
  poh.note_to_receiver ,
  poh.printed_date ,
  poh.confirming_order_flag ,
  poh.reply_method_lookup_code ,
  poh.type_lookup_code ,
  poh.ussgl_transaction_code ,
  poh.closed_date ,
  poh.rfq_close_date ,
  poh.quote_warning_delay ,
  poh.quote_vendor_quote_number ,
  p.full_name ,
  pdtt.document_subtype,
  v.vendor_name ,
  vs.address_line1 ,
  vs.address_line2 ,
  vs.address_line3 ,
  vs.city ,
  vs.state ,
  vs.zip ,
  vs.country ,
  '('||vs.area_code||') '||vs.phone ,
  '('||vs.fax_area_code||') '||vs.fax ,
  decode(poh.vendor_contact_id, null, null, vc.last_name||','|| vc.first_name),
  at.name ,
  apc.card_number,
  poh.pay_on_code ,
  por.release_num,
  poh.interface_source_code,
  poh.po_header_id
from
  po_document_types_all pdtt,
  po_document_types_all_b pdtb,
  po_lookup_codes polc,
  po_lookup_codes polc2,
  po_lookup_codes polc3,
  po_lookup_codes polc4,
  ap_terms at,
  per_all_people_f p,
  ap_suppliers v,
  AP_SUPPLIER_SITES_ALL vs,
  PO_VENDOR_CONTACTS vc,
  hr_locations hrl1,
  hr_locations hrl2,
  hr_organization_units hou,
  ap_cards_all apc,
  po_headers_all poh,
  po_releases_all por,
  wm_track_changes_vw wmtc
where
  poh.agent_id = p.person_id and
  p.business_group_id = (select nvl(max(fsp.business_group_id),0) from financials_system_params_all fsp where fsp.org_id = poh.org_id) and
  trunc(sysdate) between p.effective_start_date and  p.effective_end_date and
  p.employee_number is not null and
  ( ( pdtb.document_type_code in ( 'PO','PA') and  pdtb.document_subtype = poh.type_lookup_code ) ) and
  v.vendor_id (+) = poh.vendor_id and
  vs.vendor_site_id (+)= poh.vendor_site_id and
  vc.vendor_contact_id (+) = poh.vendor_contact_id and
  at.term_id (+) = poh.terms_id and
  hrl1.location_id (+) = poh.ship_to_location_id and
  hrl2.location_id (+) = poh.bill_to_location_id and
  nvl(poh.authorization_status,'INCOMPLETE') = polc.lookup_code(+) and
  polc.lookup_type(+) = 'AUTHORIZATION STATUS' and
  polc2.lookup_code (+) = poh.fob_lookup_code and
  polc2.lookup_type (+) = 'FOB' and
  polc3.lookup_code (+) = poh.freight_terms_lookup_code and
  polc3.lookup_type (+) = 'FREIGHT TERMS' and
  polc4.lookup_code (+) = poh.pay_on_code and
  polc4.lookup_type (+) = 'PAY ON CODE' and
  pdtb.document_type_code = pdtt.document_type_code and
  pdtb.document_subtype = pdtt.document_subtype and
  nvl(pdtt.org_id, -99) = nvl(pdtb.org_id, -99) and
  pdtb.org_id = poh.org_id and
  vs.org_id (+) = poh.org_id and
  poh.org_id = hou.organization_id (+) and
  por.po_header_id (+) = poh.po_header_id and
  apc.card_id (+) = poh.pcard_id and
  poh.po_header_id = wmtc.transaction_id and
  transaction_status <= 2 and
  wmtc.transaction_type = 'PO' and
  poh.approved_flag = 'Y'
  order by
  wmtc.web_transaction_id
/

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_QRY_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_PO_QRY_VW ( WEB_TRANSACTION_ID, 
DOCUMENT_TYPE, DOCUMENT_STATUS, ORGANIZATION_NAME, COMMENTS, 
ACCEPTANCE_REQUIRED_FLAG, ACCEPTANCE_DUE_DATE, FIRM_STATUS_LOOKUP_CODE, FROZEN_FLAG, 
AMOUNT_LIMIT, MIN_RELEASE_AMOUNT, APPROVAL_REQUIRED_FLAG, CLOSED_CODE, 
SHIP_VIA_LOOKUP_CODE, FREIGHT_TERMS_LOOKUP_CODE, RATE_TYPE, RATE, 
FROM_TYPE_LOOKUP_CODE, END_DATE, STATUS, AUTHORIZATION_STATUS, REVISED_DATE, 
NOTE_TO_VENDOR, PRINT_COUNT, REPLY_DATE, DOCUMENT_NUM, CREATION_DATE, 
SHIP_TO_ADDRESS_LINE_1, SHIP_TO_ADDRESS_LINE_2, SHIP_TO_ADDRESS_LINE_3, SHIP_TO_TOWN_OR_CITY, 
SHIP_TO_COUNTRY, SHIP_TO_POSTAL_CODE, SHIP_TO_REGION_1, SHIP_TO_REGION_2, 
SHIP_TO_REGION_3, BILL_TO_ADDRESS_LINE_1, BILL_TO_ADDRESS_LINE_2, BILL_TO_ADDRESS_LINE_3, 
BILL_TO_TOWN_OR_CITY, BILL_TO_COUNTRY, BILL_TO_POSTAL_CODE, BILL_TO_REGION_1, 
BILL_TO_REGION_2, BILL_TO_REGION_3, FOB_LOOKUP_CODE, CURRENCY_CODE, 
RATE_DATE, START_DATE, BLANKET_TOTAL_AMOUNT, REVISION_NUM, 
APPROVED_DATE, NOTE_TO_RECEIVER, PRINTED_DATE, CONFIRMING_ORDER_FLAG, 
REPLY_METHOD_LOOKUP_CODE, TYPE_LOOKUP_CODE, USSGL_TRANSACTION_CODE, CLOSED_DATE, 
RFQ_CLOSE_DATE, QUOTE_WARNING_DELAY, QUOTE_VENDOR_QUOTE_NUMBER, AGENT_NAME, 
DOC_SUBTYPE, VENDOR_NAME, ADDRESS_LINE1, ADDRESS_LINE2, 
ADDRESS_LINE3, CITY, STATE, ZIP, 
COUNTRY, PHONE, FAX, VENDOR_CONTACT, 
PAYMENT_TERMS, PCARD_NUM, PAY_ON_CODE, RELEASE_NUM, 
INTERFACE_SOURCE_CODE, PO_HEADER_ID ) AS select
  null ,
  'PO' ,
  'QUERY',
  hou.name,
  poh.comments ,
  poh.acceptance_required_flag ,
  poh.acceptance_due_date ,
  poh.firm_status_lookup_code ,
  poh.frozen_flag ,
  poh.amount_limit ,
  poh.min_release_amount ,
  poh.approval_required_flag ,
  poh.closed_code ,
  poh.ship_via_lookup_code ,
  poh.freight_terms_lookup_code ,
  poh.rate_type ,
  poh.rate ,
  poh.from_type_lookup_code ,
  poh.end_date ,
  WM_ORDER_STATUS_PKG.GET_PO_STATUS(POH.PO_HEADER_ID) ,
  poh.authorization_status ,
  poh.revised_date ,
  poh.note_to_vendor ,
  poh.print_count ,
  poh.reply_date ,
  poh.segment1 ,
  poh.creation_date,
  hrl1.address_line_1,
  hrl1.address_line_2,
  hrl1.address_line_3,
  hrl1.town_or_city,
  hrl1.country,
  hrl1.postal_code,
  hrl1.region_1,
  hrl1.region_2,
  hrl1.region_3,
  hrl2.address_line_1,
  hrl2.address_line_2,
  hrl2.address_line_3,
  hrl2.town_or_city,
  hrl2.country,
  hrl2.postal_code,
  hrl2.region_1,
  hrl2.region_2,
  hrl2.region_3,
  poh.fob_lookup_code ,
  poh.currency_code ,
  poh.rate_date ,
  poh.start_date ,
  poh.blanket_total_amount ,
  poh.revision_num ,
  poh.approved_date ,
  poh.note_to_receiver ,
  poh.printed_date ,
  poh.confirming_order_flag ,
  poh.reply_method_lookup_code ,
  poh.type_lookup_code ,
  poh.ussgl_transaction_code ,
  poh.closed_date ,
  poh.rfq_close_date ,
  poh.quote_warning_delay ,
  poh.quote_vendor_quote_number ,
  p.full_name ,
  pdtt.document_subtype,
  v.vendor_name ,
  vs.address_line1 ,
  vs.address_line2 ,
  vs.address_line3 ,
  vs.city ,
  vs.state ,
  vs.zip ,
  vs.country ,
  '('||vs.area_code||') '||vs.phone ,
  '('||vs.fax_area_code||') '||vs.fax ,
  decode(poh.vendor_contact_id, null, null, vc.last_name||','|| vc.first_name),
  at.name ,
  apc.card_number,
  poh.pay_on_code ,
  por.release_num,
  poh.interface_source_code,
  poh.po_header_id
from
  po_document_types_all pdtt,
  po_document_types_all_b pdtb,
  po_lookup_codes polc,
  po_lookup_codes polc2,
  po_lookup_codes polc3,
  po_lookup_codes polc4,
  ap_terms at,
  per_all_people_f p,
  ap_suppliers v,
  AP_SUPPLIER_SITES_ALL vs,
  PO_VENDOR_CONTACTS vc,
  hr_locations hrl1,
  hr_locations hrl2,
  hr_organization_units hou,
  ap_cards_all apc,
  po_headers_all poh,
  po_releases_all por
where
  poh.agent_id = p.person_id and
  p.business_group_id = (select nvl(max(fsp.business_group_id),0) from financials_system_params_all fsp where fsp.org_id = poh.org_id) and
  trunc(sysdate) between p.effective_start_date and  p.effective_end_date and
  p.employee_number is not null and
  ( ( pdtb.document_type_code in ( 'PO','PA') and  pdtb.document_subtype = poh.type_lookup_code ) ) and
  v.vendor_id (+) = poh.vendor_id and
  vs.vendor_site_id (+)= poh.vendor_site_id and
  vc.vendor_contact_id (+) = poh.vendor_contact_id and
  at.term_id (+) = poh.terms_id and
  hrl1.location_id (+) = poh.ship_to_location_id and
  hrl2.location_id (+) = poh.bill_to_location_id and
  nvl(poh.authorization_status,'INCOMPLETE') = polc.lookup_code(+) and
  polc.lookup_type(+) = 'AUTHORIZATION STATUS' and
  polc2.lookup_code (+) = poh.fob_lookup_code and
  polc2.lookup_type (+) = 'FOB' and
  polc3.lookup_code (+) = poh.freight_terms_lookup_code and
  polc3.lookup_type (+) = 'FREIGHT TERMS' and
  polc4.lookup_code (+) = poh.pay_on_code and
  polc4.lookup_type (+) = 'PAY ON CODE' and
  pdtb.document_type_code = pdtt.document_type_code and
  pdtb.document_subtype = pdtt.document_subtype and
  nvl(pdtt.org_id, -99) = nvl(pdtb.org_id, -99) and
  pdtb.org_id = poh.org_id and
  vs.org_id (+) = poh.org_id and
  poh.org_id = hou.organization_id (+) and
  por.po_header_id (+) = poh.po_header_id and
  apc.card_id (+) = poh.pcard_id
/

SHOW ERRORS

