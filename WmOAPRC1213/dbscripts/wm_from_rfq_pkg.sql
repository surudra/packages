  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE WM_RFQ_FETCH_PKG AUTHID CURRENT_USER AS

PROCEDURE wm_fetch_rfq(record_count OUT NUMBER);

END WM_RFQ_FETCH_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_RFQ_FETCH_PKG AS
 
PROCEDURE wm_fetch_rfq(record_count OUT NUMBER) IS
   p_rec_wm_trackChange   wm_trackchanges%ROWTYPE;
   c_transaction_type     VARCHAR2 (100) := 'RFQ';
   ld_last_send_date      DATE;
   ld_current_send_date   DATE;
   ln_counter             NUMBER;


   CURSOR get_last_send_date_c
   IS
      SELECT last_send_date
        FROM WM_SEND_REFERENCE_T
       WHERE transaction_type = 'RFQ';

   CURSOR rfq_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT print_count,
             po_header_id,
             vendor_site_id,
             creation_date,
             last_update_date
        FROM PO_RFQ_VENDORS
       WHERE print_count IS NOT NULL
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date);
BEGIN
   SELECT SYSDATE INTO ld_current_send_date FROM DUAL;

   ln_counter := 0;

   OPEN get_last_send_date_c;

   FETCH get_last_send_date_c INTO ld_last_send_date;

   CLOSE get_last_send_date_c;

   FOR rec IN rfq_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.print_count = 1
         THEN
            p_rec_wm_trackChange.transaction_type := c_transaction_type;
            p_rec_wm_trackChange.transaction_id :=
               rec.po_header_id || '-' || rec.vendor_site_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
                  'RFQ INSERT FOR '
               || rec.po_header_id
               || '-'
               || rec.vendor_site_id;
            p_rec_wm_trackChange.transaction_status := 1;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSIF rec.print_count > 1
         THEN
            p_rec_wm_trackChange.transaction_type := c_transaction_type;
            p_rec_wm_trackChange.transaction_id :=
               rec.po_header_id || '-' || rec.vendor_site_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
                  'RFQ UPDATE FOR '
               || rec.po_header_id
               || '-'
               || rec.vendor_site_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line (
               'Record inserted po_header_id - vendor_site_id:'
            || rec.po_header_id
            || '-'
            || rec.vendor_site_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   ----------------------------------------------

   UPDATE WM_SEND_REFERENCE_T
      SET last_send_date = ld_current_send_date, recs_updated = ln_counter
    WHERE transaction_type = 'RFQ';

	record_count := ln_counter;
	
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;


END wm_fetch_rfq;
END WM_RFQ_FETCH_PKG;
/