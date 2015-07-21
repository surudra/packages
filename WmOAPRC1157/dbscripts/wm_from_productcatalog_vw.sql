/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Product Catalog outbound in Application Schema  
    * Program Name:         wm_from_productcatalog_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Product Catalog Outbound
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
     30-SEP-02	Indrani Das              Created
    ***************************************************************************
*/

  SET FEEDBACK  ON
  SET VERIFY            OFF
  SET NEWPAGE   0
  SET PAUSE             OFF
  SET TERMOUT   ON

 PROMPT Program : wm_from_productcatalog_vw.sql

  
CONNECT &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      Create View wm_po_negotiated_sources_vw
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW wm_po_negotiated_sources_vw(
org_id,
vendor_name, 
vendor_site,
item_num,
item_category,
item_description, 
item_revision, 
line_uom, 
line_price, 
supplier_item, 
break_quantity, 
break_price)
AS
SELECT 
ph.org_id,
pv.vendor_name ,
pvs.vendor_site_code,
msi.concatenated_segments, 
mc.segment1||'.'||mc.segment2, 
pl.item_description , 
pl.item_revision,
pl.unit_meas_lookup_code , 
pl.unit_price , 
pl.vendor_product_num , 
pll.quantity - NVL(pll.quantity_cancelled,0) , 
pll.price_override
FROM 
po_headers_all ph , 
po_headers_all ph1 , 
po_lines_all pl , 
po_line_locations_all pll ,
po_document_types_all pdt , 
po_lookup_codes plc , 
po_lookup_codes plc1 , 
po_lookup_codes plc2 , 
per_people_f ppf , 
gl_sets_of_books gsb , 
gl_daily_conversion_types dct , 
financials_system_params_all fsp , 
hr_org_units_no_join hou , 
hr_all_organization_units_tl hout , 
mtl_parameters mp , 
hr_locations_all hl , 
po_vendors pv , 
po_vendors pv1 , 
po_vendor_sites_all pvs , po_vendor_contacts pvc , ap_terms at , ap_terms at1 , po_line_types plt ,
mtl_system_items_b_kfv msi,
mtl_categories_b mc
WHERE ph.po_header_id = pl.po_header_id 
AND ph.org_id = pl.org_id
AND pl.po_line_id = pll.po_line_id 
AND pl.org_id = pll.org_id
AND ph.type_lookup_code IN ('BLANKET', 'QUOTATION', 'PLANNED') 
AND NVL(pll.shipment_type, 'PRICE BREAK') IN ('PRICE BREAK', 'QUOTATION', 'PLANNED') 
AND (
    (ph.approved_date IS NOT NULL 
    AND NVL(ph.cancel_flag, 'N') != 'Y' 
    AND NVL(ph.frozen_flag, 'N') != 'Y' 
    AND NVL(ph.closed_code, 'OPEN') != 'FINALLY CLOSED' 
    AND NVL(pl.closed_code, 'OPEN') != 'FINALLY CLOSED' 
    AND NVL(pl.cancel_flag, 'N') != 'Y' 
    AND NVL(pll.cancel_flag, 'N') != 'Y' 
    AND NVL(pll.closed_code, 'OPEN')!= 'FINALLY CLOSED'
    ) 
  OR 
    (ph.status_lookup_code = 'A'  AND ph.quotation_class_code = 'CATALOG')
  ) 
AND (
  SYSDATE BETWEEN NVL(ph.start_date, SYSDATE - 1) AND NVL(ph.end_date, SYSDATE + 1) 
  OR TRUNC(SYSDATE) <= NVL(TRUNC(ph.start_date), TRUNC(SYSDATE))) 
