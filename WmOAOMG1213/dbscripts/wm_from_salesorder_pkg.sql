  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE WM_SALES_ORDER_FETCH_PKG AUTHID CURRENT_USER AS

PROCEDURE wm_fetch_saleorders(record_count OUT NUMBER);

END WM_SALES_ORDER_FETCH_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_SALES_ORDER_FETCH_PKG AS
 
PROCEDURE wm_fetch_saleorders(record_count OUT NUMBER) IS

   p_rec_wm_trackChange   wm_trackchanges%ROWTYPE;
   v_transaction_type     VARCHAR2 (100) := 'SALESORDER';
   ld_last_send_date      DATE;
   ld_current_send_date   DATE;
   ln_counter             NUMBER;
   p_booked_flag          oe_order_headers_all.booked_flag%TYPE;

   CURSOR get_last_send_date_c
   IS
      SELECT last_send_date
        FROM WM_SEND_REFERENCE_T
       WHERE transaction_type = 'SALESORDER';

   ---OE_ORDER_HEADERS_ALL---
   CURSOR order_headers_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT header_id,
             creation_date,
             last_update_date,
             booked_date
        FROM OE_ORDER_HEADERS_ALL
       WHERE 1 = 1 
             AND booked_flag = 'Y' -- added by vijayanand ver 2.1 dated 03-APR-2014
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date);

   -----  OE_ORDER_LINES_ALL---------
   CURSOR order_lines_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT oeh.header_id,
             oeh.booked_flag,
             oel.creation_date,
             oel.last_update_date
        FROM OE_ORDER_LINES_ALL oel, OE_ORDER_HEADERS_ALL oeh
       WHERE     1 = 1
             AND oeh.header_id = oel.header_id
             AND oeh.booked_flag = 'Y'
             AND (oel.last_update_date >= p_last_send_date
                  AND oel.last_update_date < p_current_send_date);

   ---------------OE_SALES_CREDITS------------------
   CURSOR sales_credit_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT oeh.header_id,
             oeh.booked_flag,
             osc.creation_date,
             osc.last_update_date
        FROM OE_SALES_CREDITS osc, OE_ORDER_HEADERS_ALL oeh
       WHERE     1 = 1
             AND oeh.header_id = osc.header_id
             AND oeh.booked_flag = 'Y'
             AND (osc.last_update_date >= p_last_send_date
                  AND osc.last_update_date < p_current_send_date);

   ----  OE_LOT_SERIAL_NUMBERS  ------
   CURSOR oe_lot_serials_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT oeh.header_id,
             oeh.booked_flag,
             ols.creation_date,
             ols.last_update_date
        FROM OE_ORDER_LINES_ALL oel,
             OE_ORDER_HEADERS_ALL oeh,
             OE_LOT_SERIAL_NUMBERS ols
       WHERE     1 = 1
             AND ols.line_id = oel.line_id
             AND oeh.header_id = oel.header_id
             AND oeh.booked_flag = 'Y'
             AND (ols.last_update_date >= p_last_send_date
                  AND ols.last_update_date < p_current_send_date);

   ---- OE_PRICE_ADJUSTMENTS ---
   CURSOR oe_price_adj_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT oeh.header_id,
             oeh.booked_flag,
             opa.creation_date,
             opa.last_update_date
        FROM OE_ORDER_HEADERS_ALL oeh, OE_PRICE_ADJUSTMENTS opa
       WHERE     1 = 1
             AND oeh.header_id = opa.header_id
             AND oeh.booked_flag = 'Y'
             AND (opa.last_update_date >= p_last_send_date
                  AND opa.last_update_date < p_current_send_date);

   --OE_ORDER_PRICE_ATTRIBS--
   CURSOR oe_price_attr_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      SELECT oeh.header_id,
             oeh.booked_flag,
             opa.creation_date,
             opa.last_update_date
        FROM OE_ORDER_HEADERS_ALL oeh, OE_ORDER_PRICE_ATTRIBS opa
       WHERE     1 = 1
             AND oeh.header_id = opa.header_id
             AND oeh.booked_flag = 'Y'
             AND (opa.last_update_date >= p_last_send_date
                  AND opa.last_update_date < p_current_send_date);
