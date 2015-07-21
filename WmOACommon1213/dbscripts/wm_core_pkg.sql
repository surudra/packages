/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Core Custom Packages in Application Schema  
    * Program Name:         wm_core_pkg.sql
    * Version #:            1.0
    * Title:                Core Package Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to handle Inserts to WM_TRACKCHANGES table
    *
    * Package : wm_track_changes_pkg 
    * Tables usage:     INSERT		UPDATE		DELETE
    *  WM_TRACKCHANGES    X		              
    *  WM_CONTROL    				   X     
    *
    * Procedures and Functions: web_transaction -> Inserts data to wm_trackchanges table
    *				Takes a rowtype data as an input parameter
    *				lock_control -> Sends output as 'TRUE' if it is able to set the 
    *				Transaction Control Status to 'INPROCESS'. Otherwise sends 'FALSE'
    *
    * Package : Wm_Conc_Request_Pkg
    * Tables usage:     INSERT		UPDATE		DELETE
    *     
    *
    * Procedures and Functions: WM_REQUEST_SUBMIT -> Submits Concurrent Request in 
    *				Oracle Applications after taking input from Respective Handler Packages
    *				CHECK_CONC_PROG_STATUS -> Takes concurrent request id as input and waits until
    *				the request completes. After completion it reqturns the status of the Program.
    *				GET_USER_ID -> This function returns the user id for the passed username.
    *				GET_USER_RESPONSIBILITY_ID -> This function returns responsibility id for the passed responsibility
    *				
    *
    *    * Package : WM_UTILS_PKG
    * Tables usage:     INSERT		UPDATE		DELETE
    *
    * Procedures and Functions:WM_PICK_SEQUENCE -> This procedure returns the nextval of the passed sequence as out variable
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
    *           Param3: &CustomUser 
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
     29-SEP-02	   Koushik Chakraborty 	   Added WM_UTILS_PKG Package
     13-OCT-04	   Sidney Pao              Replaced SOURCE_LANG column with LANGUAGE for
                                           fnd_responsibility_tl table
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_core_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE wm_track_changes_pkg AUTHID CURRENT_USER AS

-- Procedure to Insert into wm_trackchanges table

PROCEDURE web_transaction(p_rec_wm_trackChange IN wm_trackchanges%ROWTYPE);

PROCEDURE  lock_control(p_transaction_type IN VARCHAR2, o_return_status OUT VARCHAR2);


END wm_track_changes_pkg;
/

CREATE OR REPLACE PACKAGE BODY wm_track_changes_pkg AS
 
  /************************GLOBAL VARIABLE DECLARATIONS**************************************/

        
  /**********************END OF ERROR VARIABLE DECLARATIONS*********************************/

PROCEDURE web_transaction(p_rec_wm_trackChange IN wm_trackchanges%ROWTYPE) AS

BEGIN

 INSERT INTO WM_TRACKCHANGES
 (web_transaction_id,
  transaction_type,
  transaction_id,
  date_created,
  comments,
  transaction_status,
  processed_flag,
  date_processed
  )
  VALUES
  (wm_web_transaction_s.nextval,
   p_rec_wm_trackChange.transaction_type,
   p_rec_wm_trackChange.transaction_id,
   p_rec_wm_trackChange.date_created,
   p_rec_wm_trackChange.comments,
   p_rec_wm_trackChange.transaction_status,
   p_rec_wm_trackChange.processed_flag,
   p_rec_wm_trackChange.date_processed
   );
END web_transaction;

PROCEDURE  lock_control(p_transaction_type IN VARCHAR2, o_return_status OUT VARCHAR2)
	IS
BEGIN
 UPDATE wm_control
 SET status='INPROCESS'
 WHERE transaction_type=p_transaction_type
 AND status='READY';

 IF SQL%ROWCOUNT = 1 THEN
  o_return_status:='TRUE';
  commit;
 ELSE
  o_return_status:='FALSE';
  rollback;
 END IF;

EXCEPTION
WHEN others THEN
 o_return_status:='FALSE';

END lock_control;

END wm_track_changes_pkg;
/

show error

