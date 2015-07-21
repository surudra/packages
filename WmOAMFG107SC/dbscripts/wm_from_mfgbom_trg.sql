/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Manufacturing BOM Outbound 
    *                       in Application Schema  
    * Program Name:         wm_from_mfgbom_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				BOM_BILL_OF_MATERIALS				ON I/U/D
    *				MTL_ITEM_REVISIONS				ON I/U/D
    *				BOM_INVENTORY_COMPONENTS			ON I/U/D
    *				BOM_SUBSTITUTE_COMPONENTS			ON I/U/D
    *				BOM_REFERENCE_DESIGNATORS			ON I/U/D
    *
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
    * Trigger: 
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
    *          
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
     21-oct-02	   Indrani Das   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_mfgbom_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert/update/delete
on BOM_BILL_OF_MATERIALS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_bom_bill_of_mtls_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON BOM_BILL_OF_MATERIALS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='MFGBOM';

BEGIN
  IF NVL(:NEW.ASSEMBLY_TYPE,:OLD.ASSEMBLY_TYPE) = 1 THEN
	-- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.processed_flag:='N';

     IF INSERTING THEN

	 p_rec_wm_trackChange.comments:='BILL OF MATERIAL INSERT FOR '||:new.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_id:=:new.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_status:=1;

     ELSIF UPDATING THEN 

	 p_rec_wm_trackChange.comments:='BILL OF MATERIAL UPDATE FOR '||:new.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_id:=:new.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_status:=0;

     ELSIF DELETING THEN 

	 p_rec_wm_trackChange.comments:=:old.assembly_item_id||'+'||:old.organization_id||'+'||:old.alternate_bom_designator;
	 p_rec_wm_trackChange.transaction_id:=:old.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_status:=2;

      END IF;

	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
  END IF;

EXCEPTION
  	WHEN OTHERS THEN NULL;
END;
/

show error

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert/update/delete
on MTL_ITEM_REVISIONS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_mtl_item_rev_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON MTL_ITEM_REVISIONS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange 	wm_trackchanges%ROWTYPE;
c_transaction_type 	VARCHAR2(100):='MFGBOM';
vBillSeqId 			bom_bill_of_materials.bill_sequence_id%TYPE;
vAssemblyType   bom_bill_of_materials.assembly_type%type;

CURSOR CUR_BILL 
IS
SELECT BILL_SEQUENCE_ID, ASSEMBLY_TYPE
FROM BOM_BILL_OF_MATERIALS B
WHERE B.ORGANIZATION_ID = NVL(:NEW.ORGANIZATION_ID,:OLD.ORGANIZATION_ID)
AND B.ASSEMBLY_ITEM_ID = NVL(:NEW.INVENTORY_ITEM_ID, :OLD.INVENTORY_ITEM_ID);

BEGIN

  OPEN CUR_BILL;
  FETCH CUR_BILL INTO vBillSeqId, vAssemblyType;
  CLOSE CUR_BILL;

  IF (vBillSeqId IS NOT NULL) AND (vAssemblyType = 1) THEN
	-- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.processed_flag:='N';
	 p_rec_wm_trackChange.transaction_status:=0;

     IF INSERTING THEN

	 p_rec_wm_trackChange.comments:='ITEM REVISION INSERT FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id:= vBillSeqId;

     ELSIF UPDATING THEN 

	 p_rec_wm_trackChange.comments:='ITEM REVISION UPDATE FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id:= vBillSeqId;

     ELSIF DELETING THEN 

	 p_rec_wm_trackChange.comments:='ITEM REVISION DELETE FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id:= vBillSeqId;

      END IF;

	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

  END IF;

EXCEPTION
	WHEN OTHERS THEN NULL;
END;
/


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert/update/delete
on BOM_INVENTORY_COMPONENTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_bom_inv_comps_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON BOM_INVENTORY_COMPONENTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='MFGBOM';
vAssemblyType   bom_bill_of_materials.assembly_type%type;

CURSOR CUR_BILL 
IS
SELECT ASSEMBLY_TYPE
FROM BOM_BILL_OF_MATERIALS B
WHERE B.BILL_SEQUENCE_ID = NVL(:NEW.BILL_SEQUENCE_ID,:OLD.BILL_SEQUENCE_ID);

