/*  ***************************************************************************
        $Date:   14 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Packages for Employee inbound in Application Schema  
    * Program Name:         wm_into_employee_pkg.sql
    * Version #:            1.0
    * Title:                Package Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema to handle Calling of HRMS Interface APIs
    *
    * Tables usage:     	INSERT		UPDATE		DELETE
    * NONE
    *
    * Procedures and Functions: wm_handle_emp-> Performs pre-processing actions to determine 
    *					  the values  to be passed for Employee APIs in HRMS. 
    *					  wm_emp_create_asg -> Performs pre-processing actions to determine 
    *					  the values  to be passed for Employee assignment Create API in HRMS. 
    *					  wm_emp_update_asg -> Performs pre-processing actions to determine 
    *					  the values  to be passed for Employee assignment Update API in HRMS. 
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
     14-NOV-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on


  prompt Program : wm_into_employee_pkg.sql

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  connect &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------
 CREATE OR REPLACE PACKAGE wm_emp_imp_handler_pkg AS

-- Procedure to determine calling parameters for HRMS Employee APIs
-- Takes in the mandatory and optional parameters required for HRMS Employee APIs

	PROCEDURE WM_HANDLE_EMP
		  (p_action		  		IN VARCHAR2
		  ,p_action_subtype			IN VARCHAR2 	DEFAULT NULL
		  ,p_employee_number 			IN VARCHAR2	DEFAULT NULL
		  ,p_effective_start_date		IN DATE 	DEFAULT NULL
		  ,p_effective_end_date			IN DATE 	DEFAULT NULL
		  ,p_business_group_name		IN VARCHAR2
		  ,p_person_type_code			IN VARCHAR2 	DEFAULT NULL
		  ,p_last_name				IN VARCHAR2
		  ,p_first_name				IN VARCHAR2 	DEFAULT NULL
		  ,p_hire_start_date			IN DATE
		  ,p_applicant_number			IN VARCHAR2 	DEFAULT NULL
		  ,p_comment				IN VARCHAR2 	DEFAULT NULL
		  ,p_date_employee_data_veri		IN DATE		DEFAULT NULL
		  ,p_date_of_birth			IN DATE		
		  ,p_email_address			IN VARCHAR2	DEFAULT NULL
		  ,p_exp_chk_sent_to_addr		IN VARCHAR2	DEFAULT NULL
		  ,p_known_as				IN VARCHAR2	DEFAULT NULL
		  ,p_primary_address_flag		IN VARCHAR2	DEFAULT 'N'
		  ,p_address_style			IN VARCHAR2	
		  ,p_address_type			IN VARCHAR2 	DEFAULT 'H'
		  ,p_address_line1			IN VARCHAR2	DEFAULT NULL
		  ,p_address_line2			IN VARCHAR2	DEFAULT NULL
		  ,p_address_line3			IN VARCHAR2	DEFAULT NULL
		  ,p_city				IN VARCHAR2 	DEFAULT NULL
		  ,p_state				IN VARCHAR2 	DEFAULT NULL
		  ,p_postal_code			IN VARCHAR2 	DEFAULT NULL
		  ,p_county				IN VARCHAR2 	DEFAULT NULL
		  ,p_country				IN VARCHAR2 	DEFAULT NULL
		  ,p_phone_type				IN VARCHAR2 	DEFAULT NULL
		  ,p_telephone_number			IN VARCHAR2 	DEFAULT NULL
		  ,p_marital_status			IN VARCHAR2 	DEFAULT NULL
		  ,p_middle_name			IN VARCHAR2 	DEFAULT NULL
		  ,p_nationality			IN VARCHAR2 	DEFAULT NULL
		  ,p_national_identifier		IN VARCHAR2 	DEFAULT NULL
		  ,p_prev_last_name			IN VARCHAR2 	DEFAULT NULL
		  ,p_reg_disabled_flag			IN VARCHAR2 	DEFAULT NULL
		  ,p_sex				IN VARCHAR2 
		  ,p_title       			IN VARCHAR2 	DEFAULT NULL
		  ,p_suffix				IN VARCHAR2 	DEFAULT NULL
		  ,p_work_telephone			IN VARCHAR2 	DEFAULT NULL
		  ,o_person_id                  	OUT NUMBER
		  ,o_employee_number 		 	OUT VARCHAR2
		  ,o_assignment_id              	OUT NUMBER
          	  ,o_per_object_version_number  	OUT NUMBER
          	  ,o_asg_object_version_number  	OUT NUMBER
          	  ,o_per_effective_start_date   	OUT DATE
          	  ,o_per_effective_end_date     	OUT DATE
          	  ,o_full_name                  	OUT VARCHAR2 
          	  ,o_per_comment_id             	OUT NUMBER 
          	  ,o_assignment_sequence        	OUT NUMBER
          	  ,o_assignment_number          	OUT VARCHAR2 
          	  ,o_name_combination_warning   	OUT VARCHAR2
          	  ,o_assign_payroll_warning     	OUT VARCHAR2
		  ,o_address_id				OUT NUMBER
		  ,o_add_object_version_number		OUT NUMBER
		  ,o_phone_object_version_number 	OUT NUMBER
		  ,o_phone_id				OUT NUMBER
		  ,o_status				OUT VARCHAR2
		  ,o_message				OUT VARCHAR2
		  ,o_errmsg				OUT VARCHAR2
		  );

		  
END wm_emp_imp_handler_pkg;	
/

SHOW ERRORS

CREATE OR REPLACE PACKAGE BODY wm_emp_imp_handler_pkg AS

	PROCEDURE WM_HANDLE_EMP
		  (p_action		  		IN VARCHAR2
		  ,p_action_subtype			IN VARCHAR2 	DEFAULT NULL
		  ,p_employee_number 			IN VARCHAR2	DEFAULT NULL
		  ,p_effective_start_date		IN DATE 	DEFAULT NULL
		  ,p_effective_end_date			IN DATE 	DEFAULT NULL
		  ,p_business_group_name		IN VARCHAR2
		  ,p_person_type_code			IN VARCHAR2 	DEFAULT NULL
		  ,p_last_name				IN VARCHAR2
		  ,p_first_name				IN VARCHAR2 	DEFAULT NULL
		  ,p_hire_start_date			IN DATE
		  ,p_applicant_number			IN VARCHAR2 	DEFAULT NULL
		  ,p_comment				IN VARCHAR2 	DEFAULT NULL
		  ,p_date_employee_data_veri		IN DATE		DEFAULT NULL
		  ,p_date_of_birth			IN DATE		
		  ,p_email_address			IN VARCHAR2	DEFAULT NULL
		  ,p_exp_chk_sent_to_addr		IN VARCHAR2	DEFAULT NULL
		  ,p_known_as				IN VARCHAR2	DEFAULT NULL
		  ,p_primary_address_flag		IN VARCHAR2	DEFAULT 'N'
		  ,p_address_style			IN VARCHAR2	
		  ,p_address_type			IN VARCHAR2 	DEFAULT 'H'
		  ,p_address_line1			IN VARCHAR2	DEFAULT NULL
		  ,p_address_line2			IN VARCHAR2	DEFAULT NULL
		  ,p_address_line3			IN VARCHAR2	DEFAULT NULL
		  ,p_city				IN VARCHAR2 	DEFAULT NULL
		  ,p_state				IN VARCHAR2 	DEFAULT NULL
		  ,p_postal_code			IN VARCHAR2 	DEFAULT NULL
		  ,p_county				IN VARCHAR2 	DEFAULT NULL
		  ,p_country				IN VARCHAR2 	DEFAULT NULL
		  ,p_phone_type				IN VARCHAR2 	DEFAULT NULL
		  ,p_telephone_number			IN VARCHAR2 	DEFAULT NULL
		  ,p_marital_status			IN VARCHAR2 	DEFAULT NULL
		  ,p_middle_name			IN VARCHAR2 	DEFAULT NULL
		  ,p_nationality			IN VARCHAR2 	DEFAULT NULL
		  ,p_national_identifier		IN VARCHAR2 	DEFAULT NULL
		  ,p_prev_last_name			IN VARCHAR2 	DEFAULT NULL
		  ,p_reg_disabled_flag			IN VARCHAR2 	DEFAULT NULL
		  ,p_sex				IN VARCHAR2 
		  ,p_title       			IN VARCHAR2 	DEFAULT NULL
		  ,p_suffix				IN VARCHAR2 	DEFAULT NULL
		  ,p_work_telephone			IN VARCHAR2 	DEFAULT NULL
		  ,o_person_id                  	OUT NUMBER
		  ,o_employee_number 		 	OUT VARCHAR2
		  ,o_assignment_id              	OUT NUMBER
          	  ,o_per_object_version_number  	OUT NUMBER
          	  ,o_asg_object_version_number  	OUT NUMBER
          	  ,o_per_effective_start_date   	OUT DATE
          	  ,o_per_effective_end_date     	OUT DATE
          	  ,o_full_name                  	OUT VARCHAR2 
          	  ,o_per_comment_id             	OUT NUMBER 
          	  ,o_assignment_sequence        	OUT NUMBER
          	  ,o_assignment_number          	OUT VARCHAR2 
          	  ,o_name_combination_warning   	OUT VARCHAR2
          	  ,o_assign_payroll_warning     	OUT VARCHAR2
		  ,o_address_id				OUT NUMBER
		  ,o_add_object_version_number		OUT NUMBER
		  ,o_phone_object_version_number 	OUT NUMBER
		  ,o_phone_id				OUT NUMBER
		  ,o_status				OUT VARCHAR2
		  ,o_message				OUT VARCHAR2
		  ,o_errmsg				OUT VARCHAR2
		  )
	  
IS
		  		  
		  -- Declare local variables
		  v_business_group_id 			NUMBER;
		  v_person_type_id 			NUMBER DEFAULT NULL;
		  v_system_person_type			VARCHAR2(15):='EMP'; -- Person Type Employee
		  v_parent_table			VARCHAR2(20):='PER_ALL_PEOPLE_F'; -- Employee Parent Table 
		  v_name_combination_warning		BOOLEAN;
		  v_assign_payroll_warning		BOOLEAN;
		  v_errmsg				VARCHAR2(1000) DEFAULT NULL;
		  v_person_id                  	 	NUMBER;
		  v_employee_number 		 	VARCHAR2(1000) DEFAULT NULL;
		  v_assignment_id              	 	NUMBER;
		  v_per_object_version_number  	 	NUMBER;
		  v_asg_object_version_number  	 	NUMBER;
		  v_per_effective_start_date   	 	DATE;
		  v_per_effective_end_date     	 	DATE;
		  v_full_name                  	 	VARCHAR2(1000) DEFAULT NULL;
		  v_per_comment_id             	 	NUMBER DEFAULT NULL; 
		  v_assignment_sequence        	 	NUMBER DEFAULT NULL;
		  v_assignment_number          	 	VARCHAR2(1000) DEFAULT NULL;
		  v_address_id				NUMBER;
		  v_add_object_version_number	 	NUMBER;
		  v_phone_object_version_number  	NUMBER;
		  v_phone_id				NUMBER;

BEGIN

		  --Fetch Business Group Id for the Employee
		  
		  v_errmsg :='Error selecting Business Group Id';

		  SELECT business_group_id 
		  INTO v_business_group_id
		  FROM per_business_groups_perf 
		  WHERE name = p_business_group_name;
		  
	
		  --Fetch Person Type Id for for the Employee

		  v_errmsg :='Error selecting Person Type Id';

   		  IF p_person_type_code IS NOT NULL THEN
        		  SELECT person_type_id 
        		  INTO v_person_type_id 
        		  FROM per_person_types 
        		  WHERE system_person_type = v_system_person_type
			  AND user_person_type = p_person_type_code	
        		  AND business_group_id = v_business_group_id;
   		  ELSE
    		  	  SELECT  person_type_id 
        		  INTO v_person_type_id 
    			  FROM per_person_types 
                  	  WHERE system_person_type = v_system_person_type
                  	  AND business_group_id = v_business_group_id
                  	  AND default_flag = 'Y';
		  END IF;
		  
		  
		  IF UPPER(p_action) = 'NEW' THEN
		  
			
			BEGIN

					--Calling the Create Employee API with the Required Parameters
				
				  	v_errmsg :='Error Calling the Create Employee API. ';
		
				  	HR_EMPLOYEE_API.CREATE_EMPLOYEE(
		  					 p_hire_date		 	=>	   p_hire_start_date                 
		  					,p_business_group_id    	=>	   v_business_group_id         
		  					,p_last_name   			=>	   p_last_name                  
		  					,p_sex                          =>	   p_sex 
		  					,p_person_type_id               =>	   v_person_type_id 
		  					,p_per_comments                 =>	   p_comment 
		  					,p_date_employee_data_verified  =>	   p_date_employee_data_veri 
		  					,p_date_of_birth                => 	   p_date_of_birth
		  					,p_email_address                => 	   p_email_address
							,p_employee_number 		=>	   v_employee_number
		  					,p_expense_check_send_to_addres =>	   p_exp_chk_sent_to_addr
		  					,p_first_name                   =>	   p_first_name
		  					,p_known_as                     =>	   p_known_as
		  					,p_marital_status               =>	   p_marital_status
		  					,p_middle_names                 =>	   p_middle_name
		  					,p_nationality                  =>	   p_nationality
		  					,p_national_identifier          =>	   p_national_identifier
		  					,p_previous_last_name           =>	   p_prev_last_name
		  					,p_registered_disabled_flag     =>	   p_reg_disabled_flag
		  					,p_title                        =>	   p_title
		                           		,p_suffix                       =>	   p_suffix
		  					,p_work_telephone               =>	   p_work_telephone
		                            		,p_person_id                    =>	   v_person_id
		                            		,p_assignment_id                =>	   v_assignment_id
		                            		,p_per_object_version_number    =>	   v_per_object_version_number
		                            		,p_asg_object_version_number    =>	   v_asg_object_version_number
		                            		,p_per_effective_start_date     =>	   v_per_effective_start_date
		                            		,p_per_effective_end_date       =>	   v_per_effective_end_date
		                            		,p_full_name                    =>	   v_full_name
		                            		,p_per_comment_id               =>	   v_per_comment_id
		                            		,p_assignment_sequence          =>	   v_assignment_sequence
		                            		,p_assignment_number            =>	   v_assignment_number
		                            		,p_name_combination_warning     =>	   v_name_combination_warning
		                            		,p_assign_payroll_warning       =>	   v_assign_payroll_warning
		  					);
	

			EXCEPTION

					WHEN OTHERS THEN
					o_message := SQLERRM;
					o_status := 'FAILED';
					ROLLBACK;
					RETURN;
			END;

	
					--////**** Since OA sometimes doesn't return Employee Number ****////
					IF v_employee_number IS NULL THEN
					   SELECT employee_number 
					   INTO v_employee_number
					   FROM per_all_people_f
					   WHERE person_id = v_person_id;
					END IF;   

			            o_person_id :=  v_person_id;
			            o_employee_number := v_employee_number;
			            o_assignment_id := v_assignment_id;
			            o_per_object_version_number := v_per_object_version_number;
			            o_asg_object_version_number := v_asg_object_version_number;
			            o_per_effective_start_date := v_per_effective_start_date;
			            o_per_effective_end_date := v_per_effective_end_date;
			            o_full_name := v_full_name;
			            o_per_comment_id := v_per_comment_id;
			            o_assignment_sequence := v_assignment_sequence;
			            o_assignment_number := v_assignment_number;

			-- Typecasting Boolean to String
			IF v_name_combination_warning = TRUE THEN
				   o_name_combination_warning := 'TRUE';
			ELSE
				   o_name_combination_warning := 'FALSE';
			END IF;
					
			IF v_assign_payroll_warning = TRUE THEN
				o_assign_payroll_warning := 'TRUE';
			ELSE
				o_assign_payroll_warning := 'FALSE';
			END IF;

			BEGIN
			
					--Calling the Create Employee Address API with the required Parameters
		
					v_errmsg :='Error Calling the Create Employee Address API. ';
					
			      	  	HR_PERSON_ADDRESS_API.CREATE_PERSON_ADDRESS(
		       	  					 p_effective_date 	=> 	   v_per_effective_start_date
		       						,p_person_id		=>	   v_person_id
		       						,p_primary_flag		=>	   p_primary_address_flag
		       						,p_style		=>	   p_address_style
								,p_address_type		=>	   p_address_type
		       						,p_date_from		=>	   p_hire_start_date
		       						,p_address_line1	=>	   p_address_line1
		       						,p_address_line2	=>	   p_address_line2
		       						,p_address_line3	=>	   p_address_line3
		       						,p_town_or_city		=>	   p_city
		       						,p_region_1		=>	   p_county
		       						,p_region_2		=>	   p_state
		       						,p_postal_code		=>	   p_postal_code
		       						,p_country		=>	   p_country
		       						,p_telephone_number_1	=>	   p_telephone_number
		       						,p_address_id		=>	   v_address_id
		       						,p_object_version_number=>	   v_add_object_version_number
		       						);


			EXCEPTION
					WHEN OTHERS THEN
					o_message := SQLERRM;
					o_status := 'FAILED';
					ROLLBACK;
					RETURN;
			END;
				            o_address_id := v_address_id;
				            o_add_object_version_number := v_add_object_version_number;

			BEGIN

					--Calling the Create Employee Phone API with the required Parameters
		
		
					v_errmsg :='Error Calling the Create Employee Address API. ';
		
				  	HR_PHONE_API.CREATE_PHONE(
				  	   		  	  p_date_from		=>	   v_per_effective_start_date
								 ,p_date_to		=>	   v_per_effective_end_date
								 ,p_phone_type		=>	   p_phone_type
								 ,p_phone_number	=>	   p_telephone_number
								 ,p_parent_id		=>	   v_person_id
								 ,p_parent_table	=>	   v_parent_table
								 ,p_effective_date	=>	   v_per_effective_start_date
								 ,p_object_version_number	=>	   v_phone_object_version_number
								 ,p_phone_id		=>	   v_phone_id
								 );


			EXCEPTION
					WHEN OTHERS THEN
					o_message := SQLERRM;
					o_status := 'FAILED';
					ROLLBACK;
					RETURN;
			END;
				            o_phone_object_version_number := v_phone_object_version_number;
				            o_phone_id := v_phone_id;
  	  	END IF;
	  
	  	IF UPPER(p_action) = 'MODIFY' THEN
	  	 

			-- Fetch Person Id and Object Version Number for Employee

			v_errmsg :='Error fetching Person Id and Object Version Number for Employee. ';
      		
			IF UPPER(p_action_subtype) = 'UPDATE' THEN
				SELECT person_id, object_version_number 
				INTO v_person_id, v_per_object_version_number 
	      			FROM per_all_people_f 
	      			WHERE upper(sex) = p_sex
	      			AND ltrim(last_name) = p_last_name
	      			AND trunc(date_of_birth) = p_date_of_birth
				AND p_effective_start_date BETWEEN trunc(effective_start_date) AND trunc(effective_end_date)
				AND employee_number = p_employee_number;
			ELSE
	
				SELECT person_id, object_version_number 
				INTO v_person_id, v_per_object_version_number 
	      			FROM per_all_people_f 
	      			WHERE upper(sex) = p_sex
	      			AND ltrim(last_name) = p_last_name
	      			AND trunc(date_of_birth) = p_date_of_birth
				AND trunc(effective_start_date) = p_effective_start_date
				AND employee_number = p_employee_number;
			END IF;


			v_employee_number := p_employee_number;

			BEGIN
				-- Calling Update Person API with the required parameters

				v_errmsg := 'Error in Calling the Update Person API. ';

				HR_PERSON_API.UPDATE_PERSON(
		  	 		 p_effective_date 		=> p_effective_start_date
					,p_datetrack_update_mode  	=> p_action_subtype
					,p_person_id			=> v_person_id
					,p_object_version_number  	=> v_per_object_version_number
					,p_person_type_id		=> v_person_type_id
					,p_last_name			=> p_last_name
					,p_applicant_number	   	=> p_applicant_number
					,p_comments			=> p_comment
					,p_date_employee_data_verified  => p_date_employee_data_veri
					,p_date_of_birth		=> p_date_of_birth
					,p_email_address		=> p_email_address
					,p_employee_number		=> v_employee_number
					,p_expense_check_send_to_addres => p_exp_chk_sent_to_addr
					,p_first_name			=> p_first_name
					,p_known_as			=> p_known_as
					,p_marital_status		=> p_marital_status
					,p_middle_names			=> p_middle_name
					,p_nationality			=> p_nationality
					,p_national_identifier		=> p_national_identifier
					,p_previous_last_name		=> p_prev_last_name
					,p_registered_disabled_flag	=> p_reg_disabled_flag
					,p_sex				=> p_sex
					,p_title			=> p_title
					,p_suffix			=> p_suffix
  					,p_work_telephone               => p_work_telephone
                     			,p_effective_start_date       	=> v_per_effective_start_date
                     			,p_effective_end_date         	=> v_per_effective_end_date
                     			,p_full_name                    => v_full_name
                     			,p_comment_id                 	=> v_per_comment_id
                     			,p_name_combination_warning     => v_name_combination_warning
					,p_assign_payroll_warning	=> v_assign_payroll_warning
					);


			EXCEPTION
				WHEN OTHERS THEN
				o_message := SQLERRM;
				o_status := 'FAILED';
				ROLLBACK;
				RETURN;
			END;

		            o_person_id :=  v_person_id;
		            o_employee_number := v_employee_number;
		            o_per_effective_start_date := v_per_effective_start_date;
		            o_per_effective_end_date := v_per_effective_end_date;
		            o_full_name := v_full_name;
		            o_per_comment_id := v_per_comment_id;
	
			-- Typecasting Boolean to String							 
			IF v_name_combination_warning = TRUE THEN
				   o_name_combination_warning := 'TRUE';
			ELSE
				   o_name_combination_warning := 'FALSE';
			END IF;
			IF v_assign_payroll_warning = TRUE THEN
				   o_assign_payroll_warning := 'TRUE';
			ELSE
				   o_assign_payroll_warning := 'FALSE';
			END IF;


			-- Fetch Address_id and Address_object_version_number for the Employee
		
			v_errmsg := 'Error fetching Address Id and Address Version Number for the Employee. ';

             		SELECT address_id, object_version_number
			INTO v_address_id, v_add_object_version_number 
             		FROM per_addresses
             		WHERE primary_flag = p_primary_address_flag
             		AND business_group_id = v_business_group_id
             		AND person_id = v_person_id
             		AND date_from = p_hire_start_date;

			-- Fetch the Phone_id and the Phone_Object_Version_Number for the Employee
				
			v_errmsg := 'Error fetching Phone Id and Phone Object Version Number. ';
				
			SELECT phone_id, object_version_number
			INTO v_phone_id, v_phone_object_version_number
			FROM per_phones 
			WHERE parent_id = v_person_id
			AND parent_table = v_parent_table
			AND date_from = p_hire_start_date;


			BEGIN
								
					-- Calling Update Person Address API with the required parameters
		
					v_errmsg := 'Error in Calling the Update Person Address API. ';
		
		                    
		                    	HR_PERSON_ADDRESS_API.UPDATE_PERSON_ADDRESS(
		                                		p_effective_date 		=> 	   p_effective_start_date
		                                		,p_address_id			=>	   v_address_id
		                                		,p_object_version_number	=>	   v_add_object_version_number
		                                		,p_date_from			=>	   p_effective_start_date
		                                		,p_date_to			=>	   p_effective_end_date
		                                		,p_address_type			=>	   p_address_type
		                                		,p_address_line1		=>	   p_address_line1
		                                		,p_address_line2		=>	   p_address_line2
		                                		,p_address_line3		=>	   p_address_line3
		                                		,p_town_or_city			=>	   p_city
		                                		,p_region_1			=>	   p_county
		                                		,p_region_2			=>	   p_state
		                                		,p_postal_code			=>	   p_postal_code
		                                		,p_country			=>	   p_country
		                                		,p_telephone_number_1		=>	   p_telephone_number
		                                		);



			EXCEPTION
					WHEN OTHERS THEN
					o_message := SQLERRM;
					o_status := 'FAILED';
					ROLLBACK;
					RETURN;
			END;
	
					 o_address_id := v_address_id;
					 o_add_object_version_number := v_add_object_version_number;

			BEGIN
					-- Calling Update Person Phone Update API with the required parameters
		
					v_errmsg := 'Error in Calling the Update Person Phone API. ';
					
				
					HR_PHONE_API.UPDATE_PHONE(
							 p_phone_id	   		=>	   v_phone_id
							 ,p_date_from			=>	   p_effective_start_date
							 ,p_date_to			=>	   p_effective_end_date
							 ,p_phone_type			=>	   p_phone_type
							 ,p_phone_number		=>	   p_telephone_number
							 ,p_parent_id			=>	   v_person_id
							 ,p_parent_table		=>	   v_parent_table
							 ,p_object_version_number	=>	   v_phone_object_version_number								  
							 ,p_effective_date		=>	   p_effective_start_date
							 );

			EXCEPTION
					WHEN OTHERS THEN
					o_message := SQLERRM;
					o_status := 'FAILED';
					ROLLBACK;
					RETURN;
			END;
			 		  o_phone_object_version_number := v_phone_object_version_number;
					  o_phone_id := v_phone_id;
	  	END IF;
		