AND (SYSDATE BETWEEN NVL(pll.start_date, SYSDATE - 1) 
AND NVL(pll.end_date, SYSDATE + 1) OR TRUNC(SYSDATE) <= NVL(TRUNC(pll.start_date), TRUNC(SYSDATE))) 
AND ph.vendor_id = pv.vendor_id 
AND ph.vendor_site_id = pvs.vendor_site_id(+) 
AND ph.org_id = pvs.org_id(+)
AND msi.inventory_item_id(+) = pl.item_id
AND msi.organization_id(+) = pl.org_id
AND mc.category_id(+) = pl.category_id
AND pv.parent_vendor_id = pv1.vendor_id(+) 
AND ph.vendor_contact_id = pvc.vendor_contact_id(+) 
AND pv.minority_group_lookup_code = plc1.lookup_code(+) 
AND plc1.lookup_type(+) = 'MINORITY GROUP' 
AND ph.agent_id = ppf.person_id 
AND SYSDATE BETWEEN NVL(ppf.effective_start_date, SYSDATE - 1) AND NVL(ppf.effective_end_date, SYSDATE + 1) 
AND ph.terms_id = at.term_id(+) 
AND ph.from_header_id = ph1.po_header_id(+) 
AND DECODE(ph.type_lookup_code, 'QUOTATION', 'QUOTATION', 'BLANKET', 'PA', 'PLANNED', 'PO') = pdt.document_type_code 
AND DECODE(ph.type_lookup_code, 'QUOTATION', ph.quote_type_lookup_code, 'BLANKET', 'BLANKET', 'PLANNED', 'PLANNED') = pdt.document_subtype 
AND ph.org_id = pdt.org_id
AND DECODE(ph.type_lookup_code, 'QUOTATION', ph.status_lookup_code, 'BLANKET', ph.authorization_status, 'PLANNED', ph.authorization_status) = plc.lookup_code 
AND DECODE(ph.type_lookup_code, 'QUOTATION', 'RFQ/QUOTE STATUS', 'BLANKET', 'AUTHORIZATION STATUS', 'PLANNED', 'AUTHORIZATION STATUS') = plc.lookup_type 
AND pl.line_type_id = plt.line_type_id 
AND pll.ship_to_location_id = hl.location_id(+) 
AND pll.ship_to_organization_id = hou.organization_id(+) 
AND hou.organization_id = hout.organization_id (+) 
AND DECODE(hout.organization_id, NULL, '1', hout.language) = DECODE(hout.organization_id, NULL, '1', USERENV('LANG')) 
AND pll.terms_id = at1.term_id(+) 
AND fsp.set_of_books_id = gsb.set_of_books_id 
AND ph.org_id = fsp.org_id
AND pll.ship_to_organization_id = mp.organization_id(+) 
AND ph.rate_type = dct.conversion_type(+) 
AND plt.order_type_lookup_code = plc2.lookup_code 
AND plc2.lookup_type = 'ORDER TYPE' 
AND (    ph.type_lookup_code  != 'QUOTATION' 
                     OR                   
                    (         DECODE(ph.type_lookup_code, 
                                       'QUOTATION',ph.status_lookup_code, 
                                       'BLANKET', ph.authorization_status, 
                                       'PLANNED', ph.authorization_status)  = 'A' 
                              AND 
                             (         ph.approval_required_flag = 'N' 
                                       OR 
                                       pll.line_location_id IN 
 					(	SELECT pqa.line_location_id 
						FROM po_quotation_approvals pqa 					
                                   	WHERE pqa.line_location_id = 
							pll.line_location_id 
						AND  (   SYSDATE BETWEEN 
						NVL(pqa.start_date_active, SYSDATE - 1) 
						AND NVL(pqa.end_date_active, SYSDATE + 1) 
						OR 
						TRUNC(SYSDATE) <= NVL(pqa.start_date_active, 
									TRUNC(SYSDATE))
				              )
					)
                            )
                   )
	)
UNION 
SELECT 
ph.org_id,
pv.vendor_name , 
pvs.vendor_site_code,
msi.concatenated_segments, 
mc.segment1||'.'||mc.segment2, 
pl.item_description ,
pl.item_revision, 
pl.unit_meas_lookup_code , 
pl.unit_price , 
pl.vendor_product_num ,
TO_NUMBER(NULL) , TO_NUMBER(NULL)
FROM 
po_headers_all ph , 
po_headers_all ph1 , 
po_lines_all pl , 
po_vendors pv,
po_vendors pv1 , po_vendor_sites_all pvs , po_vendor_contacts pvc , 
po_document_types_all pdt , po_lookup_codes plc , po_lookup_codes plc1 , po_lookup_codes plc2 , 
per_people_f ppf , gl_sets_of_books gsb , gl_daily_conversion_types dct , financials_system_params_all fsp , 
ap_terms at , po_line_types plt ,
mtl_system_items_b_kfv msi,
mtl_categories_b mc
WHERE ph.type_lookup_code IN ('BLANKET', 'QUOTATION', 'PLANNED') 
AND ph.po_header_id = pl.po_header_id 
AND ph.org_id = pl.org_id
AND NOT EXISTS (SELECT 1 FROM po_line_locations_all pll
                WHERE pll.po_line_id = pl.po_line_id
                AND pll.org_id = pl.org_id)
