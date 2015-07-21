/*  ***************************************************************************
    *    $Date:   08 Nov 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:  
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods - Oracle Applications - All Modules
    * Process Name:         Create Custom triggers for Customer Outbound in Application Schema  
    * Program Name:         wm_from_customer_trg.sql
    * Version #:            1.0
    * Title:                Triggers Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create trigger in APPS schema on the following tables 
    *				
    *			 RA_CUSTOMERS			ON I/U
	*                RA_ADDRESSES_ALL		ON I/U
	*		 AR_CUSTOMER_PROFILES		ON I/U
	*		 AR_CUSTOMER_PROFILE_AMOUNTS 	ON I/U/D
	*		 AP_BANK_ACCOUNT_USES_ALL	ON I/U
	*		 RA_SITE_USES_ALL		ON I/U
	*		 RA_PHONES	    		ON I/U/D
	*		 RA_CUSTOMER_RELATIONSHIPS_ALL	ON I/U  
	*		 RA_CUST_RECEIPT_METHODS	ON I/U 		 
	*		 RA_CONTACTS			ON I/U 	
	*		 RA_CONTACT_ROLES  		ON I/U/D
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
     08-NOV-02	   Gautam Naha   			Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON

 prompt Program : wm_from_customer_trg.SQL

 CONNECT &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on RA_CUSTOMERS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_ra_customers_iu_trg
AFTER INSERT OR UPDATE ON RA_CUSTOMERS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';


BEGIN
     IF INSERTING THEN

	-- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER INSERT FOR '||:NEW.customer_id;
	 p_rec_wm_trackChange.transaction_status:=1;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN
      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER UPDATE FOR '||:NEW.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

  EXCEPTION
  	WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on RA_ADDRESSES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER wm_ra_addresses_iu_trg
AFTER INSERT OR UPDATE ON RA_ADDRESSES_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER SITE INSERT FOR '||:NEW.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER SITE UPDATE FOR '||:NEW.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on AR_CUSTOMER_PROFILES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_ar_customer_profiles_iu_trg
AFTER INSERT OR UPDATE ON AR_CUSTOMER_PROFILES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE INSERT FOR '||:NEW.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE UPDATE FOR '||:NEW.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert, update or delete
on AR_CUSTOMER_PROFILE_AMOUNTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER wm_ar_cust_prof_amts_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON AR_CUSTOMER_PROFILE_AMOUNTS  
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE AMT. INSERT FOR '||:NEW.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE AMT. UPDATE  FOR '||:NEW.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 IF DELETING THEN

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:OLD.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE AMT. DELETE FOR '||:OLD.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on AP_BANK_ACCOUNT_USES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_ap_bank_account_uses_iu_trg
AFTER INSERT OR UPDATE ON AP_BANK_ACCOUNT_USES_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='BANK ACCOUNT INSERT FOR '||:NEW.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN
      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='BANK ACCOUNT UPDATE FOR '||:NEW.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on RA_SITE_USES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER wm_ra_site_uses_iu_trg
AFTER INSERT OR UPDATE ON RA_SITE_USES_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_customer_id    ra_addresses_all.CUSTOMER_ID%TYPE;

BEGIN

     IF INSERTING THEN

        	-- Fetch data for Key Identifier
        	SELECT 	a.customer_id
        	INTO 	p_customer_id
        	FROM 	ra_addresses_all a,
        			ra_site_uses_all b
        	WHERE 	a.address_id = b.address_id  AND
        	 	  	b.address_id = :NEW.address_id;
        
             -- assign data for parent key identifier
        
        	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
        	 p_rec_wm_trackChange.transaction_id:=p_customer_id;
        	 p_rec_wm_trackChange.date_created:=SYSDATE;
        	 p_rec_wm_trackChange.comments:='BUSINESS PURPOSE INSERT FOR '||p_customer_id;
        	 p_rec_wm_trackChange.transaction_status:=0;
        	 p_rec_wm_trackChange.processed_flag:='N';
        
        
        	 -- Call Procedure to Insert into wm_track_changes
        	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

	 END IF;

     IF UPDATING THEN
	 
          	-- Fetch data for Key Identifier
          	SELECT 	a.customer_id
          	INTO 	p_customer_id
          	FROM 	ra_addresses_all a,
          			ra_site_uses_all b
          	WHERE 	a.address_id = b.address_id  AND
          	 	  	b.address_id = :NEW.address_id;
          
             -- assign data for parent key identifier
          
          	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
          	 p_rec_wm_trackChange.transaction_id:=p_customer_id;
          	 p_rec_wm_trackChange.date_created:=SYSDATE;
          	 p_rec_wm_trackChange.comments:='BUSINESS PURPOSE UPDATE FOR '||p_customer_id;
          	 p_rec_wm_trackChange.transaction_status:=0;
          	 p_rec_wm_trackChange.processed_flag:='N';
          
          
          	 -- Call Procedure to Insert into wm_track_changes
          	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
 
     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete
on RA_PHONES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER wm_ra_phones_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON RA_PHONES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN

     IF INSERTING THEN

        	
             -- assign data for parent key identifier
        
        	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
        	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
        	 p_rec_wm_trackChange.date_created:=SYSDATE;
        	 p_rec_wm_trackChange.comments:='PHONE INSERT FOR '||:NEW.customer_id;
        	 p_rec_wm_trackChange.transaction_status:=0;
        	 p_rec_wm_trackChange.processed_flag:='N';
        
        
        	 -- Call Procedure to Insert into wm_track_changes
        	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

	 END IF;

     IF UPDATING THEN
	 
          	 -- assign data for parent key identifier
          
          	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
          	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
          	 p_rec_wm_trackChange.date_created:=SYSDATE;
          	 p_rec_wm_trackChange.comments:='PHONE UPDATE FOR '||:NEW.customer_id;
          	 p_rec_wm_trackChange.transaction_status:=0;
          	 p_rec_wm_trackChange.processed_flag:='N';
          
          
          	 -- Call Procedure to Insert into wm_track_changes
          	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
 
     END IF;
	 
	 IF DELETING THEN
	 
	 	       
             -- assign data for parent key identifier
          
          	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
          	 p_rec_wm_trackChange.transaction_id:=:OLD.customer_id;
          	 p_rec_wm_trackChange.date_created:=SYSDATE;
          	 p_rec_wm_trackChange.comments:='PHONE DELETE FOR '||:OLD.customer_id;
          	 p_rec_wm_trackChange.transaction_status:=0;
          	 p_rec_wm_trackChange.processed_flag:='N';
          
          
          	 -- Call Procedure to Insert into wm_track_changes
          	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
 
     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update 
on RA_CUSTOMER_RELATIONSHIPS_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_ra_cust_relations_iu_trg
AFTER INSERT OR UPDATE ON  RA_CUSTOMER_RELATIONSHIPS_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='RELATIONSHIP INSERT FOR '||:NEW.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='RELATIONSHIP UPDATE FOR '||:NEW.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on RA_CUST_RECEIPT_METHODS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER wm_ra_cust_recp_methods_iu_trg
AFTER INSERT OR UPDATE ON RA_CUST_RECEIPT_METHODS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='PAYMENT METHOD INSERT FOR '||:NEW.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN
    -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='PAYMENT METHOD UPDATE FOR '||:NEW.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on RA_CONTACTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_ra_contacts_iu_trg
AFTER INSERT OR UPDATE ON RA_CONTACTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';


BEGIN

     IF INSERTING THEN
        
             -- assign data for parent key identifier
        
        	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
        	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
        	 p_rec_wm_trackChange.date_created:=SYSDATE;
        	 p_rec_wm_trackChange.comments:='CONTACT INSERT FOR '||:NEW.customer_id;
        	 p_rec_wm_trackChange.transaction_status:=0;
        	 p_rec_wm_trackChange.processed_flag:='N';
        
        
        	 -- Call Procedure to Insert into wm_track_changes
        	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

	 END IF;

     IF UPDATING THEN
	 
                
             -- assign data for parent key identifier
          
          	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
          	 p_rec_wm_trackChange.transaction_id:=:NEW.customer_id;
          	 p_rec_wm_trackChange.date_created:=SYSDATE;
          	 p_rec_wm_trackChange.comments:='CONTACT UPDATE FOR '||:NEW.customer_id;
          	 p_rec_wm_trackChange.transaction_status:=0;
          	 p_rec_wm_trackChange.processed_flag:='N';
          
          
          	 -- Call Procedure to Insert into wm_track_changes
          	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
 
     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert,update or delete
on RA_CONTACT_ROLES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER wm_ra_contact_roles_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON RA_CONTACT_ROLES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_customer_id    ra_contacts.CUSTOMER_ID%TYPE;

BEGIN

     IF INSERTING THEN

        	-- Fetch data for Key Identifier
        	SELECT 	a.customer_id
        	INTO 	p_customer_id
        	FROM 	ra_contacts a,
        			ra_contact_roles b
        	WHERE 	a.contact_id = b.contact_id  AND
        	 	  	b.contact_id = :NEW.contact_id;
        
             -- assign data for parent key identifier
        
        	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
        	 p_rec_wm_trackChange.transaction_id:=p_customer_id;
        	 p_rec_wm_trackChange.date_created:=SYSDATE;
        	 p_rec_wm_trackChange.comments:='CONTACT ROLE INSERT FOR '||p_customer_id;
        	 p_rec_wm_trackChange.transaction_status:=0;
        	 p_rec_wm_trackChange.processed_flag:='N';
        
        
        	 -- Call Procedure to Insert into wm_track_changes
        	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);

	 END IF;

     IF UPDATING THEN
	 
          	-- Fetch data for Key Identifier
          	SELECT 	a.customer_id
        	INTO 	p_customer_id
        	FROM 	ra_contacts a,
        			ra_contact_roles b
        	WHERE 	a.contact_id = b.contact_id  AND
        	 	  	b.contact_id = :NEW.contact_id;
          
             -- assign data for parent key identifier
          
          	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
          	 p_rec_wm_trackChange.transaction_id:=p_customer_id;
          	 p_rec_wm_trackChange.date_created:=SYSDATE;
          	 p_rec_wm_trackChange.comments:='CONTACT ROLE UPDATE FOR '||p_customer_id;
          	 p_rec_wm_trackChange.transaction_status:=0;
          	 p_rec_wm_trackChange.processed_flag:='N';
          
          
          	 -- Call Procedure to Insert into wm_track_changes
          	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
 
     END IF;
	 
	 IF DELETING THEN
	 
	 		-- Fetch data for Key Identifier
          	SELECT 	a.customer_id
        	INTO 	p_customer_id
        	FROM 	ra_contacts a,
        			ra_contact_roles b
        	WHERE 	a.contact_id = b.contact_id  AND
        	 	  	b.contact_id = :OLD.contact_id;
          
             -- assign data for parent key identifier
          
          	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
          	 p_rec_wm_trackChange.transaction_id:=p_customer_id;
          	 p_rec_wm_trackChange.date_created:=SYSDATE;
          	 p_rec_wm_trackChange.comments:='CONTACT ROLE DELETE FOR '||p_customer_id;
          	 p_rec_wm_trackChange.transaction_status:=0;
          	 p_rec_wm_trackChange.processed_flag:='N';
          
          
          	 -- Call Procedure to Insert into wm_track_changes
          	 Wm_Track_Changes_Pkg.web_transaction(p_rec_wm_trackChange);
 
     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

