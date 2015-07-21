/*  ***************************************************************************
    *    $Date:   24 Sep 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Inventory Items outbound in Application Schema  
    * Program Name:         wm_from_invitem_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Inventory Items Outbound
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
     16-OCT-02	   Sudip Chaudhuri   	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_invitem_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."


/*----------------------------------------------------------------------*/
--      Create View WM_INV_ITEMS_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_INV_ITEMS_VW
AS
SELECT
wmtc.web_transaction_id web_transaction_id, 
wmtc.transaction_type  document_type,
decode(wmtc.transaction_status,0,'UPDATE',1,'INSERT',2,'DELETE')  document_status,
fvl.inventory_item_id||'-'||fvl.organization_id inv_item_org_id,
item.concatenated_segments item_number,
org.organization_name organization_name,
fvl.summary_flag summary_flag,
fvl.tax_code tax_code,
fvl.enabled_flag enabled_flag,
fvl.start_date_active start_date_active,
fvl.end_date_active end_date_active,
fvl.description description,
perb.full_name buyer_full_name,
raa.name accounting_rule_name,
rai.name invoicing_rule_name,
fvl.purchasing_item_flag purchasing_item_flag,
fvl.shippable_item_flag shippable_item_flag,
fvl.customer_order_flag customer_order_flag,
fvl.internal_order_flag internal_order_flag,
fvl.service_item_flag service_item_flag,
fvl.inventory_item_flag inventory_item_flag,
fvl.eng_item_flag eng_item_flag,
fvl.inventory_asset_flag inventory_asset_flag,
fvl.purchasing_enabled_flag purchasing_enabled_flag,
fvl.customer_order_enabled_flag customer_order_enabled_flag,
fvl.internal_order_enabled_flag internal_order_enabled_flag,
fvl.so_transactions_flag so_transactions_flag,
fvl.mtl_transactions_enabled_flag mtl_transactions_enabled_flag,
fvl.stock_enabled_flag stock_enabled_flag,
fvl.bom_enabled_flag bom_enabled_flag,
fvl.build_in_wip_flag build_in_wip_flag,
mfl_rev.meaning revision_qty_control,
mtcg.description item_catalog_group_description,
fvl.catalog_status_flag catalog_status_flag,
fvl.check_shortages_flag check_shortages_flag,
fvl.returnable_flag returnable_flag,
org_d.organization_name default_ship_organization_name,
fvl.collateral_flag collateral_flag,
fvl.taxable_flag taxable_flag,
fvl.qty_rcv_exception_code qty_rcv_exception_code,
fvl.allow_item_desc_update_flag allow_item_desc_update_flag,
fvl.inspection_required_flag inspection_required_flag,
fvl.receipt_required_flag receipt_required_flag,
fvl.market_price market_price,
haz.hazard_class hazard_class,
fvl.rfq_required_flag rfq_required_flag,
fvl.qty_rcv_tolerance qty_rcv_tolerance,
fvl.list_price_per_unit list_price_per_unit,
fvl.un_number_id un_number_id,
fvl.price_tolerance_percent price_tolerance_percent,
fa.concatenated_segments asset_category,
fvl.rounding_factor rounding_factor,
fvl.unit_of_issue unit_of_issue,
fvl.enforce_ship_to_location_code enforce_ship_to_location_code,
fvl.allow_substitute_receipts_flag allow_substitute_receipts_flag,
fvl.allow_unordered_receipts_flag allow_unordered_receipts_flag,
fvl.allow_express_delivery_flag allow_express_delivery_flag,
fvl.days_early_receipt_allowed days_early_receipt_allowed,
fvl.days_late_receipt_allowed days_late_receipt_allowed,
fvl.receipt_days_exception_code receipt_days_exception_code,
rcv.routing_name receiving_routing_name,
fvl.invoice_close_tolerance invoice_close_tolerance,
fvl.receive_close_tolerance receive_close_tolerance,
fvl.auto_lot_alpha_prefix auto_lot_alpha_prefix,
fvl.start_auto_lot_number start_auto_lot_number,
mfl_lot.meaning lot_control,
mfl_sh.meaning shelf_life,
fvl.shelf_life_days shelf_life_days,
mfl_ser.meaning serial_number_control,
fvl.start_auto_serial_number start_auto_serial_number,
fvl.auto_serial_alpha_prefix auto_serial_alpha_prefix,
mfl_s.meaning source_type,
org_s.organization_name source_organization,
fvl.source_subinventory source_subinventory,
glve.concatenated_segments expense_account,
glven.concatenated_segments encumbrance_account,
mfl_sub.meaning restrict_subinventories,
fvl.unit_weight unit_weight,
fvl.weight_uom_code weight_uom_code,
fvl.volume_uom_code volume_uom_code,
fvl.unit_volume unit_volume,
mfl_locator.meaning restrict_locators,
mfl_loc_control.meaning location_control,
fvl.shrinkage_rate shrinkage_rate,
fvl.acceptable_early_days acceptable_early_days,
mfl_fe.meaning planning_time_fence,
mfl_de.meaning demand_time_fence,
fvl.lead_time_lot_size lead_time_lot_size,
fvl.std_lot_size std_lot_size,
fvl.cum_manufacturing_lead_time cum_manufacturing_lead_time,
fvl.overrun_percentage overrun_percentage,
fvl.mrp_calculate_atp_flag mrp_calculate_atp_flag,
fvl.acceptable_rate_increase acceptable_rate_increase,
fvl.acceptable_rate_decrease acceptable_rate_decrease,
fvl.cumulative_total_lead_time cumulative_total_lead_time,
fvl.planning_time_fence_days planning_time_fence_days,
fvl.demand_time_fence_days demand_time_fence_days,
fvl.end_assembly_pegging_flag end_assembly_pegging_flag,
fvl.repetitive_planning_flag repetitive_planning_flag,
fvl.planning_exception_set planning_exception_set,
mfl_bom.meaning bom_item_type,
fvl.pick_components_flag pick_components_flag,
fvl.replenish_to_order_flag replenish_to_order_flag,
item_b.concatenated_segments base_item,
fvl.atp_components_flag atp_components_flag,
fvl.atp_flag atp_flag,
fvl.fixed_lead_time fixed_lead_time,
fvl.variable_lead_time variable_lead_time,
loc.concatenated_segments wip_supply_locator,
mfl_wip.meaning wip_supply_type,
fvl.wip_supply_subinventory wip_supply_subinventory,
fvl.primary_uom_code primary_uom_code,
mfl_al.meaning allowed_units_lookup,
glvc.concatenated_segments cost_of_sales_account,
glv_s.concatenated_segments sales_account,
fvl.default_include_in_rollup_flag default_include_in_rollup_flag,
fvl.inventory_item_status_code inventory_item_status_code,
mfl_pl.meaning inventory_planning,
fvl.planner_code planner_code,
mfl_mb.meaning planning_make_buy,
fvl.fixed_lot_multiplier fixed_lot_multiplier,
mfl_ro.meaning rounding_control_type,
fvl.carrying_cost carrying_cost,
fvl.postprocessing_lead_time postprocessing_lead_time,
fvl.preprocessing_lead_time preprocessing_lead_time,
fvl.full_lead_time full_lead_time,
fvl.order_cost order_cost,
fvl.mrp_safety_stock_percent mrp_safety_stock_percent,
mfl_saf.meaning mrp_safety_stock,
fvl.min_minmax_quantity min_minmax_quantity,
fvl.max_minmax_quantity max_minmax_quantity,
fvl.minimum_order_quantity minimum_order_quantity,
fvl.fixed_order_quantity fixed_order_quantity,
fvl.fixed_days_supply fixed_days_supply,
fvl.maximum_order_quantity maximum_order_quantity,
atp.rule_name atp_rule_name,
pick.picking_rule_name picking_rule_name,
mfl_res.meaning reservable_type,
fvl.positive_measurement_error positive_measurement_error,
fvl.negative_measurement_error negative_measurement_error,
fvl.engineering_ecn_code engineering_ecn_code,
item_e.concatenated_segments engineering_item,
fvl.engineering_date engineering_date,
NULL service_start_date,
fvl.service_starting_delay service_starting_delay,
fvl.vendor_warranty_flag vendor_warranty_flag, 
fvl.serviceable_component_flag serviceable_component_flag,
fvl.serviceable_product_flag serviceable_product_flag,
item_s.concatenated_segments base_warranty_service_item,
rat.name payment_term_name,
fvl.preventive_maintenance_flag preventive_maintenance_flag,
perp.full_name primary_specialist_full_name,
pers.full_name secondary_specialist_full_name,
csc.name serviceable_item_class_name,
fvl.time_billable_flag time_billable_flag,
fvl.material_billable_flag material_billable_flag,
fvl.expense_billable_flag expense_billable_flag,
fvl.prorate_service_flag prorate_service_flag,
cov.name coverage_schedule_name,
fvl.service_duration_period_code service_duration_period_code,
fvl.service_duration service_duration,
pov.vendor_name warranty_vendor_name,
fvl.max_warranty_amount max_warranty_amount,
fvl.response_time_period_code response_time_period_code,
fvl.response_time_value response_time_value,
fvl.invoiceable_item_flag invoiceable_item_flag,
fvl.invoice_enabled_flag invoice_enabled_flag,
fvl.must_use_approved_vendor_flag must_use_approved_vendor_flag,
fvl.outside_operation_flag outside_operation_flag,
fvl.outside_operation_uom_type outside_operation_uom_type,
fvl.safety_stock_bucket_days safety_stock_bucket_days,
fvl.auto_reduce_mps auto_reduce_mps,
fvl.costing_enabled_flag costing_enabled_flag,
fvl.auto_created_config_flag auto_created_config_flag,
fvl.cycle_count_enabled_flag cycle_count_enabled_flag,
NULL demand_source_line,
NULL copy_item_number,
NULL set_id,
fvl.new_revision_code revision,
fnd_item_type.meaning item_type,
fvl.model_config_clause_name model_config_clause_name,
fvl.ship_model_complete_flag ship_model_complete_flag,
mfl_mrp.meaning mrp_planning,
mfl_ret.meaning return_inspection_requirement,
NULL demand_source_type,
NULL demand_source_header_id,
NULL template_name,
NULL copy_organization_name,
mfl_ato.meaning ato_forecast_control,
NULL material_cost,
NULL material_sub_element,
NULL material_oh_rate,
NULL material_oh_subelement,
mfl_re.meaning release_time_fence,
fvl.release_time_fence_days release_time_fence_days,
fvl.container_item_flag container_item_flag,
fvl.vehicle_item_flag vehicle_item_flag,
fvl.maximum_load_weight maximum_load_weight,
fvl.minimum_fill_percent minimum_fill_percent,
fvl.container_type_code container_type_code,
fvl.internal_volume internal_volume,
fvl.wh_update_date wh_update_date,
item_f.concatenated_segments  product_family_item,
fvl.purchasing_tax_code purchasing_tax_code,
mfl_tol.meaning overcompletion_tolerance_type,
fvl.overcompletion_tolerance_value overcompletion_tolerance_value,
mfl_eff.meaning effectivity_control,
fvl.over_shipment_tolerance overshipment_tolerance,
fvl.under_shipment_tolerance undershipment_tolerance,
fvl.over_return_tolerance over_return_tolerance,
fvl.under_return_tolerance under_return_tolerance,
decode(to_char(fvl.equipment_type),'1','Yes','2','No') equipment_type,
fvl.recovered_part_disp_code recovered_part_disp_code,
fvl.defect_tracking_on_flag defect_tracking_on_flag,
fvl.usage_item_flag usage_item_flag,
fvl.event_flag event_flag,
fvl.electronic_flag electronic_flag,
fvl.downloadable_flag downloadable_flag,
fvl.vol_discount_exempt_flag vol_discount_exempt_flag,
fvl.coupon_exempt_flag coupon_exempt_flag,
fvl.comms_nl_trackable_flag comms_nl_trackable_flag,
fvl.asset_creation_code asset_creation_code,
fvl.comms_activation_reqd_flag comms_activation_reqd_flag,
fvl.orderable_on_web_flag orderable_on_web_flag,
fvl.back_orderable_flag back_orderable_flag,
fvl.web_status web_status,
fvl.indivisible_flag indivisible_flag,
fvl.dimension_uom_code dimension_uom_code,
fvl.unit_length unit_length,
fvl.unit_width unit_width,
fvl.unit_height unit_height,
fvl.bulk_picked_flag bulk_picked_flag,
fvl.lot_status_enabled lot_status_enabled,
/*Following fields need to be added as a result of Impact Analysis between 11.5.7 and 11.5.9*/
fvl.CONFIG_MODEL_TYPE CONFIG_MODEL_TYPE,
fvl.IB_ITEM_INSTANCE_CLASS IB_ITEM_INSTANCE_CLASS,
fvl.LOT_SUBSTITUTION_ENABLED,
fvl.MINIMUM_LICENSE_QUANTITY
FROM mtl_system_items_fvl fvl,
     mtl_system_items_b_kfv item,
	 mtl_system_items_b_kfv item_b,
	 mtl_system_items_b_kfv item_e,
	 mtl_system_items_b_kfv item_f,
	 mtl_system_items_b_kfv item_s,
	 org_organization_definitions org,
	 org_organization_definitions org_s,
	 org_organization_definitions org_d,
	 fnd_common_lookups fnd_item_type,
	 mfg_lookups mfl_al,
	 mfg_lookups mfl_rev,
	 mfg_lookups mfl_res,
	 mfg_lookups mfl_sh,
	 mfg_lookups mfl_lot,
	 mfg_lookups mfl_loc_control,
	 mfg_lookups mfl_sub,
	 mfg_lookups mfl_locator,
	 mfg_lookups mfl_eff,
	 mfg_lookups mfl_pl,
	 mfg_lookups mfl_mb,
	 mfg_lookups mfl_s,
	 mfg_lookups mfl_saf,
	 mfg_lookups mfl_mrp,
	 mfg_lookups mfl_ato,
	 mfg_lookups mfl_ro,
	 mfg_lookups mfl_fe,
	 mfg_lookups mfl_de,
	 mfg_lookups mfl_re,
	 mfg_lookups mfl_wip,
	 mfg_lookups mfl_tol,
	 mfg_lookups mfl_ret,
	 mfg_lookups mfl_bom,
	 mfg_lookups mfl_ser,
	 mtl_item_catalog_groups mtcg,
	 gl_code_combinations_kfv glvc,
	 gl_code_combinations_kfv glven,
     gl_code_combinations_kfv glve,
	 gl_code_combinations_kfv glv_s,
	 per_all_people_f perb,
	 per_all_people_f perp,
	 per_all_people_f pers,
	 po_hazard_classes_b haz,
	 fa_categories_b_kfv fa,
	 rcv_routing_headers rcv,
	 mtl_item_locations_kfv loc,
	 mtl_atp_rules atp,
	 mtl_picking_rules pick,
	 ra_rules rai,
	 ra_rules raa,
	 ra_terms_b rat,
	 cs_coverage_schedules cov,
	 cs_serviceable_item_classes csc,
	 po_vendors pov,
	 wm_track_changes_vw wmtc