--COMMIT;		
o_message := 'Normal Completion';
o_status := 'OK';

EXCEPTION 
	WHEN OTHERS THEN 
	o_errmsg := v_errmsg || ' :- ' || SQLERRM;
	o_status := 'FAILED';
	ROLLBACK;
END wm_handle_emp ;
END wm_emp_imp_handler_pkg ;
/

SHOW ERRORS


CREATE OR REPLACE PACKAGE wm_employee_asg_import_pkg  as

PROCEDURE wm_emp_create_asg(
    p_assignment_id		IN 	NUMBER			DEFAULT NULL
   ,p_assignment_no		IN  	VARCHAR2		DEFAULT NULL
   ,p_person_id                 IN  	NUMBER
   ,p_effective_start_date      IN  	DATE
   ,p_effective_end_date	IN	DATE			DEFAULT NULL
   ,p_business_group_name	IN	VARCHAR2
   ,p_recruiter_name		IN	VARCHAR2		DEFAULT NULL
   ,p_grade			IN	VARCHAR2		DEFAULT NULL
   ,p_position			IN	VARCHAR2		DEFAULT NULL
   ,p_job			IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_status		IN 	VARCHAR2
   ,p_payroll_name		IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_1	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_2	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_3	IN	VARCHAR2		DEFAULT NULL
   ,p_location_city		IN	VARCHAR2		DEFAULT NULL
   ,p_location_county		IN	VARCHAR2		DEFAULT NULL
   ,p_location_state		IN	VARCHAR2		DEFAULT NULL
   ,p_location_postal_code	IN	VARCHAR2		DEFAULT NULL
   ,p_location_country		IN	VARCHAR2		DEFAULT NULL
   ,p_person_referred_by	IN	VARCHAR2		DEFAULT NULL
   ,p_supervisor_name		IN	VARCHAR2		DEFAULT NULL
   ,p_progr_pt_name_no		IN	VARCHAR2		DEFAULT NULL
   ,p_recruitment_act_name	IN	VARCHAR2		DEFAULT NULL
   ,p_source_orgn_name		IN	VARCHAR2		DEFAULT NULL
   ,p_orgn_name			IN	VARCHAR2		
   ,p_group_name		IN	VARCHAR2		DEFAULT NULL
   ,p_vacancy_name		IN	VARCHAR2		DEFAULT NULL
   ,p_pay_basis			IN	VARCHAR2		DEFAULT NULL
   ,p_salary_approved_flag	IN	VARCHAR2		DEFAULT NULL
   ,p_rate_basis		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_uom		IN	VARCHAR2		DEFAULT NULL
   ,p_proposed_salary		IN	NUMBER			DEFAULT NULL
   ,p_assignment_type		IN	VARCHAR2		
   ,p_assignment_primary_flag	IN	VARCHAR2		
   ,p_current_employer		IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_chg_reason	IN	VARCHAR2		DEFAULT NULL
   ,p_comment			IN	VARCHAR2		DEFAULT NULL
   ,p_date_probation_end	IN	DATE			DEFAULT NULL
   ,p_gl_account_no		IN	VARCHAR2		DEFAULT NULL
   ,p_employment_category	IN	VARCHAR2		DEFAULT NULL
   ,p_normal_work_freq		IN	VARCHAR2		DEFAULT NULL
   ,p_internal_address_line	IN	VARCHAR2		DEFAULT NULL
   ,p_manager_flag		IN	VARCHAR2		DEFAULT NULL
   ,p_normal_hours		IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period_frequency IN 	VARCHAR2		DEFAULT NULL
   ,p_term_accep_person		IN	VARCHAR2		DEFAULT NULL
   ,p_accepted_term_date	IN	DATE			DEFAULT NULL
   ,p_actual_term_date		IN	DATE			DEFAULT NULL
   ,p_final_payroll_proc_date	IN	DATE			DEFAULT NULL
   ,p_last_standard_proc_date	IN	DATE			DEFAULT NULL
   ,p_leaving_reason		IN	VARCHAR2		DEFAULT NULL
   ,p_notified_term_date	IN	DATE			DEFAULT NULL
   ,p_proj_term_date		IN	DATE			DEFAULT NULL
   ,p_probation_period		IN	VARCHAR2		DEFAULT NULL
   ,p_probation_unit		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_sal_revw_period_freq	IN	VARCHAR2		DEFAULT NULL
   ,p_set_of_books_name		IN	VARCHAR2		DEFAULT NULL
   ,p_assgn_source_type		IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_finish	IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_start	IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_title		IN	VARCHAR2		DEFAULT NULL
   ,o_assignment_no		OUT 	VARCHAR2
   ,o_assignment_id		OUT 	NUMBER
   ,o_soft_coding_keyflex_id	OUT 	NUMBER
   ,o_people_group_id 		OUT 	NUMBER
   ,o_object_version_number	OUT 	NUMBER
   ,o_effective_start_date	OUT 	DATE
   ,o_effective_end_date 	OUT 	DATE
   ,o_assignment_sequence	OUT 	NUMBER
   ,o_comment_id		OUT 	NUMBER
   ,o_concatenated_segments 	OUT 	VARCHAR2
   ,o_group_name 		OUT	VARCHAR2
   ,o_other_manager_warning 	OUT	VARCHAR2
   ,o_status			OUT 	VARCHAR2
   ,o_message			OUT 	VARCHAR2
   ,o_errmsg			OUT 	VARCHAR2
   );