AND msi.inventory_item_id(+) = pl.item_id
AND msi.organization_id(+) = pl.org_id
AND mc.category_id(+) = pl.category_id
AND NOT EXISTS (    SELECT 'PRICE BREAK'
                    FROM po_line_locations pll 
                    WHERE pll.shipment_type IN ('PRICE BREAK', 'QUOTATION', 'PLANNED') 
                    AND pl.po_line_id = pll.po_line_id 
                    AND (SYSDATE BETWEEN NVL(pll.start_date, SYSDATE - 1) AND NVL(pll.end_date, SYSDATE + 1) 
                        OR TRUNC(SYSDATE) <= NVL(TRUNC(pll.start_date), TRUNC(SYSDATE))
                        ) 
               ) 
AND ((ph.approved_date IS NOT NULL 
    AND NVL(ph.cancel_flag, 'N') != 'Y' 
    AND NVL(ph.frozen_flag, 'N') != 'Y' 
    AND NVL(ph.closed_code, 'OPEN') != 'FINALLY CLOSED' 
    AND NVL(pl.closed_code, 'OPEN') != 'FINALLY CLOSED' 
    AND NVL(pl.cancel_flag, 'N') != 'Y') 
    OR (ph.status_lookup_code = 'A' 
    AND ph.quotation_class_code = 'CATALOG')
    ) 
AND (SYSDATE BETWEEN NVL(ph.start_date, SYSDATE - 1) AND NVL(ph.end_date, SYSDATE + 1) 
    OR TRUNC(SYSDATE) <= NVL(TRUNC(ph.start_date), TRUNC(SYSDATE))
    ) 
AND ph.vendor_id = pv.vendor_id 
AND ph.vendor_site_id = pvs.vendor_site_id(+) 
AND ph.org_id = pvs.org_id(+)
AND pv.parent_vendor_id = pv1.vendor_id(+) 
AND ph.vendor_contact_id = pvc.vendor_contact_id(+) 
AND pv.minority_group_lookup_code = plc1.lookup_code(+) 
AND plc1.lookup_type(+) = 'MINORITY GROUP' 
AND ph.agent_id = ppf.person_id 
AND SYSDATE BETWEEN NVL(ppf.effective_start_date, SYSDATE - 1) 
AND NVL(ppf.effective_end_date, SYSDATE + 1) 
AND ph.terms_id = at.term_id(+) 
AND ph.from_header_id = ph1.po_header_id(+) 
AND DECODE(ph.type_lookup_code, 'QUOTATION', 'QUOTATION', 'BLANKET', 'PA', 'PLANNED', 'PO') = pdt.document_type_code 
AND DECODE(ph.type_lookup_code, 'QUOTATION', PH.QUOTE_TYPE_LOOKUP_CODE, 'BLANKET', 'BLANKET', 'PLANNED', 'PLANNED') = pdt.document_subtype 
AND ph.org_id = pdt.org_id
AND DECODE(ph.type_lookup_code, 'QUOTATION', ph.status_lookup_code, 'BLANKET', ph.authorization_status, 'PLANNED', ph.authorization_status) = plc.lookup_code 
AND DECODE(ph.type_lookup_code, 'QUOTATION', 'RFQ/QUOTE STATUS', 'BLANKET', 'AUTHORIZATION STATUS', 'PLANNED', 'AUTHORIZATION STATUS') = plc.lookup_type 
AND pl.line_type_id = plt.line_type_id 
AND fsp.set_of_books_id = gsb.set_of_books_id 
AND ph.org_id = fsp.org_id
AND ph.rate_type = dct.conversion_type(+) 
AND plt.order_type_lookup_code = plc2.lookup_code 
AND plc2.lookup_type = 'ORDER TYPE'
and ( ph.type_lookup_code  != 'QUOTATION' 
      OR                   
      (
        DECODE(ph.type_lookup_code, 
        'QUOTATION',ph.status_lookup_code, 
        'BLANKET', ph.authorization_status, 
        'PLANNED', ph.authorization_status)  = 'A' 
        AND 
        ph.approval_required_flag = 'N' 
      )
    )
