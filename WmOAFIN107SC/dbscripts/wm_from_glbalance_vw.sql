/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for General Ledger Balance outbound in Application Schema  
    * Program Name:         wm_from_glbalance_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for General Ledger Balance Outbound
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
     15-NOV-02	   Panchali Samanta   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_glbalance_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      Create View WM_GL_BALANCES_QRY_VW
/*----------------------------------------------------------------------*/

create or replace view &&apps_user..wm_gl_balances_qry_vw as
SELECT  NULL web_transaction_id,
'GLBALANCE' document_type,
'QUERY' document_status,
gls.name set_of_books_name,
glv.concatenated_segments account_code,
glb.currency_code currency_code,
glb.period_name period_name,
glb.actual_flag actual_flag,
glbv.budget_name budget_version_name,
glc.encumbrance_type encumbrance_type,
glb.revaluation_status revaluation_status,
glb.period_type period_type,
glb.period_year period_year,
glb.period_num period_number,
glb.period_net_dr period_net_dr,
glb.period_net_cr period_net_cr,
glb.period_to_date_adb period_to_date_adb,
glb.quarter_to_date_dr quarter_to_date_dr,
glb.quarter_to_date_cr quarter_to_date_cr,
glb.quarter_to_date_adb quarter_to_date_adb,
glb.year_to_date_adb year_to_date_adb,
glb.project_to_date_dr project_to_date_dr,
glb.project_to_date_cr project_to_date_cr,
glb.project_to_date_adb project_to_date_adb,
glb.begin_balance_dr begin_balance_dr,
glb.begin_balance_cr begin_balance_cr,
glb.period_net_dr_beq period_net_dr_beq,
glb.period_net_cr_beq period_net_cr_beq,
glb.begin_balance_dr_beq begin_balance_dr_beq,
glb.begin_balance_cr_beq begin_balance_cr_beq,
glt.template_name summary_template_name
FROM gl_balances glb,
gl_encumbrance_types glc,
gl_code_combinations_kfv glv,
gl_summary_templates glt,
gl_budget_versions glbv,
gl_sets_of_books gls
WHERE
glb.encumbrance_type_id = glc.encumbrance_type_id(+)
AND glb.code_combination_id = glv.code_combination_id
AND glb.template_id = glt.template_id(+)
AND glb.budget_version_id = glbv.budget_version_id(+)
AND glb.set_of_books_id = gls.set_of_books_id
/
  
SHOW ERRORS