procedure wm_emp_update_asg(
    p_assignment_id		IN 	NUMBER			DEFAULT NULL
   ,p_assignment_no		IN  	VARCHAR2
   ,p_person_id                 IN  	NUMBER
   ,p_datetrack_update_mode     IN  	VARCHAR2
   ,p_effective_start_date      IN  	DATE
   ,p_effective_end_date	IN	DATE			DEFAULT NULL
   ,p_business_group_name	IN	VARCHAR2
   ,p_recruiter_name		IN	VARCHAR2		DEFAULT NULL
   ,p_grade			IN	VARCHAR2		DEFAULT NULL
   ,p_position			IN	VARCHAR2		DEFAULT NULL
   ,p_job			IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_status		IN 	VARCHAR2
   ,p_payroll_name		IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_1	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_2	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_3	IN	VARCHAR2		DEFAULT NULL
   ,p_location_city		IN	VARCHAR2		DEFAULT NULL
   ,p_location_county		IN	VARCHAR2		DEFAULT NULL
   ,p_location_state		IN	VARCHAR2		DEFAULT NULL
   ,p_location_postal_code	IN	VARCHAR2		DEFAULT NULL
   ,p_location_country		IN	VARCHAR2		DEFAULT NULL
   ,p_person_referred_by	IN	VARCHAR2		DEFAULT NULL
   ,p_supervisor_name		IN	VARCHAR2		DEFAULT NULL
   ,p_progr_pt_name_no		IN	VARCHAR2		DEFAULT NULL
   ,p_recruitment_act_name	IN	VARCHAR2		DEFAULT NULL
   ,p_source_orgn_name		IN	VARCHAR2		DEFAULT NULL
   ,p_orgn_name			IN	VARCHAR2		
   ,p_group_name		IN	VARCHAR2		DEFAULT NULL
   ,p_vacancy_name		IN	VARCHAR2		DEFAULT NULL
   ,p_pay_basis			IN	VARCHAR2		DEFAULT NULL
   ,p_salary_approved_flag	IN	VARCHAR2		DEFAULT NULL
   ,p_rate_basis		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_uom		IN	VARCHAR2		DEFAULT NULL
   ,p_proposed_salary		IN	NUMBER			DEFAULT NULL
   ,p_assignment_type		IN	VARCHAR2		
   ,p_assignment_primary_flag	IN	VARCHAR2		
   ,p_current_employer		IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_chg_reason	IN	VARCHAR2		DEFAULT NULL
   ,p_comment			IN	VARCHAR2		DEFAULT NULL
   ,p_date_probation_end	IN	DATE			DEFAULT NULL
   ,p_gl_account_no		IN	VARCHAR2		DEFAULT NULL
   ,p_employment_category	IN	VARCHAR2		DEFAULT NULL
   ,p_normal_work_freq		IN	VARCHAR2		DEFAULT NULL
   ,p_internal_address_line	IN	VARCHAR2		DEFAULT NULL
   ,p_manager_flag		IN	VARCHAR2		DEFAULT NULL
   ,p_normal_hours		IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period_frequency IN 	VARCHAR2		DEFAULT NULL
   ,p_term_accep_person		IN	VARCHAR2		DEFAULT NULL
   ,p_accepted_term_date	IN	DATE			DEFAULT NULL
   ,p_actual_term_date		IN	DATE			DEFAULT NULL
   ,p_final_payroll_proc_date	IN	DATE			DEFAULT NULL
   ,p_last_standard_proc_date	IN	DATE			DEFAULT NULL
   ,p_leaving_reason		IN	VARCHAR2		DEFAULT NULL
   ,p_notified_term_date	IN	DATE			DEFAULT NULL
   ,p_proj_term_date		IN	DATE			DEFAULT NULL
   ,p_probation_period		IN	VARCHAR2		DEFAULT NULL
   ,p_probation_unit		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_sal_revw_period_freq	IN	VARCHAR2		DEFAULT NULL
   ,p_set_of_books_name		IN	VARCHAR2		DEFAULT NULL
   ,p_assgn_source_type		IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_finish	IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_start	IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_title		IN	VARCHAR2		DEFAULT NULL
   ,o_assignment_no		OUT 	VARCHAR2
   ,o_soft_coding_keyflex_id	OUT 	NUMBER
   ,o_comment_id		OUT 	NUMBER
   ,o_effective_start_date	OUT 	DATE
   ,o_effective_end_date	OUT 	DATE
   ,o_concatenated_segments	OUT 	VARCHAR2
   ,o_no_managers_warning	OUT	VARCHAR2
   ,o_other_manager_warning 	OUT	VARCHAR2
   ,o_status			OUT 	VARCHAR2
   ,o_message			OUT 	VARCHAR2
   ,o_errmsg			OUT 	VARCHAR2
  );

