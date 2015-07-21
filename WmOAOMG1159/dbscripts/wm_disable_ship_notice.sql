/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Disable Triggers for Advance Ship Notice outbound in APPS schema
    * Program Name:         wm_disable_ship_notice.sql
    * Version #:            1.0
    * Title:                Disable Triggers in APPS schema used for Advance Ship Notice Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Disable Triggers in Apps schema used for              
    *			     	     Advance Ship Notice Outbound Transactions
    *
    *    
    *		
    * Triggers to disable: 	wm_delivery_detail_u_trg
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
     24-OCT-02	Panchali Samanta	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  prompt Program : wm_disable_ship_notice.sql

  connect &&apps_user/&&appspwd@&&DbString

REM "Disabling Triggers....."

ALTER TRIGGER wm_delivery_detail_u_trg DISABLE
/
SHOW ERRORS