WHERE    fvl.organization_id = item.organization_id
AND fvl.inventory_item_id=item.inventory_item_id
AND fvl.organization_id = org.organization_id
AND fnd_item_type.lookup_type(+)='ITEM_TYPE'
AND fnd_item_type.lookup_code(+)=fvl.item_type
AND mfl_al.lookup_type(+)='MTL_CONVERSION_TYPE'
AND fvl.allowed_units_lookup_code=mfl_al.lookup_code(+)		 
AND fvl.item_catalog_group_id=mtcg.item_catalog_group_id(+)
AND fvl.revision_qty_control_code=mfl_rev.lookup_code(+)
AND mfl_rev.lookup_type(+)='MTL_ENG_QTY'
AND fvl.reservable_type=mfl_res.lookup_code(+)
AND mfl_res.lookup_type(+)='MTL_RESERVATION_CONTROL'
AND fvl.shelf_life_code=mfl_sh.lookup_code(+)
AND mfl_sh.lookup_type(+)='MTL_SHELF_LIFE'
AND fvl.lot_control_code = mfl_lot.lookup_code(+)
AND mfl_lot.lookup_type(+)='MTL_LOT_CONTROL'
AND fvl.location_control_code=mfl_loc_control.lookup_code(+)
AND mfl_loc_control.lookup_type(+)='MTL_LOCATION_CONTROL'
AND fvl.restrict_subinventories_code=mfl_sub.lookup_code(+)
AND mfl_sub.lookup_type(+)='MTL_SUBINVENTORY_RESTRICTIONS'
AND fvl.restrict_locators_code=mfl_locator.lookup_code(+)
AND mfl_locator.lookup_type(+)='MTL_LOCATOR_RESTRICTIONS'
AND fvl.base_item_id=item_b.inventory_item_id(+)
AND fvl.organization_id=item_b.organization_id(+)
AND fvl.effectivity_control=mfl_eff.lookup_code(+)
AND mfl_eff.lookup_type(+)='MTL_EFFECTIVITY_CONTROL'
AND fvl.bom_item_type=mfl_bom.lookup_code(+)
AND mfl_bom.lookup_type(+)='BOM_ITEM_TYPE'
AND fvl.engineering_item_id=item_e.inventory_item_id(+)
AND fvl.organization_id=item_e.organization_id(+)
AND fvl.product_family_item_id=item_f.inventory_item_id(+)
AND fvl.organization_id=item_f.organization_id(+)
AND fvl.cost_of_sales_account=glvc.code_combination_id(+)
AND fvl.buyer_id=perb.person_id(+)
AND TRUNC(SYSDATE) BETWEEN NVL(perb.effective_start_date,TRUNC(SYSDATE)) AND  NVL(perb.effective_end_date,TRUNC(SYSDATE)) 
AND fvl.primary_specialist_id=perp.person_id(+)
AND TRUNC(SYSDATE) BETWEEN NVL(perp.effective_start_date,TRUNC(SYSDATE)) AND  NVL(perp.effective_end_date,TRUNC(SYSDATE))
AND fvl.secondary_specialist_id=pers.person_id(+)
AND TRUNC(SYSDATE) BETWEEN NVL(pers.effective_start_date,TRUNC(SYSDATE)) AND  NVL(pers.effective_end_date,TRUNC(SYSDATE)) 
AND fvl.hazard_class_id=haz.hazard_class_id(+)
AND fvl.encumbrance_account=glven.code_combination_id(+)
AND fvl.expense_account=glve.code_combination_id(+)
AND fvl.asset_category_id=fa.category_id(+)
AND fvl.receiving_routing_id=rcv.routing_header_id(+)
AND fvl.inventory_planning_code=mfl_pl.lookup_code(+)
AND mfl_pl.lookup_type(+)='MTL_MATERIAL_PLANNING'
AND fvl.planning_make_buy_code=mfl_mb.lookup_code(+)
AND mfl_mb.lookup_type(+)='MTL_PLANNING_MAKE_BUY'
AND fvl.source_type=mfl_s.lookup_code(+)
AND mfl_s.lookup_type(+)='MTL_SOURCE_TYPES'
AND fvl.source_organization_id=org_s.organization_id(+)
AND fvl.mrp_safety_stock_code=mfl_saf.lookup_code(+)
AND mfl_saf.lookup_type(+)='MTL_SAFETY_STOCK_TYPE'
AND fvl.mrp_planning_code=mfl_mrp.lookup_code(+)
AND mfl_mrp.lookup_type(+)='MRP_PLANNING_CODE'
AND fvl.ato_forecast_control=mfl_ato.lookup_code(+)
AND mfl_ato.lookup_type(+)='MRP_ATO_FORECAST_CONTROL'
AND fvl.rounding_control_type=mfl_ro.lookup_code(+)
AND mfl_ro.lookup_type(+)='MTL_ROUNDING'
AND fvl.planning_time_fence_code=mfl_fe.lookup_code(+)
AND mfl_fe.lookup_type(+)='MTL_TIME_FENCE'
AND fvl.demand_time_fence_code=mfl_de.lookup_code(+)
AND mfl_de.lookup_type(+)='MTL_TIME_FENCE'
AND fvl.release_time_fence_code=mfl_re.lookup_code(+)
AND mfl_re.lookup_type(+)='MTL_RELEASE_TIME_FENCE'
AND fvl.wip_supply_type=mfl_wip.lookup_code(+)
AND mfl_wip.lookup_type(+)='WIP_SUPPLY'
AND fvl.organization_id=loc.organization_id(+)
AND fvl.wip_supply_locator_id=loc.inventory_location_id(+)
AND fvl.overcompletion_tolerance_type=mfl_tol.lookup_code(+)
AND mfl_tol.lookup_type(+)='WIP_TOLERANCE_TYPE'
AND fvl.atp_rule_id=atp.rule_id(+)
AND fvl.picking_rule_id=pick.picking_rule_id(+)
AND fvl.default_shipping_org=org_d.organization_id(+)
AND fvl.return_inspection_requirement=mfl_ret.lookup_code(+)
AND mfl_ret.lookup_type(+)='MTL_RETURN_INSPECTION'
AND fvl.serial_number_control_code=mfl_ser.lookup_code(+)
AND mfl_ser.lookup_type(+)='MTL_SERIAL_NUMBER'
AND fvl.invoicing_rule_id=rai.rule_id(+)
AND fvl.accounting_rule_id=raa.rule_id(+)
AND fvl.sales_account=glv_s.code_combination_id(+)
AND fvl.payment_terms_id=rat.term_id(+)
AND fvl.coverage_schedule_id=cov.coverage_schedule_id(+)
AND fvl.serviceable_item_class_id=csc.serviceable_item_class_id(+)
AND fvl.organization_id=item_s.organization_id(+)
AND fvl.base_warranty_service_id=item_s.inventory_item_id(+)
AND fvl.warranty_vendor_id=pov.vendor_id(+)
AND wmtc.transaction_id=fvl.inventory_item_id||'-'||fvl.organization_id
AND wmtc.transaction_status <= 2 
AND wmtc.transaction_type = 'ITEM'
order by
wmtc.web_transaction_id
/