--AND pl.item_description = 'Leather Computer Case' --'Capacitor'
--AND ph.org_id = 204
/
  
SHOW ERRORS


/*----------------------------------------------------------------------*/
--      Create View wm_po_prior_purchases_vw
/*----------------------------------------------------------------------*/
CREATE OR REPLACE VIEW wm_po_prior_purchases_vw
(
org_id,
order_date, 
vendor_name, 
vendor_site,
item_num,
item_category,
item_description, 
item_revision,
uom, 
supplier_item, 
quantity, 
price)
AS
SELECT 
ph.org_id,
DECODE(ph.type_lookup_code, 'STANDARD', ph.creation_date, 
                            'PLANNED', pr.creation_date, 
                            'BLANKET', pr.creation_date) , 
pv.vendor_name , 
pvs.vendor_site_code,
msi.concatenated_segments, 
mc.segment1||'.'||mc.segment2, 
pl.item_description , 
pl.item_revision,
pl.unit_meas_lookup_code , 
pl.vendor_product_num , 
pll.quantity - NVL(pll.quantity_cancelled,0) , 
DECODE(ph.type_lookup_code, 'STANDARD', pl.unit_price, 
                            'PLANNED', pll.price_override, 
                            'BLANKET', pll.price_override) 
FROM 
po_headers_all ph , 
po_headers_all ph2 , 
po_releases_all pr , 
po_vendors pv , 
po_vendors pv1 , 
per_people_f ppf , 
po_vendor_sites_all pvs , 
po_vendor_contacts pvc , 
po_lookup_codes plc1 , po_lookup_codes plc2 , po_lookup_codes plc3 , 
po_lines_all pl , 
po_lines_all pl2 , 
hr_locations hl ,
po_line_locations_all pll ,
ap_terms at , gl_sets_of_books gsb , gl_daily_conversion_types dct , 
financials_system_params_all fsp , 
--hr_organization_units hou , 
mtl_parameters mp , 
po_line_types plt , po_document_types_all pdt ,
mtl_system_items_b_kfv msi,
mtl_categories_b mc
WHERE 
    ph.type_lookup_code IN ('BLANKET', 'PLANNED', 'STANDARD') 
AND ph.po_header_id = pl.po_header_id 
AND ph.org_id = pl.org_id
AND msi.inventory_item_id(+) = pl.item_id
AND msi.organization_id(+) = pl.org_id
AND mc.category_id(+) = pl.category_id 
AND pl.po_line_id = pll.po_line_id 
AND pl.org_id = pll.org_id
AND pll.po_release_id = pr.po_release_id(+) 
AND pr.org_id = pll.org_id
AND pll.shipment_type IN ('BLANKET', 'SCHEDULED', 'STANDARD') 
AND (pll.quantity - NVL(pll.quantity_cancelled,0) > 0) 
AND DECODE(ph.type_lookup_code, 'STANDARD', ph.approved_date, 
                                'PLANNED', pr.approved_date, 
                                'BLANKET', pr.approved_date) IS NOT NULL 
AND DECODE(ph.type_lookup_code, 'STANDARD', ph.agent_id, 
                                'PLANNED', pr.agent_id, 
                                'BLANKET', pr.agent_id) = ppf.person_id 
