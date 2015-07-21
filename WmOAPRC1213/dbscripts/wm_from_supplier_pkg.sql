  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE WM_SUPPLIER_FETCH_PKG AUTHID CURRENT_USER AS

PROCEDURE wm_fetch_suppliers(record_count OUT NUMBER);

END WM_SUPPLIER_FETCH_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_SUPPLIER_FETCH_PKG AS
 
PROCEDURE wm_fetch_suppliers(record_count OUT NUMBER) IS

   p_rec_wm_trackChange   wm_trackchanges%ROWTYPE;
   v_transaction_type     VARCHAR2 (100) := 'SUPPLIER';
   ld_last_send_date      DATE;
   ld_current_send_date   DATE;
   ln_counter             NUMBER;
   v_vendor_id            ap_suppliers.vendor_id%TYPE;


   CURSOR get_last_send_date_c
   IS
      SELECT last_send_date
        FROM WM_SEND_REFERENCE_T
       WHERE transaction_type = 'SUPPLIER';


   CURSOR vendors_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT vendor_id,
             vendor_name,
             creation_date,
             last_update_date
        FROM AP_SUPPLIERS
       WHERE 1 = 1 AND NVL (vendor_type_lookup_code, 'XXYY') <> 'EMPLOYEE' -- added nvl by vijayanand dated 03-APR-2014 ver 2.1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date);

   CURSOR vendor_sites_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT vendor_id,
             vendor_site_code,
             creation_date,
             last_update_date
        FROM AP_SUPPLIER_SITES_ALL pvs
       WHERE 1 = 1
             AND EXISTS
                    (SELECT 1
                       FROM ap_suppliers aps
                      WHERE pvs.vendor_id = aps.vendor_id
                            AND NVL (aps.vendor_type_lookup_code, 'XXYY') <>
                                   'EMPLOYEE') -- added nvl by vijayanand dated 03-APR-2014 ver 2.1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date);

   CURSOR ap_supplier_contacts_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT first_name,
             last_name,
             middle_name,
             vendor_site_id,
             creation_date,
             last_update_date
        FROM AP_SUPPLIER_CONTACTS contacts
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND EXISTS
                    (SELECT 1
                       FROM ap_suppliers aps, ap_supplier_sites_all pvc
                      WHERE pvc.vendor_id = aps.vendor_id
                            AND contacts.vendor_site_id = pvc.vendor_site_id
                            AND NVL (aps.vendor_type_lookup_code, 'XXYY') <>
                                   'EMPLOYEE') -- added nvl by vijayanand dated 03-APR-2014 ver 2.1
                                              ;

   -- Bank account uses - AP_BANK_ACCOUNT_USES_ALL ------
   CURSOR c_bank_acct_uses (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT DISTINCT pvs.vendor_id,
                      pvs.vendor_site_id,
                      instr_assign.creation_date,
                      instr_assign.last_update_date
        FROM iby_pmt_instr_uses_all instr_assign,
             iby_external_payees_all payee,
             po_vendor_sites_all pvs
       WHERE     1 = 1
             AND instr_assign.ext_pmt_party_id = payee.ext_payee_id
             AND instr_assign.instrument_type = 'BANKACCOUNT'
             AND instr_assign.payment_flow = 'DISBURSEMENTS'
             AND payee.supplier_site_id = pvs.vendor_site_id
             AND pay_site_flag = 'Y'
             AND EXISTS
                    (SELECT 1
                       FROM ap_suppliers aps
                      WHERE pvs.vendor_id = aps.vendor_id
                            AND NVL (aps.vendor_type_lookup_code, 'XXYY') <>
                                   'EMPLOYEE') -- added nvl by vijayanand dated 03-APR-2014 ver 2.1
             AND (instr_assign.last_update_date >= p_last_send_date
                  AND instr_assign.last_update_date < p_current_send_date);
BEGIN
   SELECT SYSDATE INTO ld_current_send_date FROM DUAL;

   ln_counter := 0;

   OPEN get_last_send_date_c;

   FETCH get_last_send_date_c INTO ld_last_send_date;

   CLOSE get_last_send_date_c;

   --Populate the table WM_TRACKCHANGES when there is an insert or update
   --on AP_SUPPLIERS table and gives a call to WEB_TRANSACTION procedure to populate
   --WM_TRACKCHANGES tables.

   FOR rec IN vendors_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.vendor_id;
            p_rec_wm_trackChange.date_created := rec.creation_date;
            p_rec_wm_trackChange.comments :=
               'VENDOR INSERT FOR ' || rec.vendor_name;
            p_rec_wm_trackChange.transaction_status := 1;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.vendor_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'VENDOR UPDATE FOR ' || rec.vendor_name;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line ('Record inserted :' || rec.vendor_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   --populate the table WM_TRACKCHANGES when there is an insert or update on
   --PO_VENDORS_SITES_ALL table and gives a call to WEB_TRANSACTION procedure to populate
   --WM_TRACKCHANGES tables.


   FOR rec IN vendor_sites_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.vendor_id;
            p_rec_wm_trackChange.date_created := rec.Creation_date;
            p_rec_wm_trackChange.comments :=
               'VENDOR SITE INSERT FOR ' || rec.vendor_site_code;
            p_rec_wm_trackChange.transaction_status := 1;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.vendor_id;
            p_rec_wm_trackChange.date_created := rec.Creation_date;
            p_rec_wm_trackChange.comments :=
               'VENDOR SITE UPDATE FOR ' || rec.vendor_site_code;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line ('Record inserted :' || rec.vendor_site_code);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   --  ap_supplier_contacts_c --
   FOR rec
      IN ap_supplier_contacts_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         SELECT vendor_id
           INTO v_vendor_id
           FROM AP_SUPPLIER_SITES_ALL
          WHERE vendor_site_id = rec.vendor_site_id;

         IF rec.creation_date = rec.last_update_date
         THEN
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := v_vendor_id;
            p_rec_wm_trackChange.date_created := rec.creation_date;
            p_rec_wm_trackChange.comments :=
                  'VENDOR CONTACT INSERT FOR '
               || rec.first_name
               || ' '
               || rec.middle_name
               || ' '
               || rec.last_name;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := v_vendor_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
                  'VENDOR CONTACT UPDATE FOR '
               || rec.first_name
               || ' '
               || rec.middle_name
               || ' '
               || rec.last_name;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line ('Record inserted :' || v_vendor_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;


   -------------------  4. iby_pmt_instr_uses_all  / AP_BANK_ACCOUNT_USES_ALL -----------

   FOR rec IN c_bank_acct_uses (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN                                                     -- inserting
            -- assign data for parent key identifier

            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.vendor_id;
            p_rec_wm_trackChange.date_created := rec.creation_date;
            p_rec_wm_trackChange.comments :=
               'BANK ACCOUNT INSERTED FOR VENDOR ID: ' || rec.vendor_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            -- assign data for parent key identifier

            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.vendor_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'BANK ACCOUNT UPDATED FOR VENDOR ID: ' || rec.vendor_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line ('Record inserted Vendor id:' || rec.vendor_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;



   UPDATE WM_SEND_REFERENCE_T
      SET last_send_date = ld_current_send_date, recs_updated = ln_counter
    WHERE transaction_type = 'SUPPLIER';

	record_count := ln_counter;
	
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;


END wm_fetch_suppliers;
END WM_SUPPLIER_FETCH_PKG;
/