/*----------------------------------------------------------------------*/
--      Create View WM_INV_ITEM_CATEGORIES_VW
/*----------------------------------------------------------------------*/
CREATE OR REPLACE VIEW WM_INV_ITEM_CATEGORIES_VW
AS
SELECT
cati.inventory_item_id||'-'||cati.organization_id inv_item_org_id,
cats.category_set_name category_set_name,
cat.concatenated_segments category_name,
NULL transaction_type
FROM
mtl_item_categories cati,
mtl_category_sets cats,
mtl_categories_kfv cat
WHERE
cati.category_set_id=cats.category_set_id
AND cati.category_id=cat.category_id
/

/*----------------------------------------------------------------------*/
--      Create View WM_INV_ITEM_REVISIONS_VW
/*----------------------------------------------------------------------*/
CREATE OR REPLACE VIEW WM_INV_ITEM_REVISIONS_VW
AS
SELECT
rev.inventory_item_id||'-'||rev.organization_id inv_item_org_id,
rev.revision revision,
rev.change_notice change_notice,
rev.ecn_initiation_date ecn_initiation_date,
rev.implementation_date implementation_date,
rev.implemented_serial_number implemented_serial_number,
rev.effectivity_date effectivity_date,
rev.revised_item_sequence_id revised_item_sequence_id,
rev.description description,
/*Following fields have been added as a result of Impact Analysis between 11.5.7 and 11.5.9*/
rev.REVISION_LABEL REVISION_LABEL,
rev.REVISION_REASON REVISION_REASON
FROM
mtl_item_revisions_b rev
/
 
