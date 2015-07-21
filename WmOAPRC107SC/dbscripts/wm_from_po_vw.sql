/*  ***************************************************************************
    *    $Date:   12 NOV 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for PO outbound in Application Schema  
    * Program Name:         wm_from_po_vw.sql
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
     12-NOV-02	   Rajib Naha		   Created
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
  decode(pod1.expenditure_type,null,'N','Y'),
  pod1.line_location_id
from 
  po_requisition_headers_all porh,
  po_requisition_lines_all porl,
  po_distributions_all pod1,
  hr_locations hl,
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
  pa_expenditure_types pe
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
  pod1.expenditure_organization_id =  do.organization_id (+)
/


/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_LINE_LOCATIONS_VW 
/*----------------------------------------------------------------------*/

create or replace view wm_po_line_locations_vw 
( 
  shipment_num,   
  ship_to_organization_name,
  ship_to_location,
  ship_to_loc_address_line_1,
  ship_to_loc_address_line_2,
  ship_to_loc_address_line_3,
  ship_to_loc_town_or_city,
  ship_to_location_country,
  ship_to_location_postal_code,
  ship_to_location_region_1,
  ship_to_location_region_2,
  ship_to_location_region_3,
  need_by_date, 
  promised_date, 
  price_discount,   
  effective_start_date, 
  expiration_end_date, 
  lead_time, 
  lead_time_unit,   
  inspection_required_flag,   
  receipt_required_flag, 
  receive_close_tolerance, 
  invoice_close_tolerance, 
  qty_rcv_exception_code,   
  days_early_receipt_allowed, 
  days_late_receipt_allowed, 
  enforce_ship_to_location_code, 
  receipt_days_exception_code, 
  accrue_on_receipt_flag, 
  allow_substitute_receipts_flag,   
  line_location_id,
  po_line_id,
  cancel_flag, 
  cancel_reason, 
  cancel_date, 
  closed_flag, 
  closed_reason, 
  closed_date
  ) as 
select 
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
/


/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_LINES_VW
/*----------------------------------------------------------------------*/

create or replace view wm_po_lines_vw
( 
  line_num,
  line_type, 
  item_revision, 
  item_description, 
  unit_meas_lookup_code,   
  committed_amount, 
  allow_price_override_flag, 
  not_to_exceed_price,   
  list_price_per_unit, 
  unit_price, 
  quantity, 
  vendor_product_num,   
  un_number, 
  hazard_class,   
  min_order_quantity, 
  max_order_quantity, 
  qty_rcv_tolerance, 
  over_tolerance_error_flag,   
  market_price, 
  firm_status_lookup_code, 
  note_to_vendor,   
  taxable_flag, 
  tax_name,   
  type_1099, 
  capital_expense_flag, 
  negotiated_by_preparer_flag, 
  min_release_amount,   
  price_type_lookup_code, 
  price_break_lookup_code, 
  transaction_reason_code, 
  ussgl_transaction_code, 
  item,  
  uom_code,  
  category,
  from_header_num,
  unit_weight,
  weight_uom_code,
  volume_uom_code,
  unit_volume,
  sourcing_rule_name,
  action,
  po_line_id,
  po_header_id,
  cancel_flag, 
  cancel_reason, 
  cancel_date, 
  closed_flag, 
  closed_reason, 
  closed_date
) as 
select 
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
  msi.unit_weight,
  msi.weight_uom_code,
  msi.volume_uom_code,
  msi.unit_volume,
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
  mtl_categories_kfv mckfv,
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
  pol.tax_name = atc.name(+) and
  pol.category_id = mckfv.category_id (+) and
  pol.from_header_id = poh.po_header_id (+) and
  pol.from_line_id = pol1.po_line_id (+) and
  msr.organization_id (+) = pol.org_id and
  fsp.org_id (+) = pol.org_id
/     


/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_HEADERS_VW 
/*----------------------------------------------------------------------*/

create or replace view wm_po_headers_vw 
( 
 web_transaction_id, 
 document_type,
 document_status,
 creation_date,
 status,
 organization_name,
 comments,
 acceptance_required_flag,
 acceptance_due_date,   
 firm_status_lookup_code, 
 frozen_flag,   
 amount_limit, 
 min_release_amount,
 approval_required_flag,   
 closed_code, 
 ship_via_lookup_code, 
 freight_terms_lookup_code,
 rate_type,   
 rate, 
 from_type_lookup_code, 
 end_date, 
 authorization_status,   
 revised_date, 
 note_to_vendor, 
 print_count,   
 reply_date, 
 document_num,   
 ship_to_address_line_1,
 ship_to_address_line_2,
 ship_to_address_line_3,
 ship_to_town_or_city,
 ship_to_country,
 ship_to_postal_code,
 ship_to_region_1,
 ship_to_region_2,
 ship_to_region_3,
 bill_to_address_line_1,
 bill_to_address_line_2,
 bill_to_address_line_3,
 bill_to_town_or_city,
 bill_to_country,
 bill_to_postal_code,
 bill_to_region_1,
 bill_to_region_2,
 bill_to_region_3,
 fob_lookup_code, 
 currency_code,
 rate_date,   
 start_date, 
 blanket_total_amount,
 revision_num,  
 approved_date, 
 note_to_receiver, 
 printed_date,   
 confirming_order_flag, 
 reply_method_lookup_code, 
 type_lookup_code, 
 ussgl_transaction_code,
 closed_date, 
 rfq_close_date, 
 quote_warning_delay, 
 quote_vendor_quote_number, 
 agent_name,  
 doc_subtype,
 vendor_name,   
 address_line1,  
 address_line2, 
 address_line3, 
 city, 
 state,   
 zip, 
 country, 
 phone, 
 fax, 
 vendor_contact, 
 payment_terms, 
 release_num,
 interface_source_code,
 po_header_id 
 ) as 
