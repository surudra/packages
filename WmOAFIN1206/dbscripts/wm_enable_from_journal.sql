/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Enable Triggers for Journal outbound in APPS schema
    * Program Name:         wm_enable_from_journal.sql
    * Version #:            1.0
    * Title:                Enable Triggers in APPS schema used for Journal Outbound Transactions			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Enable Triggers in Apps schema used for Journal      
    *			     	     Outbound Transactions			
    *
    *    
    * 
    *		
    * Triggers to enable: 	wm_gl_je_lines_iu_trg
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     03-oct-02	Indrani Das	   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  prompt Program : wm_enable_from_journal.sql

  connect &&apps_user/&&appspwd@&&DBString

REM "Enabling Triggers....."

ALTER TRIGGER wm_gl_je_lines_iu_trg ENABLE
/
SHOW ERRORS