end ;
/	

SHOW ERRORS
	
create or replace package body wm_employee_asg_import_pkg  as

PROCEDURE wm_emp_create_asg(
    p_assignment_id		IN 	NUMBER			DEFAULT NULL
   ,p_assignment_no		IN  	VARCHAR2		DEFAULT NULL
   ,p_person_id                 IN  	NUMBER
   ,p_effective_start_date      IN  	DATE
   ,p_effective_end_date	IN	DATE			DEFAULT NULL
   ,p_business_group_name	IN	VARCHAR2
   ,p_recruiter_name		IN	VARCHAR2		DEFAULT NULL
   ,p_grade			IN	VARCHAR2		DEFAULT NULL
   ,p_position			IN	VARCHAR2		DEFAULT NULL
   ,p_job			IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_status		IN 	VARCHAR2
   ,p_payroll_name		IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_1	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_2	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_3	IN	VARCHAR2		DEFAULT NULL
   ,p_location_city		IN	VARCHAR2		DEFAULT NULL
   ,p_location_county		IN	VARCHAR2		DEFAULT NULL
   ,p_location_state		IN	VARCHAR2		DEFAULT NULL
   ,p_location_postal_code	IN	VARCHAR2		DEFAULT NULL
   ,p_location_country		IN	VARCHAR2		DEFAULT NULL
   ,p_person_referred_by	IN	VARCHAR2		DEFAULT NULL
   ,p_supervisor_name		IN	VARCHAR2		DEFAULT NULL
   ,p_progr_pt_name_no		IN	VARCHAR2		DEFAULT NULL
   ,p_recruitment_act_name	IN	VARCHAR2		DEFAULT NULL
   ,p_source_orgn_name		IN	VARCHAR2		DEFAULT NULL
   ,p_orgn_name			IN	VARCHAR2		
   ,p_group_name		IN	VARCHAR2		DEFAULT NULL
   ,p_vacancy_name		IN	VARCHAR2		DEFAULT NULL
   ,p_pay_basis			IN	VARCHAR2		DEFAULT NULL
   ,p_salary_approved_flag	IN	VARCHAR2		DEFAULT NULL
   ,p_rate_basis		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_uom		IN	VARCHAR2		DEFAULT NULL
   ,p_proposed_salary		IN	NUMBER			DEFAULT NULL
   ,p_assignment_type		IN	VARCHAR2		
   ,p_assignment_primary_flag	IN	VARCHAR2		
   ,p_current_employer		IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_chg_reason	IN	VARCHAR2		DEFAULT NULL
   ,p_comment			IN	VARCHAR2		DEFAULT NULL
   ,p_date_probation_end	IN	DATE			DEFAULT NULL
   ,p_gl_account_no		IN	VARCHAR2		DEFAULT NULL
   ,p_employment_category	IN	VARCHAR2		DEFAULT NULL
   ,p_normal_work_freq		IN	VARCHAR2		DEFAULT NULL
   ,p_internal_address_line	IN	VARCHAR2		DEFAULT NULL
   ,p_manager_flag		IN	VARCHAR2		DEFAULT NULL
   ,p_normal_hours		IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period_frequency IN 	VARCHAR2		DEFAULT NULL
   ,p_term_accep_person		IN	VARCHAR2		DEFAULT NULL
   ,p_accepted_term_date	IN	DATE			DEFAULT NULL
   ,p_actual_term_date		IN	DATE			DEFAULT NULL
   ,p_final_payroll_proc_date	IN	DATE			DEFAULT NULL
   ,p_last_standard_proc_date	IN	DATE			DEFAULT NULL
   ,p_leaving_reason		IN	VARCHAR2		DEFAULT NULL
   ,p_notified_term_date	IN	DATE			DEFAULT NULL
   ,p_proj_term_date		IN	DATE			DEFAULT NULL
   ,p_probation_period		IN	VARCHAR2		DEFAULT NULL
   ,p_probation_unit		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_sal_revw_period_freq	IN	VARCHAR2		DEFAULT NULL
   ,p_set_of_books_name		IN	VARCHAR2		DEFAULT NULL
   ,p_assgn_source_type		IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_finish	IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_start	IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_title		IN	VARCHAR2		DEFAULT NULL
   ,o_assignment_no		OUT 	VARCHAR2
   ,o_assignment_id		OUT 	NUMBER
   ,o_soft_coding_keyflex_id	OUT 	NUMBER
   ,o_people_group_id 		OUT 	NUMBER
   ,o_object_version_number	OUT 	NUMBER
   ,o_effective_start_date	OUT 	DATE
   ,o_effective_end_date 	OUT 	DATE
   ,o_assignment_sequence	OUT 	NUMBER
   ,o_comment_id		OUT 	NUMBER
   ,o_concatenated_segments 	OUT 	VARCHAR2
   ,o_group_name 		OUT	VARCHAR2
   ,o_other_manager_warning 	OUT	VARCHAR2
   ,o_status			OUT 	VARCHAR2
   ,o_message			OUT 	VARCHAR2
   ,o_errmsg			OUT 	VARCHAR2
   )
	
