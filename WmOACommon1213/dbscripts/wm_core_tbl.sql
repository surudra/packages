/*  ***************************************************************************
    *    $Date:   14 Aug 2002 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Creates Core Tables and Indexes in webMethods schema
    * Program Name:         wm_core_tbl.sql
    * Version #:            1.0
    * Title:                Install Table to track changes made to base tables for webMethods
    *			    	    Outbound Transactions				
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:          Creates WM_TRACKCHANGES table in Custom (webmethods) Schema.
    * 			    Creates WM_CONTROL table in Custom (webmethods) Schema.    
    *			       		
    *
    *           
    *
    * Tables usage:             
    *   
    *
    * Procedures And Functions:         
    *
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
    *           Param2: &CustomUser
    *           Param3: &CustomUser Password    
    *           Param4: &Custom Tablespace
    *           Param5: &Custom Indexspace
    *
    * Menu Responsibilities And path: 
    *
    *
    * Technical Implementation Notes: 
    *
    *
    * Change History:           
    *
    *==========================================================================
    * Date         | Name               | Remarks 
    *==========================================================================
    *10-AUG-2002    Sudip K Chaudhuri     Created
    ***************************************************************************
*/


set feedback    on
set verify              off
set newpage     0
set pause               off
set termout     on

prompt Program : wm_core_tbl.sql

-- 
-- Connect to Custom User Account And create the table and indexes
--

connect &&custom_user/&&custom_password@&&DBString

/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_TRACKCHANGES
/*----------------------------------------------------------------------*/

DROP TABLE WM_TRACKCHANGES
/

CREATE TABLE WM_TRACKCHANGES (
  WEB_TRANSACTION_ID		  NUMBER NOT NULL ,
  TRANSACTION_TYPE		  VARCHAR2(100) NOT NULL,
  TRANSACTION_ID                VARCHAR2(100) NOT NULL, 
  DATE_CREATED		          DATE 		NOT NULL,
  COMMENTS			  VARCHAR2(240) NOT NULL,
  TRANSACTION_STATUS		  NUMBER	NOT NULL,
  PROCESSED_FLAG		  VARCHAR2(1)	NOT NULL,
  DATE_PROCESSED		  DATE
  )TABLESPACE &&custom_tablespace
/

/*----------------------------------------------------------------------*/
--      Drop and Create Table WM_CONTROL
/*----------------------------------------------------------------------*/

DROP TABLE WM_CONTROL
/

CREATE TABLE WM_CONTROL (
  TRANSACTION_TYPE		  VARCHAR2(100) NOT NULL,
  STATUS			  VARCHAR2(20) NOT NULL	CONSTRAINT checktable_status CHECK (STATUS IN('READY','INPROCESS')) 
  )TABLESPACE &&custom_tablespace 
/

DROP TABLE WM_SEND_REFERENCE_T
/

CREATE TABLE WM_SEND_REFERENCE_T
(
  TRANSACTION_ID  NUMBER                    NOT NULL,
  TRANSACTION_TYPE    VARCHAR2(100 BYTE)        NOT NULL,
  LAST_SEND_DATE      DATE NOT NULL,
  RECS_UPDATED NUMBER
)
TABLESPACE &&custom_tablespace
/

/*----------------------------------------------------------------------*/
--      Give grant all on custom data objects to APPS User
/*----------------------------------------------------------------------*/

grant all on WM_TRACKCHANGES to &&apps_user with grant option
/
grant all on WM_CONTROL to &&apps_user with grant option
/
grant all on WM_SEND_REFERENCE_T to &&apps_user with grant option
/