/*----------------------------------------------------------------------*/
--      Create View WM_INV_ITEMS_QRY_VW
/*----------------------------------------------------------------------*/
CREATE OR REPLACE VIEW WM_INV_ITEMS_QRY_VW
AS
SELECT
NULL web_transaction_id, 
NULL  document_type,
'QUERY' document_status,
fvl.inventory_item_id||'-'||fvl.organization_id inv_item_org_id,
item.concatenated_segments item_number,
org.organization_name organization_name,
fvl.summary_flag summary_flag,
fvl.tax_code tax_code,
fvl.enabled_flag enabled_flag,
fvl.start_date_active start_date_active,
fvl.end_date_active end_date_active,
fvl.description description,
perb.full_name buyer_full_name,
raa.name accounting_rule_name,
rai.name invoicing_rule_name,
fvl.purchasing_item_flag purchasing_item_flag,
fvl.shippable_item_flag shippable_item_flag,
fvl.customer_order_flag customer_order_flag,
fvl.internal_order_flag internal_order_flag,
fvl.service_item_flag service_item_flag,
fvl.inventory_item_flag inventory_item_flag,
fvl.eng_item_flag eng_item_flag,
fvl.inventory_asset_flag inventory_asset_flag,
fvl.purchasing_enabled_flag purchasing_enabled_flag,
fvl.customer_order_enabled_flag customer_order_enabled_flag,
fvl.internal_order_enabled_flag internal_order_enabled_flag,
fvl.so_transactions_flag so_transactions_flag,
fvl.mtl_transactions_enabled_flag mtl_transactions_enabled_flag,
fvl.stock_enabled_flag stock_enabled_flag,
fvl.bom_enabled_flag bom_enabled_flag,
fvl.build_in_wip_flag build_in_wip_flag,
mfl_rev.meaning revision_qty_control,
mtcg.description item_catalog_group_description,
fvl.catalog_status_flag catalog_status_flag,
fvl.check_shortages_flag check_shortages_flag,
fvl.returnable_flag returnable_flag,
org_d.organization_name default_ship_organization_name,
fvl.collateral_flag collateral_flag,
fvl.taxable_flag taxable_flag,
fvl.qty_rcv_exception_code qty_rcv_exception_code,
fvl.allow_item_desc_update_flag allow_item_desc_update_flag,
fvl.inspection_required_flag inspection_required_flag,
fvl.receipt_required_flag receipt_required_flag,
fvl.market_price market_price,
haz.hazard_class hazard_class,
fvl.rfq_required_flag rfq_required_flag,
fvl.qty_rcv_tolerance qty_rcv_tolerance,
fvl.list_price_per_unit list_price_per_unit,
fvl.un_number_id un_number_id,
fvl.price_tolerance_percent price_tolerance_percent,
fa.concatenated_segments asset_category,
fvl.rounding_factor rounding_factor,
fvl.unit_of_issue unit_of_issue,
fvl.enforce_ship_to_location_code enforce_ship_to_location_code,
fvl.allow_substitute_receipts_flag allow_substitute_receipts_flag,
fvl.allow_unordered_receipts_flag allow_unordered_receipts_flag,
fvl.allow_express_delivery_flag allow_express_delivery_flag,
fvl.days_early_receipt_allowed days_early_receipt_allowed,
fvl.days_late_receipt_allowed days_late_receipt_allowed,
fvl.receipt_days_exception_code receipt_days_exception_code,
rcv.routing_name receiving_routing_name,
fvl.invoice_close_tolerance invoice_close_tolerance,
fvl.receive_close_tolerance receive_close_tolerance,
fvl.auto_lot_alpha_prefix auto_lot_alpha_prefix,
fvl.start_auto_lot_number start_auto_lot_number,
mfl_lot.meaning lot_control,
mfl_sh.meaning shelf_life,
fvl.shelf_life_days shelf_life_days,
mfl_ser.meaning serial_number_control,
fvl.start_auto_serial_number start_auto_serial_number,
fvl.auto_serial_alpha_prefix auto_serial_alpha_prefix,
mfl_s.meaning source_type,
org_s.organization_name source_organization,
fvl.source_subinventory source_subinventory,
glve.concatenated_segments expense_account,
glven.concatenated_segments encumbrance_account,
mfl_sub.meaning restrict_subinventories,
fvl.unit_weight unit_weight,
fvl.weight_uom_code weight_uom_code,
fvl.volume_uom_code volume_uom_code,
fvl.unit_volume unit_volume,
mfl_locator.meaning restrict_locators,
mfl_loc_control.meaning location_control,
fvl.shrinkage_rate shrinkage_rate,
fvl.acceptable_early_days acceptable_early_days,
mfl_fe.meaning planning_time_fence,
mfl_de.meaning demand_time_fence,
fvl.lead_time_lot_size lead_time_lot_size,
fvl.std_lot_size std_lot_size,
fvl.cum_manufacturing_lead_time cum_manufacturing_lead_time,
fvl.overrun_percentage overrun_percentage,
fvl.mrp_calculate_atp_flag mrp_calculate_atp_flag,
fvl.acceptable_rate_increase acceptable_rate_increase,
fvl.acceptable_rate_decrease acceptable_rate_decrease,
fvl.cumulative_total_lead_time cumulative_total_lead_time,
fvl.planning_time_fence_days planning_time_fence_days,
fvl.demand_time_fence_days demand_time_fence_days,
fvl.end_assembly_pegging_flag end_assembly_pegging_flag,
fvl.repetitive_planning_flag repetitive_planning_flag,
fvl.planning_exception_set planning_exception_set,
mfl_bom.meaning bom_item_type,
fvl.pick_components_flag pick_components_flag,
fvl.replenish_to_order_flag replenish_to_order_flag,
item_b.concatenated_segments base_item,
fvl.atp_components_flag atp_components_flag,
fvl.atp_flag atp_flag,
fvl.fixed_lead_time fixed_lead_time,
fvl.variable_lead_time variable_lead_time,
loc.concatenated_segments wip_supply_locator,
mfl_wip.meaning wip_supply_type,
fvl.wip_supply_subinventory wip_supply_subinventory,
fvl.primary_uom_code primary_uom_code,
mfl_al.meaning allowed_units_lookup,
glvc.concatenated_segments cost_of_sales_account,
glv_s.concatenated_segments sales_account,
fvl.default_include_in_rollup_flag default_include_in_rollup_flag,
fvl.inventory_item_status_code inventory_item_status_code,
mfl_pl.meaning inventory_planning,
fvl.planner_code planner_code,
mfl_mb.meaning planning_make_buy,
fvl.fixed_lot_multiplier fixed_lot_multiplier,
mfl_ro.meaning rounding_control_type,
fvl.carrying_cost carrying_cost,
fvl.postprocessing_lead_time postprocessing_lead_time,
fvl.preprocessing_lead_time preprocessing_lead_time,
fvl.full_lead_time full_lead_time,
fvl.order_cost order_cost,
fvl.mrp_safety_stock_percent mrp_safety_stock_percent,
mfl_saf.meaning mrp_safety_stock,
fvl.min_minmax_quantity min_minmax_quantity,
fvl.max_minmax_quantity max_minmax_quantity,
fvl.minimum_order_quantity minimum_order_quantity,
fvl.fixed_order_quantity fixed_order_quantity,
fvl.fixed_days_supply fixed_days_supply,
fvl.maximum_order_quantity maximum_order_quantity,
atp.rule_name atp_rule_name,
pick.picking_rule_name picking_rule_name,
mfl_res.meaning reservable_type,
fvl.positive_measurement_error positive_measurement_error,
fvl.negative_measurement_error negative_measurement_error,
fvl.engineering_ecn_code engineering_ecn_code,
item_e.concatenated_segments engineering_item,
fvl.engineering_date engineering_date,
NULL service_start_date,
fvl.service_starting_delay service_starting_delay,
fvl.vendor_warranty_flag vendor_warranty_flag, 
fvl.serviceable_component_flag serviceable_component_flag,
fvl.serviceable_product_flag serviceable_product_flag,
item_s.concatenated_segments base_warranty_service_item,
rat.name payment_term_name,
fvl.preventive_maintenance_flag preventive_maintenance_flag,
perp.full_name primary_specialist_full_name,
pers.full_name secondary_specialist_full_name,
csc.name serviceable_item_class_name,
fvl.time_billable_flag time_billable_flag,
fvl.material_billable_flag material_billable_flag,
fvl.expense_billable_flag expense_billable_flag,
fvl.prorate_service_flag prorate_service_flag,
cov.name coverage_schedule_name,
fvl.service_duration_period_code service_duration_period_code,
fvl.service_duration service_duration,
pov.vendor_name warranty_vendor_name,
fvl.max_warranty_amount max_warranty_amount,
fvl.response_time_period_code response_time_period_code,
fvl.response_time_value response_time_value,
fvl.invoiceable_item_flag invoiceable_item_flag,
fvl.invoice_enabled_flag invoice_enabled_flag,
fvl.must_use_approved_vendor_flag must_use_approved_vendor_flag,
fvl.outside_operation_flag outside_operation_flag,
fvl.outside_operation_uom_type outside_operation_uom_type,
fvl.safety_stock_bucket_days safety_stock_bucket_days,
fvl.auto_reduce_mps auto_reduce_mps,
fvl.costing_enabled_flag costing_enabled_flag,
fvl.auto_created_config_flag auto_created_config_flag,
fvl.cycle_count_enabled_flag cycle_count_enabled_flag,
NULL demand_source_line,
NULL copy_item_number,
NULL set_id,
fvl.new_revision_code revision,
fnd_item_type.meaning item_type,
fvl.model_config_clause_name model_config_clause_name,
fvl.ship_model_complete_flag ship_model_complete_flag,
mfl_mrp.meaning mrp_planning,
mfl_ret.meaning return_inspection_requirement,
NULL demand_source_type,
NULL demand_source_header_id,
NULL template_name,
NULL copy_organization_name,
mfl_ato.meaning ato_forecast_control,
NULL material_cost,
NULL material_sub_element,
NULL material_oh_rate,
NULL material_oh_subelement,
mfl_re.meaning release_time_fence,
fvl.release_time_fence_days release_time_fence_days,
fvl.container_item_flag container_item_flag,
fvl.vehicle_item_flag vehicle_item_flag,
fvl.maximum_load_weight maximum_load_weight,
fvl.minimum_fill_percent minimum_fill_percent,
fvl.container_type_code container_type_code,
fvl.internal_volume internal_volume,
fvl.wh_update_date wh_update_date,
item_f.concatenated_segments  product_family_item,
fvl.purchasing_tax_code purchasing_tax_code,
mfl_tol.meaning overcompletion_tolerance_type,
fvl.overcompletion_tolerance_value overcompletion_tolerance_value,
mfl_eff.meaning effectivity_control,
fvl.over_shipment_tolerance overshipment_tolerance,
fvl.under_shipment_tolerance undershipment_tolerance,
fvl.over_return_tolerance over_return_tolerance,
fvl.under_return_tolerance under_return_tolerance,
decode(to_char(fvl.equipment_type),'1','Yes','2','No') equipment_type,
fvl.recovered_part_disp_code recovered_part_disp_code,
fvl.defect_tracking_on_flag defect_tracking_on_flag,
fvl.usage_item_flag usage_item_flag,
fvl.event_flag event_flag,
fvl.electronic_flag electronic_flag,
fvl.downloadable_flag downloadable_flag,
fvl.vol_discount_exempt_flag vol_discount_exempt_flag,
fvl.coupon_exempt_flag coupon_exempt_flag,
fvl.comms_nl_trackable_flag comms_nl_trackable_flag,
fvl.asset_creation_code asset_creation_code,
fvl.comms_activation_reqd_flag comms_activation_reqd_flag,
fvl.orderable_on_web_flag orderable_on_web_flag,
fvl.back_orderable_flag back_orderable_flag,
fvl.web_status web_status,
fvl.indivisible_flag indivisible_flag,
fvl.dimension_uom_code dimension_uom_code,
fvl.unit_length unit_length,
fvl.unit_width unit_width,
fvl.unit_height unit_height,
fvl.bulk_picked_flag bulk_picked_flag,
fvl.lot_status_enabled lot_status_enabled,
/*Following fields need to be added as a result of Impact Analysis between 11.5.7 and 11.5.9*/
fvl.CONFIG_MODEL_TYPE CONFIG_MODEL_TYPE,
fvl.IB_ITEM_INSTANCE_CLASS IB_ITEM_INSTANCE_CLASS,
fvl.LOT_SUBSTITUTION_ENABLED,
fvl.MINIMUM_LICENSE_QUANTITY
FROM mtl_system_items_fvl fvl,
     mtl_system_items_b_kfv item,
	 mtl_system_items_b_kfv item_b,
	 mtl_system_items_b_kfv item_e,
	 mtl_system_items_b_kfv item_f,
	 mtl_system_items_b_kfv item_s,
	 org_organization_definitions org,
	 org_organization_definitions org_s,
	 org_organization_definitions org_d,
	 fnd_common_lookups fnd_item_type,
	 mfg_lookups mfl_al,
	 mfg_lookups mfl_rev,
	 mfg_lookups mfl_res,
	 mfg_lookups mfl_sh,
	 mfg_lookups mfl_lot,
	 mfg_lookups mfl_loc_control,
	 mfg_lookups mfl_sub,
	 mfg_lookups mfl_locator,
	 mfg_lookups mfl_eff,
	 mfg_lookups mfl_pl,
	 mfg_lookups mfl_mb,
	 mfg_lookups mfl_s,
	 mfg_lookups mfl_saf,
	 mfg_lookups mfl_mrp,
	 mfg_lookups mfl_ato,
	 mfg_lookups mfl_ro,
	 mfg_lookups mfl_fe,
	 mfg_lookups mfl_de,
	 mfg_lookups mfl_re,
	 mfg_lookups mfl_wip,
	 mfg_lookups mfl_tol,
	 mfg_lookups mfl_ret,
	 mfg_lookups mfl_bom,
	 mfg_lookups mfl_ser,
	 mtl_item_catalog_groups mtcg,
	 gl_code_combinations_kfv glvc,
	 gl_code_combinations_kfv glven,
     gl_code_combinations_kfv glve,
	 gl_code_combinations_kfv glv_s,
	 per_all_people_f perb,
	 per_all_people_f perp,
	 per_all_people_f pers,
	 po_hazard_classes_b haz,
	 fa_categories_b_kfv fa,
	 rcv_routing_headers rcv,
	 mtl_item_locations_kfv loc,
	 mtl_atp_rules atp,
	 mtl_picking_rules pick,
	 ra_rules rai,
	 ra_rules raa,
	 ra_terms_b rat,
	 cs_coverage_schedules cov,
	 cs_serviceable_item_classes csc,
	 po_vendors pov