CREATE OR REPLACE PACKAGE Wm_Conc_Request_Pkg AUTHID CURRENT_USER AS

-- Funnction to submit Concurrent Request in Oracle Applications
-- Return Request Id of the Concurrent Request after the Completion of the Request has been completed

PROCEDURE WM_REQUEST_SUBMIT(    application_id IN NUMBER,
					  user_responsibility_id IN NUMBER,
					  user_id IN NUMBER,
		 			  application IN VARCHAR2 DEFAULT NULL,
			  		  program     IN VARCHAR2 DEFAULT NULL,
			  		  v_request_status    OUT VARCHAR2    ,
			  		  v_request_id	OUT NUMBER,
                			  description IN VARCHAR2 DEFAULT NULL,
                			  start_time  IN VARCHAR2 DEFAULT NULL,
				  	  o_message OUT VARCHAR2,
				  	  v_errmsg  OUT VARCHAR2,
                			  argument1   IN VARCHAR2 DEFAULT CHR(0),
                			  argument2   IN VARCHAR2 DEFAULT CHR(0),
                  		  argument3   IN VARCHAR2 DEFAULT CHR(0),
                			  argument4   IN VARCHAR2 DEFAULT CHR(0),
                			  argument5   IN VARCHAR2 DEFAULT CHR(0),
                			  argument6   IN VARCHAR2 DEFAULT CHR(0),
                			  argument7   IN VARCHAR2 DEFAULT CHR(0),
                			  argument8   IN VARCHAR2 DEFAULT CHR(0),
                			  argument9   IN VARCHAR2 DEFAULT CHR(0),
                			  argument10  IN VARCHAR2 DEFAULT CHR(0),
                			  argument11  IN VARCHAR2 DEFAULT CHR(0),
                			  argument12  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument13  IN VARCHAR2 DEFAULT CHR(0),
                			  argument14  IN VARCHAR2 DEFAULT CHR(0),
                			  argument15  IN VARCHAR2 DEFAULT CHR(0),
                			  argument16  IN VARCHAR2 DEFAULT CHR(0),
                			  argument17  IN VARCHAR2 DEFAULT CHR(0),
                			  argument18  IN VARCHAR2 DEFAULT CHR(0),
                			  argument19  IN VARCHAR2 DEFAULT CHR(0),
                			  argument20  IN VARCHAR2 DEFAULT CHR(0),
                			  argument21  IN VARCHAR2 DEFAULT CHR(0),
                			  argument22  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument23  IN VARCHAR2 DEFAULT CHR(0),
                			  argument24  IN VARCHAR2 DEFAULT CHR(0),
                			  argument25  IN VARCHAR2 DEFAULT CHR(0),
                			  argument26  IN VARCHAR2 DEFAULT CHR(0),
                			  argument27  IN VARCHAR2 DEFAULT CHR(0),
                			  argument28  IN VARCHAR2 DEFAULT CHR(0),
                			  argument29  IN VARCHAR2 DEFAULT CHR(0),
                			  argument30  IN VARCHAR2 DEFAULT CHR(0),
                			  argument31  IN VARCHAR2 DEFAULT CHR(0),
                			  argument32  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument33  IN VARCHAR2 DEFAULT CHR(0),
                			  argument34  IN VARCHAR2 DEFAULT CHR(0),
                			  argument35  IN VARCHAR2 DEFAULT CHR(0),
                			  argument36  IN VARCHAR2 DEFAULT CHR(0),
                			  argument37  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument38  IN VARCHAR2 DEFAULT CHR(0),
                			  argument39  IN VARCHAR2 DEFAULT CHR(0),
                			  argument40  IN VARCHAR2 DEFAULT CHR(0),
                			  argument41  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument42  IN VARCHAR2 DEFAULT CHR(0),
                			  argument43  IN VARCHAR2 DEFAULT CHR(0),
                			  argument44  IN VARCHAR2 DEFAULT CHR(0),
                			  argument45  IN VARCHAR2 DEFAULT CHR(0),
                			  argument46  IN VARCHAR2 DEFAULT CHR(0),
                			  argument47  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument48  IN VARCHAR2 DEFAULT CHR(0),
                			  argument49  IN VARCHAR2 DEFAULT CHR(0),
                			  argument50  IN VARCHAR2 DEFAULT CHR(0),
                			  argument51  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument52  IN VARCHAR2 DEFAULT CHR(0),
                			  argument53  IN VARCHAR2 DEFAULT CHR(0),
                			  argument54  IN VARCHAR2 DEFAULT CHR(0),
                			  argument55  IN VARCHAR2 DEFAULT CHR(0),
                			  argument56  IN VARCHAR2 DEFAULT CHR(0),
                			  argument57  IN VARCHAR2 DEFAULT CHR(0),
                			  argument58  IN VARCHAR2 DEFAULT CHR(0),
                			  argument59  IN VARCHAR2 DEFAULT CHR(0),
                			  argument60  IN VARCHAR2 DEFAULT CHR(0),
                			  argument61  IN VARCHAR2 DEFAULT CHR(0),
                			  argument62  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument63  IN VARCHAR2 DEFAULT CHR(0),
                			  argument64  IN VARCHAR2 DEFAULT CHR(0),
                			  argument65  IN VARCHAR2 DEFAULT CHR(0),
                			  argument66  IN VARCHAR2 DEFAULT CHR(0),
                			  argument67  IN VARCHAR2 DEFAULT CHR(0),
                			  argument68  IN VARCHAR2 DEFAULT CHR(0),
                			  argument69  IN VARCHAR2 DEFAULT CHR(0),
                			  argument70  IN VARCHAR2 DEFAULT CHR(0),
                			  argument71  IN VARCHAR2 DEFAULT CHR(0),
                			  argument72  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument73  IN VARCHAR2 DEFAULT CHR(0),
                			  argument74  IN VARCHAR2 DEFAULT CHR(0),
                			  argument75  IN VARCHAR2 DEFAULT CHR(0),
                			  argument76  IN VARCHAR2 DEFAULT CHR(0),
                			  argument77  IN VARCHAR2 DEFAULT CHR(0),
                			  argument78  IN VARCHAR2 DEFAULT CHR(0),
                			  argument79  IN VARCHAR2 DEFAULT CHR(0),
                			  argument80  IN VARCHAR2 DEFAULT CHR(0),
                			  argument81  IN VARCHAR2 DEFAULT CHR(0),
                			  argument82  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument83  IN VARCHAR2 DEFAULT CHR(0),
                			  argument84  IN VARCHAR2 DEFAULT CHR(0),
                			  argument85  IN VARCHAR2 DEFAULT CHR(0),
                			  argument86  IN VARCHAR2 DEFAULT CHR(0),
                			  argument87  IN VARCHAR2 DEFAULT CHR(0),
                			  argument88  IN VARCHAR2 DEFAULT CHR(0),
                			  argument89  IN VARCHAR2 DEFAULT CHR(0),
                			  argument90  IN VARCHAR2 DEFAULT CHR(0),
                			  argument91  IN VARCHAR2 DEFAULT CHR(0),
                			  argument92  IN VARCHAR2 DEFAULT CHR(0),
                  		  argument93  IN VARCHAR2 DEFAULT CHR(0),
                			  argument94  IN VARCHAR2 DEFAULT CHR(0),
                			  argument95  IN VARCHAR2 DEFAULT CHR(0),
                			  argument96  IN VARCHAR2 DEFAULT CHR(0),
                			  argument97  IN VARCHAR2 DEFAULT CHR(0),
                			  argument98  IN VARCHAR2 DEFAULT CHR(0),
                			  argument99  IN VARCHAR2 DEFAULT CHR(0),
                			  argument100 IN VARCHAR2 DEFAULT CHR(0)
                			  );

