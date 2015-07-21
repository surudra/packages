  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE WM_ENGBOM_FETCH_PKG AUTHID CURRENT_USER AS

PROCEDURE wm_fetch_engbom(record_count OUT NUMBER);

END WM_ENGBOM_FETCH_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_ENGBOM_FETCH_PKG AS
 
PROCEDURE wm_fetch_engbom(record_count OUT NUMBER) IS


   p_rec_wm_trackChange   wm_trackchanges%ROWTYPE;
   c_transaction_type     VARCHAR2 (100) := 'ENGBOM';
   ld_last_send_date      DATE;
   ld_current_send_date   DATE;
   ln_counter             NUMBER;
   V_BILL_SEQUENCE_ID	  bom_bill_of_materials.bill_sequence_id%TYPE;
   V_ASSEMBLY_TYPE		  bom_bill_of_materials.assembly_type%type;

   CURSOR get_last_send_date_c
   IS
      SELECT last_send_date
        FROM WM_SEND_REFERENCE_T
       WHERE transaction_type = 'ENGBOM';

   CURSOR bom_structures_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
   IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
             bill_sequence_id,
             ASSEMBLY_TYPE,
             1 transaction_status,
             'BILL OF MATERIAL INSERT FOR ' || bill_sequence_id comments
        FROM bom_structures_b
       WHERE     creation_date >= p_last_send_date
             AND ASSEMBLY_TYPE = 2
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
             bill_sequence_id,
             ASSEMBLY_TYPE,
             0 transaction_status,
             'BILL OF MATERIAL UPDATE FOR ' || bill_sequence_id comments
        FROM bom_structures_b
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND ASSEMBLY_TYPE = 2
             AND creation_date <= p_last_send_date;
			 
	CURSOR mtl_item_revisions_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
    IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
			 INVENTORY_ITEM_ID, 
			 ORGANIZATION_ID, 
             0 transaction_status,
			 'ITEM REVISION INSERT FOR ' comments
        FROM MTL_ITEM_REVISIONS_B
       WHERE     creation_date >= p_last_send_date
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
             INVENTORY_ITEM_ID, 
			 ORGANIZATION_ID, 
             0 transaction_status,
			 'ITEM REVISION UPDATE FOR ' comments
        FROM MTL_ITEM_REVISIONS_B
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND creation_date <= p_last_send_date;		 
	
	
	CURSOR bom_components_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
    IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
			 bill_sequence_id, 
             0 transaction_status,
			 'COMPONENT ITEM INSERT FOR '||bill_sequence_id comments
        FROM bom_components_b
       WHERE     creation_date >= p_last_send_date
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
			 bill_sequence_id, 
             0 transaction_status,
			 'COMPONENT ITEM UPDATE FOR '||bill_sequence_id comments
        FROM bom_components_b
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND creation_date <= p_last_send_date;

	
	CURSOR bom_substitute_components_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
    IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
			 COMPONENT_SEQUENCE_ID, 
             0 transaction_status,
			 'SUBSTITUTE ITEM INSERT FOR ' comments
        FROM BOM_SUBSTITUTE_COMPONENTS
       WHERE     creation_date >= p_last_send_date
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
			 COMPONENT_SEQUENCE_ID, 
             0 transaction_status,
			 'SUBSTITUTE ITEM UPDATE FOR ' comments
        FROM BOM_SUBSTITUTE_COMPONENTS
       WHERE 1 = 1
             AND (last_update_date >= p_last_send_date
                  AND last_update_date < p_current_send_date)
             AND creation_date <= p_last_send_date;
	
	
	CURSOR bom_reference_designators_c (
      p_current_send_date    DATE,
      p_last_send_date       DATE)
    IS
      -- logic for INSERT records
      SELECT creation_date - last_update_date,
             creation_date creation_date1,
			 COMPONENT_SEQUENCE_ID, 
             0 transaction_status,
			 'REF DESIGNATOR INSERT FOR ' comments
        FROM BOM_REFERENCE_DESIGNATORS
       WHERE     creation_date >= p_last_send_date
             AND creation_date < p_current_send_date
      UNION ALL
      -- logic for all updated records that was created in the last time period
      SELECT creation_date - last_update_date,
             last_update_date creation_date1,
			 COMPONENT_SEQUENCE_ID, 
             0 transaction_status,
			 'REF DESIGNATOR UPDATE FOR ' comments
        FROM BOM_REFERENCE_DESIGNATORS
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


   FOR rec IN bom_structures_c (ld_current_send_date, ld_last_send_date)
   LOOP
      p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := rec.bill_sequence_id;
      p_rec_wm_trackChange.date_created := SYSDATE;
      p_rec_wm_trackChange.comments := rec.comments;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';
	  
      DBMS_OUTPUT.put_line ('Record inserted :' || rec.bill_sequence_id);
      wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange); -- NOTE : For testing Purpose only.  Remove 1 from pkg name.
      ln_counter := ln_counter + 1;
   END LOOP;

   
   FOR rec IN mtl_item_revisions_c (ld_current_send_date, ld_last_send_date)
   LOOP
   
   SELECT BILL_SEQUENCE_ID, ASSEMBLY_TYPE
	  INTO V_BILL_SEQUENCE_ID, V_ASSEMBLY_TYPE
	  FROM BOM_BILL_OF_MATERIALS B
	  WHERE B.ORGANIZATION_ID = rec.ORGANIZATION_ID
	  AND B.ASSEMBLY_ITEM_ID = rec.INVENTORY_ITEM_ID;
	  
   IF (V_BILL_SEQUENCE_ID IS NOT NULL) AND (V_ASSEMBLY_TYPE = 2) THEN
	  p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := V_BILL_SEQUENCE_ID;
      p_rec_wm_trackChange.date_created := SYSDATE;
      p_rec_wm_trackChange.comments := rec.comments||V_BILL_SEQUENCE_ID;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';	
	  
	  wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
   
   END IF;
   END LOOP;
   
   
   FOR rec IN bom_components_c (ld_current_send_date, ld_last_send_date)
   LOOP
   
   SELECT ASSEMBLY_TYPE
   INTO V_ASSEMBLY_TYPE 
   FROM BOM_BILL_OF_MATERIALS B
   WHERE B.BILL_SEQUENCE_ID = rec.BILL_SEQUENCE_ID;
	  
   IF V_ASSEMBLY_TYPE = 2 THEN
	  p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := rec.bill_sequence_id;
      p_rec_wm_trackChange.date_created := SYSDATE;
      p_rec_wm_trackChange.comments := rec.comments;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';	
	  
	  wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
   
   END IF;
   END LOOP;

   
   FOR rec IN bom_substitute_components_c (ld_current_send_date, ld_last_send_date)
   LOOP
   
   SELECT A.BILL_SEQUENCE_ID, A.ASSEMBLY_TYPE
   INTO V_BILL_SEQUENCE_ID, V_ASSEMBLY_TYPE
   FROM BOM_INVENTORY_COMPONENTS B, BOM_BILL_OF_MATERIALS A
   WHERE A.BILL_SEQUENCE_ID = B.BILL_SEQUENCE_ID
   AND B.COMPONENT_SEQUENCE_ID = rec.COMPONENT_SEQUENCE_ID;
	  
   IF V_ASSEMBLY_TYPE = 2 THEN
	  p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := V_BILL_SEQUENCE_ID;
      p_rec_wm_trackChange.date_created := SYSDATE;
      p_rec_wm_trackChange.comments := rec.comments||V_BILL_SEQUENCE_ID;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';	
	  
	  wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
   
   END IF;
   END LOOP;
   
   
   FOR rec IN bom_reference_designators_c (ld_current_send_date, ld_last_send_date)
   LOOP
   
   SELECT A.BILL_SEQUENCE_ID, A.ASSEMBLY_TYPE
   INTO V_BILL_SEQUENCE_ID, V_ASSEMBLY_TYPE
   FROM BOM_INVENTORY_COMPONENTS B, BOM_BILL_OF_MATERIALS A
   WHERE A.BILL_SEQUENCE_ID = B.BILL_SEQUENCE_ID
   AND B.COMPONENT_SEQUENCE_ID = rec.COMPONENT_SEQUENCE_ID;
	  
   IF V_ASSEMBLY_TYPE = 2 THEN
	  p_rec_wm_trackChange.transaction_type := c_transaction_type;
      p_rec_wm_trackChange.transaction_id := V_BILL_SEQUENCE_ID;
      p_rec_wm_trackChange.date_created := SYSDATE;
      p_rec_wm_trackChange.comments := rec.comments||V_BILL_SEQUENCE_ID;
      p_rec_wm_trackChange.transaction_status := rec.transaction_status;
      p_rec_wm_trackChange.processed_flag := 'N';	
	  
	  wm_track_changes_pkg.web_transaction (p_rec_wm_trackChange);
   
   END IF;
   END LOOP;
   
   
   
   UPDATE WM_SEND_REFERENCE_T
      SET last_send_date = ld_current_send_date, recs_updated = ln_counter
    WHERE transaction_type = 'ENGBOM';

	record_count := ln_counter;
	
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;



	  
END wm_fetch_engbom;
END WM_ENGBOM_FETCH_PKG;
/