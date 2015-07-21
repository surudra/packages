REM  ================================================================
REM  ===================  Release 11 ================================
REM  ================================================================
REM  ===================This script has been added By Milind Shah to test POCO transaction on 02/11/2000  for testing only  =====

WHENEVER SQLERROR EXIT FAILURE ROLLBACK
CREATE OR REPLACE PACKAGE WM_POCO_UPDATE AS
PROCEDURE WM_UPDATE_POCO
     (po_org_id	   IN	NUMBER,
      po_number      IN VARCHAR2,
      release_number IN VARCHAR2,
	po_type IN VARCHAR2);
END;
/
CREATE OR REPLACE PACKAGE BODY WM_POCO_UPDATE AS
PROCEDURE WM_UPDATE_POCO
     (po_org_id	   IN	NUMBER,
      po_number      IN VARCHAR2,
      release_number IN VARCHAR2,
	po_type IN VARCHAR2       ) IS

	po_document_type 	   VARCHAR2(25);
      l_document_type       VARCHAR2(25);
      l_document_subtype   VARCHAR2(25);
      l_document_id        NUMBER;
      l_header_id          NUMBER;
      l_release_id         NUMBER;

      BEGIN
   		fnd_client_info.set_org_context(po_org_id);

         SELECT   po_header_id INTO l_header_id
         FROM     po_headers
         WHERE    segment1         = po_number AND
                  type_lookup_code = po_type;

         -- Perform this update if this is a Standard or Blanket PO
--       IF po_document_type NOT IN ('NR','CR') THEN
         IF release_number = 0 THEN
           UPDATE   po_headers_archive            
	     SET last_update_date     =  SYSDATE,
               printed_date         =  SYSDATE,                     
   		   print_count          =  NVL(print_count,0) + 1,
               edi_processed_flag   = 'Y'            
	     WHERE po_header_id   =  l_header_id AND   
		     latest_external_flag = 'Y';

         ELSE
            -- Get the po_release_id, as it is needed here for the update and
            -- later for the archive call
                    
 	  -- Perform this update if this is a Release PO
            
            -- Perform the update for the Archive Table.
	    UPDATE   po_releases_archive
            SET      last_update_date     =  SYSDATE,
                     printed_date         =  SYSDATE,
                     print_count          =  NVL(print_count,0) + 1,
                     edi_processed_flag   = 'Y'
            WHERE    po_header_id         =  l_header_id AND
                     release_num          =  release_number AND
                     latest_external_flag = 'Y';
         END IF;
     END WM_UPDATE_POCO;
END;
/