IS
		--- Declare variables
		v_set_of_books_id		NUMBER DEFAULT NULL;
		v_supervisor_id 		NUMBER DEFAULT NULL;
		v_organization_id		NUMBER DEFAULT NULL;
		v_grade_id			NUMBER DEFAULT NULL;
		v_position_id 			NUMBER DEFAULT NULL;
		v_job_id			NUMBER DEFAULT NULL;
		v_assignment_status_type_id	NUMBER DEFAULT NULL; 
		v_payroll_id			NUMBER DEFAULT NULL;
		v_location_id 			NUMBER DEFAULT NULL;
		v_pay_basis_id			NUMBER DEFAULT NULL;
		v_code_combination_id		NUMBER DEFAULT NULL;
		v_business_group_id		NUMBER DEFAULT NULL;
		v_other_manager_warning   	BOOLEAN ;
		v_errmsg			VARCHAR2(2000);
		v_assignment_no			VARCHAR2(2000);
		v_assignment_id			NUMBER;
		v_soft_coding_keyflex_id	NUMBER DEFAULT NULL;
		v_people_group_id		NUMBER DEFAULT NULL;
		v_object_version_number		NUMBER;
		v_effective_start_date		DATE;
		v_effective_end_date		DATE;
		v_assignment_sequence		NUMBER DEFAULT NULL;
		v_comment_id			NUMBER DEFAULT NULL;
		v_concatenated_segments		VARCHAR2(2000) DEFAULT NULL;
		v_group_name			VARCHAR2(2000) DEFAULT NULL;

