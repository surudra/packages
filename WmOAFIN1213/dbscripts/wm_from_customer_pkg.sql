  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE WM_CUSTOMER_FETCH_PKG AUTHID CURRENT_USER AS

PROCEDURE wm_fetch_customers(record_count OUT NUMBER);

END WM_CUSTOMER_FETCH_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_CUSTOMER_FETCH_PKG AS
 
PROCEDURE wm_fetch_customers(record_count OUT NUMBER) IS

   p_rec_wm_trackChange   wm_trackchanges%ROWTYPE;
   c_transaction_type     VARCHAR2 (100) := 'CUSTOMER';
   ld_last_send_date      DATE;
   ld_current_send_date   DATE;
   ln_counter             NUMBER;
   v_cust_id              NUMBER;
   cust_account_id        NUMBER;

   p_party_type           hz_parties.party_type%TYPE;
   p_object_id            hz_party_relationships.object_id%TYPE;

   CURSOR get_last_send_date_c
   IS
      SELECT last_send_date
        FROM WM_SEND_REFERENCE_T
       WHERE transaction_type = 'CUSTOMER';

  ------ 1. HZ_PARTIES-------
   CURSOR customers_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      -- logic for INSERT records
      -- no logic to capture new inserts at all
      -- logic for all updated records that was updated in the current period
      SELECT party_id,
             creation_date,
             last_update_date
        FROM HZ_PARTIES
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND party_type IN ('ORGANIZATION', 'PERSON') 
                                                         ;

   CURSOR cust_in_party(p_party_id number)
   IS
      SELECT cust_account_id
        FROM hz_cust_accounts
       WHERE party_id = p_party_id;


   --      2.  hz_cust_accounts  insert or update
   CURSOR cust_in_party1 (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_account_id,
             party_id,
             creation_date,
             last_update_date
        FROM hz_cust_accounts
       WHERE 1 = 1                                --and party_id=:new.party_id
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date);

   -- 3. iby_pmt_instr_uses_all  / AP_BANK_ACCOUNT_USES_ALL -----------
   CURSOR c_bank_acct_uses (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT                           --ac.customer_name, ac.customer_number,
            ac.customer_id,
             instr_assign.creation_date,
             instr_assign.last_update_date
        FROM iby_pmt_instr_uses_all instr_assign,
             iby_external_payers_all payee,
             iby_ext_bank_accounts bankacct,
             hz_cust_accounts_all hcal,
             ar_customers ac
       WHERE     instr_assign.instrument_id = bankacct.ext_bank_account_id
             AND instr_assign.ext_pmt_party_id = payee.ext_payer_id
             AND instr_assign.instrument_type = 'BANKACCOUNT'
             AND instr_assign.payment_flow = 'FUNDS_CAPTURE'
             AND instr_assign.payment_function = 'CUSTOMER_PAYMENT'
             AND hcal.cust_account_id = payee.cust_account_id
             AND ac.customer_number = hcal.account_number
             AND (instr_assign.last_update_date >= p_last_send_date
                  AND instr_assign.last_update_date < p_current_send_date);

   ----- 4. HZ_CONTACT_POINTS ---------

   CURSOR c_contact_points (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT owner_table_id, creation_date, last_update_date, owner_table_name
        FROM HZ_CONTACT_POINTS
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);

   CURSOR cust_for_party_site (v_owner_table_id IN NUMBER)
   IS
      SELECT cust_account_id
        FROM hz_cust_acct_sites_all
       WHERE party_site_id = v_owner_table_id;

   CURSOR cust_for_party_customer (
      v_owner_table_id IN NUMBER)
   IS
      SELECT a.cust_account_id cust_account_id
        FROM hz_cust_account_roles a, hz_relationships b, hz_parties c
       WHERE     a.party_id = b.party_id
             AND b.party_id = v_owner_table_id
             AND b.party_id = c.party_id
             AND b.directional_flag = 'F'
             AND b.party_id = c.party_id
             AND c.party_type = 'PARTY_RELATIONSHIP'
      UNION
      SELECT cust_account_id
        FROM hz_cust_accounts a, hz_parties b
       WHERE     b.party_id = a.party_id
             AND b.party_id = v_owner_table_id
             AND b.party_type IN ('ORGANIZATION', 'PERSON');

   ----- ----   5. HZ_CUSTOMER_PROFILES -----
   CURSOR C_customer_profiles (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_account_id, creation_date, last_update_date
        FROM hz_customer_profiles
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);


   ---------  6. HZ_CUST_ACCT_RELATE_ALL -----------
   CURSOR C_customer_relation (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_account_id, creation_date, last_update_date
        FROM HZ_CUST_ACCT_RELATE_ALL
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);

   ------7. HZ_CUST_ACCT_SITES_ALL------
   CURSOR C_cust_acct_sites (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_account_id, creation_date, last_update_date
        FROM HZ_CUST_ACCT_SITES_ALL
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);

   -------------8. HZ_CUST_PROFILE_AMTS------------
   CURSOR C_cust_profile_amt (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_account_id, creation_date, last_update_date
        FROM HZ_CUST_PROFILE_AMTS
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);

   -------9. HZ_CUST_SITE_USES_ALL------------
   CURSOR C_cust_site_uses (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_acct_site_id, creation_date, last_update_date
        FROM HZ_CUST_SITE_USES_ALL
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);


   CURSOR cust_account (p_acct_site_id NUMBER)
   IS
      SELECT cust_account_id
        FROM hz_cust_acct_sites_all
       WHERE cust_acct_site_id = p_acct_site_id;

   ------------------10. HZ Locations------------------

   CURSOR C_hz_location (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT location_id, creation_date, last_update_date
        FROM HZ_LOCATIONS
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);


   CURSOR cust_location (
      p_location_id NUMBER)
   IS
      SELECT a.cust_account_id cust_account_id
        FROM hz_cust_acct_sites_all a, hz_party_sites b
       WHERE b.location_id = p_location_id
             AND a.party_site_id = b.party_site_id;

   --------------  11. HZ_CUST_ACCOUNT_ROLES    ----------------------
   CURSOR C_cust_acct_roles (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_account_id, creation_date, last_update_date
        FROM HZ_CUST_ACCOUNT_ROLES
       WHERE role_type = 'CONTACT'
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date);

   -------------- 12. HZ_ROLE_RESPONSIBILITY--------------------
   CURSOR C_cust_acct_role_resp (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT cust_account_role_id, creation_date, last_update_date
        FROM HZ_ROLE_RESPONSIBILITY
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);

   p_party_type           hz_parties.party_type%TYPE;
   p_object_id            hz_party_relationships.object_id%TYPE;
   v_cust_account_id      NUMBER;

   --------  13. RA_CUST_RECEIPT_METHODS -------------
   CURSOR C_CUST_RECEIPT_METHODS (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT customer_id, creation_date, last_update_date
        FROM RA_CUST_RECEIPT_METHODS
       WHERE (last_update_date >= p_last_send_date
              AND last_update_date < p_current_send_date);
BEGIN
   SELECT SYSDATE INTO ld_current_send_date FROM DUAL;

   ln_counter := 0;

   OPEN get_last_send_date_c;

   FETCH get_last_send_date_c INTO ld_last_send_date;

   CLOSE get_last_send_date_c;


   FOR rec IN customers_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         SELECT b.CUST_ACCOUNT_ID
           INTO v_cust_id
           FROM hz_relationships a, hz_cust_accounts b
          WHERE     a.subject_id = rec.party_id
                AND a.object_id = b.party_id
                AND directional_flag = 'F';

         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := v_cust_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments := 'PARTY UPDATE FOR ' || v_cust_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';

         DBMS_OUTPUT.put_line ('Record inserted :' ||v_cust_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); -- NOTE : For testing Purpose only.  Remove 1 from pkg name.
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;

      FOR c_cust_in_party IN cust_in_party(rec.party_id)
      LOOP
         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id :=
            c_cust_in_party.cust_account_id;
         p_rec_wm_trackChange.date_created := SYSDATE;
         p_rec_wm_trackChange.comments :=
            'PARTY UPDATE FOR ' || c_cust_in_party.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';

         -- Call Procedure to Insert into wm_track_changes
         DBMS_OUTPUT.put_line (
            'Record inserted cust acct id:'
            || c_cust_in_party.cust_account_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
         ln_counter := ln_counter + 1;
      END LOOP;
   END LOOP;

   ------------- HZ cust Accounts -------------

   FOR rec IN cust_in_party1(ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN                                                        -- inserting
         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER INSERT FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 1;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE                                                         -- updating
         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER UPDATE FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted cust acct id:' || rec.cust_account_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;

  -------------------  3. iby_pmt_instr_uses_all  / AP_BANK_ACCOUNT_USES_ALL -----------

   FOR rec IN c_bank_acct_uses(ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN                                                        -- inserting
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.customer_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'BANK ACCOUNT INSERT FOR ' || rec.customer_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.customer_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'BANK ACCOUNT UPDATE FOR ' || rec.customer_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted customer id:' || rec.customer_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;

   ---------- 4. HZ_CONTACT_POINTS--------------------

   FOR rec IN c_contact_points (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN
         IF rec.owner_table_name = 'HZ_PARTY_SITES'
         THEN
            --- If inserting contact point for a party site

            FOR c_cust_for_party_site
               IN cust_for_party_site (rec.owner_table_id)
            LOOP
               -- assign data for parent key identifier

               p_rec_wm_trackChange.transaction_type := c_transaction_type;
               p_rec_wm_trackChange.transaction_id :=
                  c_cust_for_party_site.cust_account_id;
               p_rec_wm_trackChange.date_created := rec.creation_date;
               p_rec_wm_trackChange.comments :=
                  'CONTACT POINT INSERT FOR '
                  || c_cust_for_party_site.cust_account_id;
               p_rec_wm_trackChange.transaction_status := 0;
               p_rec_wm_trackChange.processed_flag := 'N';


               -- Call Procedure to Insert into wm_track_changes
               DBMS_OUTPUT.put_line (
                  'Record inserted customer id:'
                  || c_cust_for_party_site.cust_account_id);
               wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
               ln_counter := ln_counter + 1;
            END LOOP;
         ELSE
            FOR c_cust_for_party_customer
               IN cust_for_party_customer (rec.owner_table_id)
            LOOP
               -- assign data for parent key identifier

               p_rec_wm_trackChange.transaction_type := c_transaction_type;
               p_rec_wm_trackChange.transaction_id :=
                  c_cust_for_party_customer.cust_account_id;
               p_rec_wm_trackChange.date_created := rec.creation_date;
               p_rec_wm_trackChange.comments :=
                  'CONTACT POINT INSERT FOR '
                  || c_cust_for_party_customer.cust_account_id;
               p_rec_wm_trackChange.transaction_status := 0;
               p_rec_wm_trackChange.processed_flag := 'N';


               DBMS_OUTPUT.put_line (
                  'Record inserted customer id:'
                  || c_cust_for_party_customer.cust_account_id);
               wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
               ln_counter := ln_counter + 1;
            END LOOP;
         END IF;
      ELSE                                                           -- update
         IF rec.owner_table_name = 'HZ_PARTY_SITES'
         THEN
            --- If updating contact point for a party site

            FOR c_cust_for_party_site
               IN cust_for_party_site (rec.owner_table_id)
            LOOP
               -- assign data for parent key identifier

               p_rec_wm_trackChange.transaction_type := c_transaction_type;
               p_rec_wm_trackChange.transaction_id :=
                  c_cust_for_party_site.cust_account_id;
               p_rec_wm_trackChange.date_created := rec.last_update_date;
               p_rec_wm_trackChange.comments :=
                  'CONTACT POINT UPDATE FOR '
                  || c_cust_for_party_site.cust_account_id;
               p_rec_wm_trackChange.transaction_status := 0;
               p_rec_wm_trackChange.processed_flag := 'N';


               -- Call Procedure to Insert into wm_track_changes
               DBMS_OUTPUT.put_line (
                  'Record inserted customer id:'
                  || c_cust_for_party_site.cust_account_id);
               wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
               ln_counter := ln_counter + 1;
            END LOOP;
         ELSE                                            -- not HZ_PARTY_SITES
            FOR c_cust_for_party_customer
               IN cust_for_party_customer (rec.owner_table_id)
            LOOP
               -- assign data for parent key identifier

               p_rec_wm_trackChange.transaction_type := c_transaction_type;
               p_rec_wm_trackChange.transaction_id :=
                  c_cust_for_party_customer.cust_account_id;
               p_rec_wm_trackChange.date_created := rec.last_update_date;
               p_rec_wm_trackChange.comments :=
                  'CONTACT POINT UPDATE FOR '
                  || c_cust_for_party_customer.cust_account_id;
               p_rec_wm_trackChange.transaction_status := 0;
               p_rec_wm_trackChange.processed_flag := 'N';


               -- Call Procedure to Insert into wm_track_changes
               DBMS_OUTPUT.put_line (
                  'Record inserted customer id:'
                  || c_cust_for_party_customer.cust_account_id);
               wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
               ln_counter := ln_counter + 1;
            END LOOP;
         END IF;
      END IF;
   END LOOP;


   ----   5. HZ_CUSTOMER_PROFILES -----
   FOR rec IN C_customer_profiles (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER PROFILE INSERT FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER PROFILE UPDATE FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted customer id:' || rec.cust_account_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;


   ---------  6. HZ_CUST_ACCT_RELATE_ALL -----------
   FOR rec IN C_customer_relation (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'RELATIONSHIP INSERT FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'RELATIONSHIP UPDATE FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted customer id:' || rec.cust_account_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;

   -----------7. HZ_CUST_ACCT_SITES_ALL-------
   FOR rec IN C_cust_acct_sites (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER SITE INSERT FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER SITE UPDATE FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted customer id:' || rec.cust_account_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;


   ----------8. HZ_CUST_PROFILE_AMTS-----------

   FOR rec IN C_cust_profile_amt (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER PROFILE AMT. INSERT  FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'CUSTOMER PROFILE AMT. UPDATE  FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted customer id:' || rec.cust_account_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;

   ----------9. HZ_CUST_SITE_USES_ALL------------
   FOR rec IN C_cust_site_uses (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN                                                        -- inserting
         FOR c_cust_account IN cust_account(rec.cust_acct_site_id)
         LOOP
            -- assign data for parent key identifier

            p_rec_wm_trackChange.transaction_type := c_transaction_type;
            p_rec_wm_trackChange.transaction_id :=
               c_cust_account.cust_account_id;
            p_rec_wm_trackChange.date_created := rec.creation_date;
            p_rec_wm_trackChange.comments :=
               'BUSINESS PURPOSE INSERT FOR '
               || c_cust_account.cust_account_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';

            DBMS_OUTPUT.put_line (
               'Record inserted customer id:'
               || c_cust_account.cust_account_id);
            wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
            ln_counter := ln_counter + 1;
         END LOOP;
      ELSE                                                         -- updating
         FOR c_cust_account IN cust_account(rec.cust_acct_site_id)
         LOOP
            -- assign data for parent key identifier

            p_rec_wm_trackChange.transaction_type := c_transaction_type;
            p_rec_wm_trackChange.transaction_id :=
               c_cust_account.cust_account_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'BUSINESS PURPOSE UPDATE FOR '
               || c_cust_account.cust_account_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';

            DBMS_OUTPUT.put_line (
               'Record inserted customer id:'
               || c_cust_account.cust_account_id);
            wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
            ln_counter := ln_counter + 1;
         END LOOP;
      END IF;
   END LOOP;

   ------------10. HZ_LOCATIONS -------------
   FOR rec IN C_hz_location (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN                                                        -- inserting
         FOR c_cust_location IN cust_location(rec.location_id)
         LOOP
            -- assign data for parent key identifier

            p_rec_wm_trackChange.transaction_type := c_transaction_type;
            p_rec_wm_trackChange.transaction_id :=
               c_cust_location.cust_account_id;
            p_rec_wm_trackChange.date_created := rec.creation_date;
            p_rec_wm_trackChange.comments :=
               'LOCATION INSERT FOR  ' || c_cust_location.cust_account_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';

            DBMS_OUTPUT.put_line (
               'Record inserted customer id:'
               || c_cust_location.cust_account_id);
            wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
            ln_counter := ln_counter + 1;
         END LOOP;
      ELSE                                                         -- updating
         FOR c_cust_location IN cust_location(rec.location_id)
         LOOP
            -- assign data for parent key identifier

            p_rec_wm_trackChange.transaction_type := c_transaction_type;
            p_rec_wm_trackChange.transaction_id :=
               c_cust_location.cust_account_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'LOCATION UPDATE FOR ' || c_cust_location.cust_account_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';

            DBMS_OUTPUT.put_line (
               'Record inserted customer id:'
               || c_cust_location.cust_account_id);
            wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
            ln_counter := ln_counter + 1;
         END LOOP;
      END IF;
   END LOOP;

   -------------11. HZ_CUST_ACCOUNT_ROLES---------

   FOR rec IN C_cust_acct_roles (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN                                                  -- only for insert
         -- assign data for parent key identifier

         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.cust_account_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'CONTACT INSERT FOR ' || rec.cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';

         DBMS_OUTPUT.put_line (
            'Record inserted customer id:' || rec.cust_account_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
         ln_counter := ln_counter + 1;
      END IF;
   END LOOP;

   -------------- 12. HZ_ROLE_RESPONSIBILITY--------------------

   FOR rec IN C_cust_acct_role_resp (ld_current_send_date, ld_last_send_date)
   LOOP
      SELECT cust_account_id
        INTO v_cust_account_id
        FROM hz_cust_account_roles
       WHERE cust_account_role_id = rec.cust_account_role_id;

      IF rec.creation_date = rec.last_update_date
      THEN                                                      --  for insert
         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := v_cust_account_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'CONTACT ROLE INSERT FOR ' || v_cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE                                                           -- update
         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := v_cust_account_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'CONTACT ROLE UPDATE FOR ' || v_cust_account_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted customer id:' || v_cust_account_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;


   --------  13. RA_CUST_RECEIPT_METHODS -------------

   FOR rec
      IN C_CUST_RECEIPT_METHODS (ld_current_send_date, ld_last_send_date)
   LOOP
      IF rec.creation_date = rec.last_update_date
      THEN                                                      --  for insert
         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.customer_id;
         p_rec_wm_trackChange.date_created := rec.creation_date;
         p_rec_wm_trackChange.comments :=
            'PAYMENT METHOD INSERT FOR ' || rec.customer_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      ELSE                                                           -- update
         p_rec_wm_trackChange.transaction_type := c_transaction_type;
         p_rec_wm_trackChange.transaction_id := rec.customer_id;
         p_rec_wm_trackChange.date_created := rec.last_update_date;
         p_rec_wm_trackChange.comments :=
            'PAYMENT METHOD INSERT FOR ' || rec.customer_id;
         p_rec_wm_trackChange.transaction_status := 0;
         p_rec_wm_trackChange.processed_flag := 'N';
      END IF;

      DBMS_OUTPUT.put_line (
         'Record inserted customer id:' || rec.customer_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
      ln_counter := ln_counter + 1;
   END LOOP;



   UPDATE WM_SEND_REFERENCE_T
      SET last_send_date = ld_current_send_date, recs_updated = ln_counter
    WHERE transaction_type = 'CUSTOMER';

	record_count := ln_counter;
	
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;


	  
END wm_fetch_customers;
END WM_CUSTOMER_FETCH_PKG;
/