BEGIN
   SELECT SYSDATE INTO ld_current_send_date FROM DUAL;

   ln_counter := 0;

   OPEN get_last_send_date_c;

   FETCH get_last_send_date_c INTO ld_last_send_date;

   CLOSE get_last_send_date_c;

   --Populate the table WM_TRACKCHANGES when there is an insert or update
   --on OE_ORDER_HEADERS_ALL table and gives a call to WEB_TRANSACTION procedure to populate
   --WM_TRACKCHANGES tables.

   FOR rec IN order_headers_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.comments :=
               'ORDER HEADER INSERT FOR ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 1;

            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.date_created := rec.creation_date;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            --            IF rec.booked_date IS NULL  -- commented by vijayanand ver 2.1 dated 03-APR-2014
            IF rec.booked_date = rec.last_update_date -- added by vijayanand ver 2.1 dated 03-APR-2014
            THEN
               p_rec_wm_trackChange.transaction_id := rec.header_id;
               p_rec_wm_trackChange.comments :=
                  'ORDER HEADER INSERT FOR ' || rec.header_id;
               p_rec_wm_trackChange.transaction_status := 1;
               p_rec_wm_trackChange.transaction_type := v_transaction_type;
               p_rec_wm_trackChange.date_created := rec.creation_date;
               p_rec_wm_trackChange.processed_flag := 'N';
            --            ELSE    -- commented by vijayanand ver 2.1 dated 03-APR-2014
            ELSIF rec.last_update_date > rec.booked_date
            THEN              -- added by vijayanand ver 2.1 dated 03-APR-2014
               p_rec_wm_trackChange.transaction_id := rec.header_id;
               p_rec_wm_trackChange.comments :=
                  'ORDER HEADER UPDATE FOR ' || rec.header_id;
               p_rec_wm_trackChange.transaction_status := 0;
               p_rec_wm_trackChange.transaction_type := v_transaction_type;
               p_rec_wm_trackChange.date_created := rec.creation_date;
               p_rec_wm_trackChange.processed_flag := 'N';
            END IF;
         END IF;

         DBMS_OUTPUT.put_line (
            'Record inserted order header id:' || rec.header_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   --populate the table WM_TRACKCHANGES when there is an insert or update on
   --OE_ORDER_LINES_ALL table and gives a call to WEB_TRANSACTION procedure to populate
   --WM_TRACKCHANGES tables.


   FOR rec IN order_lines_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN                                                        -- Insert
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.Creation_date;
            p_rec_wm_trackChange.comments :=
               'ORDER LINE INSERT FOR ORDER HEADER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'ORDER LINE UPDATE FOR ORDER HEADER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line (
            'Record inserted for order lines:' || rec.header_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   ---sales_credit_c---
   FOR rec IN sales_credit_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN                                                        -- Insert
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.Creation_date;
            p_rec_wm_trackChange.comments :=
               'SALES CREDIT INSERT FOR ORDER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'SALES CREDIT UPDATE FOR ORDER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line (
            'Record inserted for order lines:' || rec.header_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   --replace Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_LOT_SERIAL_NUMBERS table
   --and gives a call to WEB_TRANSACTION procedure to populate  WM_TRACKCHANGES tables.

   -------------------  4. OE_LOT_SERIAL_NUMBERS -----------

   FOR rec IN oe_lot_serials_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN                                                        -- Insert
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.Creation_date;
            p_rec_wm_trackChange.comments :=
               'LOT SERIAL INSERT FOR LINE OF ORDER HEADER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'LOT SERIAL UPDATE FOR LINE OF ORDER HEADER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line (
            'Record inserted for order lot serials :' || rec.header_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   -- Replace Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_PRICE_ADJUSTMENTS table
   --and gives a call to WEB_TRANSACTION procedure to populate WM_TRACKCHANGES tables.

   ---- OE_PRICE_ADJUSTMENTS ---
   FOR rec IN oe_price_adj_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN                                                        -- Insert
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.Creation_date;
            p_rec_wm_trackChange.comments :=
               'PRICE ADJUSTMENTS INSERT FOR ORDER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'PRICE ADJUSTMENTS UPDATE FOR ORDER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line (
            'PRICE ADJUSTMENTS  FOR ORDER  :' || rec.header_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;


   --Replace Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete on OE_ORDER_PRICE_ATTRIBS table
   --and gives a call to WEB_TRANSACTION procedure to populate WM_TRACKCHANGES tables.

   --OE_ORDER_PRICE_ATTRIBS--

   FOR rec IN oe_price_attr_c (ld_current_send_date, ld_last_send_date)
   LOOP
      BEGIN
         IF rec.creation_date = rec.last_update_date
         THEN                                                        -- Insert
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.Creation_date;
            p_rec_wm_trackChange.comments :=
               'ORDER PRICE ATTRIBUTES INSERT FOR ORDER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         ELSE
            p_rec_wm_trackChange.transaction_type := v_transaction_type;
            p_rec_wm_trackChange.transaction_id := rec.header_id;
            p_rec_wm_trackChange.date_created := rec.last_update_date;
            p_rec_wm_trackChange.comments :=
               'ORDER PRICE ATTRIBUTES UPDATE FOR ORDER ' || rec.header_id;
            p_rec_wm_trackChange.transaction_status := 0;
            p_rec_wm_trackChange.processed_flag := 'N';
         END IF;

         DBMS_OUTPUT.put_line (
            'ORDER PRICE ATTRIBUTES INSERT FOR ORDER :' || rec.header_id);
         wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
         ln_counter := ln_counter + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;
   END LOOP;

   --------------------------------------------
   UPDATE WM_SEND_REFERENCE_T
      SET last_send_date = ld_current_send_date, recs_updated = ln_counter
    WHERE transaction_type = 'SALESORDER';

	record_count := ln_counter;
	
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;


END wm_fetch_saleorders;
END WM_SALES_ORDER_FETCH_PKG;
/