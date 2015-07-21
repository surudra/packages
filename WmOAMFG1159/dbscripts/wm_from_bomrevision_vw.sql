/*  ***************************************************************************
    *    $Date:   14 Oct 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Bom Revisions outbound in Application Schema  
    * Program Name:         wm_from_bomrevision_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Bom Revisions Outbound
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
     14-OCT-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_bomrevision_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_BOM_REVISIONS_QRY_VW 
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_BOM_REVISIONS_QRY_VW
(
ITEM,
INV_ORG_NAME,
REVISION,
CHANGE_NOTICE,
ECN_INITIATION_DATE,
IMPLEMENTATION_DATE,
EFFECTIVITY_DATE,
REVISION_LABEL,
REVISION_REASON
)AS
SELECT 
  MSI.CONCATENATED_SEGMENTS ITEM_NUMBER,
  HOU.NAME INV_ORG_NAME,
  MIR.REVISION REVISION,
  MIR.CHANGE_NOTICE CHANGE_NOTICE,
  MIR.ECN_INITIATION_DATE ECN_INITIATION_DATE,
  MIR.IMPLEMENTATION_DATE IMPLEMENTATION_DATE,
  MIR.EFFECTIVITY_DATE EFFECTIVITY_DATE,
  MIR.REVISION_LABEL REVISION_LABEL,
  MIR.REVISION_REASON REVISION_REASON
FROM 
  MTL_ITEM_REVISIONS MIR,
  HR_ALL_ORGANIZATION_UNITS HOU,
  MTL_SYSTEM_ITEMS_B_KFV MSI,
  BOM_BILL_OF_MATERIALS BOM
WHERE 
  MIR.ORGANIZATION_ID = HOU.ORGANIZATION_ID (+)  AND
  MIR.ORGANIZATION_ID = MSI.ORGANIZATION_ID (+) AND
  MIR.INVENTORY_ITEM_ID = MSI.INVENTORY_ITEM_ID (+)  AND
  BOM.ORGANIZATION_ID (+) = MIR.ORGANIZATION_ID  AND
  BOM.ASSEMBLY_ITEM_ID (+) = MIR.INVENTORY_ITEM_ID
/

SHOW ERRORS