-- Procedure to check Concurrent Program status					  
					  
PROCEDURE 	CHECK_CONC_PROG_STATUS(p_request_id IN NUMBER,
						p_interval IN NUMBER,
						o_status OUT VARCHAR2,
						o_message OUT VARCHAR2,
						v_errmsg OUT VARCHAR2);
			  
-- Function to return a User Id for a User Name 					  
					  
FUNCTION 	GET_USER_ID(p_user IN VARCHAR2)
	 	RETURN NUMBER;
	 	
-- Function to return a Responsibility Id for a Responsibility Name

FUNCTION       GET_USER_RESPONSIBILITY_ID(p_responsibility IN VARCHAR2)
	       RETURN NUMBER;

END Wm_Conc_Request_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_Conc_Request_Pkg AS

-- Function to submit a Concurrent Request


	PROCEDURE WM_REQUEST_SUBMIT(   application_id IN NUMBER,
				  user_responsibility_id IN NUMBER,
				  user_id IN NUMBER,
				  application IN VARCHAR2 DEFAULT NULL,
				  program     IN VARCHAR2 DEFAULT NULL,
				  v_request_status    OUT VARCHAR2  ,
				  v_request_id OUT NUMBER,
				  description IN VARCHAR2 DEFAULT NULL,
				  start_time  IN VARCHAR2 DEFAULT NULL,
				  o_message OUT VARCHAR2,
				  v_errmsg  OUT VARCHAR2,
				  argument1   IN VARCHAR2 DEFAULT CHR(0),
				  argument2   IN VARCHAR2 DEFAULT CHR(0),
				  argument3   IN VARCHAR2 DEFAULT CHR(0),
				  argument4   IN VARCHAR2 DEFAULT CHR(0),
				  argument5   IN VARCHAR2 DEFAULT CHR(0),
				  argument6   IN VARCHAR2 DEFAULT CHR(0),
				  argument7   IN VARCHAR2 DEFAULT CHR(0),
				  argument8   IN VARCHAR2 DEFAULT CHR(0),
				  argument9   IN VARCHAR2 DEFAULT CHR(0),
				  argument10  IN VARCHAR2 DEFAULT CHR(0),
				  argument11  IN VARCHAR2 DEFAULT CHR(0),
				  argument12  IN VARCHAR2 DEFAULT CHR(0),
				  argument13  IN VARCHAR2 DEFAULT CHR(0),
				  argument14  IN VARCHAR2 DEFAULT CHR(0),
				  argument15  IN VARCHAR2 DEFAULT CHR(0),
				  argument16  IN VARCHAR2 DEFAULT CHR(0),
				  argument17  IN VARCHAR2 DEFAULT CHR(0),
				  argument18  IN VARCHAR2 DEFAULT CHR(0),
				  argument19  IN VARCHAR2 DEFAULT CHR(0),
				  argument20  IN VARCHAR2 DEFAULT CHR(0),
				  argument21  IN VARCHAR2 DEFAULT CHR(0),
				  argument22  IN VARCHAR2 DEFAULT CHR(0),
				  argument23  IN VARCHAR2 DEFAULT CHR(0),
				  argument24  IN VARCHAR2 DEFAULT CHR(0),
				  argument25  IN VARCHAR2 DEFAULT CHR(0),
				  argument26  IN VARCHAR2 DEFAULT CHR(0),
				  argument27  IN VARCHAR2 DEFAULT CHR(0),
				  argument28  IN VARCHAR2 DEFAULT CHR(0),
				  argument29  IN VARCHAR2 DEFAULT CHR(0),
				  argument30  IN VARCHAR2 DEFAULT CHR(0),
				  argument31  IN VARCHAR2 DEFAULT CHR(0),
				  argument32  IN VARCHAR2 DEFAULT CHR(0),
				  argument33  IN VARCHAR2 DEFAULT CHR(0),
				  argument34  IN VARCHAR2 DEFAULT CHR(0),
				  argument35  IN VARCHAR2 DEFAULT CHR(0),
				  argument36  IN VARCHAR2 DEFAULT CHR(0),
				  argument37  IN VARCHAR2 DEFAULT CHR(0),
				  argument38  IN VARCHAR2 DEFAULT CHR(0),
				  argument39  IN VARCHAR2 DEFAULT CHR(0),
				  argument40  IN VARCHAR2 DEFAULT CHR(0),
				  argument41  IN VARCHAR2 DEFAULT CHR(0),
				  argument42  IN VARCHAR2 DEFAULT CHR(0),
				  argument43  IN VARCHAR2 DEFAULT CHR(0),
				  argument44  IN VARCHAR2 DEFAULT CHR(0),
				  argument45  IN VARCHAR2 DEFAULT CHR(0),
				  argument46  IN VARCHAR2 DEFAULT CHR(0),
				  argument47  IN VARCHAR2 DEFAULT CHR(0),
				  argument48  IN VARCHAR2 DEFAULT CHR(0),
				  argument49  IN VARCHAR2 DEFAULT CHR(0),
				  argument50  IN VARCHAR2 DEFAULT CHR(0),
				  argument51  IN VARCHAR2 DEFAULT CHR(0),
				  argument52  IN VARCHAR2 DEFAULT CHR(0),
				  argument53  IN VARCHAR2 DEFAULT CHR(0),
				  argument54  IN VARCHAR2 DEFAULT CHR(0),
				  argument55  IN VARCHAR2 DEFAULT CHR(0),
				  argument56  IN VARCHAR2 DEFAULT CHR(0),
				  argument57  IN VARCHAR2 DEFAULT CHR(0),
				  argument58  IN VARCHAR2 DEFAULT CHR(0),
				  argument59  IN VARCHAR2 DEFAULT CHR(0),
				  argument60  IN VARCHAR2 DEFAULT CHR(0),
				  argument61  IN VARCHAR2 DEFAULT CHR(0),
				  argument62  IN VARCHAR2 DEFAULT CHR(0),
				  argument63  IN VARCHAR2 DEFAULT CHR(0),
				  argument64  IN VARCHAR2 DEFAULT CHR(0),
				  argument65  IN VARCHAR2 DEFAULT CHR(0),
				  argument66  IN VARCHAR2 DEFAULT CHR(0),
				  argument67  IN VARCHAR2 DEFAULT CHR(0),
				  argument68  IN VARCHAR2 DEFAULT CHR(0),
				  argument69  IN VARCHAR2 DEFAULT CHR(0),
				  argument70  IN VARCHAR2 DEFAULT CHR(0),
				  argument71  IN VARCHAR2 DEFAULT CHR(0),
				  argument72  IN VARCHAR2 DEFAULT CHR(0),
				  argument73  IN VARCHAR2 DEFAULT CHR(0),
				  argument74  IN VARCHAR2 DEFAULT CHR(0),
				  argument75  IN VARCHAR2 DEFAULT CHR(0),
				  argument76  IN VARCHAR2 DEFAULT CHR(0),
				  argument77  IN VARCHAR2 DEFAULT CHR(0),
				  argument78  IN VARCHAR2 DEFAULT CHR(0),
				  argument79  IN VARCHAR2 DEFAULT CHR(0),
				  argument80  IN VARCHAR2 DEFAULT CHR(0),
				  argument81  IN VARCHAR2 DEFAULT CHR(0),
				  argument82  IN VARCHAR2 DEFAULT CHR(0),
				  argument83  IN VARCHAR2 DEFAULT CHR(0),
				  argument84  IN VARCHAR2 DEFAULT CHR(0),
				  argument85  IN VARCHAR2 DEFAULT CHR(0),
				  argument86  IN VARCHAR2 DEFAULT CHR(0),
				  argument87  IN VARCHAR2 DEFAULT CHR(0),
				  argument88  IN VARCHAR2 DEFAULT CHR(0),
				  argument89  IN VARCHAR2 DEFAULT CHR(0),
				  argument90  IN VARCHAR2 DEFAULT CHR(0),
				  argument91  IN VARCHAR2 DEFAULT CHR(0),
				  argument92  IN VARCHAR2 DEFAULT CHR(0),
				  argument93  IN VARCHAR2 DEFAULT CHR(0),
				  argument94  IN VARCHAR2 DEFAULT CHR(0),
				  argument95  IN VARCHAR2 DEFAULT CHR(0),
				  argument96  IN VARCHAR2 DEFAULT CHR(0),
				  argument97  IN VARCHAR2 DEFAULT CHR(0),
				  argument98  IN VARCHAR2 DEFAULT CHR(0),
				  argument99  IN VARCHAR2 DEFAULT CHR(0),
				  argument100  IN VARCHAR2 DEFAULT CHR(0)
				  )

 IS
 
 request_id NUMBER;
 v_boolean  BOOLEAN;
 v_phase                 VARCHAR2(80);
 v_status                VARCHAR2(80);
 v_dev_phase             VARCHAR2(80);
 v_dev_status            VARCHAR2(80);
 v_message               VARCHAR2(200);

 BEGIN

 	  --- Call to Initialize Session Variables

	  Fnd_Global.apps_initialize(user_id,user_responsibility_id,application_id);


	  -- Call to submit request

	  v_request_id := Fnd_Request.submit_request( application,
			  					  program,
			  					  description,
			  					  start_time,
			  					  FALSE,
                    			  argument1   ,
                    			  argument2   ,
                      			  argument3   ,
                    			  argument4   ,
                    			  argument5   ,
                    			  argument6   ,
                    			  argument7   ,
                    			  argument8   ,
                    			  argument9   ,
                    			  argument10  ,
                    			  argument11  ,
                    			  argument12  ,
                      			  argument13  ,
                    			  argument14  ,
                    			  argument15  ,
                    			  argument16  ,
                    			  argument17  ,
                    			  argument18  ,
                    			  argument19  ,
                    			  argument20  ,
                    			  argument21  ,
                    			  argument22  ,
                      			  argument23  ,
                    			  argument24  ,
                    			  argument25  ,
                    			  argument26  ,
                    			  argument27  ,
                    			  argument28  ,
                    			  argument29  ,
                    			  argument30  ,
                    			  argument31  ,
                    			  argument32  ,
                      			  argument33  ,
                    			  argument34  ,
                    			  argument35  ,
                    			  argument36  ,
                    			  argument37  ,
                      			  argument38  ,
                    			  argument39  ,
                    			  argument40  ,
                    			  argument41  ,
                      			  argument42  ,
                    			  argument43  ,
                    			  argument44  ,
                    			  argument45  ,
                    			  argument46  ,
                    			  argument47  ,
                      			  argument48  ,
                    			  argument49  ,
                    			  argument50  ,
                    			  argument51  ,
                      			  argument52  ,
                    			  argument53  ,
                    			  argument54  ,
                    			  argument55  ,
                    			  argument56  ,
                    			  argument57  ,
                    			  argument58  ,
                    			  argument59  ,
                    			  argument60  ,
                    			  argument61  ,
                    			  argument62  ,
                      			  argument63  ,
                    			  argument64  ,
                    			  argument65  ,
                    			  argument66  ,
                    			  argument67  ,
                    			  argument68  ,
                    			  argument69  ,
                    			  argument70  ,
                    			  argument71  ,
                    			  argument72  ,
                      			  argument73  ,
                    			  argument74  ,
                    			  argument75  ,
                    			  argument76  ,
                    			  argument77  ,
                    			  argument78  ,
                    			  argument79  ,
                    			  argument80  ,
                    			  argument81  ,
                    			  argument82  ,
                      			  argument83  ,
                    			  argument84  ,
                    			  argument85  ,
                    			  argument86  ,
                    			  argument87  ,
                    			  argument88  ,
                    			  argument89  ,
                    			  argument90  ,
                    			  argument91  ,
                    			  argument92  ,
                      			  argument93  ,
                    			  argument94  ,
                    			  argument95  ,
                    			  argument96  ,
                    			  argument97  ,
                    			  argument98  ,
                    			  argument99  ,
                    			  argument100  );

	COMMIT;

   /** Wait till the Request Completes**/