WHERE
    fvl.organization_id = item.organization_id
AND fvl.inventory_item_id=item.inventory_item_id
AND fvl.organization_id = org.organization_id
AND fnd_item_type.lookup_type(+)='ITEM_TYPE'
AND fnd_item_type.lookup_code(+)=fvl.item_type
AND mfl_al.lookup_type(+)='MTL_CONVERSION_TYPE'
AND fvl.allowed_units_lookup_code=mfl_al.lookup_code(+)		 
AND fvl.item_catalog_group_id=mtcg.item_catalog_group_id(+)
AND fvl.revision_qty_control_code=mfl_rev.lookup_code(+)
AND mfl_rev.lookup_type(+)='MTL_ENG_QTY'
AND fvl.reservable_type=mfl_res.lookup_code(+)
AND mfl_res.lookup_type(+)='MTL_RESERVATION_CONTROL'
AND fvl.shelf_life_code=mfl_sh.lookup_code(+)
AND mfl_sh.lookup_type(+)='MTL_SHELF_LIFE'
AND fvl.lot_control_code = mfl_lot.lookup_code(+)
AND mfl_lot.lookup_type(+)='MTL_LOT_CONTROL'
AND fvl.location_control_code=mfl_loc_control.lookup_code(+)
AND mfl_loc_control.lookup_type(+)='MTL_LOCATION_CONTROL'
AND fvl.restrict_subinventories_code=mfl_sub.lookup_code(+)
AND mfl_sub.lookup_type(+)='MTL_SUBINVENTORY_RESTRICTIONS'
AND fvl.restrict_locators_code=mfl_locator.lookup_code(+)
AND mfl_locator.lookup_type(+)='MTL_LOCATOR_RESTRICTIONS'
AND fvl.base_item_id=item_b.inventory_item_id(+)
AND fvl.organization_id=item_b.organization_id(+)
AND fvl.effectivity_control=mfl_eff.lookup_code(+)
AND mfl_eff.lookup_type(+)='MTL_EFFECTIVITY_CONTROL'
AND fvl.bom_item_type=mfl_bom.lookup_code(+)
AND mfl_bom.lookup_type(+)='BOM_ITEM_TYPE'
AND fvl.engineering_item_id=item_e.inventory_item_id(+)
AND fvl.organization_id=item_e.organization_id(+)
AND fvl.product_family_item_id=item_f.inventory_item_id(+)
AND fvl.organization_id=item_f.organization_id(+)
AND fvl.cost_of_sales_account=glvc.code_combination_id(+)
AND fvl.buyer_id=perb.person_id(+)
AND TRUNC(SYSDATE) BETWEEN NVL(perb.effective_start_date,TRUNC(SYSDATE)) AND  NVL(perb.effective_end_date,TRUNC(SYSDATE)) 
AND fvl.primary_specialist_id=perp.person_id(+)
AND TRUNC(SYSDATE) BETWEEN NVL(perp.effective_start_date,TRUNC(SYSDATE)) AND  NVL(perp.effective_end_date,TRUNC(SYSDATE))
AND fvl.secondary_specialist_id=pers.person_id(+)
AND TRUNC(SYSDATE) BETWEEN NVL(pers.effective_start_date,TRUNC(SYSDATE)) AND  NVL(pers.effective_end_date,TRUNC(SYSDATE)) 
AND fvl.hazard_class_id=haz.hazard_class_id(+)
AND fvl.encumbrance_account=glven.code_combination_id(+)
AND fvl.expense_account=glve.code_combination_id(+)
AND fvl.asset_category_id=fa.category_id(+)
AND fvl.receiving_routing_id=rcv.routing_header_id(+)
AND fvl.inventory_planning_code=mfl_pl.lookup_code(+)
AND mfl_pl.lookup_type(+)='MTL_MATERIAL_PLANNING'
AND fvl.planning_make_buy_code=mfl_mb.lookup_code(+)
AND mfl_mb.lookup_type(+)='MTL_PLANNING_MAKE_BUY'
AND fvl.source_type=mfl_s.lookup_code(+)
AND mfl_s.lookup_type(+)='MTL_SOURCE_TYPES'
AND fvl.source_organization_id=org_s.organization_id(+)
AND fvl.mrp_safety_stock_code=mfl_saf.lookup_code(+)
AND mfl_saf.lookup_type(+)='MTL_SAFETY_STOCK_TYPE'
AND fvl.mrp_planning_code=mfl_mrp.lookup_code(+)
AND mfl_mrp.lookup_type(+)='MRP_PLANNING_CODE'
AND fvl.ato_forecast_control=mfl_ato.lookup_code(+)
AND mfl_ato.lookup_type(+)='MRP_ATO_FORECAST_CONTROL'
AND fvl.rounding_control_type=mfl_ro.lookup_code(+)
AND mfl_ro.lookup_type(+)='MTL_ROUNDING'
AND fvl.planning_time_fence_code=mfl_fe.lookup_code(+)
AND mfl_fe.lookup_type(+)='MTL_TIME_FENCE'
AND fvl.demand_time_fence_code=mfl_de.lookup_code(+)
AND mfl_de.lookup_type(+)='MTL_TIME_FENCE'
AND fvl.release_time_fence_code=mfl_re.lookup_code(+)
AND mfl_re.lookup_type(+)='MTL_RELEASE_TIME_FENCE'
AND fvl.wip_supply_type=mfl_wip.lookup_code(+)
AND mfl_wip.lookup_type(+)='WIP_SUPPLY'
AND fvl.organization_id=loc.organization_id(+)
AND fvl.wip_supply_locator_id=loc.inventory_location_id(+)
AND fvl.overcompletion_tolerance_type=mfl_tol.lookup_code(+)
AND mfl_tol.lookup_type(+)='WIP_TOLERANCE_TYPE'
AND fvl.atp_rule_id=atp.rule_id(+)
AND fvl.picking_rule_id=pick.picking_rule_id(+)
AND fvl.default_shipping_org=org_d.organization_id(+)
AND fvl.return_inspection_requirement=mfl_ret.lookup_code(+)
AND mfl_ret.lookup_type(+)='MTL_RETURN_INSPECTION'
AND fvl.serial_number_control_code=mfl_ser.lookup_code(+)
AND mfl_ser.lookup_type(+)='MTL_SERIAL_NUMBER'
AND fvl.invoicing_rule_id=rai.rule_id(+)
AND fvl.accounting_rule_id=raa.rule_id(+)
AND fvl.sales_account=glv_s.code_combination_id(+)
AND fvl.payment_terms_id=rat.term_id(+)
AND fvl.coverage_schedule_id=cov.coverage_schedule_id(+)
AND fvl.serviceable_item_class_id=csc.serviceable_item_class_id(+)
AND fvl.organization_id=item_s.organization_id(+)
AND fvl.base_warranty_service_id=item_s.inventory_item_id(+)
AND fvl.warranty_vendor_id=pov.vendor_id(+)
/

SHOW ERRORS


