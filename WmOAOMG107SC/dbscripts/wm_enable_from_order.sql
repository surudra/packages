/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Sales Order outbound in APPS schema
    * Program Name:         wm_enable_from_order.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for
    *				    Sales Order Outbound Transactions
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used 
    *			     	     for Sales Order Outbound Transactions
    *
    *    
    * 
    *		
    * Triggers to enable: 	WM_ORDER_HEADERS_IU_TRG
    *					WM_ORDER_LINES_IU_TRG
    *					WM_SALES_CREDITS_IUD_TRG
    *					WM_LINE_DETAILS_IUD_TRG
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     11-NOV-02	Panchali Samanta	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  prompt Program : wm_enable_from_order.sql

  connect &&apps_user/&&appspwd@&&DBString

REM "Enabling Triggers....."

ALTER TRIGGER WM_ORDER_HEADERS_IU_TRG ENABLE
/
ALTER TRIGGER WM_ORDER_LINES_IU_TRG ENABLE
/
ALTER TRIGGER WM_SALES_CREDITS_IUD_TRG ENABLE
/
ALTER TRIGGER WM_LINE_DETAILS_IUD_TRG ENABLE
/
SHOW ERRORS

