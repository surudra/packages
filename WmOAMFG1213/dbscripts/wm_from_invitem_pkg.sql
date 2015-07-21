  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE WM_INVENTORYITEM_FETCH_PKG AUTHID CURRENT_USER AS

PROCEDURE wm_fetch_inventory_item(record_count OUT NUMBER);

END WM_INVENTORYITEM_FETCH_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_INVENTORYITEM_FETCH_PKG AS
 
PROCEDURE wm_fetch_inventory_item(record_count OUT NUMBER) IS

   p_rec_wm_trackChange   wm_trackchanges%ROWTYPE;
   c_transaction_type     VARCHAR2 (100) := 'ITEM';
   ld_last_send_date      DATE;
   ld_current_send_date   DATE;
   ln_counter             NUMBER;

   CURSOR get_last_send_date_c
   IS
      SELECT last_send_date
        FROM WM_SEND_REFERENCE_T
       WHERE transaction_type = 'ITEM';

   CURSOR mtl_system_items_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
             inventory_item_id,
			 organization_id,
             1 transaction_status,
             'Inventory Item '||inventory_item_id||' for Organization '||organization_id||' CREATED' comments
        FROM MTL_SYSTEM_ITEMS_B
       WHERE     creation_date >= p_last_send_date
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
             inventory_item_id,
			 organization_id,
             0 transaction_status,
             'Inventory Item '||inventory_item_id||' for Organization '||organization_id||' UPDATED' comments
        FROM MTL_SYSTEM_ITEMS_B
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND creation_date <= p_last_send_date;
	
	
   CURSOR mtl_item_categories_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
             inventory_item_id,
			 organization_id,
             0 transaction_status,
             'Category for Inventory Item '||inventory_item_id||' for Organization '||organization_id||' CREATED' comments
        FROM MTL_ITEM_CATEGORIES
       WHERE     creation_date >= p_last_send_date
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
             inventory_item_id,
			 organization_id,
             0 transaction_status,
             'Category for Inventory Item '||inventory_item_id||' for Organization '||organization_id||' UPDATED' comments
        FROM MTL_ITEM_CATEGORIES
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND creation_date <= p_last_send_date;

			 
   CURSOR mtl_item_revisions_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
             inventory_item_id,
			 organization_id,
             0 transaction_status,
             'Revision for Inventory Item '||inventory_item_id||' for Organization '||organization_id||' CREATED' comments
        FROM MTL_ITEM_REVISIONS_B
       WHERE     creation_date >= p_last_send_date
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
             inventory_item_id,
			 organization_id,
             0 transaction_status,
             'Revision for Inventory Item '||inventory_item_id||' for Organization '||organization_id||' UPDATED' comments
        FROM MTL_ITEM_REVISIONS_B
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND creation_date <= p_last_send_date;		 
			 
BEGIN
   SELECT SYSDATE INTO ld_current_send_date FROM DUAL;

   ln_counter := 0;

   OPEN get_last_send_date_c;

   FETCH get_last_send_date_c INTO ld_last_send_date;

   CLOSE get_last_send_date_c;


   FOR rec IN mtl_system_items_c (ld_current_send_date, ld_last_send_date)
   LOOP
      p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := rec.inventory_item_id||'-'||rec.organization_id;
      p_rec_wm_trackChange.date_created := rec.creation_date1;
      p_rec_wm_trackChange.comments := rec.comments;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';

      DBMS_OUTPUT.put_line ('Record inserted :' || rec.inventory_item_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
      ln_counter := ln_counter + 1;
   END LOOP;


   FOR rec IN mtl_item_categories_c (ld_current_send_date, ld_last_send_date)
   LOOP
      p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := rec.inventory_item_id||'-'||rec.organization_id;
      p_rec_wm_trackChange.date_created := rec.creation_date1;
      p_rec_wm_trackChange.comments := rec.comments;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';

      DBMS_OUTPUT.put_line ('Record inserted :' || rec.inventory_item_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
      ln_counter := ln_counter + 1;
   END LOOP;
   
   FOR rec IN mtl_item_revisions_c (ld_current_send_date, ld_last_send_date)
   LOOP
      p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := rec.inventory_item_id||'-'||rec.organization_id;
      p_rec_wm_trackChange.date_created := rec.creation_date1;
      p_rec_wm_trackChange.comments := rec.comments;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';

      DBMS_OUTPUT.put_line ('Record inserted :' || rec.inventory_item_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); 
      ln_counter := ln_counter + 1;
   END LOOP;
   
   UPDATE WM_SEND_REFERENCE_T
      SET last_send_date = ld_current_send_date, recs_updated = ln_counter
    WHERE transaction_type = 'ITEM';

	record_count := ln_counter;
	
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;


	  
END wm_fetch_inventory_item;
END WM_INVENTORYITEM_FETCH_PKG;
/