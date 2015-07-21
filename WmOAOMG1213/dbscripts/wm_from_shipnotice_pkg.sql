  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE WM_ASN_FETCH_PKG AUTHID CURRENT_USER AS

PROCEDURE wm_fetch_shipnotices(record_count OUT NUMBER);

END WM_ASN_FETCH_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_ASN_FETCH_PKG AS
 
PROCEDURE wm_fetch_shipnotices(record_count OUT NUMBER) IS


   p_rec_wm_trackChange   wm_trackchanges%ROWTYPE;
   c_transaction_type     VARCHAR2 (100) := 'ASN';
   ld_last_send_date      DATE;
   ld_current_send_date   DATE;
   ln_counter             NUMBER;


   CURSOR get_last_send_date_c
   IS
      SELECT last_send_date
        FROM WM_SEND_REFERENCE_T
       WHERE transaction_type = 'ASN';

   CURSOR asn_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT source_line_id, creation_date, last_update_date
        FROM WSH_DELIVERY_DETAILS
       WHERE released_status = 'C' AND source_code = 'OE'
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date);
BEGIN
   SELECT SYSDATE INTO ld_current_send_date FROM DUAL;

   ln_counter := 0;

   OPEN get_last_send_date_c;

   FETCH get_last_send_date_c INTO ld_last_send_date;

   CLOSE get_last_send_date_c;

   FOR rec IN asn_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date <> rec.last_update_date
         THEN
            p_rec_wm_trackChange.transaction_type := c_transaction_type;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.processed_flag := 'N';

            p_rec_wm_trackChange.transaction_id := rec.source_line_id;
            p_rec_wm_trackChange.comments :=
               'DELIVERY DETAIL SHIPPED FOR ORDER LINE '
               || rec.source_line_id;
            p_rec_wm_trackChange.transaction_status := 1;

            DBMS_OUTPUT.put_line (
               'Record inserted cust acct id:' || rec.source_line_id);
            wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
            ln_counter := ln_counter + 1;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   ----------------------------------------------

   UPDATE WM_SEND_REFERENCE_T
      SET last_send_date = ld_current_send_date, recs_updated = ln_counter
    WHERE transaction_type = 'ASN';

	record_count := ln_counter;
	
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;






END wm_fetch_shipnotices;
END WM_ASN_FETCH_PKG;
/