/*
   LOOP
   	   	 --dbms_output.put_line(request_id||','||v_phase||','||v_status||','||v_dev_phase);
         v_boolean := Fnd_Concurrent.GET_REQUEST_STATUS(v_request_id,
            						NULL,
            						NULL,
            						v_phase,
            						v_status,
            						v_dev_phase,
            						v_dev_status,
            						v_message);

         EXIT WHEN v_dev_phase = 'COMPLETE';
         EXIT WHEN v_dev_phase = 'ERROR';

      END LOOP;

      IF v_dev_phase = 'COMPLETE' AND v_dev_status IN ('NORMAL','WARNING') THEN
      	 v_dev_status := 'SUCCESS';
      ELSE
         v_dev_status := 'FAILED';
      END IF;
      
  */
	IF v_request_id <>0 THEN

		CHECK_CONC_PROG_STATUS(v_request_id,10,v_dev_status,	v_message, v_errmsg);
   
      	v_request_status := v_dev_status;

		o_message := v_message;
	ELSE
		v_request_status := 'FAILED';
	END IF;

EXCEPTION
	WHEN others THEN
		v_errmsg:='Error in WM_SUBMIT_REQUEST process. '||sqlerrm;
		v_request_status := 'FAILED';
 
 END WM_REQUEST_SUBMIT;