BEGIN

	--Fetch set_of_books_id
	v_errmsg := 'Error in fetching set_of_books_id';
	
	IF p_set_of_books_name	IS NOT NULL THEN
	    	SELECT set_of_books_id 
	    	INTO v_set_of_books_id 
	    	FROM gl_sets_of_books 
	    	WHERE name = p_set_of_books_name;	
	END IF;

	---Fetch supervisor_id
	v_errmsg := 'Error in fetching supervisor_id';
	
	IF p_supervisor_name IS NOT NULL THEN
		SELECT DISTINCT(person_id)
	    	INTO v_supervisor_id 
	    	FROM per_all_people_f 
	    	WHERE full_name = p_supervisor_name;	
	END IF;
     
	---Fetch organization_id
	v_errmsg := 'Error in fetching organisation_id';
	
	IF p_orgn_name IS NOT NULL THEN
		SELECT organization_id 
	    	INTO v_organization_id 
	    	FROM hr_all_organization_units 
	    	WHERE name = p_orgn_name;	
	END IF;	

	
	---Fetch grade_id
	v_errmsg := 'Error in fetching grade_id';
	
	IF p_grade IS NOT NULL THEN
		SELECT grade_id
	    	INTO v_grade_id 
	    	FROM per_grades 
	    	WHERE name = p_grade;	
	END IF;	
	
	
	---Fetch position_id
	v_errmsg := 'Error in fetching position_id';
	
	IF p_position IS NOT NULL THEN
		SELECT position_id
	    	INTO v_position_id 
	    	FROM per_all_positions 
	    	WHERE name = p_position;	
	END IF;	
		
		
		
	---Fetch job_id
	v_errmsg := 'Error in fetching job_id';
	
	IF p_job IS NOT NULL THEN
		SELECT job_id
	    	INTO v_job_id 
	    	FROM per_jobs 
	    	WHERE name = p_job;	
	END IF;	
	
	
	---Fetch business_group_id
	v_errmsg := 'Error in fetching business_group_id';
	
	SELECT 	business_group_id
    	INTO 	v_business_group_id
    	FROM 	per_business_groups_perf 
    	WHERE 	name = p_business_group_name;	
		

	---Fetch assignment_status_type_id
	v_errmsg := 'Error in fetching assignment_status_type_id';
	
	SELECT assignment_status_type_id 
	INTO v_assignment_status_type_id 
	FROM per_assignment_status_types 
	WHERE per_system_status = p_assignment_status
	AND default_flag = 'Y';
	
	
	---Transformer for payroll_id
	v_errmsg := 'Error in fetching payroll_id';
	
	IF p_payroll_name IS NOT NULL THEN
		SELECT payroll_id
	    	INTO v_payroll_id 
	    	FROM pay_all_payrolls_f 
	    	WHERE payroll_name = p_payroll_name;	
	END IF;	
	
	
	---Transformer for location_id
	v_errmsg := 'Error in fetching location_id';
	
	IF p_location_address_line_1 IS NOT NULL THEN
		SELECT LOCATION_ID 
		INTO v_location_id
		FROM HR_LOCATIONS 
		WHERE UPPER(NVL(ADDRESS_LINE_1,'XXXX')) LIKE UPPER( NVL(p_location_address_line_1,'XXXX')) AND 
		UPPER(NVL(ADDRESS_LINE_2,'XXXX')) LIKE UPPER( NVL(p_location_address_line_2,'XXXX')) AND 
		UPPER(NVL(ADDRESS_LINE_3,'XXXX')) LIKE UPPER( NVL(p_location_address_line_3,'XXXX')) AND 
		UPPER(NVL(TOWN_OR_CITY,'XXXX')) LIKE UPPER( NVL(p_location_city,'XXXX')) AND 
		UPPER(NVL(COUNTRY,'XXXX')) LIKE UPPER(NVL(p_location_country,'XXXX')) AND 
		UPPER(NVL(POSTAL_CODE,'XXXX')) LIKE UPPER(NVL(p_location_postal_code,'XXXX')) AND 
		UPPER(NVL(REGION_1,'XXXX')) LIKE UPPER(NVL(p_location_county,'XXXX')) AND 
		UPPER(NVL(REGION_2,'XXXX')) LIKE UPPER(NVL(p_location_state,'XXXX')) 
		AND rownum = 1;
	END IF;	
	
	
	---Transformer for pay_basis_id
	v_errmsg := 'Error in fetching pay_basis_id';
	
	IF p_pay_basis	IS NOT NULL THEN
		SELECT pay_basis_id
	    	INTO v_pay_basis_id 
	    	FROM per_pay_bases 
	    	WHERE name = p_pay_basis;	
	END IF;	
	
	
	---Transformer for default_code_combination_id
	v_errmsg := 'Error in fetching default_code_combination_id';
	
	IF p_gl_account_no IS NOT NULL THEN
		SELECT gl_code_combinations_kfv.code_combination_id
	    	INTO v_code_combination_id 
	    	FROM gl_code_combinations_kfv,  gl_sets_of_books
	    	WHERE concatenated_segments = p_gl_account_no
		AND gl_sets_of_books.set_of_books_id = v_set_of_books_id;	
	END IF;	
	 

	BEGIN

	--Call orapps api
	
	HR_ASSIGNMENT_API.create_secondary_emp_asg
		(p_effective_date               =>     	p_effective_start_date 
	       ,p_person_id                    =>     	p_person_id 
	       ,p_organization_id              =>     	v_organization_id
	       ,p_grade_id                     =>     	v_grade_id
	       ,p_position_id                  =>     	v_position_id
	       ,p_job_id                       =>     	v_job_id
	       ,p_assignment_status_type_id    =>     	v_assignment_status_type_id
	       ,p_payroll_id                   =>    	v_payroll_id
	       ,p_location_id                  =>     	v_location_id
	       ,p_supervisor_id                =>     	v_supervisor_id
	       ,p_pay_basis_id                 =>    	v_pay_basis_id
	       ,p_assignment_number            =>	v_assignment_no 
	       ,p_change_reason                =>    	p_assignment_chg_reason
	       ,p_comments                     =>     	p_comment
	       ,p_date_probation_end           =>    	p_date_probation_end
	       ,p_default_code_comb_id         =>    	v_code_combination_id 
	       ,p_employment_category          =>    	p_employment_category
	       ,p_frequency                    =>    	p_normal_work_freq 
	       ,p_internal_address_line        =>    	p_internal_address_line
	       ,p_manager_flag                 =>    	p_manager_flag  
	       ,p_normal_hours                 =>    	p_normal_hours
	       ,p_perf_review_period           =>   	p_perf_review_period 
	       ,p_perf_review_period_frequency =>    	p_perf_review_period_frequency
	       ,p_probation_period             =>    	p_probation_period
	       ,p_probation_unit               =>     	p_probation_unit
	       ,p_sal_review_period            =>    	p_salary_review_period  
	       ,p_sal_review_period_frequency  =>    	p_sal_revw_period_freq	
	       ,p_set_of_books_id              =>    	v_set_of_books_id  
	       ,p_source_type                  =>     	p_assgn_source_type
	       ,p_time_normal_finish           =>    	p_work_time_normal_finish
	       ,p_time_normal_start            =>    	p_work_time_normal_start
	       ,p_title 		       =>	p_assignment_title
	       ,p_assignment_id                => 	v_assignment_id
	       ,p_soft_coding_keyflex_id       => 	v_soft_coding_keyflex_id
	       ,p_people_group_id              => 	v_people_group_id 
	       ,p_object_version_number        => 	v_object_version_number
	       ,p_effective_start_date         => 	v_effective_start_date
	       ,p_effective_end_date           => 	v_effective_end_date 
	       ,p_assignment_sequence          => 	v_assignment_sequence
	       ,p_comment_id                   => 	v_comment_id
	       ,p_concatenated_segments        => 	v_concatenated_segments 
	       ,p_group_name                   => 	v_group_name 
	       ,p_other_manager_warning        => 	v_other_manager_warning  
	);


	EXCEPTION
	
		WHEN OTHERS THEN
		o_message := SQLERRM;
		o_status := 'FAILED';
		ROLLBACK;
		RETURN;

	END;

		o_assignment_no 		:= v_assignment_no;
		o_assignment_id 		:= v_assignment_id;
		o_soft_coding_keyflex_id 	:= v_soft_coding_keyflex_id;
		o_people_group_id 		:= v_people_group_id;
		o_object_version_number 	:= v_object_version_number;
		o_effective_start_date 		:= v_effective_start_date;
		o_effective_end_date 		:= v_effective_end_date;
		o_assignment_sequence 		:= v_assignment_sequence;
		o_comment_id 			:= v_comment_id;
		o_concatenated_segments 	:= v_concatenated_segments;
		o_group_name 			:= v_group_name;

		IF v_other_manager_warning   = TRUE THEN
			o_other_manager_warning := 'TRUE';
		ELSE
			o_other_manager_warning := 'FALSE';
		END IF;
