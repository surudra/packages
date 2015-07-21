/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Uninstall Objects for Sales Order Outbound Transactions
    * Program Name:         wm_drop_from_salesorder.sql
    * Version #:            1.0
    * Title:                Uninstall objects used for Sales Order Outbound Transactions    
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Uninstall objects used for Sales Order Outbound Transactions    			
    *
    *           
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
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
    *           Param2: &DatabaseApplicationUser
    *           Param3: &DatabaseApplicationPwd
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
     03-oct-02	Panchali Samanta	Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_drop_from_salesorder.sql

  
connect &&dbAppUser/&&dbAppPwd@&&DB_Name

REM "Uninstalling Triggers....."


-- Dropping All Triggers------------------------------------------------------

DROP TRIGGER &&dbAppUser..WM_ORDER_HEADERS_IU_TRG
/
DROP TRIGGER &&dbAppUser..WM_ORDER_LINES_IUD_TRG 
/
DROP TRIGGER &&dbAppUser..WM_SALES_CREDITS_IUD_TRG 
/
DROP TRIGGER &&dbAppUser..WM_OE_LOTSERIAL_IUD_TRG 
/
DROP TRIGGER &&dbAppUser..WM_OE_PRICE_ADJ_IUD_TRG 
/
DROP TRIGGER &&dbAppUser..WM_OE_PRICE_ATTRIBS_IUD_TRG 
/
DROP TRIGGER &&dbAppUser..WM_LINE_SETS_ID_TRG 
/

-- DROP VIEWS in APPS------------------------------------------------------

DROP VIEW WM_ORDER_HEADERS_VW 
/
DROP VIEW WM_ORDER_LINES_VW 
/
DROP VIEW WM_SALES_CREDITS_VW 
/
DROP VIEW WM_HEADER_SALES_CREDIT_VW 
/
DROP VIEW WM_PRICE_ADJ_VW 
/
DROP VIEW WM_HEADER_PRICE_ADJ_VW 
/
DROP VIEW WM_PRICE_ATTRIBS_VW 
/
DROP VIEW WM_HEADER_PRICE_ATTRB_VW
/
DROP VIEW WM_OE_RESERVTNS_VW  
/
DROP VIEW WM_LOTSERIALS_VW 
/
DROP VIEW WM_OE_ACTIONS_VW 
/
DROP VIEW WM_OE_LINE_ACTIONS_VW 
/
DROP VIEW WM_ORDER_HEADER_QRY_VW 
/
clear buffer

SHOW ERRORS

prompt UnInstall Complete for Sales Order Outbound