PROCEDURE 	CHECK_CONC_PROG_STATUS(p_request_id IN NUMBER,
						p_interval IN NUMBER,
						o_status OUT VARCHAR2,
						o_message OUT VARCHAR2,
						v_errmsg OUT VARCHAR2)
IS

v_boolean BOOLEAN;
v_phase VARCHAR2(20);
v_status VARCHAR2(20);
v_dev_status VARCHAR2(20);
v_dev_phase VARCHAR2(20);

BEGIN
	o_message:=NULL;
	v_errmsg:=NULL;
	v_boolean := fnd_concurrent.wait_for_request(p_request_id,
            						p_interval,
            						NULL,
            						v_phase,
            						v_status,
            						v_dev_phase,
            						v_dev_status,
            						o_message);

     
      IF v_dev_phase = 'COMPLETE' AND v_dev_status IN ('NORMAL','WARNING') THEN
      	 o_status := 'SUCCESS';
      ELSE
         o_status := 'FAILED';
      END IF;

EXCEPTION

WHEN OTHERS THEN
o_status:= 'FAILED';
v_errmsg:= 'Error checking Concurrent request status for Request: '||p_request_id||'. '||sqlerrm;
      
END CHECK_CONC_PROG_STATUS;




-- Function to fetch the User Id

FUNCTION GET_USER_ID (p_user IN VARCHAR2)