AND SYSDATE BETWEEN NVL(ppf.effective_start_date, SYSDATE - 1) AND NVL(ppf.effective_end_date, SYSDATE + 1) 
AND ph.vendor_id = pv.vendor_id 
AND ph.vendor_site_id = pvs.vendor_site_id 
AND ph.org_id = pvs.org_id
AND fsp.set_of_books_id = gsb.set_of_books_id 
AND ph.org_id = fsp.org_id
AND ph.terms_id = at.term_id(+) 
AND ph.authorization_status = plc2.lookup_code 
AND plc2.lookup_type = 'AUTHORIZATION STATUS' 
AND pv.minority_group_lookup_code = plc1.lookup_code(+) 
AND plc1.lookup_type(+) = 'MINORITY GROUP' 
AND pl.line_type_id = plt.line_type_id 
AND pl.from_header_id = ph2.po_header_id(+) 
AND pl.org_id = ph2.org_id(+)
AND pl.from_line_id = pl2.po_line_id(+) 
AND pl.org_id = pl2.org_id(+)
AND pll.ship_to_location_id = hl.location_id 
--AND pll.ship_to_organization_id = hou.organization_id 
AND DECODE(ph.type_lookup_code, 'STANDARD', 'PO', 
                                'PLANNED', 'RELEASE', 
                                'BLANKET', 'RELEASE') = pdt.document_type_code 
AND DECODE(ph.type_lookup_code, 'STANDARD', ph.type_lookup_code, 
                                'PLANNED', pr.release_type, 
                                'BLANKET', pr.release_type) = pdt.document_subtype 
AND ph.org_id = pdt.org_id
AND ph.vendor_contact_id = pvc.vendor_contact_id(+) 
AND pv.parent_vendor_id = pv1.vendor_id(+) 
AND pll.ship_to_organization_id = mp.organization_id(+) 
AND ph.rate_type = dct.conversion_type(+) 
AND plt.order_type_lookup_code = plc3.lookup_code 
AND plc3.lookup_type = 'ORDER TYPE'
/
  
SHOW ERRORS

/*----------------------------------------------------------------------*/
--      Create View wm_po_sourcing_rules_vw
/*----------------------------------------------------------------------*/
CREATE OR REPLACE VIEW wm_po_sourcing_rules_vw
(
org_id,
rule, 
rule_id,
item_num, 
item_description, 
from_date, 
to_date, 
vendor_name, 
vendor_site, 
organization_code,
vendor_id
)
AS
SELECT 
sr.organization_id,
sr.sourcing_rule_name , 
sr.sourcing_rule_id,
msik.concatenated_segments, 
--mc.segment1||'.'||mc.segment2, 
msi.description , 
sr.effective_date , 
sr.disable_date , 
pv.vendor_name , 
pvs.vendor_site_code , 
mp.organization_code ,
pv.vendor_id
FROM 
mrp_sources_v sr , 
po_vendors pv , 
po_vendor_sites_all pvs , 
mtl_system_items_b_kfv msik,
mtl_system_items_b msi , 
mtl_parameters mp , 
mtl_categories_b mc,
financials_system_params_all fsp 
WHERE sr.vendor_id = pv.vendor_id 
AND sr.vendor_site_id = pvs.vendor_site_id(+) 
AND sr.inventory_item_id = msi.inventory_item_id 
AND sr.organization_id = msi.organization_id
AND msik.inventory_item_id(+) = sr.inventory_item_id
AND msik.organization_id(+) = sr.organization_id
AND fsp.inventory_organization_id = msi.organization_id 
AND sr.organization_id = mp.organization_id(+) 
AND NVL(sr.effective_date, SYSDATE) <= SYSDATE 
AND NVL(sr.disable_date, SYSDATE) >= SYSDATE 
/
  
SHOW ERRORS