select 
  wmtc.web_transaction_id ,
  wmtc.transaction_type ,
  decode(wmtc.transaction_status,0,'UPDATE',1,'INSERT',2,'DELETE'),
  poh.creation_date,
  wm_order_status_pkg.get_po_status(poh.po_header_id) ,
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
  poh.authorization_status ,
  poh.revised_date ,
  poh.note_to_vendor ,
  poh.print_count ,
  poh.reply_date ,
  poh.segment1 ,
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
  por.release_num,
  null,
  poh.po_header_id
from 
  po_document_types_all pdtt,
  po_lookup_codes polc,
  po_lookup_codes polc2,
  po_lookup_codes polc3,
  ap_terms at,
  per_all_people_f p,
  po_vendors v,
  po_vendor_sites_all vs,
  po_vendor_contacts vc,
  hr_locations hrl1,
  hr_locations hrl2,
  hr_organization_units hou,
  po_headers_all poh,
  po_releases_all por,
  wm_track_changes_vw wmtc
where 
  poh.agent_id = p.person_id and
  p.business_group_id = (select nvl(max(fsp.business_group_id),0) from financials_system_params_all fsp where fsp.org_id = poh.org_id) and
  trunc(sysdate) between p.effective_start_date and  p.effective_end_date and
  p.employee_number is not null and
  ( ( pdtt.document_type_code in ( 'PO','PA') and  pdtt.document_subtype = poh.type_lookup_code ) ) and
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
  pdtt.org_id (+) = poh.org_id and
  vs.org_id (+) = poh.org_id and
  poh.org_id = hou.organization_id (+) and
  por.po_header_id (+) = poh.po_header_id and
  poh.po_header_id = wmtc.transaction_id and
  transaction_status <= 2 and
  wmtc.transaction_type = 'PO' and
  poh.approved_flag = 'Y'
/

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_PO_QRY_VW 
/*----------------------------------------------------------------------*/

create or replace view wm_po_qry_vw 
( 
 web_transaction_id, 
 document_type,
 document_status,
 creation_date,
 status,
 organization_name,
 comments,
 acceptance_required_flag,
 acceptance_due_date,   
 firm_status_lookup_code, 
 frozen_flag,   
 amount_limit, 
 min_release_amount,
 approval_required_flag,   
 closed_code, 
 ship_via_lookup_code, 
 freight_terms_lookup_code,
 rate_type,   
 rate, 
 from_type_lookup_code, 
 end_date, 
 authorization_status,   
 revised_date, 
 note_to_vendor, 
 print_count,   
 reply_date, 
 document_num,   
 ship_to_address_line_1,
 ship_to_address_line_2,
 ship_to_address_line_3,
 ship_to_town_or_city,
 ship_to_country,
 ship_to_postal_code,
 ship_to_region_1,
 ship_to_region_2,
 ship_to_region_3,
 bill_to_address_line_1,
 bill_to_address_line_2,
 bill_to_address_line_3,
 bill_to_town_or_city,
 bill_to_country,
 bill_to_postal_code,
 bill_to_region_1,
 bill_to_region_2,
 bill_to_region_3,
 fob_lookup_code, 
 currency_code,
 rate_date,   
 start_date, 
 blanket_total_amount,
 revision_num,  
 approved_date, 
 note_to_receiver, 
 printed_date,   
 confirming_order_flag, 
 reply_method_lookup_code, 
 type_lookup_code, 
 ussgl_transaction_code,
 closed_date, 
 rfq_close_date, 
 quote_warning_delay, 
 quote_vendor_quote_number, 
 agent_name,  
 doc_subtype,
 vendor_name,   
 address_line1,  
 address_line2, 
 address_line3, 
 city, 
 state,   
 zip, 
 country, 
 phone, 
 fax, 
 vendor_contact, 
 payment_terms, 
 release_num,
 interface_source_code,
 po_header_id 
 ) as 
select 
  null ,
  'PO' ,
  'QUERY',
  poh.creation_date,
  wm_order_status_pkg.get_po_status(poh.po_header_id) ,
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
  poh.authorization_status ,
  poh.revised_date ,
  poh.note_to_vendor ,
  poh.print_count ,
  poh.reply_date ,
  poh.segment1 ,
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
  por.release_num,
  null,
  poh.po_header_id
from 
  po_document_types_all pdtt,
  po_lookup_codes polc,
  po_lookup_codes polc2,
  po_lookup_codes polc3,
  ap_terms at,
  per_all_people_f p,
  po_vendors v,
  po_vendor_sites_all vs,
  po_vendor_contacts vc,
  hr_locations hrl1,
  hr_locations hrl2,
  hr_organization_units hou,
  po_headers_all poh,
  po_releases_all por
where 
  poh.agent_id = p.person_id and
  p.business_group_id = (select nvl(max(fsp.business_group_id),0) from financials_system_params_all fsp where fsp.org_id = poh.org_id) and
  trunc(sysdate) between p.effective_start_date and  p.effective_end_date and
  p.employee_number is not null and
  ( ( pdtt.document_type_code in ( 'PO','PA') and  pdtt.document_subtype = poh.type_lookup_code ) ) and
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
  pdtt.org_id (+) = poh.org_id and
  vs.org_id (+) = poh.org_id and
  poh.org_id = hou.organization_id (+) and
  por.po_header_id (+) = poh.po_header_id

/

SHOW ERRORS
/