RETURN NUMBER IS

v_user_id NUMBER;

BEGIN

	SELECT user_id
	INTO   v_user_id
	FROM   fnd_user
	WHERE  user_name = p_user;
	
RETURN  v_user_id;

END GET_USER_ID;

-- Function to return a Responsibility Id for a Responsibility Name

FUNCTION GET_USER_RESPONSIBILITY_ID(p_responsibility IN VARCHAR2)

RETURN NUMBER IS

v_user_responsibility_id NUMBER;

BEGIN

	SELECT responsibility_id
	INTO   v_user_responsibility_id
	FROM   fnd_responsibility_tl
	WHERE  responsibility_name = p_responsibility
	AND    language = userenv('LANG');
	
RETURN v_user_responsibility_id;
	
END GET_USER_RESPONSIBILITY_ID;

END Wm_Conc_Request_Pkg;
/

CREATE OR REPLACE PACKAGE WM_UTILS_PKG AUTHID CURRENT_USER AS

-- Procedure to return the nextval of the passed sequence name

PROCEDURE WM_PICK_SEQUENCE(p_sequence_name IN varchar2, o_sequence_value OUT NUMBER);

END WM_UTILS_PKG;
/

CREATE OR REPLACE PACKAGE BODY WM_UTILS_PKG AS

/************************GLOBAL VARIABLE DECLARATIONS**************************************/

        
/**********************END OF ERROR VARIABLE DECLARATIONS*********************************/

PROCEDURE WM_PICK_SEQUENCE(p_sequence_name IN varchar2, o_sequence_value OUT NUMBER) IS

v_select_stmt varchar2(100);

BEGIN

v_select_stmt:='SELECT '||p_sequence_name||'.NEXTVAL FROM DUAL';

EXECUTE IMMEDIATE v_select_stmt
INTO o_sequence_value;

END WM_PICK_SEQUENCE;

END WM_UTILS_PKG;
/

SHOW ERRORS


