REM  ================================================================
REM  ===================  Release 10.7SC ================================
REM  ================================================================
WHENEVER SQLERROR EXIT FAILURE ROLLBACK
CREATE OR REPLACE PACKAGE WM_POO_UPDATE AS
PROCEDURE WM_UPDATE_PO
     (po_org_id	   IN	NUMBER,
document_type  IN VARCHAR2,
      po_number      IN VARCHAR2,
      po_type        IN VARCHAR2,
      release_number IN VARCHAR2);
END;
/
CREATE OR REPLACE PACKAGE BODY WM_POO_UPDATE AS
PROCEDURE WM_UPDATE_PO
     (po_org_id	   IN	NUMBER,
	document_type  IN VARCHAR2,
      po_number      IN VARCHAR2,
      po_type        IN VARCHAR2,
      release_number IN VARCHAR2) IS

	po_document_type 	   VARCHAR2(25);
      l_document_type       VARCHAR2(25);
	l_document_subtype   VARCHAR2(25);
      l_document_id        NUMBER;
      l_header_id          NUMBER;
      l_release_id         NUMBER;
      l_error_code         NUMBER;
      l_error_buf          VARCHAR2(1000);
      l_error_stack        VARCHAR2(2000);

      BEGIN
   		fnd_client_info.set_org_context(po_org_id);

		SELECT DECODE(document_type,
                           'BLANKET'         ,'NB',
                           'STANDARD'        ,'NS',
                           'PLANNED'         ,'NP',
                           'RELEASE'         ,'NR',
                           'BLANKET RELEASE' ,'NR',
                           'NR') INTO po_document_type
      	FROM  DUAL;

         SELECT   po_header_id INTO l_header_id
         FROM     po_headers
         WHERE    segment1         = po_number AND
                  type_lookup_code = po_type;

         -- Perform the first update if this is a Standard or Blanket PO
        
         IF po_document_type NOT IN('NR','CR') THEN
            UPDATE   po_headers
            SET      last_update_date     =  SYSDATE,
                     printed_date         =  SYSDATE,
                     print_count          =  NVL(print_count,0) + 1,
                     edi_processed_flag   = 'Y'
            WHERE    po_header_id         =  l_header_id;

            -- Perform the same update for the Archive Table.
            UPDATE   po_headers_archive
            SET      last_update_date     =  SYSDATE,
                     printed_date         =  SYSDATE,
                     print_count          =  NVL(print_count,0) + 1,
                     edi_processed_flag   = 'Y'
            WHERE    po_header_id         =  l_header_id AND
                     latest_external_flag = 'Y';
         ELSE
            -- Get the po_release_id, as it is needed here for the update and
            -- later for the archive call
         
            SELECT   po_release_id INTO l_release_id
            FROM     po_releases
            WHERE    release_num  = release_number AND
                     po_header_id = l_header_id;
           
 -- Perform this update if this is a Release PO
            
            UPDATE   po_releases
            SET      last_update_date     =  SYSDATE,
                     printed_date         =  SYSDATE,
                     print_count          =  NVL(print_count,0) + 1,
                     edi_processed_flag   = 'Y'
            WHERE    po_release_id        =  l_release_id;

		-- Perform the same update for the Archive Table.
		UPDATE   po_releases_archive
            SET      last_update_date     =  SYSDATE,
                     printed_date         =  SYSDATE,
                     print_count          =  NVL(print_count,0) + 1,
                     edi_processed_flag   = 'Y'
            WHERE    po_release_id        =  l_release_id AND
                     latest_external_flag = 'Y';
         END IF;

         -- Perform archiving by calling the archive proceedure.
         
         SELECT   DECODE
                    (po_document_type,
                     'NS','PO',
                     'CS','PO',
                     'NB','PA',
                     'CB','PA',
                     'NP','PO',
                     'CP','PO',
                     'NR','RELEASE',
                     'CR','RELEASE'),
                  DECODE
                    (po_document_type,
                     'NR',DECODE
                           (po_type,
                            'PLANNED','SCHEDULED',
                            'BLANKET','BLANKET'),
                     'CR',DECODE(po_type,
                            'PLANNED','SCHEDULED',
                            'BLANKET','BLANKET'),
                     po_type) INTO l_document_type,l_document_subtype
         FROM     DUAL;

         IF po_document_type NOT IN ('NR','CR') THEN
               l_document_id := l_header_id;
         ELSE
               l_document_id := l_release_id;
         END IF;

         ece_po_archive_pkg.porarchive
           (l_document_type,
            l_document_subtype,
            l_document_id,
           'PRINT',
            l_error_code,
            l_error_buf,
            l_error_stack);

	IF l_error_code != 0 THEN
            raise_application_error(-20000,l_error_buf || l_error_stack);
      END IF;
   END WM_UPDATE_PO;
END;
/
