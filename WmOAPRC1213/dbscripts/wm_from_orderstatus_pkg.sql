/*  ***************************************************************************
        $Date:   04 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Packages for Order Status Outbound in Application Schema  
    * Program Name:         wm_from_orderstatus_pkg.sql
    * Version #:            1.0
    * Title:                Package Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *
    * Tables usage:     		INSERT		UPDATE		DELETE
    *
    * Procedures and Functions: get_po_status-> Derives Purchase Order Status for a Purchase Order 
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
    *           Param3: &CustomUser 
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
     04-OCT-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_from_orderstatus_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE Wm_order_status_Pkg AUTHID CURRENT_USER AS


  FUNCTION get_po_status  (X_po_header_id IN NUMBER)
		RETURN VARCHAR2;


END Wm_order_status_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_order_status_Pkg AS

  FUNCTION get_po_status  (X_po_header_id IN NUMBER)
              RETURN VARCHAR2 IS

   X_status             VARCHAR2(4000) := '';
   x_status_code	VARCHAR2(80) := '';
   x_cancel_status	VARCHAR2(80) := '';
   x_closed_status      VARCHAR2(80) := '';
   x_frozen_status      VARCHAR2(80) := '';
   x_hold_status        VARCHAR2(80) := '';
   x_auth_status        VARCHAR2(25) := '';
   x_cancel_flag	VARCHAR2(1)  := 'N';
   x_closed_code        VARCHAR2(25) := '';
   x_frozen_flag	VARCHAR2(1)  := 'N';
   x_user_hold_flag     VARCHAR2(1)  := 'N';
   x_reserved_flag      VARCHAR2(1)  := 'N';
   x_reserved_status    VARCHAR2(80) := '';
   x_po_encumbrance_flag VARCHAR2(1) := '';
   x_delimiter		VARCHAR2(2)  := ', ';
   x_org_id		NUMBER;

   BEGIN

              SELECT plc_sta.displayed_field,
                     decode(poh.cancel_flag,
                            'Y', plc_can.displayed_field, NULL),
                     decode(nvl(poh.closed_code, 'OPEN'), 'OPEN', NULL,
                            plc_clo.displayed_field),
                     decode(poh.frozen_flag,
                            'Y', plc_fro.displayed_field, NULL),
                     decode(poh.user_hold_flag,
                            'Y', plc_hld.displayed_field, NULL),
                     poh.authorization_status,
                     nvl(poh.cancel_flag, 'N'),
                     poh.closed_code,
                     nvl(poh.frozen_flag, 'N'),
                     nvl(poh.user_hold_flag, 'N'),
		     org_id
              into   x_status_code,
                     x_cancel_status,
                     x_closed_status,
                     x_frozen_status,
                     x_hold_status,
                     x_auth_status,
                     x_cancel_flag,
                     x_closed_code,
                     x_frozen_flag,
                     x_user_hold_flag,
		     x_org_id
              from   po_lookup_codes plc_sta,
                     po_lookup_codes plc_can,
                     po_lookup_codes plc_clo,
                     po_lookup_codes plc_fro,
                     po_lookup_codes plc_hld,
                     po_headers_all poh
              where  plc_sta.lookup_code =
                     decode(poh.approved_flag,
                            'R', poh.approved_flag,
                                 nvl(poh.authorization_status,'INCOMPLETE'))
              and    plc_sta.lookup_type in ('PO APPROVAL', 'DOCUMENT STATE')
              and    plc_can.lookup_code = 'CANCELLED'
              and    plc_can.lookup_type = 'DOCUMENT STATE'
              and    plc_clo.lookup_code = nvl(poh.closed_code, 'OPEN')
              and    plc_clo.lookup_type = 'DOCUMENT STATE'
              and    plc_fro.lookup_code = 'FROZEN'
              and    plc_fro.lookup_type = 'DOCUMENT STATE'
              and    plc_hld.lookup_code = 'ON HOLD'
              and    plc_hld.lookup_type = 'DOCUMENT STATE'
              and    poh.po_header_id = X_po_header_id;

	      BEGIN
              SELECT NVL(purch_encumbrance_flag,'N')
              INTO   X_po_encumbrance_flag
              FROM   FINANCIALS_SYSTEM_PARAMS_ALL
	      WHERE  ORG_ID = x_org_id;
	      	EXCEPTION
			WHEN NO_DATA_FOUND THEN  NULL;
	        	WHEN OTHERS THEN  NULL;
              END;


              IF X_po_encumbrance_flag = 'Y' THEN

	       BEGIN
              	SELECT POLC.displayed_field,
                       decode(POLC.lookup_code, 'RESERVED', 'Y', 'N')
              	INTO   x_reserved_status,
                       x_reserved_flag
           	FROM   PO_LOOKUP_CODES POLC
              	WHERE  POLC.lookup_type = 'DOCUMENT STATE'
              	AND    POLC.lookup_code = 'RESERVED'
              	AND EXISTS
               	    ( SELECT 'Do we have shipments'
                 	FROM   PO_LINE_LOCATIONS POLL
                 	WHERE  POLL.po_header_id = X_po_header_id
                        AND    POLL.shipment_type in ('STANDARD', 'PLANNED')
                 	AND    nvl(POLL.cancel_flag, 'N') = 'N'
                 	AND    nvl(POLL.closed_code, 'OPEN') <> 'FINALLY CLOSED' )
              	AND NOT EXISTS
               	    ( SELECT 'Do we have uncumbered shipments'
                 	FROM   PO_LINE_LOCATIONS POLL
                 	WHERE  POLL.po_header_id = X_po_header_id
                 	AND    nvl(POLL.encumbered_flag, 'N') = 'N'
                 	AND    POLL.shipment_type in ('STANDARD', 'PLANNED')
                 	AND    nvl(POLL.cancel_flag, 'N') <> 'Y'
                 	AND    nvl(POLL.closed_code, 'OPEN') <>
                        	          'FINALLY CLOSED');

	      	EXCEPTION
			WHEN NO_DATA_FOUND THEN  NULL;
	        	WHEN OTHERS THEN  NULL;
              END;

             END IF; /* of po encumbrance ON */


	      SELECT x_status_code||
			decode(x_closed_code, 'OPEN', '', '', '',
				x_delimiter||x_closed_status)||
			decode(x_cancel_flag, 'N', '', '', '',
			        x_delimiter||x_cancel_status)||
			decode(x_frozen_flag, 'N', '', '', '',
				x_delimiter||x_frozen_status)||
		        decode(x_user_hold_flag, 'N', '', '', '',
				x_delimiter||x_hold_status)||
			decode(x_reserved_flag, 'N', '', '', '',
				x_delimiter||x_reserved_status)
	      INTO   x_status
              FROM   dual;

      RETURN (X_status);

      EXCEPTION
	WHEN OTHERS THEN
             RETURN (NULL);
             RAISE;

 END get_po_status;

END Wm_order_status_Pkg;
/

SHOW ERRORS