--COMMIT;
o_message := 'Normal Completion';
o_status := 'OK';

EXCEPTION

	WHEN OTHERS THEN 
	o_errmsg := v_errmsg || ' :- ' || SQLERRM;
	o_status := 'FAILED';
	ROLLBACK;
	
END wm_emp_create_asg;


-----------------------------------------------------  Procedure to update an assignment ________________________________________ 
procedure wm_emp_update_asg(
    p_assignment_id		IN 	NUMBER			DEFAULT NULL
   ,p_assignment_no		IN  	VARCHAR2
   ,p_person_id                 IN  	NUMBER
   ,p_datetrack_update_mode     IN  	VARCHAR2
   ,p_effective_start_date      IN  	DATE
   ,p_effective_end_date	IN	DATE			DEFAULT NULL
   ,p_business_group_name	IN	VARCHAR2
   ,p_recruiter_name		IN	VARCHAR2		DEFAULT NULL
   ,p_grade			IN	VARCHAR2		DEFAULT NULL
   ,p_position			IN	VARCHAR2		DEFAULT NULL
   ,p_job			IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_status		IN 	VARCHAR2
   ,p_payroll_name		IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_1	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_2	IN	VARCHAR2		DEFAULT NULL
   ,p_location_address_line_3	IN	VARCHAR2		DEFAULT NULL
   ,p_location_city		IN	VARCHAR2		DEFAULT NULL
   ,p_location_county		IN	VARCHAR2		DEFAULT NULL
   ,p_location_state		IN	VARCHAR2		DEFAULT NULL
   ,p_location_postal_code	IN	VARCHAR2		DEFAULT NULL
   ,p_location_country		IN	VARCHAR2		DEFAULT NULL
   ,p_person_referred_by	IN	VARCHAR2		DEFAULT NULL
   ,p_supervisor_name		IN	VARCHAR2		DEFAULT NULL
   ,p_progr_pt_name_no		IN	VARCHAR2		DEFAULT NULL
   ,p_recruitment_act_name	IN	VARCHAR2		DEFAULT NULL
   ,p_source_orgn_name		IN	VARCHAR2		DEFAULT NULL
   ,p_orgn_name			IN	VARCHAR2		
   ,p_group_name		IN	VARCHAR2		DEFAULT NULL
   ,p_vacancy_name		IN	VARCHAR2		DEFAULT NULL
   ,p_pay_basis			IN	VARCHAR2		DEFAULT NULL
   ,p_salary_approved_flag	IN	VARCHAR2		DEFAULT NULL
   ,p_rate_basis		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_uom		IN	VARCHAR2		DEFAULT NULL
   ,p_proposed_salary		IN	NUMBER			DEFAULT NULL
   ,p_assignment_type		IN	VARCHAR2		
   ,p_assignment_primary_flag	IN	VARCHAR2		
   ,p_current_employer		IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_chg_reason	IN	VARCHAR2		DEFAULT NULL
   ,p_comment			IN	VARCHAR2		DEFAULT NULL
   ,p_date_probation_end	IN	DATE			DEFAULT NULL
   ,p_gl_account_no		IN	VARCHAR2		DEFAULT NULL
   ,p_employment_category	IN	VARCHAR2		DEFAULT NULL
   ,p_normal_work_freq		IN	VARCHAR2		DEFAULT NULL
   ,p_internal_address_line	IN	VARCHAR2		DEFAULT NULL
   ,p_manager_flag		IN	VARCHAR2		DEFAULT NULL
   ,p_normal_hours		IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_perf_review_period_frequency IN 	VARCHAR2		DEFAULT NULL
   ,p_term_accep_person		IN	VARCHAR2		DEFAULT NULL
   ,p_accepted_term_date	IN	DATE			DEFAULT NULL
   ,p_actual_term_date		IN	DATE			DEFAULT NULL
   ,p_final_payroll_proc_date	IN	DATE			DEFAULT NULL
   ,p_last_standard_proc_date	IN	DATE			DEFAULT NULL
   ,p_leaving_reason		IN	VARCHAR2		DEFAULT NULL
   ,p_notified_term_date	IN	DATE			DEFAULT NULL
   ,p_proj_term_date		IN	DATE			DEFAULT NULL
   ,p_probation_period		IN	VARCHAR2		DEFAULT NULL
   ,p_probation_unit		IN	VARCHAR2		DEFAULT NULL
   ,p_salary_review_period	IN	VARCHAR2		DEFAULT NULL
   ,p_sal_revw_period_freq	IN	VARCHAR2		DEFAULT NULL
   ,p_set_of_books_name		IN	VARCHAR2		DEFAULT NULL
   ,p_assgn_source_type		IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_finish	IN	VARCHAR2		DEFAULT NULL
   ,p_work_time_normal_start	IN	VARCHAR2		DEFAULT NULL
   ,p_assignment_title		IN	VARCHAR2		DEFAULT NULL
   ,o_assignment_no		OUT 	VARCHAR2
   ,o_soft_coding_keyflex_id	OUT 	NUMBER
   ,o_comment_id		OUT 	NUMBER
   ,o_effective_start_date	OUT 	DATE
   ,o_effective_end_date	OUT 	DATE
   ,o_concatenated_segments	OUT 	VARCHAR2
   ,o_no_managers_warning	OUT	VARCHAR2
   ,o_other_manager_warning 	OUT	VARCHAR2
   ,o_status			OUT 	VARCHAR2
   ,o_message			OUT 	VARCHAR2
   ,o_errmsg			OUT 	VARCHAR2
  )

