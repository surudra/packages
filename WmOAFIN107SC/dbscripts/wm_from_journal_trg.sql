/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Journal Outbound in Application Schema  
    * Program Name:         wm_from_journal_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				GL_JE_LINES				ON I/U
    *
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
    * Trigger: 
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
     03-oct-02	   Indrani Das   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_journal_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on GL_JE_LINES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_gl_je_lines_iu_trg
AFTER INSERT OR UPDATE ON GL_JE_LINES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW WHEN (new.status='P' and old.status!='P')
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='JOURNAL';

BEGIN

	-- assign data for parent key identifier
	

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.processed_flag:='N';

	 p_rec_wm_trackChange.transaction_status:=1;
	 p_rec_wm_trackChange.comments:='JE HEADER INSERT FOR '||:new.je_header_id||'-'||:new.je_line_num;
	 p_rec_wm_trackChange.transaction_id:=:new.je_header_id||'-'||:new.je_line_num;


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

  EXCEPTION
  	WHEN OTHERS THEN NULL;

END;
/
