/*  ***************************************************************************
    *    $Date:   24 Nov 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Order Status outbound in Application Schema  
    * Program Name:         wm_from_orderstatus_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Order Status Outbound
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
     05-NOV-02	  Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_os_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_OS_QRY_VW 
/*----------------------------------------------------------------------*/

create or replace view wm_os_qry_vw 
( 
 organization_name,
 po_document_num,   
 creation_date,
 ship_to_address_line_1,
 ship_to_address_line_2,
 ship_to_address_line_3,
 ship_to_town_or_city,
 ship_to_region_1,
 ship_to_region_2,
 ship_to_region_3,
 ship_to_country,
 ship_to_postal_code,
 bill_to_address_line_1,
 bill_to_address_line_2,
 bill_to_address_line_3,
 bill_to_town_or_city,
 bill_to_region_1,
 bill_to_region_2,
 bill_to_region_3,
 bill_to_country,
 bill_to_postal_code,
 currency_code,
 blanket_total_amount,
 revision_num,  
 type_lookup_code, 
 agent_name,  
 supplier_name,   
 supplier_site_code,
 supplier_address_line1,  
 supplier_address_line2, 
 supplier_address_line3, 
 supplier_city, 
 supplier_state,   
 supplier_zip, 
 supplier_country, 
 supplier_contact, 
 po_status,
 comments
 ) as 
select 
  hou.name,
  poh.segment1 ,
  poh.creation_date,
  hrl1.address_line_1,
  hrl1.address_line_2,
  hrl1.address_line_3,
  hrl1.town_or_city,
  hrl1.region_1,
  hrl1.region_2,
  hrl1.region_3,
  hrl1.country,
  hrl1.postal_code,
  hrl2.address_line_1,
  hrl2.address_line_2,
  hrl2.address_line_3,
  hrl2.town_or_city,
  hrl2.region_1,
  hrl2.region_2,
  hrl2.region_3,
  hrl2.country,
  hrl2.postal_code,
  poh.currency_code ,
  poh.blanket_total_amount ,
  poh.revision_num ,
  poh.type_lookup_code ,
  p.full_name ,
  v.vendor_name ,
  vs.vendor_site_code,
  vs.address_line1 ,
  vs.address_line2 ,
  vs.address_line3 ,
  vs.city ,
  vs.state ,
  vs.zip ,
  vs.country ,
  decode(poh.vendor_contact_id, null, null, vc.last_name||','|| vc.first_name),
  wm_order_status_pkg.get_po_status(poh.po_header_id),
  poh.comments
from 
  po_document_types_all pdtt,
  po_document_types_all pdtb,
  po_lookup_codes polc,
  po_lookup_codes polc2,
  po_lookup_codes polc3,
  per_all_people_f p,
  po_vendors v,
  po_vendor_sites_all vs,
  po_vendor_contacts vc,
  hr_locations hrl1,
  hr_locations hrl2,
  hr_organization_units hou,
  po_headers_all poh
where 
  poh.agent_id = p.person_id and
  p.business_group_id = (select nvl(max(fsp.business_group_id),0) from financials_system_params_all fsp where fsp.org_id = poh.org_id) and
  trunc(sysdate) between p.effective_start_date and  p.effective_end_date and
  p.employee_number is not null and
  ( ( pdtb.document_type_code in ( 'PO','PA') and  pdtb.document_subtype = poh.type_lookup_code ) ) and
  v.vendor_id (+) = poh.vendor_id and
  vs.vendor_site_id (+)= poh.vendor_site_id and
  vc.vendor_contact_id (+) = poh.vendor_contact_id and
  hrl1.location_id (+) = poh.ship_to_location_id and
  hrl2.location_id (+) = poh.bill_to_location_id and
  nvl(poh.authorization_status,'INCOMPLETE') = polc.lookup_code(+) and
  polc.lookup_type(+) = 'AUTHORIZATION STATUS' and
  polc2.lookup_code (+) = poh.fob_lookup_code and
  polc2.lookup_type (+) = 'FOB' and
  polc3.lookup_code (+) = poh.freight_terms_lookup_code and
  polc3.lookup_type (+) = 'FREIGHT TERMS' and
  pdtb.document_type_code = pdtt.document_type_code and
  pdtb.document_subtype = pdtt.document_subtype and
  nvl(pdtt.org_id, -99) = nvl(pdtb.org_id, -99) and 
  pdtb.org_id = poh.org_id and
  vs.org_id (+) = poh.org_id and
  poh.org_id = hou.organization_id (+)
/

SHOW ERRORS