/*----------------------------------------------------------------------*/
--      Create View wm_po_sourcing_docs_vw
/*----------------------------------------------------------------------*/
CREATE OR REPLACE VIEW wm_po_sourcing_docs_vw
(
org_id,
item_num,
item_category,
vendor_id,
rule_id,
sequence_num, 
vendor_product_num, 
line_uom, 
line_price, 
break_quantity, 
break_price)
AS
SELECT 
ph.org_id,
msi.concatenated_segments, 
mc.segment1||'.'||mc.segment2, 
pv.vendor_id,
pad.asl_id,
pad.sequence_num , 
pl.vendor_product_num , 
pl.unit_meas_lookup_code , 
pl.unit_price , 
pll.quantity - NVL(pll.quantity_cancelled, 0) , 
pll.price_override
FROM 
po_vendors pv , po_vendor_sites_all pvs , po_vendor_contacts pvc , financials_system_params_all fsp , 
gl_sets_of_books gsb , gl_daily_conversion_types dct , po_headers_all ph , 
po_headers_all ph1 , 
po_asl_documents pad , 
po_lines_all pl , per_people_f ppf , hr_locations hl , hr_org_units_no_join hou , 
hr_all_organization_units_tl hout , mtl_parameters mp , po_line_locations_all pll , 
ap_terms at , ap_terms at1 , po_lookup_codes plc , po_lookup_codes plc1 , po_lookup_codes plc2 , 
po_document_types_all pdt , po_line_types plt , po_approved_supplier_lis_val_v pasl , po_asl_attributes paa ,
mtl_system_items_b_kfv msi,
mtl_categories_b mc
WHERE 
pad.document_header_id = ph.po_header_id 
AND ph.org_id = fsp.org_id 
AND msi.inventory_item_id(+) = pl.item_id
AND msi.organization_id(+) = pl.org_id
AND mc.category_id(+) = pl.category_id
AND paa.asl_id = pad.asl_id 
AND paa.using_organization_id = pad.using_organization_id 
AND pasl.asl_id = paa.asl_id 
AND pasl.vendor_id = pv.vendor_id 
AND ph.vendor_contact_id = pvc.vendor_contact_id(+) 
AND ph.org_id = pad.using_organization_id
AND pad.document_line_id = pl.po_line_id 
AND ph.org_id = pl.org_id 
AND pad.document_line_id = pll.po_line_id 
AND ph.org_id = pll.org_id
AND ph.vendor_site_id = pvs.vendor_site_id(+) 
AND ph.org_id = pvs.org_id(+)
AND NVL(pll.shipment_type, 'PRICE BREAK') IN ('PRICE BREAK', 'QUOTATION') 
AND ( (
      ph.approved_date IS NOT NULL 
      AND NVL(ph.cancel_flag, 'N') != 'Y' 
      AND NVL(ph.frozen_flag, 'N') != 'Y' 
      AND NVL(ph.closed_code, 'OPEN') != 'FINALLY CLOSED' 
      AND NVL(pl.closed_code, 'OPEN') != 'FINALLY CLOSED' 
      AND NVL(pl.cancel_flag, 'N') != 'Y'
      ) 
    OR 
      (ph.status_lookup_code = 'A')
    ) 
AND (
    SYSDATE BETWEEN NVL(ph.start_date, SYSDATE - 1) AND NVL(ph.end_date, SYSDATE + 1) 
    OR 
    TRUNC(SYSDATE) <= NVL(TRUNC(ph.start_date), TRUNC(SYSDATE))
    ) 
AND (
    SYSDATE BETWEEN NVL(pll.start_date, SYSDATE - 1) AND NVL(pll.end_date, SYSDATE + 1) 
    OR 
    TRUNC(SYSDATE) <= NVL(TRUNC(pll.start_date), TRUNC(SYSDATE))
    ) 
