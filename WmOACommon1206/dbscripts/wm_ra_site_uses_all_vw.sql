/*  ***************************************************************************
        $Date:   09 Apr 2009 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2009, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create custom views common for the transactions of all packages
    * Program Name:         ra_site_uses_all_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 6.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         Create custom views common for the transactions of all packages.      
    *
    *           
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
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
     09-APR-09	Telagareddy Sriram Mohan   Created
    ***************************************************************************
*/
set feedback  on
set verify            off
set newpage   0
set pause             off
set termout   on

prompt Program : ra_site_uses_all_vw.sql 

connect &&apps_user/&&appspwd@&&DBString 

REM "Creating View WM_RA_SITE_USES_ALL_VW"

CREATE OR REPLACE VIEW APPS.WM_RA_SITE_USES_ALL_VW
(
SITE_USE_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY,
CREATION_DATE, 
CREATED_BY,
SITE_USE_CODE,
ADDRESS_ID,  
PRIMARY_FLAG,
STATUS,
LOCATION,
LAST_UPDATE_LOGIN,
CONTACT_ID,
BILL_TO_SITE_USE_ID,
ORIG_SYSTEM_REFERENCE,
SIC_CODE,
PAYMENT_TERM_ID ,
GSA_INDICATOR  ,
SHIP_PARTIAL  ,
SHIP_VIA ,
FOB_POINT,
ORDER_TYPE_ID,
PRICE_LIST_ID,
FREIGHT_TERM ,
WAREHOUSE_ID,
TERRITORY_ID,
ATTRIBUTE_CATEGORY,
ATTRIBUTE1,
ATTRIBUTE2,
ATTRIBUTE3,
ATTRIBUTE4,
ATTRIBUTE5,
ATTRIBUTE6,
ATTRIBUTE7,
ATTRIBUTE8,
ATTRIBUTE9,
ATTRIBUTE10,
REQUEST_ID,
PROGRAM_APPLICATION_ID,
PROGRAM_ID,
PROGRAM_UPDATE_DATE,
TAX_REFERENCE,
SORT_PRIORITY,
TAX_CODE,
ATTRIBUTE11,
ATTRIBUTE12,
ATTRIBUTE13,
ATTRIBUTE14,
ATTRIBUTE15,
ATTRIBUTE16,
ATTRIBUTE17,
ATTRIBUTE18,
ATTRIBUTE19,
ATTRIBUTE20,
ATTRIBUTE21,
ATTRIBUTE22,
ATTRIBUTE23,
ATTRIBUTE24,
ATTRIBUTE25,
LAST_ACCRUE_CHARGE_DATE,
SECOND_LAST_ACCRUE_CHARGE_DATE,
LAST_UNACCRUE_CHARGE_DATE,
SECOND_LAST_UNACCRUE_CHRG_DATE,
DEMAND_CLASS_CODE,
TAX_EXEMPT ,   
TAX_EXEMPT_NUM,
TAX_EXEMPT_REASON_CODE ,
ORG_ID,
TAX_CLASSIFICATION, 
TAX_HEADER_LEVEL_FLAG,
TAX_ROUNDING_RULE,
WH_UPDATE_DATE  ,
GLOBAL_ATTRIBUTE1,
GLOBAL_ATTRIBUTE2,
GLOBAL_ATTRIBUTE3,
GLOBAL_ATTRIBUTE4,
GLOBAL_ATTRIBUTE5,
GLOBAL_ATTRIBUTE6,
GLOBAL_ATTRIBUTE7,
GLOBAL_ATTRIBUTE8,
GLOBAL_ATTRIBUTE9,
GLOBAL_ATTRIBUTE10,
GLOBAL_ATTRIBUTE11,
GLOBAL_ATTRIBUTE12,
GLOBAL_ATTRIBUTE13,
GLOBAL_ATTRIBUTE14,
GLOBAL_ATTRIBUTE15,
GLOBAL_ATTRIBUTE16,
GLOBAL_ATTRIBUTE17,
GLOBAL_ATTRIBUTE18 ,                              
GLOBAL_ATTRIBUTE19  ,                            
GLOBAL_ATTRIBUTE20   ,                         
GLOBAL_ATTRIBUTE_CATEGORY,
PRIMARY_SALESREP_ID,
FINCHRG_RECEIVABLES_TRX_ID,
GL_ID_REC,
GL_ID_REV,
GL_ID_TAX,
GL_ID_FREIGHT,
GL_ID_CLEARING,
GL_ID_UNBILLED,
GL_ID_UNEARNED,
GL_ID_UNPAID_REC,
GL_ID_REMITTANCE,
GL_ID_FACTOR,
DATES_NEGATIVE_TOLERANCE,
DATES_POSITIVE_TOLERANCE,
DATE_TYPE_PREFERENCE,
OVER_SHIPMENT_TOLERANCE ,
UNDER_SHIPMENT_TOLERANCE,
ITEM_CROSS_REF_PREF,
OVER_RETURN_TOLERANCE,
UNDER_RETURN_TOLERANCE,
SHIP_SETS_INCLUDE_LINES_FLAG,
ARRIVALSETS_INCLUDE_LINES_FLAG,
SCHED_DATE_PUSH_FLAG,
INVOICE_QUANTITY_RULE,
PRICING_EVENT
) AS 
SELECT 
SITE_USE_ID,
LAST_UPDATE_DATE,
LAST_UPDATED_BY  ,                       
CREATION_DATE ,                         
CREATED_BY ,                           
SITE_USE_CODE ,                       
CUST_ACCT_SITE_ID,
PRIMARY_FLAG ,                      
STATUS ,                           
LOCATION ,                        
LAST_UPDATE_LOGIN ,              
CONTACT_ID ,                    
BILL_TO_SITE_USE_ID ,          
ORIG_SYSTEM_REFERENCE,        
SIC_CODE ,                   
PAYMENT_TERM_ID ,           
GSA_INDICATOR ,            
SHIP_PARTIAL ,            
SHIP_VIA ,               
FOB_POINT ,             
ORDER_TYPE_ID ,        
PRICE_LIST_ID,        
FREIGHT_TERM  ,     
WAREHOUSE_ID ,     
TERRITORY_ID ,                             
ATTRIBUTE_CATEGORY ,                               
ATTRIBUTE1 ,                                      
ATTRIBUTE2,                                      
ATTRIBUTE3,                                     
ATTRIBUTE4,                                    
ATTRIBUTE5,                                   
ATTRIBUTE6,                                  
ATTRIBUTE7,                                 
ATTRIBUTE8,                                
ATTRIBUTE9,                               
ATTRIBUTE10,                             
REQUEST_ID,                             
PROGRAM_APPLICATION_ID ,               
PROGRAM_ID ,                          
PROGRAM_UPDATE_DATE ,                
TAX_REFERENCE ,                     
SORT_PRIORITY ,                    
TAX_CODE ,                        
ATTRIBUTE11 ,                    
ATTRIBUTE12,                    
ATTRIBUTE13,                   
ATTRIBUTE14,                  
ATTRIBUTE15,                 
ATTRIBUTE16,                
ATTRIBUTE17,              
ATTRIBUTE18,             
ATTRIBUTE19,            
ATTRIBUTE20,           
ATTRIBUTE21,          
ATTRIBUTE22,         
ATTRIBUTE23,        
ATTRIBUTE24,       
ATTRIBUTE25,                                       
LAST_ACCRUE_CHARGE_DATE ,                         
SECOND_LAST_ACCRUE_CHARGE_DATE ,                 
LAST_UNACCRUE_CHARGE_DATE ,                     
SECOND_LAST_UNACCRUE_CHRG_DATE,                
DEMAND_CLASS_CODE ,                           
NULL /*TAX_EXEMPT*/,    
NULL /*TAX_EXEMPT_NUM  */,                       
NULL /*TAX_EXEMPT_REASON_CODE*/,                 
ORG_ID ,                                  
TAX_CLASSIFICATION ,                     
TAX_HEADER_LEVEL_FLAG ,                 
TAX_ROUNDING_RULE ,                    
WH_UPDATE_DATE,                       
GLOBAL_ATTRIBUTE1 ,                  
GLOBAL_ATTRIBUTE2 ,                 
GLOBAL_ATTRIBUTE3 ,                
GLOBAL_ATTRIBUTE4 ,               
GLOBAL_ATTRIBUTE5 ,              
GLOBAL_ATTRIBUTE6 ,             
GLOBAL_ATTRIBUTE7 ,            
GLOBAL_ATTRIBUTE8 ,           
GLOBAL_ATTRIBUTE9 ,          
GLOBAL_ATTRIBUTE10 ,        
GLOBAL_ATTRIBUTE11 ,       
GLOBAL_ATTRIBUTE12 ,      
GLOBAL_ATTRIBUTE13 ,     
GLOBAL_ATTRIBUTE14 ,    
GLOBAL_ATTRIBUTE15 ,   
GLOBAL_ATTRIBUTE16 ,  
GLOBAL_ATTRIBUTE17 ,                               
GLOBAL_ATTRIBUTE18 ,                              
GLOBAL_ATTRIBUTE19 ,                             
GLOBAL_ATTRIBUTE20 ,                           
GLOBAL_ATTRIBUTE_CATEGORY ,                   
PRIMARY_SALESREP_ID ,                        
FINCHRG_RECEIVABLES_TRX_ID ,                
GL_ID_REC ,                                
GL_ID_REV ,                               
GL_ID_TAX ,                              
GL_ID_FREIGHT ,                         
GL_ID_CLEARING ,                       
GL_ID_UNBILLED  ,                     
GL_ID_UNEARNED  ,                    
GL_ID_UNPAID_REC ,                  
GL_ID_REMITTANCE  ,                
GL_ID_FACTOR ,                    
DATES_NEGATIVE_TOLERANCE ,       
DATES_POSITIVE_TOLERANCE ,      
DATE_TYPE_PREFERENCE ,         
OVER_SHIPMENT_TOLERANCE ,     
UNDER_SHIPMENT_TOLERANCE ,   
ITEM_CROSS_REF_PREF ,       
OVER_RETURN_TOLERANCE ,    
UNDER_RETURN_TOLERANCE,   
SHIP_SETS_INCLUDE_LINES_FLAG ,                      
ARRIVALSETS_INCLUDE_LINES_FLAG,                    
SCHED_DATE_PUSH_FLAG ,                            
INVOICE_QUANTITY_RULE ,                          
PRICING_EVENT
FROM HZ_CUST_SITE_USES_ALL
/