BEGIN

  OPEN CUR_BILL;
  FETCH CUR_BILL INTO vAssemblyType;
  CLOSE CUR_BILL;

  IF (vAssemblyType = 1) THEN

	-- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 p_rec_wm_trackChange.date_created := SYSDATE;
	 p_rec_wm_trackChange.processed_flag := 'N';
	 p_rec_wm_trackChange.transaction_status := 0;

     IF INSERTING THEN

	 p_rec_wm_trackChange.comments := 'COMPONENT ITEM INSERT FOR '||:new.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_id := :new.bill_sequence_id;

     ELSIF UPDATING THEN 

	 p_rec_wm_trackChange.comments := 'COMPONENT ITEM  UPDATE FOR '||:new.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_id:= :new.bill_sequence_id;

     ELSIF DELETING THEN 

	 p_rec_wm_trackChange.comments := 'COMPONENT ITEM DELETE FOR '||:old.bill_sequence_id;
	 p_rec_wm_trackChange.transaction_id := :old.bill_sequence_id;

      END IF;

	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

  END IF;

EXCEPTION
  	WHEN OTHERS THEN NULL;
END;
/


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert/update/delete
on BOM_SUBSTITUTE_COMPONENTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_bom_sub_comps_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON BOM_SUBSTITUTE_COMPONENTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange 	wm_trackchanges%ROWTYPE;
c_transaction_type 	VARCHAR2(100):='MFGBOM';
vBillSeqId 			bom_bill_of_materials.bill_sequence_id%TYPE;
vAssemblyType   bom_bill_of_materials.assembly_type%type;

CURSOR CUR_BILL 
IS
SELECT A.BILL_SEQUENCE_ID, A.ASSEMBLY_TYPE
FROM BOM_INVENTORY_COMPONENTS B, BOM_BILL_OF_MATERIALS A
WHERE A.BILL_SEQUENCE_ID = B.BILL_SEQUENCE_ID
AND B.COMPONENT_SEQUENCE_ID = NVL(:NEW.COMPONENT_SEQUENCE_ID,:OLD.COMPONENT_SEQUENCE_ID);

BEGIN

  OPEN CUR_BILL;
  FETCH CUR_BILL INTO vBillSeqId, vAssemblyType;
  CLOSE CUR_BILL;

  IF vAssemblyType = 1 THEN
	-- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 p_rec_wm_trackChange.date_created := SYSDATE;
	 p_rec_wm_trackChange.processed_flag := 'N';
	 p_rec_wm_trackChange.transaction_status := 0;

     IF INSERTING THEN

	 p_rec_wm_trackChange.comments := 'SUBSTITUTE ITEM INSERT FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id := vBillSeqId;

     ELSIF UPDATING THEN 

	 p_rec_wm_trackChange.comments := 'SUBSTITUTE ITEM  UPDATE FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id:= vBillSeqId;

     ELSIF DELETING THEN 

	 p_rec_wm_trackChange.comments := 'SUBSTITUTE ITEM DELETE FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id := vBillSeqId;

      END IF;

	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

  END IF;

EXCEPTION
  	WHEN OTHERS THEN NULL;

END;
/


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert/update/delete
on BOM_REFERENCE_DESIGNATORS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_bom_ref_desgs_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON BOM_REFERENCE_DESIGNATORS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='MFGBOM';
vBillSeqId 			bom_bill_of_materials.bill_sequence_id%TYPE;
vAssemblyType   bom_bill_of_materials.assembly_type%type;

CURSOR CUR_BILL 
IS
SELECT A.BILL_SEQUENCE_ID, A.ASSEMBLY_TYPE
FROM BOM_INVENTORY_COMPONENTS B, BOM_BILL_OF_MATERIALS A
WHERE A.BILL_SEQUENCE_ID = B.BILL_SEQUENCE_ID
AND B.COMPONENT_SEQUENCE_ID = NVL(:NEW.COMPONENT_SEQUENCE_ID,:OLD.COMPONENT_SEQUENCE_ID);

BEGIN

  OPEN CUR_BILL;
  FETCH CUR_BILL INTO vBillSeqId, vAssemblyType;
  CLOSE CUR_BILL;

  IF vAssemblyType = 1 THEN
	-- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type := c_transaction_type;
	 p_rec_wm_trackChange.date_created := SYSDATE;
	 p_rec_wm_trackChange.processed_flag := 'N';
	 p_rec_wm_trackChange.transaction_status := 0;

     IF INSERTING THEN

	 p_rec_wm_trackChange.comments := 'REF DESIGNATOR INSERT FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id := vBillSeqId;

     ELSIF UPDATING THEN 

	 p_rec_wm_trackChange.comments := 'REF DESIGNATOR UPDATE FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id:= vBillSeqId;

     ELSIF DELETING THEN 

	 p_rec_wm_trackChange.comments := 'REF DESIGNATOR DELETE FOR '||vBillSeqId;
	 p_rec_wm_trackChange.transaction_id := vBillSeqId;

      END IF;

	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

  END IF;

EXCEPTION
  	WHEN OTHERS THEN NULL;

END;
/