AND DECODE(pad.document_type_code, 'QUOTATION', 'QUOTATION', 'BLANKET', 'PA') = pdt.document_type_code
AND DECODE(pad.document_type_code, 'QUOTATION', ph.quote_type_lookup_code, 'BLANKET', 'BLANKET') = pdt.document_subtype 
AND ph.org_id = pdt.org_id
AND paa.release_generation_method = plc.lookup_code(+) 
AND plc.lookup_type(+) = 'DOC GENERATION METHOD' 
AND DECODE(ph.type_lookup_code, 'QUOTATION', ph.status_lookup_code, 'BLANKET', ph.authorization_status) = plc1.lookup_code(+) 
AND DECODE(ph.type_lookup_code, 'QUOTATION', 'RFQ/QUOTE STATUS', 'BLANKET', 'AUTHORIZATION_STATUS') = plc1.lookup_type(+) 
AND ph.agent_id = ppf.person_id 
AND SYSDATE BETWEEN NVL(ppf.effective_start_date, SYSDATE - 1) AND NVL(ppf.effective_end_date, SYSDATE + 1) 
AND ph.from_header_id = ph1.po_header_id(+) 
AND ph.org_id = ph1.org_id(+)
AND pl.line_type_id = plt.line_type_id 
AND pll.ship_to_location_id = hl.location_id(+) 
AND pll.ship_to_organization_id = hou.organization_id(+) 
AND hou.organization_id = hout.organization_id (+) 
AND DECODE(hout.organization_id, NULL, '1', hout.language) = DECODE(hout.organization_id, NULL, '1', USERENV('LANG')) 
AND pll.ship_to_organization_id = mp.organization_id(+) 
AND fsp.set_of_books_id = gsb.set_of_books_id 
AND ph.terms_id = at.term_id(+) 
AND pll.terms_id = at1.term_id(+) 
AND ph.rate_type = dct.conversion_type(+) 
AND plt.order_type_lookup_code = plc2.lookup_code 
and plc2.lookup_type = 'ORDER TYPE' 
AND ( plc.lookup_code != 'QUOTATION' 
      OR 
      ( DECODE(pad.document_type_code, 'QUOTATION', ph.status_lookup_code, 
                                       'BLANKET', ph.authorization_status)  = 'A' 
        AND 
        ( ph.approval_required_flag = 'N' 
          OR 
          pll.line_location_id IN 
                             ( SELECT pqa.line_location_id 
                               FROM po_quotation_approvals pqa 
                               WHERE pqa.line_location_id = pll.line_location_id 
                               AND (SYSDATE BETWEEN NVL(pqa.start_date_active, SYSDATE - 1) 
                                            AND NVL(pqa.end_date_active, SYSDATE + 1) 
                                   OR TRUNC(SYSDATE) <= NVL(pqa.start_date_active, TRUNC(SYSDATE))
                                   )
                             )
        )
      )
    ) 
UNION
SELECT 
ph.org_id,
msi.concatenated_segments, 
mc.segment1||'.'||mc.segment2, 
pv.vendor_id,
pad.asl_id,
pad.sequence_num , 
pl.vendor_product_num , 
pl.unit_meas_lookup_code , 
pl.unit_price , 
TO_NUMBER(NULL) , 
TO_NUMBER(NULL) 
FROM 
po_vendors pv , po_vendor_sites_all pvs , po_vendor_contacts pvc , financials_system_params_all fsp , 
gl_sets_of_books gsb , gl_daily_conversion_types dct , po_headers_all ph , po_headers_all ph1 , 
po_asl_documents pad , po_approved_supplier_lis_val_v pasl , po_asl_attributes paa , po_lines_all pl , 
per_people_f ppf , ap_terms at , po_lookup_codes plc , po_lookup_codes plc1 , po_lookup_codes plc2 , 
po_document_types_all pdt , po_line_types plt ,mtl_system_items_b_kfv msi,
mtl_categories_b mc
WHERE pad.document_header_id = ph.po_header_id and pad.document_line_id = pl.po_line_id 
AND paa.asl_id = pasl.asl_id and pad.asl_id = paa.asl_id 
AND pad.using_organization_id = paa.using_organization_id 
AND NOT EXISTS (SELECT 'PRICE BREAK' FROM po_line_locations pll 
               WHERE pll.shipment_type IN ('PRICE BREAK', 'QUOTATION') 
               AND pl.po_line_id = pll.po_line_id 
               AND (SYSDATE BETWEEN NVL(pll.start_date, SYSDATE - 1) AND NVL(pll.end_date, SYSDATE + 1) 
               OR TRUNC(SYSDATE) <= NVL(TRUNC(pll.start_date), TRUNC(SYSDATE))) ) 
