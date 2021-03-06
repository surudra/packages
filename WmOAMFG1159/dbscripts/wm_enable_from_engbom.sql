/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Engineering BOM outbound in APPS schema
    * Program Name:         wm_enable_from_engbom.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for Engineering BOM 
    *                       Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for Engineering BOM      
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to enable: 	WM_ENG_BOM_BILL_OF_MTL_IUD_TRG
    *                         WM_ENG_MTL_ITEM_REV_IUD_TRG
    *					WM_ENG_BOM_INV_COMPS_IUD_TRG
    *					WM_ENG_BOM_SUB_COMPS_IUD_TRG
    *                         WM_ENG_BOM_REF_DESGS_IUD_TRG
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     22-oct-02	Indrani Das	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  prompt Program : wm_enable_from_engbom.sql

  connect &&apps_user/&&appspwd@&&DBString

REM "Enabling Triggers....."

ALTER TRIGGER WM_ENG_BOM_BILL_OF_MTL_IUD_TRG ENABLE
/
ALTER TRIGGER WM_ENG_MTL_ITEM_REV_IUD_TRG ENABLE
/
ALTER TRIGGER WM_ENG_BOM_INV_COMPS_IUD_TRG ENABLE
/
ALTER TRIGGER WM_ENG_BOM_SUB_COMPS_IUD_TRG ENABLE
/
ALTER TRIGGER WM_ENG_BOM_REF_DESGS_IUD_TRG ENABLE
/
SHOW ERRORS

