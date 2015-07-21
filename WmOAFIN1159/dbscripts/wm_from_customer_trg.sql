/*  ***************************************************************************
    *    $Date:   14 Aug 2001 10:56:36  $
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
    *				HZ_PARTIES					ON U
    *				HZ_CUST_ACCOUNTS				ON I/U
    *				AP_BANK_ACCOUNT_USES_ALL		ON I/U
    *				HZ_CONTACT_POINTS				ON I/U/D
    *				HZ_CUSTOMER_PROFILES			ON I/U
    *				HZ_CUST_ACCT_RELATE_ALL			ON I/U
    *				HZ_CUST_ACCT_SITES_ALL			ON I/U
    *				HZ_CUST_PROFILE_AMTS			ON I/U/D
    *				HZ_CUST_SITE_USES_ALL			ON I/U
    *				HZ_LOCATIONS				ON I/U
    *				HZ_CUST_ACCOUNT_ROLES			ON I
    *				HZ_ROLE_RESPONSIBILITY			ON I/U/D
    *				RA_CUST_RECEIPT_METHODS			ON I/U
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
     12-AUG-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_customer_trg.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an update
on HZ_PARTIES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_parties_u_trg
AFTER UPDATE ON HZ_PARTIES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
v_cust_id NUMBER;

CURSOR cust_in_party IS
SELECT cust_account_id
FROM hz_cust_accounts
WHERE party_id=:new.party_id;

BEGIN

IF((:new.PARTY_NAME <> :old.PARTY_NAME ) OR
(:new.SIC_CODE <> :old.SIC_CODE ) OR
(:new.HQ_BRANCH_IND <> :old.HQ_BRANCH_IND ) OR
(:new.TAX_REFERENCE <> :old.TAX_REFERENCE ) OR
(:new.JGZZ_FISCAL_CODE <> :old.JGZZ_FISCAL_CODE ) OR
(:new.DUNS_NUMBER <> :old.DUNS_NUMBER ) OR
(:new.TAX_NAME <> :old.TAX_NAME ) OR
(:new.PERSON_PRE_NAME_ADJUNCT <> :old.PERSON_PRE_NAME_ADJUNCT ) OR
(:new.PERSON_FIRST_NAME <> :old.PERSON_FIRST_NAME ) OR
(:new.PERSON_MIDDLE_NAME <> :old.PERSON_MIDDLE_NAME ) OR
(:new.PERSON_LAST_NAME <> :old.PERSON_LAST_NAME ) OR
(:new.PERSON_NAME_SUFFIX <> :old.PERSON_NAME_SUFFIX ) OR
(:new.PERSON_TITLE <> :old.PERSON_TITLE ) OR
(:new.PERSON_ACADEMIC_TITLE <> :old.PERSON_ACADEMIC_TITLE ) OR
(:new.PERSON_PREVIOUS_LAST_NAME <> :old.PERSON_PREVIOUS_LAST_NAME ) OR
(:new.KNOWN_AS <> :old.KNOWN_AS ) OR
(:new.PERSON_IDEN_TYPE <> :old.PERSON_IDEN_TYPE ) OR
(:new.PERSON_IDENTIFIER <> :old.PERSON_IDENTIFIER ) OR
(:new.COUNTRY <> :old.COUNTRY ) OR
(:new.ADDRESS1 <> :old.ADDRESS1 ) OR
(:new.ADDRESS2 <> :old.ADDRESS2 ) OR
(:new.ADDRESS3 <> :old.ADDRESS3 ) OR
(:new.ADDRESS4 <> :old.ADDRESS4 ) OR
(:new.CITY <> :old.CITY ) OR
(:new.POSTAL_CODE <> :old.POSTAL_CODE ) OR
(:new.STATE <> :old.STATE ) OR
(:new.PROVINCE <> :old.PROVINCE ) OR
(:new.STATUS <> :old.STATUS ) OR
(:new.COUNTY <> :old.COUNTY ) OR
(:new.SIC_CODE_TYPE <> :old.SIC_CODE_TYPE ) OR
(:new.TOTAL_NUM_OF_ORDERS <> :old.TOTAL_NUM_OF_ORDERS ) OR
(:new.TOTAL_ORDERED_AMOUNT <> :old.TOTAL_ORDERED_AMOUNT ) OR
(:new.LAST_ORDERED_DATE <> :old.LAST_ORDERED_DATE ) OR
(:new.URL <> :old.URL ) OR
(:new.EMAIL_ADDRESS <> :old.EMAIL_ADDRESS ) OR
(:new.DO_NOT_MAIL_FLAG <> :old.DO_NOT_MAIL_FLAG ) OR
(:new.ANALYSIS_FY <> :old.ANALYSIS_FY ) OR
(:new.FISCAL_YEAREND_MONTH <> :old.FISCAL_YEAREND_MONTH ) OR
(:new.EMPLOYEES_TOTAL <> :old.EMPLOYEES_TOTAL ) OR
(:new.CURR_FY_POTENTIAL_REVENUE <> :old.CURR_FY_POTENTIAL_REVENUE ) OR
(:new.NEXT_FY_POTENTIAL_REVENUE <> :old.NEXT_FY_POTENTIAL_REVENUE ) OR
(:new.YEAR_ESTABLISHED <> :old.YEAR_ESTABLISHED ) OR
(:new.GSA_INDICATOR_FLAG <> :old.GSA_INDICATOR_FLAG ) OR
(:new.MISSION_STATEMENT <> :old.MISSION_STATEMENT ) OR
(:new.ORGANIZATION_NAME_PHONETIC <> :old.ORGANIZATION_NAME_PHONETIC ) OR
(:new.PERSON_FIRST_NAME_PHONETIC <> :old.PERSON_FIRST_NAME_PHONETIC ) OR
(:new.PERSON_LAST_NAME_PHONETIC <> :old.PERSON_LAST_NAME_PHONETIC ) OR
(:new.LANGUAGE_NAME <> :old.LANGUAGE_NAME ) OR
(:new.CATEGORY_CODE <> :old.CATEGORY_CODE ) OR
(:new.REFERENCE_USE_FLAG <> :old.REFERENCE_USE_FLAG ) OR
(:new.THIRD_PARTY_FLAG <> :old.THIRD_PARTY_FLAG ) OR
(:new.COMPETITOR_FLAG <> :old.COMPETITOR_FLAG ) OR
(:new.SALUTATION <> :old.SALUTATION ) OR
(:new.KNOWN_AS2 <> :old.KNOWN_AS2 ) OR
(:new.KNOWN_AS3 <> :old.KNOWN_AS3 ) OR
(:new.KNOWN_AS4 <> :old.KNOWN_AS4 ) OR
(:new.KNOWN_AS5 <> :old.KNOWN_AS5 ) OR
(:new.DUNS_NUMBER_C <> :old.DUNS_NUMBER_C )) THEN

	 IF :new.party_type IN('ORGANIZATION','PERSON') THEN

	 BEGIN

		SELECT b.CUST_ACCOUNT_ID
		INTO v_cust_id
		FROM hz_relationships a, hz_cust_accounts b
		WHERE a.subject_id=:new.party_id
		AND a.object_id = b.party_id
		AND directional_flag='F';

      -- assign data for parent key identifier

     	 	p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=v_cust_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='PARTY UPDATE FOR '||v_cust_id;
     	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';

     	 	-- Call Procedure to Insert into wm_track_changes
	 	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	EXCEPTION
	WHEN no_data_found THEN
		NULL;
	END;

	FOR c_cust_in_party IN cust_in_party LOOP
	
	     	p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 	p_rec_wm_trackChange.transaction_id:=c_cust_in_party.cust_account_id;
     	 	p_rec_wm_trackChange.date_created:=SYSDATE;
     	 	p_rec_wm_trackChange.comments:='PARTY UPDATE FOR '||c_cust_in_party.cust_account_id;
     	 	p_rec_wm_trackChange.transaction_status:=0;
	 	p_rec_wm_trackChange.processed_flag:='N';

     	 	-- Call Procedure to Insert into wm_track_changes
	 	wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
 
	END LOOP;

	END IF;
END IF;
	 EXCEPTION
	   	WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on HZ_CUST_ACCOUNTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_cust_accounts_iu_trg
AFTER INSERT OR UPDATE ON HZ_CUST_ACCOUNTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

		
CURSOR cust_in_party IS
SELECT cust_account_id 
FROM hz_cust_accounts
WHERE party_id=:new.party_id;

BEGIN
     IF INSERTING THEN

	-- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER INSERT FOR '||:new.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=1;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN 
      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER UPDATE FOR '||:new.cust_account_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

  EXCEPTION
  	WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on AP_BANK_ACCOUNTS_USES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_ap_bank_account_uses_iu_trg
AFTER INSERT OR UPDATE ON AP_BANK_ACCOUNT_USES_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='BANK ACCOUNT INSERT FOR '||:new.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN
      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='BANK ACCOUNT UPDATE FOR '||:new.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert, update or delete
on HZ_CONTACT_POINTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_contact_points_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON HZ_CONTACT_POINTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
p_party_type hz_parties.party_type%TYPE;
p_object_id  hz_party_relationships.object_id%TYPE;

CURSOR cust_for_party_site(v_owner_table_id in NUMBER) IS
  SELECT cust_account_id
  FROM   hz_cust_acct_sites_all
  WHERE  party_site_id = v_owner_table_id;

CURSOR cust_for_party_customer(v_owner_table_id in NUMBER) IS
  SELECT a.cust_account_id cust_account_id
  FROM hz_cust_account_roles a, hz_relationships b, hz_parties c
  WHERE a.party_id=b.party_id
  AND b.party_id=v_owner_table_id
  AND b.party_id=c.party_id
  AND b.directional_flag='F'
  AND b.party_id=c.party_id
  AND c.party_type='PARTY_RELATIONSHIP'
UNION
  SELECT cust_account_id
  FROM hz_cust_accounts a, hz_parties b
  WHERE b.party_id=a.party_id
  AND b.party_id=v_owner_table_id
  AND b.party_type IN ('ORGANIZATION','PERSON');
  
BEGIN

     IF INSERTING THEN

	 	IF :new.owner_table_name = 'HZ_PARTY_SITES' THEN

			--- If inserting contact point for a party site

	FOR c_cust_for_party_site IN cust_for_party_site(:new.owner_table_id) LOOP

			-- assign data for parent key identifier

             	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
             	 p_rec_wm_trackChange.transaction_id:=c_cust_for_party_site.cust_account_id;
             	 p_rec_wm_trackChange.date_created:=SYSDATE;
             	 p_rec_wm_trackChange.comments:='CONTACT POINT INSERT FOR '||c_cust_for_party_site.cust_account_id;
             	 p_rec_wm_trackChange.transaction_status:=0;
             	 p_rec_wm_trackChange.processed_flag:='N';


             	 -- Call Procedure to Insert into wm_track_changes
             	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	END LOOP;

		ELSE
			FOR c_cust_for_party_customer IN cust_for_party_customer(:new.owner_table_id) LOOP

			-- assign data for parent key identifier

             	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
             	 p_rec_wm_trackChange.transaction_id:=c_cust_for_party_customer.cust_account_id;
             	 p_rec_wm_trackChange.date_created:=SYSDATE;
             	 p_rec_wm_trackChange.comments:='CONTACT POINT INSERT FOR '||c_cust_for_party_customer.cust_account_id;
             	 p_rec_wm_trackChange.transaction_status:=0;
             	 p_rec_wm_trackChange.processed_flag:='N';


             	 -- Call Procedure to Insert into wm_track_changes
             	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


			END LOOP;
	 	END IF;
	 END IF;


     IF UPDATING THEN

		IF :new.owner_table_name = 'HZ_PARTY_SITES' THEN

			--- If updating contact point for a party site

	FOR c_cust_for_party_site IN cust_for_party_site(:new.owner_table_id) LOOP

			-- assign data for parent key identifier

             	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
             	 p_rec_wm_trackChange.transaction_id:=c_cust_for_party_site.cust_account_id;
             	 p_rec_wm_trackChange.date_created:=SYSDATE;
             	 p_rec_wm_trackChange.comments:='CONTACT POINT UPDATE FOR '||c_cust_for_party_site.cust_account_id;
             	 p_rec_wm_trackChange.transaction_status:=0;
             	 p_rec_wm_trackChange.processed_flag:='N';


             	 -- Call Procedure to Insert into wm_track_changes
             	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
	 END LOOP;

		ELSE
			FOR c_cust_for_party_customer IN cust_for_party_customer(:new.owner_table_id) LOOP

			-- assign data for parent key identifier

             	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
             	 p_rec_wm_trackChange.transaction_id:=c_cust_for_party_customer.cust_account_id;
             	 p_rec_wm_trackChange.date_created:=SYSDATE;
             	 p_rec_wm_trackChange.comments:='CONTACT POINT UPDATE FOR '||c_cust_for_party_customer.cust_account_id;
             	 p_rec_wm_trackChange.transaction_status:=0;
             	 p_rec_wm_trackChange.processed_flag:='N';


             	 -- Call Procedure to Insert into wm_track_changes
             	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


			END LOOP;
	 	END IF;
     END IF;


	 IF DELETING THEN

		 IF :old.owner_table_name = 'HZ_PARTY_SITES' THEN

			--- If deleting contact point for a party site


		 -- assign data for parent key identifier
		FOR c_cust_for_party_site IN cust_for_party_site(:old.owner_table_id) LOOP

			-- assign data for parent key identifier

             	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
             	 p_rec_wm_trackChange.transaction_id:=c_cust_for_party_site.cust_account_id;
             	 p_rec_wm_trackChange.date_created:=SYSDATE;
             	 p_rec_wm_trackChange.comments:='CONTACT POINT DELETE FOR '||c_cust_for_party_site.cust_account_id;
             	 p_rec_wm_trackChange.transaction_status:=0;
             	 p_rec_wm_trackChange.processed_flag:='N';


             	 -- Call Procedure to Insert into wm_track_changes
             	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
		END LOOP;

		ELSE
			FOR c_cust_for_party_customer IN cust_for_party_customer(:old.owner_table_id) LOOP

			-- assign data for parent key identifier

             	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
             	 p_rec_wm_trackChange.transaction_id:=c_cust_for_party_customer.cust_account_id;
             	 p_rec_wm_trackChange.date_created:=SYSDATE;
             	 p_rec_wm_trackChange.comments:='CONTACT POINT INSERT FOR '||c_cust_for_party_customer.cust_account_id;
             	 p_rec_wm_trackChange.transaction_status:=0;
             	 p_rec_wm_trackChange.processed_flag:='N';


             	 -- Call Procedure to Insert into wm_track_changes
             	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


			END LOOP;
	 	END IF;
	 END IF;

--	 EXCEPTION
  --		WHEN OTHERS THEN NULL;
END;
/

show errors


/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on HZ_CUSTOMER_PROFILES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_customer_profiles_iu_trg
AFTER INSERT OR UPDATE ON HZ_CUSTOMER_PROFILES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE INSERT FOR '||:new.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE UPDATE FOR '||:new.cust_account_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on HZ_CUST_ACCT_RELATE_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_cust_acct_relate_iu_trg
AFTER INSERT OR UPDATE ON HZ_CUST_ACCT_RELATE_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='RELATIONSHIP INSERT FOR '||:new.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='RELATIONSHIP UPDATE FOR '||:new.cust_account_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;




END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on HZ_CUST_ACCT_SITES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_cust_acct_sites_iu_trg
AFTER INSERT OR UPDATE ON HZ_CUST_ACCT_SITES_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=p_party_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER SITE INSERT FOR '||:new.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=p_party_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER SITE UPDATE FOR '||:new.cust_account_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert, update or delete
on HZ_CUST_PROFILE_AMTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_cust_prof_amts_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON HZ_CUST_PROFILE_AMTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE AMT. INSERT FOR '||:new.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN

      -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE AMT. UPDATE  FOR '||:new.cust_account_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 IF DELETING THEN

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:old.cust_account_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='CUSTOMER PROFILE AMT. DELETE FOR '||:old.cust_account_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on HZ_CUST_SITE_USES_ALL table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_cust_site_uses_iu_trg
AFTER INSERT OR UPDATE ON HZ_CUST_SITE_USES_ALL
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;

CURSOR cust_account IS
SELECT cust_account_id
FROM hz_cust_acct_sites_all
WHERE cust_acct_site_id=:new.cust_acct_site_id;

BEGIN
     IF INSERTING THEN

	 -- Fetch data for Key Identifier
	FOR c_cust_account IN cust_account LOOP

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=c_cust_account.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='BUSINESS PURPOSE INSERT FOR '||c_cust_account.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	END LOOP;
	
      END IF;

     IF UPDATING THEN
	FOR c_cust_account IN cust_account LOOP

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=c_cust_account.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='BUSINESS PURPOSE UPDATE FOR '||c_cust_account.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	END LOOP;

     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update
on HZ_LOCATIONS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_locations_iu_trg
AFTER INSERT OR UPDATE ON HZ_LOCATIONS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;

CURSOR cust_location IS
SELECT a.cust_account_id cust_account_id
FROM hz_cust_acct_sites_all a, hz_party_sites b
WHERE b.location_id=:new.location_id
AND a.party_site_id = b.party_site_id;

BEGIN
     IF INSERTING THEN

	 -- Fetch data for Key Identifier
	FOR c_cust_location IN cust_location LOOP
     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=c_cust_location.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='LOCATION INSERT FOR '||c_cust_location.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	END LOOP;

      END IF;

     IF UPDATING THEN

	FOR c_cust_location IN cust_location LOOP
     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=c_cust_location.cust_account_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='LOCATION UPDATE FOR '||c_cust_location.cust_account_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

	END LOOP;

     END IF;

	EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert
on HZ_CUST_ACCOUNT_ROLES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/

CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_cust_acct_roles_i_trg
AFTER INSERT ON HZ_CUST_ACCOUNT_ROLES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW WHEN (new.role_type='CONTACT')
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';

BEGIN

	 		p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 		p_rec_wm_trackChange.transaction_id:=:new.cust_account_id;
	 		p_rec_wm_trackChange.date_created:=SYSDATE;
	 		p_rec_wm_trackChange.comments:='CONTACT INSERT FOR '||:new.cust_account_id;
	 		p_rec_wm_trackChange.transaction_status:=0;
	 		p_rec_wm_trackChange.processed_flag:='N';

			-- Call Procedure to Insert into wm_track_changes
	 		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

show errors

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete
on HZ_ROLE_RESPONSIBILITY table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_role_resp_iud_trg
AFTER INSERT OR UPDATE OR DELETE ON HZ_ROLE_RESPONSIBILITY
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
p_party_type hz_parties.party_type%TYPE;
p_object_id hz_party_relationships.object_id%TYPE;
v_cust_account_id NUMBER;

BEGIN
     IF INSERTING THEN

	 -- Fetch data for Key Identifier
	 	SELECT cust_account_id
		INTO 	v_cust_account_id
		FROM hz_cust_account_roles
		WHERE cust_account_role_id = :new.cust_account_role_id;


     	  	-- assign data for parent key identifier

	 		p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 		p_rec_wm_trackChange.transaction_id:=v_cust_account_id;
	 		p_rec_wm_trackChange.date_created:=SYSDATE;
	 		p_rec_wm_trackChange.comments:='CONTACT ROLE INSERT FOR '||v_cust_account_id;
	 		p_rec_wm_trackChange.transaction_status:=0;
	 		p_rec_wm_trackChange.processed_flag:='N';


	 		-- Call Procedure to Insert into wm_track_changes
	 		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;



     IF UPDATING THEN

	 -- Fetch data for Key Identifier
	 	SELECT cust_account_id
		INTO 	v_cust_account_id
		FROM hz_cust_account_roles
		WHERE cust_account_role_id = :new.cust_account_role_id;


     	  	-- assign data for parent key identifier

	 		p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 		p_rec_wm_trackChange.transaction_id:=v_cust_account_id;
	 		p_rec_wm_trackChange.date_created:=SYSDATE;
	 		p_rec_wm_trackChange.comments:='CONTACT ROLE UPDATE FOR '||v_cust_account_id;
	 		p_rec_wm_trackChange.transaction_status:=0;
	 		p_rec_wm_trackChange.processed_flag:='N';


	 		-- Call Procedure to Insert into wm_track_changes
	 		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

     END IF;

	 IF DELETING THEN

	 -- Fetch data for Key Identifier
	 	SELECT cust_account_id
		INTO 	v_cust_account_id
		FROM hz_cust_account_roles
		WHERE cust_account_role_id = :old.cust_account_role_id;


     	  	-- assign data for parent key identifier

	 		p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 		p_rec_wm_trackChange.transaction_id:=v_cust_account_id;
	 		p_rec_wm_trackChange.date_created:=SYSDATE;
	 		p_rec_wm_trackChange.comments:='CONTACT ROLE DELETE FOR '||v_cust_account_id;
	 		p_rec_wm_trackChange.transaction_status:=0;
	 		p_rec_wm_trackChange.processed_flag:='N';


	 		-- Call Procedure to Insert into wm_track_changes
	 		wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);
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
CREATE OR REPLACE TRIGGER &&apps_user..wm_ra_cust_recp_methods_iu_trg
AFTER INSERT OR UPDATE ON RA_CUST_RECEIPT_METHODS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
BEGIN
     IF INSERTING THEN

     	  -- assign data for parent key identifier

	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
	 p_rec_wm_trackChange.transaction_id:=:new.customer_id;
	 p_rec_wm_trackChange.date_created:=SYSDATE;
	 p_rec_wm_trackChange.comments:='PAYMENT METHOD INSERT FOR '||:new.customer_id;
	 p_rec_wm_trackChange.transaction_status:=0;
	 p_rec_wm_trackChange.processed_flag:='N';


	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);

      END IF;

     IF UPDATING THEN
    -- assign data for parent key identifier

     	 p_rec_wm_trackChange.transaction_type:=c_transaction_type;
     	 p_rec_wm_trackChange.transaction_id:=:new.customer_id;
     	 p_rec_wm_trackChange.date_created:=SYSDATE;
     	 p_rec_wm_trackChange.comments:='PAYMENT METHOD UPDATE FOR '||:new.customer_id;
     	 p_rec_wm_trackChange.transaction_status:=0;
	 	 p_rec_wm_trackChange.processed_flag:='N';

     	 -- Call Procedure to Insert into wm_track_changes
	 wm_track_changes_pkg.web_transaction(p_rec_wm_trackChange);


     END IF;

	 EXCEPTION
  		WHEN OTHERS THEN NULL;

END;
/

SHOW ERRORS