AND ((ph.approved_date IS NOT NULL 
AND NVL(ph.cancel_flag, 'N') != 'Y' AND NVL(ph.frozen_flag, 'N') != 'Y' 
AND NVL(ph.closed_code, 'OPEN') != 'FINALLY CLOSED' AND NVL(pl.closed_code, 'OPEN') != 'FINALLY CLOSED' 
AND NVL(pl.cancel_flag, 'N') != 'Y') OR (ph.status_lookup_code = 'A')) AND pasl.vendor_id = pv.vendor_id 
AND ph.vendor_contact_id = pvc.vendor_contact_id(+) AND ph.vendor_site_id = pvs.vendor_site_id(+) 
AND DECODE(pad.document_type_code, 'QUOTATION', 'QUOTATION', 'BLANKET', 'PA') = pdt.document_type_code 
AND DECODE(pad.document_type_code, 'QUOTATION', ph.quote_type_lookup_code, 'BLANKET', 'BLANKET') = pdt.document_subtype 
AND paa.release_generation_method = plc.lookup_code(+) AND plc.lookup_type(+) = 'DOC GENERATION METHOD' 
AND DECODE(Ph.Type_Lookup_Code, 'QUOTATION', PH.STATUS_LOOKUP_CODE, 'BLANKET', ph.authorization_status) = plc1.lookup_code(+) 
AND DECODE(ph.type_lookup_code, 'QUOTATION', 'RFQ/QUOTE STATUS', 'BLANKET', 'AUTHORIZATION_STATUS') = plc1.lookup_type(+) 
AND ph.agent_id = ppf.person_id 
AND NOT EXISTS (SELECT 1 FROM po_line_locations_all pll 
                WHERE pll.org_id = ph.org_id
                AND pll.po_line_id = pl.po_line_id)
AND SYSDATE BETWEEN NVL(ppf.effective_start_date, SYSDATE - 1) AND NVL(ppf.effective_end_date, SYSDATE + 1) 
AND ph.from_header_id = ph1.po_header_id(+) and pl.line_type_id = plt.line_type_id 
AND fsp.set_of_books_id = gsb.set_of_books_id and ph.terms_id = at.term_id(+) 
AND ph.rate_type = dct.conversion_type(+) and plt.order_type_lookup_code = plc2.lookup_code 
AND plc2.lookup_type = 'ORDER TYPE' 
AND msi.inventory_item_id(+) = pl.item_id
AND msi.organization_id(+) = pl.org_id
AND mc.category_id(+) = pl.category_id
AND ph.org_id = fsp.org_id 
AND ph.org_id = pad.using_organization_id
AND pad.using_organization_id = pl.org_id 
AND ph.org_id = pvs.org_id(+)
AND ph.org_id = pdt.org_id
AND ph.org_id = ph1.org_id(+)
--and pl.item_id = 87
AND ( plc.lookup_code != 'QUOTATION' 
      OR 
      ( DECODE(pad.document_type_code, 'QUOTATION', ph.status_lookup_code, 
                                       'BLANKET', ph.authorization_status)  = 'A' 
        AND 
        ( ph.approval_required_flag = 'N' 
        )
      )
    ) 
/

SHOW ERRORS

/*----------------------------------------------------------------------*/
--      Create View wm_po_product_catalog_qry_vw
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_PO_PRODUCT_CATALOG_QRY_VW ( WEB_TRANSACTION_ID, 
DOCUMENT_TYPE, DOCUMENT_STATUS, ORG_ID, ORGANIZATION_NAME, ITEM_CATEGORY, 
ITEM_NUM, VENDOR_NAME, VENDOR_SITE, ITEM_DESCRIPTION, 
ITEM_REVISION, SUPPLIER_ITEM ) AS SELECT DISTINCT
NULL,
'PRODUCTCAT',
'QUERY',
nsv.org_id,
hout.name,
nsv.item_category,
nsv.item_num,
nsv.vendor_name,
nsv.vendor_site,
nsv.item_description,
nsv.item_revision,
nsv.supplier_item
FROM
wm_po_negotiated_sources_vw nsv, hr_all_organization_units_tl hout
WHERE
nsv.ORG_ID = hout.ORGANIZATION_ID
UNION
SELECT DISTINCT
NULL,
'PRODUCTCAT',
'QUERY',
ppv.org_id,
hout.name,
ppv.item_category,
ppv.item_num,
ppv.vendor_name,
ppv.vendor_site,
ppv.item_description,
ppv.item_revision,
ppv.supplier_item
FROM
wm_po_prior_purchases_vw ppv, hr_all_organization_units_tl hout
WHERE
ppv.ORG_ID = hout.ORGANIZATION_ID
/
  
SHOW ERRORS


