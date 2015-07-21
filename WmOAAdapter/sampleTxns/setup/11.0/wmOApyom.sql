REM =============================   Release 11  ======================================
REM =============================   Payments =========================================
REM =============================   Payments =========================================
REM =============================   Payments =========================================

CREATE OR REPLACE VIEW WM_PYO_PAYMENT_V
AS           
SELECT
      asic.org_id,                                                        
     'PYO'				document_id,                                                                          
     asic.check_number			document_code,                                                                                       
     sysdate				TRANSACTION_DATE,                                                                                                                
     pvs.EDI_transaction_handling	transaction_handling_code,                                        
     asic.check_amount			check_amount,                                                               
     asic.currency_code			currency_code,                                                             
     pvs.edi_payment_method		edi_payment_method,                                                    
     pvs.edi_payment_format		edi_payment_format,                                                    
     abb.bank_branch_type		bank_branch_type,                                                        
     aba.account_type			bank_account_type,                                                          
     aba.bank_account_num		bank_account_num,                                                        
     abb.edi_id_number			bank_edi_id_number,                     
     pvs.bank_branch_type		vendor_bank_branch_type,                                                 
     asic.bank_account_type		vendor_bank_account_type,                                              
     asic.bank_account_num		vendor_bank_account_num,                                                
     asic.payment_date			payment_date,                                                              
     abb.bank_num			bank_num,                                                                       
     asic.bank_num			vendor_bank_num,                                                               
     pvs.edi_remittance_method		edi_remittance_method,                                              
     pvs.edi_remittance_instruction	edi_remittance_instruction,                                     
     asic.checkrun_name			checkrun_name,                                                             
     asic.check_voucher_num		check_voucher_num,                                                     
     asic.selected_check_id		selected_check_id,                                                     
     asic.check_number			check_number,                                                               
     asic.customer_num			customer_num,                                                               
     pv.segment1			segment1,                                                                        
     pvs.edi_id_number			vendor_edi_id_number,                                                      
     pv.segment2			segment2,                                                                        
     pv.segment3			segment3,                                                                        
     pv.segment4			segment4,                                                                        
     pv.segment5			segment5,                                                                        
     abb.bank_branch_id			bank_branch_id,                                                            
     abb.address_line1			bk_address_line1,                    
     abb.address_line2			bk_address_line2,                                                          
     abb.address_line3			bk_address_line3,                                                          
     abb.city				bk_city,                                                                           
     abb.zip				bk_zip,                                                                             
     abb.country			bk_country,                                                                      
     abb.state				bk_state,                                                                         
     abb.province			bk_province,                                                                    
     abb.contact_first_name		bk_contact_first_name,                                                 
     abb.contact_middle_name		bk_contact_middle_name,                                               
     abb.contact_last_name		bk_contact_last_name,                                                   
     abb.contact_title			bk_contact_title,                                                          
     abb.contact_prefix			bk_contact_prefix,                                                        
     abb.area_code			bk_contact_area_code,                                                           
     abb.phone				bk_contact_phone,                                                                  
     asic.vendor_site_code		vendor_site_code,                                                       
     asic.vendor_name			vendor_name,                                                                
     asic.address_line1			address_line1,                                                            
     asic.address_line2			address_line2,                                                            
     asic.address_line3			address_line3,                                                            
     asic.city				city,                                                                             
     asic.zip				zip,                 
     asic.country			country,                                                                        
     asic.state				state,                                                                            
     asic.province			province                                                                       
 from                                                                                               
 	ap_selected_invoice_checks_all		asic,                                                                 
 	ap_bank_branches			abb,                                                                           
 	po_vendor_sites_all			pvs,                                                                            
 	ap_bank_accounts_all			aba,                                                                           
 	po_vendors				pv,                                                                                  
 	ap_inv_selection_criteria_all		aisc                                                                                                                            
 where	pvs.vendor_site_id = asic.vendor_site_id                                                     
 and 	aisc.checkrun_name = asic.checkrun_name                                                       
 and	aba.bank_account_name = aisc.bank_account_name                                                 
 and	abb.bank_branch_id = aba.bank_branch_id                                                        
 and	pv.vendor_id = asic.vendor_id                                                                  
 and	asic.ok_to_pay_flag = 'Y'                                                                      
 and	nvl(asic.status_lookup_code, 'N') != 'UNCONFIRMED SET UP'                                      
 and	nvl(asic.void_flag, 'N')  != 'Y' 
 and    asic.org_id = aba.org_id
 and    asic.org_id = pvs.org_id 
 and    asic.org_id = aisc.org_id     
;                  
REM =============================   Payment - Invoices ===============================
REM =============================   Payment - Invoices ===============================
REM =============================   Payment - Invoices ===============================

CREATE OR REPLACE VIEW WM_PYO_INVOICE_V
AS                 
SELECT 
asi.checkrun_name checkrun_name, 
asi.pay_selected_check_id pay_selected_check_id, 
asi.vendor_num vendor_num, 
asi.customer_num customer_num, 
asi.invoice_num invoice_num, 
asi.invoice_date invoice_date, 
asi.invoice_description invoice_description, 
asi.proposed_payment_amount proposed_payment_amount, 
asi.invoice_amount invoice_amount, 
asi.discount_amount discount_amount, 
asi.print_selected_check_id print_selected_check_id, 
asi.attribute_category attribute_category, 
asi.attribute1 attribute1, 
asi.attribute2 attribute2, 
asi.attribute3 attribute3, 
asi.attribute4 attribute4, 
asi.attribute5 attribute5, 
asi.attribute6 attribute6, 
asi.attribute7 attribute7, 
asi.attribute8 attribute8, 
asi.attribute9 attribute9, 
asi.attribute10 attribute10, 
asi.attribute11 attribute11, 
asi.attribute12 attribute12, 
asi.attribute13 attribute13, 
asi.attribute14 attribute14, 
asi.attribute15 attribute15 
from ap_selected_invoices_all asi
;                                      