IS
		--- Declare variables
		
		v_set_of_books_id  		NUMBER DEFAULT NULL;
		v_supervisor_id    		NUMBER DEFAULT NULL;	
		v_code_combination_id  		NUMBER DEFAULT NULL;
		v_business_group_id    		NUMBER DEFAULT NULL;
		v_object_version_number      	NUMBER DEFAULT NULL;
		v_organization_id  		NUMBER DEFAULT NULL;
		v_no_managers_warning		BOOLEAN;
   		v_other_manager_warning 	BOOLEAN;
		v_assignment_id			NUMBER DEFAULT NULL;
		vp_assignment_id		NUMBER DEFAULT NULL;	
		v_errmsg			VARCHAR2(2000) := NULL;
		v_assignment_no			VARCHAR2(2000);
		v_soft_coding_keyflex_id	NUMBER DEFAULT NULL;
		v_comment_id			NUMBER DEFAULT NULL;
		v_effective_start_date		DATE;
		v_effective_end_date		DATE;
		v_concatenated_segments		VARCHAR2(2000) DEFAULT NULL;

BEGIN
	
	--Fetch set_of_books_id
	v_errmsg := 'Error in fetching set_of_books_id';
	
	IF p_set_of_books_name	IS NOT NULL THEN
	    	SELECT set_of_books_id 
	    	INTO v_set_of_books_id 
	    	FROM gl_sets_of_books 
	    	WHERE name = p_set_of_books_name;	
	END IF;

	---Fetch supervisor_id
	v_errmsg := 'Error in fetching supervisor_id';
	
	IF p_supervisor_name IS NOT NULL THEN
		SELECT DISTINCT(person_id)
	    	INTO v_supervisor_id 
	    	FROM per_all_people_f 
	    	WHERE full_name = p_supervisor_name;	
	END IF;
     
		
	
	---Fetch default_code_combination_id
	v_errmsg := 'Error in fetching default_code_combination_id';
	
	IF p_gl_account_no IS NOT NULL THEN
		SELECT gl_code_combinations_kfv.code_combination_id
	    	INTO v_code_combination_id 
	    	FROM gl_code_combinations_kfv,  gl_sets_of_books
	    	WHERE concatenated_segments = p_gl_account_no
		AND gl_sets_of_books.set_of_books_id = v_set_of_books_id;	
	END IF;	
	 

	---Fetch business_group_id
	v_errmsg := 'Error in fetching business_group_id';
	
	SELECT 	business_group_id
   	INTO 	v_business_group_id
   	FROM 	per_business_groups_perf 
   	WHERE 	name = p_business_group_name;	
		

	---Fetch organization_id
	v_errmsg := 'Error in fetching organization_id';
	
	IF p_orgn_name IS NOT NULL THEN
		SELECT organization_id 
	    	INTO v_organization_id 
	    	FROM hr_all_organization_units 
	    	WHERE name = p_orgn_name;	
	END IF;	
	
	--Fetch Assignment Id
	v_errmsg := 'Error in fetching Assignment ID';

	IF p_assignment_id IS NULL THEN

		IF UPPER(p_datetrack_update_mode) = 'CORRECTION' THEN
			SELECT assignment_id
			INTO v_assignment_id
			FROM per_all_assignments_f
		    	WHERE person_id = p_person_id
	    		AND business_group_id = v_business_group_id
		    	AND organization_id = v_organization_id 
		    	AND assignment_number = p_assignment_no
		    	AND effective_start_date = p_effective_start_date;
		ELSE
			SELECT assignment_id
			INTO v_assignment_id
			FROM per_all_assignments_f
		    	WHERE person_id = p_person_id
	    		AND business_group_id = v_business_group_id
		    	AND organization_id = v_organization_id 
		    	AND assignment_number = p_assignment_no
			AND p_effective_start_date BETWEEN TRUNC(effective_start_date) AND TRUNC(effective_end_date);
		END IF;		

		vp_assignment_id := v_assignment_id;
		
	ELSE
		vp_assignment_id := p_assignment_id;
    	END IF;		
	
	---Fetch Object Version Number
	v_errmsg := 'Error in fetching object_version_number ';

	IF UPPER(p_datetrack_update_mode) = 'CORRECTION' THEN
		SELECT object_version_number 
		INTO v_object_version_number
		FROM per_all_assignments_f 
		WHERE person_id = p_person_id
		AND business_group_id = v_business_group_id
		AND organization_id = v_organization_id 
		AND assignment_id = vp_assignment_id
		AND effective_start_date = p_effective_start_date;
	ELSE
		SELECT object_version_number 
		INTO v_object_version_number
		FROM per_all_assignments_f 
		WHERE person_id = p_person_id
		AND business_group_id = v_business_group_id
		AND organization_id = v_organization_id 
		AND assignment_id = vp_assignment_id
		AND p_effective_start_date BETWEEN TRUNC(effective_start_date) AND TRUNC(effective_end_date);
	END IF;

		
	BEGIN	
	--Call orapps api
	
	HR_ASSIGNMENT_API.update_emp_asg
		(p_effective_date               =>     p_effective_start_date 
  		,p_datetrack_update_mode        =>     p_datetrack_update_mode  
  		,p_assignment_id                =>     vp_assignment_id
  		,p_object_version_number        =>     v_object_version_number
  		,p_supervisor_id                =>     v_supervisor_id 
  		,p_assignment_number            =>     v_assignment_no
  		,p_change_reason                =>     p_assignment_chg_reason
  		,p_comments                     =>     p_comment
  		,p_date_probation_end           =>     p_date_probation_end
  		,p_default_code_comb_id         =>     v_code_combination_id
  		,p_frequency                    =>     p_normal_work_freq 
  		,p_internal_address_line        =>     p_internal_address_line
  		,p_manager_flag                 =>     p_manager_flag
  		,p_normal_hours                 =>     p_normal_hours
  		,p_perf_review_period           =>     p_perf_review_period 
  		,p_perf_review_period_frequency =>     p_perf_review_period_frequency
  		,p_probation_period             =>     p_probation_period
  		,p_probation_unit               =>     p_probation_unit 
  		,p_sal_review_period            =>     p_salary_review_period
  		,p_sal_review_period_frequency  =>     p_sal_revw_period_freq	
  		,p_set_of_books_id              =>     v_set_of_books_id
  		,p_source_type                  =>     p_assgn_source_type
  		,p_time_normal_finish           =>     p_work_time_normal_finish
  		,p_time_normal_start            =>     p_work_time_normal_start
		,p_title			=>     p_assignment_title
  		,p_soft_coding_keyflex_id       =>     v_soft_coding_keyflex_id
  		,p_comment_id                   =>     v_comment_id
  		,p_effective_start_date         =>     v_effective_start_date
  		,p_effective_end_date           =>     v_effective_end_date
  		,p_concatenated_segments        =>     v_concatenated_segments
  		,p_no_managers_warning          =>     v_no_managers_warning
  		,p_other_manager_warning        =>     v_other_manager_warning 
		);	


		
	EXCEPTION

		WHEN OTHERS THEN
		o_message := SQLERRM;
		o_status := 'FAILED';
		ROLLBACK;
		RETURN;
	END;

		o_assignment_no 		:= v_assignment_no;
		o_soft_coding_keyflex_id 	:= v_soft_coding_keyflex_id;
		o_comment_id 			:= v_comment_id;
		o_effective_start_date 		:= v_effective_start_date;
		o_effective_end_date 		:= v_effective_end_date;
		o_concatenated_segments 	:= v_concatenated_segments;

		IF v_no_managers_warning = TRUE THEN
			o_no_managers_warning := 'TRUE';
		ELSE
			o_no_managers_warning := 'FALSE';
		END IF;
		
		IF v_other_manager_warning  = TRUE THEN
			o_otHER_MANAGER_WARNING  := 'TRUE';
		ELSE
			o_other_manager_warning := 'FALSE';
		END IF;

--COMMIT;
o_message := 'Normal Completion';
o_status := 'OK';

EXCEPTION
	
	WHEN OTHERS THEN 
	o_errmsg := v_errmsg || ' :- ' || SQLERRM;
	o_status := 'FAILED';
	ROLLBACK;

END wm_emp_update_asg;

END wm_employee_asg_import_pkg;
/

SHOW ERRORS
		  
		  
	