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
    *                HZ_PARTIES                    ON U
    *                HZ_CUST_ACCOUNTS                ON I/U
    *                AP_BANK_ACCOUNT_USES_ALL        ON I/U
    *                HZ_CONTACT_POINTS                ON I/U/D
    *                HZ_CUSTOMER_PROFILES            ON I/U
    *                HZ_CUST_ACCT_RELATE_ALL            ON I/U
    *                HZ_CUST_ACCT_SITES_ALL            ON I/U
    *                HZ_CUST_PROFILE_AMTS            ON I/U/D
    *                HZ_CUST_SITE_USES_ALL            ON I/U
    *                HZ_LOCATIONS                ON I/U
    *                HZ_CUST_ACCOUNT_ROLES            ON I
    *                HZ_ROLE_RESPONSIBILITY            ON I/U/D
    *                RA_CUST_RECEIPT_METHODS            ON I/U
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
     12-AUG-02       Sudip Kumar Chaudhuri   Created
     21-Mar-14       Vijayanand                      Updated
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_customer_trg_ver_2_0.sql

 connect &&apps_user/&&AppsPwd@&&DBString


REM "Creating Triggers....."

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an update
on HZ_PARTIES table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
/*   Marked -- REM -- to all insert update triggers and leave alone DELETE Triggers by Vijayanand ver 2.0 */

/*************************Triggers Used****************************************************
Trigger Description:

Trigger to populate the table WM_TRACKCHANGES when there is an insert, update or delete
on HZ_CONTACT_POINTS table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_contact_points_iud_trg
--AFTER INSERT OR UPDATE OR DELETE ON HZ_CONTACT_POINTS  -- ver 2.0 by Vijayanand
AFTER DELETE ON HZ_CONTACT_POINTS  -- added for ver 2.0 by Vijayanand
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

--     EXCEPTION
  --        WHEN OTHERS THEN NULL;
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
--AFTER INSERT OR UPDATE OR DELETE ON HZ_CUST_PROFILE_AMTS  -- ver 2.0 by Vijayanand
AFTER DELETE ON HZ_CUST_PROFILE_AMTS
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
BEGIN


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

Trigger to populate the table WM_TRACKCHANGES when there is an insert or update or delete
on HZ_ROLE_RESPONSIBILITY table and gives a call to WEB_TRANSACTION procedure to populate  
WM_TRACKCHANGES tables.

******************************************************************************************/
CREATE OR REPLACE TRIGGER &&apps_user..wm_hz_role_resp_iud_trg
--AFTER INSERT OR UPDATE OR DELETE ON HZ_ROLE_RESPONSIBILITY  -- ver 2.0 by Vijayanand
AFTER DELETE ON HZ_ROLE_RESPONSIBILITY
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
p_rec_wm_trackChange wm_trackchanges%ROWTYPE;
c_transaction_type VARCHAR2(100):='CUSTOMER';
p_party_id hz_parties.party_id%TYPE;
p_party_type hz_parties.party_type%TYPE;
p_object_id hz_party_relationships.object_id%TYPE;
v_cust_account_id NUMBER;

BEGIN


     IF DELETING THEN

     -- Fetch data for Key Identifier
         SELECT cust_account_id
        INTO     v_cust_account_id
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


