 /***************************************************************************
        $Date:   24 Oct 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *				
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom objects in Application Schema  
    * Program Name:         wm_into_priceRequest_pkg.sql
    * Version #:            1.0
    * Title:                Processing Script for Price Request Outbound
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Packages in APPS schema. This wrapper calls Price Request API.
    *
    * Tables usage:     
    *     
    *
    * Procedures and Functions: Wm_Price_Request_Api-> Wrapper procedure that calls Price Request API in Oracle Applications
    *				Wm_Price_Request_del-> procedure that deletes records from all the custom tables
    *
    * Restart Information:      
    *
    *
    * Flexfields Used:          
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
    * 15-NOV-02	 			        Created
    ***************************************************************************
*/

  SET feedback  ON
  SET verify            OFF
  SET newpage   0
  SET pause             OFF
  SET termout   ON


  prompt Program : wm_into_priceRequest_pkg.SQL

  --------------------------------------------- 
  -- Connect to APPS Account and create package
  ---------------------------------------------

  CONNECT &&apps_user/&&AppsPwd@&&DBString

 ----------------------------------------------------------------------------
 --    Create custom Package in APPS schema       
 ----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE Wm_PriceRequest_Handler_Pkg AUTHID CURRENT_USER AS

      PROCEDURE Wm_Price_Request_del (
		p_line_index			IN NUMBER);

      PROCEDURE Wm_Price_Request_Api (
		x_return_status			OUT VARCHAR2
	,	x_return_status_text		OUT VARCHAR2
	,	p_line_index			IN NUMBER
	,	p_pricing_event			IN VARCHAR2
	,	p_calculate_flag		IN VARCHAR2
	,	p_simulation_flag		IN VARCHAR2
	,	p_rounding_flag			IN VARCHAR2);

END Wm_PriceRequest_Handler_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Wm_PriceRequest_Handler_Pkg AS

      PROCEDURE Wm_Price_Request_del (
		p_line_index			IN NUMBER)
IS

BEGIN

DELETE 
FROM WM_RELATED_LINES_TBL 
WHERE RELATED_LINE_INDEX = p_line_index;

DELETE
FROM WM_LINE_DETAIL_ATTR_TBL
WHERE LINE_DETAIL_INDEX IN (
SELECT LINE_DETAIL_INDEX
FROM WM_LINE_DETAIL_TBL
WHERE LINE_INDEX = p_line_index);

DELETE
FROM WM_LINE_DETAIL_QUAL_TBL
WHERE LINE_DETAIL_INDEX IN (
SELECT LINE_DETAIL_INDEX
FROM WM_LINE_DETAIL_TBL
WHERE LINE_INDEX = p_line_index);

DELETE 
FROM WM_LINE_DETAIL_TBL
WHERE LINE_INDEX = p_line_index;

DELETE 
FROM WM_LINE_ATTR_TBL
WHERE LINE_INDEX = p_line_index;

DELETE 
FROM WM_QUAL_TBL
WHERE LINE_INDEX = p_line_index;

DELETE 
FROM WM_LINE_TBL
WHERE LINE_INDEX = p_line_index;

EXCEPTION
WHEN OTHERS THEN 
null;

END Wm_Price_Request_del;

       PROCEDURE Wm_Price_Request_Api (
		x_return_status			OUT VARCHAR2
	,	x_return_status_text		OUT VARCHAR2
	,	p_line_index			IN NUMBER
	,	p_pricing_event			IN VARCHAR2
	,	p_calculate_flag		IN VARCHAR2
	,	p_simulation_flag		IN VARCHAR2
	,	p_rounding_flag			IN VARCHAR2)

IS

 p_line_tbl                  QP_PREQ_GRP.LINE_TBL_TYPE;
 p_qual_tbl                  QP_PREQ_GRP.QUAL_TBL_TYPE;
 p_line_attr_tbl             QP_PREQ_GRP.LINE_ATTR_TBL_TYPE;
 p_LINE_DETAIL_tbl           QP_PREQ_GRP.LINE_DETAIL_TBL_TYPE;
 p_LINE_DETAIL_qual_tbl      QP_PREQ_GRP.LINE_DETAIL_QUAL_TBL_TYPE;
 p_LINE_DETAIL_attr_tbl      QP_PREQ_GRP.LINE_DETAIL_ATTR_TBL_TYPE;
 p_related_lines_tbl         QP_PREQ_GRP.RELATED_LINES_TBL_TYPE;
 p_control_rec               QP_PREQ_GRP.CONTROL_RECORD_TYPE;
 x_line_tbl                  QP_PREQ_GRP.LINE_TBL_TYPE;
 x_qual_tbl                  QP_PREQ_GRP.QUAL_TBL_TYPE;
 x_line_attr_tbl             QP_PREQ_GRP.LINE_ATTR_TBL_TYPE;
 x_line_detail_tbl           QP_PREQ_GRP.LINE_DETAIL_TBL_TYPE;
 x_line_detail_qual_tbl      QP_PREQ_GRP.LINE_DETAIL_QUAL_TBL_TYPE;
 x_line_detail_attr_tbl      QP_PREQ_GRP.LINE_DETAIL_ATTR_TBL_TYPE;
 x_related_lines_tbl         QP_PREQ_GRP.RELATED_LINES_TBL_TYPE;
 qual_rec                    QP_PREQ_GRP.QUAL_REC_TYPE;
 line_attr_rec               QP_PREQ_GRP.LINE_ATTR_REC_TYPE;      
 line_rec                    QP_PREQ_GRP.LINE_REC_TYPE;
 rltd_rec                    QP_PREQ_GRP.RELATED_LINES_REC_TYPE;
 line_detail_rec	     QP_PREQ_GRP.LINE_DETAIL_REC_TYPE;
 line_detail_qual_rec	     QP_PREQ_GRP.LINE_DETAIL_QUAL_REC_TYPE;
 line_detail_attr_rec	     QP_PREQ_GRP.LINE_DETAIL_ATTR_REC_TYPE;

 I BINARY_INTEGER;
 l_version VARCHAR2(240);

 CURSOR l_line_tbl_cur (p_line_index NUMBER) IS
 SELECT 
 REQUEST_TYPE_CODE,
 PRICING_EVENT,
 HEADER_ID,
 LINE_INDEX,
 LINE_ID,
 LINE_TYPE_CODE,
 PRICING_EFFECTIVE_DATE,
 ACTIVE_DATE_FIRST,
 ACTIVE_DATE_FIRST_TYPE,
 ACTIVE_DATE_SECOND,
 ACTIVE_DATE_SECOND_TYPE,
 LINE_QUANTITY,
 LINE_UOM_CODE,
 UOM_QUANTITY,
 PRICED_QUANTITY,
 PRICED_UOM_CODE,
 CURRENCY_CODE,
 UNIT_PRICE,
 PERCENT_PRICE,
 ADJUSTED_UNIT_PRICE,
 UPDATED_ADJUSTED_UNIT_PRICE,
 PARENT_PRICE,
 PARENT_QUANTITY,
 ROUNDING_FACTOR,
 PARENT_UOM_CODE,
 PRICING_PHASE_ID,
 PRICE_FLAG,
 PROCESSED_CODE,
 PRICE_REQUEST_CODE,
 HOLD_CODE,
 HOLD_TEXT,
 STATUS_CODE,
 STATUS_TEXT,
 USAGE_PRICING_TYPE,
 LINE_CATEGORY
 FROM WM_LINE_TBL
 WHERE LINE_INDEX = p_line_index;

 CURSOR l_line_attr_tbl_cur (p_line_index NUMBER) IS
 SELECT 
 LINE_INDEX,
 PRICING_CONTEXT,
 PRICING_ATTRIBUTE,
 PRICING_ATTR_VALUE_FROM,
 PRICING_ATTR_VALUE_TO,
 VALIDATED_FLAG,
 STATUS_CODE,
 STATUS_TEXT
 FROM WM_LINE_ATTR_TBL
 WHERE LINE_INDEX = p_line_index;

 CURSOR l_qual_tbl_cur (p_line_index NUMBER) IS
 SELECT 
 LINE_INDEX,
 QUALIFIER_CONTEXT,
 QUALIFIER_ATTRIBUTE,
 QUALIFIER_ATTR_VALUE_FROM,
 QUALIFIER_ATTR_VALUE_TO,
 COMPARISON_OPERATOR_CODE,
 VALIDATED_FLAG,
 STATUS_CODE,
 STATUS_TEXT
 FROM WM_QUAL_TBL
 WHERE LINE_INDEX = p_line_index;

 CURSOR l_line_detail_tbl_cur (p_line_index NUMBER) IS
 SELECT 
 LINE_DETAIL_INDEX,
 LINE_DETAIL_ID,
 LINE_DETAIL_TYPE_CODE,
 LINE_INDEX,
 LIST_HEADER_ID,
 LIST_LINE_ID,
 LIST_LINE_TYPE_CODE,
 SUBSTITUTION_TYPE_CODE,
 SUBSTITUTION_FROM,
 SUBSTITUTION_TO,
 AUTOMATIC_FLAG,
 OPERAND_CALCULATION_CODE,
 OPERAND_VALUE,
 PRICING_GROUP_SEQUENCE,
 PRICE_BREAK_TYPE_CODE,
 CREATED_FROM_LIST_TYPE_CODE,
 PRICING_PHASE_ID,
 LIST_PRICE,
 LINE_QUANTITY ,
 ADJUSTMENT_AMOUNT,
 APPLIED_FLAG,
 MODIFIER_LEVEL_CODE,
 STATUS_CODE,
 STATUS_TEXT,
 SUBSTITUTION_ATTRIBUTE,
 ACCRUAL_FLAG,
 LIST_LINE_NO,
 ESTIM_GL_VALUE,
 ACCRUAL_CONVERSION_RATE,
 OVERRIDE_FLAG,
 PRINT_ON_INVOICE_FLAG,
 INVENTORY_ITEM_ID,
 ORGANIZATION_ID,
 RELATED_ITEM_ID,
 RELATIONSHIP_TYPE_ID,
 ESTIM_ACCRUAL_RATE,
 EXPIRATION_DATE ,
 BENEFIT_PRICE_LIST_LINE_ID,
 RECURRING_FLAG,
 BENEFIT_LIMIT,
 CHARGE_TYPE_CODE,
 CHARGE_SUBTYPE_CODE ,
 INCLUDE_ON_RETURNS_FLAG,
 BENEFIT_QTY,
 BENEFIT_UOM_CODE,
 PRORATION_TYPE_CODE ,
 SOURCE_SYSTEM_CODE,
 REBATE_TRANSACTION_TYPE_CODE,
 SECONDARY_PRICELIST_IND,
 GROUP_VALUE,
 COMMENTS ,
 UPDATED_FLAG,
 PROCESS_CODE,
 LIMIT_CODE,
 LIMIT_TEXT,
 FORMULA_ID,
 CALCULATION_CODE
 FROM WM_LINE_DETAIL_TBL
 WHERE LINE_INDEX = p_line_index;

 CURSOR l_line_detail_qual_tbl_cur (p_line_index NUMBER) IS
 SELECT 
 LDQ.LINE_DETAIL_INDEX ,
 LDQ.QUALIFIER_CONTEXT ,
 LDQ.QUALIFIER_ATTRIBUTE,
 LDQ.QUALIFIER_ATTR_VALUE_FROM,
 LDQ.QUALIFIER_ATTR_VALUE_TO,
 LDQ.COMPARISON_OPERATOR_CODE,
 LDQ.VALIDATED_FLAG,
 LDQ.STATUS_CODE,
 LDQ.STATUS_TEXT
 FROM WM_LINE_DETAIL_QUAL_TBL LDQ, WM_LINE_DETAIL_TBL LD
 WHERE LD.LINE_INDEX = p_line_index
 AND   LD.LINE_DETAIL_INDEX = LDQ.LINE_DETAIL_INDEX;

 CURSOR l_line_detail_attr_tbl_cur (p_line_index NUMBER) IS
 SELECT 
 LDA.LINE_DETAIL_INDEX,
 LDA.PRICING_CONTEXT,
 LDA.PRICING_ATTRIBUTE,
 LDA.PRICING_ATTR_VALUE_FROM,
 LDA.PRICING_ATTR_VALUE_TO,
 LDA.VALIDATED_FLAG,
 LDA.STATUS_CODE,
 LDA.STATUS_TEXT
 FROM WM_LINE_DETAIL_ATTR_TBL LDA, WM_LINE_DETAIL_TBL LD
 WHERE LD.LINE_INDEX = p_line_index
 AND   LD.LINE_DETAIL_INDEX = LDA.LINE_DETAIL_INDEX;

 CURSOR l_related_lines_tbl_cur (p_line_index NUMBER) IS
 SELECT 
 LINE_INDEX,
 LINE_DETAIL_INDEX,
 RELATIONSHIP_TYPE_CODE,
 RELATED_LINE_INDEX,
 RELATED_LINE_DETAIL_INDEX,
 STATUS_CODE,
 STATUS_TEXT
 FROM WM_RELATED_LINES_TBL
 WHERE RELATED_LINE_INDEX = p_line_index;

BEGIN

-- The statments below help the user in turning debug on
-- The user needs to set the oe_debug_pub.G_DIR value.
-- This value can be found by executing the following statement
--     select value
--     from   v$parameter
--     where name like 'utl_file_dir%';
-- This might return multiple values , and any one of the values can be taken 
-- Make sure that the value of the directory specified , actually exists

oe_debug_pub.SetDebugLevel(10);
oe_debug_pub.G_DIR :='/usr/tmp'; -- Example
--dbms_output.put_line('The File is'|| oe_debug_pub.Set_Debug_Mode('FILE'));
oe_debug_pub.Initialize;
oe_debug_pub.debug_on;

-- Passing Information to the Pricing Engine

-- Setting up the control record variables
-- Please refer documentation for explanation of each of these settings

-- p_control_rec.pricing_event := 'LINE';
-- p_control_rec.calculate_flag := 'Y';
-- p_control_rec.simulation_flag := 'N';

 p_control_rec.pricing_event := p_pricing_event	;
 p_control_rec.calculate_flag := p_calculate_flag;
 p_control_rec.simulation_flag := p_simulation_flag;
 p_control_rec.rounding_flag := p_rounding_flag;

-- Request Line (Order Line) Information
-- line_rec.request_type_code :='ONT';
-- line_rec.line_id :=22293;                     -- Order Line Id. This can be any thing for this script
-- line_rec.line_Index :='1';                    -- Request Line Index 
-- line_rec.line_type_code := 'LINE';            -- LINE or ORDER(Summary Line)
-- line_rec.pricing_effective_date := sysdate;   -- Pricing as of what date ? 
-- line_rec.active_date_first := sysdate;        -- Can be Ordered Date or Ship Date
-- line_rec.active_date_second := sysdate;       -- Can be Ordered Date or Ship Date
-- line_rec.active_date_first_type := 'NO TYPE'; -- ORD/SHIP
-- line_rec.active_date_second_type :='NO TYPE'; -- ORD/SHIP
-- line_rec.line_quantity := 5;                  -- Ordered Quantity
-- line_rec.line_uom_code := 'Ea';               -- Ordered UOM Code
-- line_rec.currency_code := 'USD';              -- Currency Code
-- line_rec.price_flag := 'Y';                   -- Price Flag can have 'Y' , 'N'(No pricing) , 'P'(Phase)
-- p_line_tbl(1) := line_rec;

 I := 1;
 FOR line_tbl_rec IN l_line_tbl_cur(p_line_index) LOOP
 line_rec.REQUEST_TYPE_CODE := line_tbl_rec.REQUEST_TYPE_CODE;
 line_rec.PRICING_EVENT := line_tbl_rec.PRICING_EVENT;
 line_rec.HEADER_ID := line_tbl_rec.HEADER_ID;
 line_rec.LINE_INDEX := line_tbl_rec.LINE_INDEX;
 line_rec.LINE_ID := line_tbl_rec.LINE_ID;
 line_rec.LINE_TYPE_CODE := line_tbl_rec.LINE_TYPE_CODE;
 line_rec.PRICING_EFFECTIVE_DATE := line_tbl_rec.PRICING_EFFECTIVE_DATE;
 line_rec.ACTIVE_DATE_FIRST := line_tbl_rec.ACTIVE_DATE_FIRST;
 line_rec.ACTIVE_DATE_FIRST_TYPE := line_tbl_rec.ACTIVE_DATE_FIRST_TYPE;
 line_rec.ACTIVE_DATE_SECOND := line_tbl_rec.ACTIVE_DATE_SECOND;
 line_rec.ACTIVE_DATE_SECOND_TYPE := line_tbl_rec.ACTIVE_DATE_SECOND_TYPE;
 line_rec.LINE_QUANTITY := line_tbl_rec.LINE_QUANTITY;
 line_rec.LINE_UOM_CODE := line_tbl_rec.LINE_UOM_CODE;
 line_rec.UOM_QUANTITY := line_tbl_rec.UOM_QUANTITY;
 line_rec.PRICED_QUANTITY := line_tbl_rec.PRICED_QUANTITY;
 line_rec.PRICED_UOM_CODE := line_tbl_rec.PRICED_UOM_CODE;
 line_rec.CURRENCY_CODE := line_tbl_rec.CURRENCY_CODE;
 line_rec.UNIT_PRICE := line_tbl_rec.UNIT_PRICE;
 line_rec.PERCENT_PRICE := line_tbl_rec.PERCENT_PRICE;
 line_rec.ADJUSTED_UNIT_PRICE := line_tbl_rec.ADJUSTED_UNIT_PRICE;
 line_rec.UPDATED_ADJUSTED_UNIT_PRICE := line_tbl_rec.UPDATED_ADJUSTED_UNIT_PRICE;
 line_rec.PARENT_PRICE := line_tbl_rec.PARENT_PRICE;
 line_rec.PARENT_QUANTITY := line_tbl_rec.PARENT_QUANTITY;
 line_rec.ROUNDING_FACTOR := line_tbl_rec.ROUNDING_FACTOR;
 line_rec.PARENT_UOM_CODE := line_tbl_rec.PARENT_UOM_CODE;
 line_rec.PRICING_PHASE_ID := line_tbl_rec.PRICING_PHASE_ID;
 line_rec.PRICE_FLAG := line_tbl_rec.PRICE_FLAG;
 line_rec.PROCESSED_CODE := line_tbl_rec.PROCESSED_CODE;
 line_rec.PRICE_REQUEST_CODE := line_tbl_rec.PRICE_REQUEST_CODE;
 line_rec.HOLD_CODE := line_tbl_rec.HOLD_CODE;
 line_rec.HOLD_TEXT := line_tbl_rec.HOLD_TEXT;
 line_rec.STATUS_CODE := line_tbl_rec.STATUS_CODE;
 line_rec.STATUS_TEXT := line_tbl_rec.STATUS_TEXT;
 line_rec.USAGE_PRICING_TYPE := line_tbl_rec.USAGE_PRICING_TYPE;
 line_rec.LINE_CATEGORY := line_tbl_rec.LINE_CATEGORY;
 p_line_tbl(I) := line_rec;
 I := I+1;
 END LOOP;

-- If u need to get the price for multiple order lines , please fill the above information for each line
-- and add to the p_line_tbl

-- Pricing Attributes Passed In
-- Please refer documentation for explanation of each of these settings
-- line_attr_rec.LINE_INDEX := 1; -- Attributes for the above line. Attributes are attached with the line index 
-- line_attr_rec.PRICING_CONTEXT :='ITEM'; -- 
-- line_attr_rec.PRICING_ATTRIBUTE :='PRICING_ATTRIBUTE1';
-- line_attr_rec.PRICING_ATTR_VALUE_FROM  := '149'; -- Inventory Item Id
-- line_attr_rec.VALIDATED_FLAG :='N';  
-- p_line_attr_tbl(1):= line_attr_rec;

 I := 1;
 FOR line_attr_tbl_rec IN l_line_attr_tbl_cur(p_line_index) LOOP
 line_attr_rec.LINE_INDEX := line_attr_tbl_rec.LINE_INDEX;
 line_attr_rec.PRICING_CONTEXT := line_attr_tbl_rec.PRICING_CONTEXT;
 line_attr_rec.PRICING_ATTRIBUTE := line_attr_tbl_rec.PRICING_ATTRIBUTE;
 line_attr_rec.PRICING_ATTR_VALUE_FROM := line_attr_tbl_rec.PRICING_ATTR_VALUE_FROM;
 line_attr_rec.PRICING_ATTR_VALUE_TO := line_attr_tbl_rec.PRICING_ATTR_VALUE_TO;
 line_attr_rec.VALIDATED_FLAG := line_attr_tbl_rec.VALIDATED_FLAG;
 line_attr_rec.STATUS_CODE := line_attr_tbl_rec.STATUS_CODE;
 line_attr_rec.STATUS_TEXT := line_attr_tbl_rec.STATUS_TEXT;
 p_line_attr_tbl(I):= line_attr_rec;
 I := I+1;
 END LOOP;


-- If u need to add multiple attributes , please fill the above information for each attribute
-- and add to the p_line_attr_tbl
-- Make sure that u are adding the attribute to the right line index
 
-- Qualifiers Passed In
-- Please refer documentation for explanation of each of these settings
-- qual_rec.LINE_INDEX := 1; -- Attributes for the above line. Attributes are attached with the line index 
-- qual_rec.QUALIFIER_CONTEXT :='MODLIST';
-- qual_rec.QUALIFIER_ATTRIBUTE :='QUALIFIER_ATTRIBUTE4';
-- qual_rec.QUALIFIER_ATTR_VALUE_FROM :='1000'; -- Price List Id
-- qual_rec.COMPARISON_OPERATOR_CODE := '=';
-- qual_rec.VALIDATED_FLAG :='Y';
-- p_qual_tbl(1):= qual_rec; 


 I := 1;
 FOR qual_tbl_rec IN l_qual_tbl_cur(p_line_index) LOOP
 qual_rec.LINE_INDEX := qual_tbl_rec.LINE_INDEX;
 qual_rec.QUALIFIER_CONTEXT := qual_tbl_rec.QUALIFIER_CONTEXT;
 qual_rec.QUALIFIER_ATTRIBUTE := qual_tbl_rec.QUALIFIER_ATTRIBUTE;
 qual_rec.QUALIFIER_ATTR_VALUE_FROM := qual_tbl_rec.QUALIFIER_ATTR_VALUE_FROM;
 qual_rec.QUALIFIER_ATTR_VALUE_TO := qual_tbl_rec.QUALIFIER_ATTR_VALUE_TO;
 qual_rec.COMPARISON_OPERATOR_CODE := qual_tbl_rec.COMPARISON_OPERATOR_CODE;
 qual_rec.VALIDATED_FLAG := qual_tbl_rec.VALIDATED_FLAG;
 qual_rec.STATUS_CODE := qual_tbl_rec.STATUS_CODE;
 qual_rec.STATUS_TEXT := qual_tbl_rec.STATUS_TEXT;
 p_qual_tbl(I):= qual_rec; 
 I := I+1;
 END LOOP;


 I := 1;
 FOR line_detail_tbl_rec IN l_line_detail_tbl_cur(p_line_index) LOOP
 line_detail_rec.LINE_DETAIL_INDEX := line_detail_tbl_rec.LINE_DETAIL_INDEX;
 line_detail_rec.LINE_DETAIL_ID := line_detail_tbl_rec.LINE_DETAIL_ID;
 line_detail_rec.LINE_DETAIL_TYPE_CODE := line_detail_tbl_rec.LINE_DETAIL_TYPE_CODE;
 line_detail_rec.LINE_INDEX := line_detail_tbl_rec.LINE_INDEX;
 line_detail_rec.LIST_HEADER_ID := line_detail_tbl_rec.LIST_HEADER_ID;
 line_detail_rec.LIST_LINE_ID := line_detail_tbl_rec.LIST_LINE_ID;
 line_detail_rec.LIST_LINE_TYPE_CODE := line_detail_tbl_rec.LIST_LINE_TYPE_CODE;
 line_detail_rec.SUBSTITUTION_TYPE_CODE := line_detail_tbl_rec.SUBSTITUTION_TYPE_CODE;
 line_detail_rec.SUBSTITUTION_FROM := line_detail_tbl_rec.SUBSTITUTION_FROM;
 line_detail_rec.SUBSTITUTION_TO := line_detail_tbl_rec.SUBSTITUTION_TO;
 line_detail_rec.AUTOMATIC_FLAG := line_detail_tbl_rec.AUTOMATIC_FLAG;
 line_detail_rec.OPERAND_CALCULATION_CODE := line_detail_tbl_rec.OPERAND_CALCULATION_CODE;
 line_detail_rec.OPERAND_VALUE := line_detail_tbl_rec.OPERAND_VALUE;
 line_detail_rec.PRICING_GROUP_SEQUENCE := line_detail_tbl_rec.PRICING_GROUP_SEQUENCE;
 line_detail_rec.PRICE_BREAK_TYPE_CODE := line_detail_tbl_rec.PRICE_BREAK_TYPE_CODE;
 line_detail_rec.CREATED_FROM_LIST_TYPE_CODE := line_detail_tbl_rec.CREATED_FROM_LIST_TYPE_CODE;
 line_detail_rec.PRICING_PHASE_ID := line_detail_tbl_rec.PRICING_PHASE_ID;
 line_detail_rec.LIST_PRICE := line_detail_tbl_rec.LIST_PRICE;
 line_detail_rec.LINE_QUANTITY := line_detail_tbl_rec.LINE_QUANTITY;
 line_detail_rec.ADJUSTMENT_AMOUNT := line_detail_tbl_rec.ADJUSTMENT_AMOUNT;
 line_detail_rec.APPLIED_FLAG := line_detail_tbl_rec.APPLIED_FLAG;
 line_detail_rec.MODIFIER_LEVEL_CODE := line_detail_tbl_rec.MODIFIER_LEVEL_CODE;
 line_detail_rec.STATUS_CODE := line_detail_tbl_rec.STATUS_CODE;
 line_detail_rec.STATUS_TEXT := line_detail_tbl_rec.STATUS_TEXT;
 line_detail_rec.SUBSTITUTION_ATTRIBUTE := line_detail_tbl_rec.SUBSTITUTION_ATTRIBUTE;
 line_detail_rec.ACCRUAL_FLAG := line_detail_tbl_rec.ACCRUAL_FLAG;
 line_detail_rec.LIST_LINE_NO := line_detail_tbl_rec.LIST_LINE_NO;
 line_detail_rec.ESTIM_GL_VALUE := line_detail_tbl_rec.ESTIM_GL_VALUE;
 line_detail_rec.ACCRUAL_CONVERSION_RATE := line_detail_tbl_rec.ACCRUAL_CONVERSION_RATE;
 line_detail_rec.OVERRIDE_FLAG := line_detail_tbl_rec.OVERRIDE_FLAG;
 line_detail_rec.PRINT_ON_INVOICE_FLAG := line_detail_tbl_rec.PRINT_ON_INVOICE_FLAG;
 line_detail_rec.INVENTORY_ITEM_ID := line_detail_tbl_rec.INVENTORY_ITEM_ID;
 line_detail_rec.ORGANIZATION_ID := line_detail_tbl_rec.ORGANIZATION_ID;
 line_detail_rec.RELATED_ITEM_ID := line_detail_tbl_rec.RELATED_ITEM_ID;
 line_detail_rec.RELATIONSHIP_TYPE_ID := line_detail_tbl_rec.RELATIONSHIP_TYPE_ID;
 line_detail_rec.ESTIM_ACCRUAL_RATE := line_detail_tbl_rec.ESTIM_ACCRUAL_RATE;
 line_detail_rec.EXPIRATION_DATE := line_detail_tbl_rec.EXPIRATION_DATE;
 line_detail_rec.BENEFIT_PRICE_LIST_LINE_ID := line_detail_tbl_rec.BENEFIT_PRICE_LIST_LINE_ID;
 line_detail_rec.RECURRING_FLAG := line_detail_tbl_rec.RECURRING_FLAG;
 line_detail_rec.BENEFIT_LIMIT := line_detail_tbl_rec.BENEFIT_LIMIT;
 line_detail_rec.CHARGE_TYPE_CODE := line_detail_tbl_rec.CHARGE_TYPE_CODE;
 line_detail_rec.CHARGE_SUBTYPE_CODE := line_detail_tbl_rec.CHARGE_SUBTYPE_CODE;
 line_detail_rec.INCLUDE_ON_RETURNS_FLAG := line_detail_tbl_rec.INCLUDE_ON_RETURNS_FLAG;
 line_detail_rec.BENEFIT_QTY := line_detail_tbl_rec.BENEFIT_QTY;
 line_detail_rec.BENEFIT_UOM_CODE := line_detail_tbl_rec.BENEFIT_UOM_CODE;
 line_detail_rec.PRORATION_TYPE_CODE := line_detail_tbl_rec.PRORATION_TYPE_CODE;
 line_detail_rec.SOURCE_SYSTEM_CODE := line_detail_tbl_rec.SOURCE_SYSTEM_CODE;
 line_detail_rec.REBATE_TRANSACTION_TYPE_CODE := line_detail_tbl_rec.REBATE_TRANSACTION_TYPE_CODE;
 line_detail_rec.SECONDARY_PRICELIST_IND := line_detail_tbl_rec.SECONDARY_PRICELIST_IND;
 line_detail_rec.GROUP_VALUE := line_detail_tbl_rec.GROUP_VALUE;
 line_detail_rec.COMMENTS := line_detail_tbl_rec.COMMENTS;
 line_detail_rec.UPDATED_FLAG := line_detail_tbl_rec.UPDATED_FLAG;
 line_detail_rec.PROCESS_CODE := line_detail_tbl_rec.PROCESS_CODE;
 line_detail_rec.LIMIT_CODE := line_detail_tbl_rec.LIMIT_CODE;
 line_detail_rec.LIMIT_TEXT := line_detail_tbl_rec.LIMIT_TEXT;
 line_detail_rec.FORMULA_ID := line_detail_tbl_rec.FORMULA_ID;
 line_detail_rec.CALCULATION_CODE := line_detail_tbl_rec.CALCULATION_CODE;
 p_line_detail_tbl(I):= line_detail_rec; 
 I := I+1;
 END LOOP;


 I := 1;
 FOR line_detail_qual_tbl_rec IN l_line_detail_qual_tbl_cur(p_line_index) LOOP
 line_detail_qual_rec.LINE_DETAIL_INDEX := line_detail_qual_tbl_rec.LINE_DETAIL_INDEX;
 line_detail_qual_rec.QUALIFIER_CONTEXT := line_detail_qual_tbl_rec.QUALIFIER_CONTEXT;
 line_detail_qual_rec.QUALIFIER_ATTRIBUTE := line_detail_qual_tbl_rec.QUALIFIER_ATTRIBUTE;
 line_detail_qual_rec.QUALIFIER_ATTR_VALUE_FROM := line_detail_qual_tbl_rec.QUALIFIER_ATTR_VALUE_FROM;
 line_detail_qual_rec.QUALIFIER_ATTR_VALUE_TO := line_detail_qual_tbl_rec.QUALIFIER_ATTR_VALUE_TO;
 line_detail_qual_rec.COMPARISON_OPERATOR_CODE := line_detail_qual_tbl_rec.COMPARISON_OPERATOR_CODE;
 line_detail_qual_rec.VALIDATED_FLAG := line_detail_qual_tbl_rec.VALIDATED_FLAG;
 line_detail_qual_rec.STATUS_CODE := line_detail_qual_tbl_rec.STATUS_CODE;
 line_detail_qual_rec.STATUS_TEXT := line_detail_qual_tbl_rec.STATUS_TEXT;
 p_line_detail_qual_tbl(I):= line_detail_qual_rec; 
 I := I+1;
 END LOOP;


 I := 1;
 FOR line_detail_attr_tbl_rec IN l_line_detail_attr_tbl_cur(p_line_index) LOOP
 line_detail_attr_rec.LINE_DETAIL_INDEX := line_detail_attr_tbl_rec.LINE_DETAIL_INDEX;
 line_detail_attr_rec.PRICING_CONTEXT := line_detail_attr_tbl_rec.PRICING_CONTEXT;
 line_detail_attr_rec.PRICING_ATTRIBUTE := line_detail_attr_tbl_rec.PRICING_ATTRIBUTE;
 line_detail_attr_rec.PRICING_ATTR_VALUE_FROM := line_detail_attr_tbl_rec.PRICING_ATTR_VALUE_FROM;
 line_detail_attr_rec.PRICING_ATTR_VALUE_TO := line_detail_attr_tbl_rec.PRICING_ATTR_VALUE_TO;
 line_detail_attr_rec.VALIDATED_FLAG := line_detail_attr_tbl_rec.VALIDATED_FLAG;
 line_detail_attr_rec.STATUS_CODE := line_detail_attr_tbl_rec.STATUS_CODE;
 line_detail_attr_rec.STATUS_TEXT := line_detail_attr_tbl_rec.STATUS_TEXT;
 p_line_detail_attr_tbl(I):= line_detail_attr_rec; 
 I := I+1;
 END LOOP;


 I := 1;
 FOR related_line_tbl_rec IN l_related_lines_tbl_cur(p_line_index) LOOP
 rltd_rec.LINE_INDEX := related_line_tbl_rec.LINE_INDEX;
 rltd_rec.LINE_DETAIL_INDEX := related_line_tbl_rec.LINE_DETAIL_INDEX;
 rltd_rec.RELATIONSHIP_TYPE_CODE := related_line_tbl_rec.RELATIONSHIP_TYPE_CODE;
 rltd_rec.RELATED_LINE_INDEX := related_line_tbl_rec.RELATED_LINE_INDEX;
 rltd_rec.RELATED_LINE_DETAIL_INDEX := related_line_tbl_rec.RELATED_LINE_DETAIL_INDEX;
 rltd_rec.STATUS_CODE := related_line_tbl_rec.STATUS_CODE;
 rltd_rec.STATUS_TEXT := related_line_tbl_rec.STATUS_TEXT;
 p_related_lines_tbl(I):= rltd_rec; 
 I := I+1;
 END LOOP;


--testing with second request line
-- line_rec.request_type_code :='ONT';
-- line_rec.line_id :=44346;
-- line_rec.line_Index :=2;
-- line_rec.line_type_code := 'LINE';
-- line_rec.pricing_effective_date := sysdate;
-- line_rec.active_date_first := sysdate;
-- line_rec.active_date_second := sysdate;
-- line_rec.line_quantity := 300;
-- line_rec.line_uom_code := 'Ea';
-- line_rec.price_flag :='Y';
-- line_rec.currency_code := 'USD';
-- p_line_tbl(2) := line_rec;

-- qual_rec.LINE_INDEX := 2;
-- qual_rec.QUALIFIER_CONTEXT :='MODLIST';
-- qual_rec.QUALIFIER_ATTRIBUTE :='QUALIFIER_ATTRIBUTE4';
-- qual_rec.QUALIFIER_ATTR_VALUE_FROM :='1000';
-- qual_rec.QUALIFIER_ATTR_VALUE_TO :='1000';
-- qual_rec.COMPARISON_OPERATOR_CODE := '=';
-- qual_rec.VALIDATED_FLAG :='Y';
-- p_qual_tbl(2):= qual_rec;

-- line_attr_rec.LINE_INDEX := 2;
-- line_attr_rec.PRICING_CONTEXT :='ITEM';
-- line_attr_rec.PRICING_ATTRIBUTE :='PRICING_ATTRIBUTE1';
-- line_attr_rec.PRICING_ATTR_VALUE_FROM  :='155';
-- line_attr_rec.VALIDATED_FLAG :='N';  --don't care because item is not a list
-- p_line_attr_tbl(2):= line_attr_rec;


-- Relationship between the lines need to be passed
-- rltd_rec.LINE_INDEX := 1;
-- rltd_rec.RELATED_LINE_INDEX :=2;
-- rltd_rec.RELATIONSHIP_TYPE_CODE :='SERVICE_LINE';
-- p_related_lines_tbl(1) := rltd_rec;

l_version :=  QP_PREQ_GRP.GET_VERSION;
--DBMS_OUTPUT.PUT_LINE('Testing version '||l_version);
 QP_PREQ_GRP.PRICE_REQUEST
       (p_line_tbl,
        p_qual_tbl,
        p_line_attr_tbl,
        p_line_detail_tbl,
        p_line_detail_qual_tbl,
        p_line_detail_attr_tbl,
        p_related_lines_tbl,
        p_control_rec,
        x_line_tbl,
        x_qual_tbl,
        x_line_attr_tbl,
        x_line_detail_tbl,
        x_line_detail_qual_tbl,
        x_line_detail_attr_tbl,
        x_related_lines_tbl,
        x_return_status,
        x_return_status_text);

-- Delete existing records from all tables. 

Wm_Price_Request_del(p_line_index);

-- Insert into all the tables from Output of the Price Request API.

-- Interpreting Information From the Pricing Engine . Output statements commented. Please uncomment for debugging

-- Return Status Information .. 
--DBMS_OUTPUT.PUT_LINE('Return Status text '||  x_return_status_text);
--DBMS_OUTPUT.PUT_LINE('Return Status  '||  x_return_status);

--DBMS_OUTPUT.PUT_LINE('+---------Information Returned to Caller---------------------+ ');

--DBMS_OUTPUT.PUT_LINE('-------------Request Line Information-------------------');

I := x_line_tbl.FIRST;
IF I IS NOT NULL THEN
 LOOP
--  DBMS_OUTPUT.PUT_LINE('Line Index: '||x_line_tbl(I).line_index);
--  DBMS_OUTPUT.PUT_LINE('Unit_price: '||x_line_tbl(I).unit_price);
--  DBMS_OUTPUT.PUT_LINE('Percent price: '||x_line_tbl(I).percent_price);
--  DBMS_OUTPUT.PUT_LINE('Adjusted Unit Price: '||x_line_tbl(I).adjusted_unit_price);
--  DBMS_OUTPUT.PUT_LINE('Pricing status code: '||x_line_tbl(I).status_code);
--  DBMS_OUTPUT.PUT_LINE('Pricing status text: '||x_line_tbl(I).status_text);

  INSERT INTO WM_LINE_TBL
  SELECT
  x_line_tbl(I).REQUEST_TYPE_CODE,
  x_line_tbl(I).PRICING_EVENT,
  x_line_tbl(I).HEADER_ID,
  x_line_tbl(I).LINE_INDEX,
  x_line_tbl(I).LINE_ID,
  x_line_tbl(I).LINE_TYPE_CODE,
  x_line_tbl(I).PRICING_EFFECTIVE_DATE,
  x_line_tbl(I).ACTIVE_DATE_FIRST,
  x_line_tbl(I).ACTIVE_DATE_FIRST_TYPE,
  x_line_tbl(I).ACTIVE_DATE_SECOND,
  x_line_tbl(I).ACTIVE_DATE_SECOND_TYPE,
  x_line_tbl(I).LINE_QUANTITY,
  x_line_tbl(I).LINE_UOM_CODE,
  x_line_tbl(I).UOM_QUANTITY,
  x_line_tbl(I).PRICED_QUANTITY,
  x_line_tbl(I).PRICED_UOM_CODE,
  x_line_tbl(I).CURRENCY_CODE,
  x_line_tbl(I).UNIT_PRICE,
  x_line_tbl(I).PERCENT_PRICE,
  x_line_tbl(I).ADJUSTED_UNIT_PRICE,
  x_line_tbl(I).UPDATED_ADJUSTED_UNIT_PRICE,
  x_line_tbl(I).PARENT_PRICE,
  x_line_tbl(I).PARENT_QUANTITY,
  x_line_tbl(I).ROUNDING_FACTOR,
  x_line_tbl(I).PARENT_UOM_CODE,
  x_line_tbl(I).PRICING_PHASE_ID,
  x_line_tbl(I).PRICE_FLAG,
  x_line_tbl(I).PROCESSED_CODE,
  x_line_tbl(I).PRICE_REQUEST_CODE,
  x_line_tbl(I).HOLD_CODE,
  x_line_tbl(I).HOLD_TEXT,
  x_line_tbl(I).STATUS_CODE,
  x_line_tbl(I).STATUS_TEXT,
  x_line_tbl(I).USAGE_PRICING_TYPE,
  x_line_tbl(I).LINE_CATEGORY
  FROM DUAL;

  EXIT WHEN I = x_line_tbl.LAST;
  I := x_line_tbl.NEXT(I);
 END LOOP;
END IF;

--DBMS_OUTPUT.PUT_LINE('-----------Pricing Attributes Information-------------');

I := x_line_attr_tbl.FIRST;
IF I IS NOT NULL THEN
 LOOP

  INSERT INTO WM_LINE_ATTR_TBL
  SELECT
  x_line_attr_tbl(I).LINE_INDEX,
  x_line_attr_tbl(I).PRICING_CONTEXT,
  x_line_attr_tbl(I).PRICING_ATTRIBUTE,
  x_line_attr_tbl(I).PRICING_ATTR_VALUE_FROM,
  x_line_attr_tbl(I).PRICING_ATTR_VALUE_TO,
  x_line_attr_tbl(I).VALIDATED_FLAG,
  x_line_attr_tbl(I).STATUS_CODE,
  x_line_attr_tbl(I).STATUS_TEXT
  FROM DUAL;

  EXIT WHEN I = x_line_attr_tbl.last;
  I:=x_line_attr_tbl.NEXT(I);

 END LOOP;
END IF;


I := x_line_detail_attr_tbl.FIRST;
IF I IS NOT NULL THEN
 LOOP

--  DBMS_OUTPUT.PUT_LINE('Line detail Index '||x_line_detail_attr_tbl(I).line_detail_index);
--  DBMS_OUTPUT.PUT_LINE('Context '||x_line_detail_attr_tbl(I).pricing_context);
--  DBMS_OUTPUT.PUT_LINE('Attribute '||x_line_detail_attr_tbl(I).pricing_attribute);
--  DBMS_OUTPUT.PUT_LINE('Value '||x_line_detail_attr_tbl(I).pricing_attr_value_from);
--  DBMS_OUTPUT.PUT_LINE('Status Code '||x_line_detail_attr_tbl(I).status_code);
--  DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');

  INSERT INTO WM_LINE_DETAIL_ATTR_TBL
  SELECT
  x_line_detail_attr_tbl(I).LINE_DETAIL_INDEX,
  x_line_detail_attr_tbl(I).PRICING_CONTEXT,
  x_line_detail_attr_tbl(I).PRICING_ATTRIBUTE,
  x_line_detail_attr_tbl(I).PRICING_ATTR_VALUE_FROM,
  x_line_detail_attr_tbl(I).PRICING_ATTR_VALUE_TO,
  x_line_detail_attr_tbl(I).VALIDATED_FLAG,
  x_line_detail_attr_tbl(I).STATUS_CODE,
  x_line_detail_attr_tbl(I).STATUS_TEXT
  FROM DUAL;

  EXIT WHEN I = x_line_detail_attr_tbl.last;
  I:=x_line_detail_attr_tbl.NEXT(I);

 END LOOP;
END IF;

--DBMS_OUTPUT.PUT_LINE('-----------Qualifier Attributes Information-------------');

I := x_qual_tbl.FIRST;
IF I IS NOT NULL THEN
 LOOP

  INSERT INTO WM_QUAL_TBL
  SELECT
  x_qual_tbl(I).LINE_INDEX,
  x_qual_tbl(I).QUALIFIER_CONTEXT,
  x_qual_tbl(I).QUALIFIER_ATTRIBUTE,
  x_qual_tbl(I).QUALIFIER_ATTR_VALUE_FROM,
  x_qual_tbl(I).QUALIFIER_ATTR_VALUE_TO,
  x_qual_tbl(I).COMPARISON_OPERATOR_CODE,
  x_qual_tbl(I).VALIDATED_FLAG,
  x_qual_tbl(I).STATUS_CODE,
  x_qual_tbl(I).STATUS_TEXT
  FROM DUAL;

  EXIT WHEN I = x_qual_tbl.last;
  I:=x_qual_tbl.NEXT(I);

 END LOOP;
END IF;

I := x_line_detail_qual_tbl.FIRST;
IF I IS NOT NULL THEN
 LOOP
--  DBMS_OUTPUT.PUT_LINE('Line Detail Index '||x_line_detail_qual_tbl(I).line_detail_index);
--  DBMS_OUTPUT.PUT_LINE('Context '||x_line_detail_qual_tbl(I).qualifier_context);
--  DBMS_OUTPUT.PUT_LINE('Attribute '||x_line_detail_qual_tbl(I).qualifier_attribute);
--  DBMS_OUTPUT.PUT_LINE('Value '||x_line_detail_qual_tbl(I).qualifier_attr_value_from);
--  DBMS_OUTPUT.PUT_LINE('Status Code '||x_line_detail_qual_tbl(I).status_code);
--  DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');

  INSERT INTO WM_LINE_DETAIL_QUAL_TBL
  SELECT
  x_line_detail_qual_tbl(I).LINE_DETAIL_INDEX ,
  x_line_detail_qual_tbl(I).QUALIFIER_CONTEXT ,
  x_line_detail_qual_tbl(I).QUALIFIER_ATTRIBUTE,
  x_line_detail_qual_tbl(I).QUALIFIER_ATTR_VALUE_FROM,
  x_line_detail_qual_tbl(I).QUALIFIER_ATTR_VALUE_TO,
  x_line_detail_qual_tbl(I).COMPARISON_OPERATOR_CODE,
  x_line_detail_qual_tbl(I).VALIDATED_FLAG,
  x_line_detail_qual_tbl(I).STATUS_CODE,
  x_line_detail_qual_tbl(I).STATUS_TEXT
  FROM DUAL;

  EXIT WHEN I = x_line_detail_qual_tbl.last;
  I:=x_line_detail_qual_tbl.NEXT(I);

 END LOOP;
END IF;

I := x_line_detail_tbl.FIRST;

--DBMS_OUTPUT.PUT_LINE('------------Price List/Discount Information------------');

IF I IS NOT NULL THEN
 LOOP
--  DBMS_OUTPUT.PUT_LINE('Line Index: '||x_line_detail_tbl(I).line_index);
--  DBMS_OUTPUT.PUT_LINE('Line Detail Index: '||x_line_detail_tbl(I).line_detail_index);
--  DBMS_OUTPUT.PUT_LINE('Line Detail Type:'||x_line_detail_tbl(I).line_detail_type_code);
--  DBMS_OUTPUT.PUT_LINE('List Header Id: '||x_line_detail_tbl(I).list_header_id);
--  DBMS_OUTPUT.PUT_LINE('List Line Id: '||x_line_detail_tbl(I).list_line_id);
--  DBMS_OUTPUT.PUT_LINE('List Line Type Code: '||x_line_detail_tbl(I).list_line_type_code);
--  DBMS_OUTPUT.PUT_LINE('Adjustment Amount : '||x_line_detail_tbl(I).adjustment_amount);
--  DBMS_OUTPUT.PUT_LINE('Line Quantity : '||x_line_detail_tbl(I).line_quantity);
--  DBMS_OUTPUT.PUT_LINE('Operand Calculation Code: '||x_line_detail_tbl(I).Operand_calculation_code);
--  DBMS_OUTPUT.PUT_LINE('Operand value: '||x_line_detail_tbl(I).operand_value);
--  DBMS_OUTPUT.PUT_LINE('Automatic Flag: '||x_line_detail_tbl(I).automatic_flag);
--  DBMS_OUTPUT.PUT_LINE('Override Flag: '||x_line_detail_tbl(I).override_flag);
--  DBMS_OUTPUT.PUT_LINE('status_code: '||x_line_detail_tbl(I).status_code);
--  DBMS_OUTPUT.PUT_LINE('status text: '||x_line_detail_tbl(I).status_text);
--  DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

  INSERT INTO WM_LINE_DETAIL_TBL
  SELECT
  x_line_detail_tbl(I).LINE_DETAIL_INDEX,
  x_line_detail_tbl(I).LINE_DETAIL_ID,
  x_line_detail_tbl(I).LINE_DETAIL_TYPE_CODE,
  x_line_detail_tbl(I).LINE_INDEX,
  x_line_detail_tbl(I).LIST_HEADER_ID,
  x_line_detail_tbl(I).LIST_LINE_ID,
  x_line_detail_tbl(I).LIST_LINE_TYPE_CODE,
  x_line_detail_tbl(I).SUBSTITUTION_TYPE_CODE,
  x_line_detail_tbl(I).SUBSTITUTION_FROM,
  x_line_detail_tbl(I).SUBSTITUTION_TO,
  x_line_detail_tbl(I).AUTOMATIC_FLAG,
  x_line_detail_tbl(I).OPERAND_CALCULATION_CODE,
  x_line_detail_tbl(I).OPERAND_VALUE,
  x_line_detail_tbl(I).PRICING_GROUP_SEQUENCE,
  x_line_detail_tbl(I).PRICE_BREAK_TYPE_CODE,
  x_line_detail_tbl(I).CREATED_FROM_LIST_TYPE_CODE,
  x_line_detail_tbl(I).PRICING_PHASE_ID,
  x_line_detail_tbl(I).LIST_PRICE,
  x_line_detail_tbl(I).LINE_QUANTITY,
  x_line_detail_tbl(I).ADJUSTMENT_AMOUNT,
  x_line_detail_tbl(I).APPLIED_FLAG,
  x_line_detail_tbl(I).MODIFIER_LEVEL_CODE,
  x_line_detail_tbl(I).STATUS_CODE,
  x_line_detail_tbl(I).STATUS_TEXT,
  x_line_detail_tbl(I).SUBSTITUTION_ATTRIBUTE,
  x_line_detail_tbl(I).ACCRUAL_FLAG,
  x_line_detail_tbl(I).LIST_LINE_NO,
  x_line_detail_tbl(I).ESTIM_GL_VALUE,
  x_line_detail_tbl(I).ACCRUAL_CONVERSION_RATE,
  x_line_detail_tbl(I).OVERRIDE_FLAG,
  x_line_detail_tbl(I).PRINT_ON_INVOICE_FLAG,
  x_line_detail_tbl(I).INVENTORY_ITEM_ID,
  x_line_detail_tbl(I).ORGANIZATION_ID,
  x_line_detail_tbl(I).RELATED_ITEM_ID,
  x_line_detail_tbl(I).RELATIONSHIP_TYPE_ID,
  x_line_detail_tbl(I).ESTIM_ACCRUAL_RATE,
  x_line_detail_tbl(I).EXPIRATION_DATE,
  x_line_detail_tbl(I).BENEFIT_PRICE_LIST_LINE_ID,
  x_line_detail_tbl(I).RECURRING_FLAG,
  x_line_detail_tbl(I).BENEFIT_LIMIT,
  x_line_detail_tbl(I).CHARGE_TYPE_CODE,
  x_line_detail_tbl(I).CHARGE_SUBTYPE_CODE,
  x_line_detail_tbl(I).INCLUDE_ON_RETURNS_FLAG,
  x_line_detail_tbl(I).BENEFIT_QTY,
  x_line_detail_tbl(I).BENEFIT_UOM_CODE,
  x_line_detail_tbl(I).PRORATION_TYPE_CODE,
  x_line_detail_tbl(I).SOURCE_SYSTEM_CODE,
  x_line_detail_tbl(I).REBATE_TRANSACTION_TYPE_CODE,
  x_line_detail_tbl(I).SECONDARY_PRICELIST_IND,
  x_line_detail_tbl(I).GROUP_VALUE,
  x_line_detail_tbl(I).COMMENTS,
  x_line_detail_tbl(I).UPDATED_FLAG,
  x_line_detail_tbl(I).PROCESS_CODE,
  x_line_detail_tbl(I).LIMIT_CODE,
  x_line_detail_tbl(I).LIMIT_TEXT,
  x_line_detail_tbl(I).FORMULA_ID,
  x_line_detail_tbl(I).CALCULATION_CODE
  FROM DUAL;

  EXIT WHEN I =  x_line_detail_tbl.LAST;
  I := x_line_detail_tbl.NEXT(I);
 END LOOP;
END IF;

--DBMS_OUTPUT.PUT_LINE('--------------Related Lines Information for Price Breaks/Service Items---------------');

I := x_related_lines_tbl.FIRST;
IF I IS NOT NULL THEN
 LOOP
--  DBMS_OUTPUT.PUT_LINE('Line Index :'||x_related_lines_tbl(I).line_index);
--  DBMS_OUTPUT.PUT_LINE('Line Detail Index: '||x_related_lines_tbl(I).LINE_DETAIL_INDEX);
--  DBMS_OUTPUT.PUT_LINE('Relationship Type Code: '||x_related_lines_tbl(I).relationship_type_code);
--  DBMS_OUTPUT.PUT_LINE('Related Line Index: '||x_related_lines_tbl(I).RELATED_LINE_INDEX);
--  DBMS_OUTPUT.PUT_LINE('Related Line Detail Index: '||x_related_lines_tbl(I).related_line_detail_index);
--  DBMS_OUTPUT.PUT_LINE('Status Code: '|| x_related_lines_tbl(I).STATUS_CODE);

  INSERT INTO WM_RELATED_LINES_TBL
  SELECT
  x_related_lines_tbl(I).LINE_INDEX,
  x_related_lines_tbl(I).LINE_DETAIL_INDEX,
  x_related_lines_tbl(I).RELATIONSHIP_TYPE_CODE,
  x_related_lines_tbl(I).RELATED_LINE_INDEX,
  x_related_lines_tbl(I).RELATED_LINE_DETAIL_INDEX,
  x_related_lines_tbl(I).STATUS_CODE,
  x_related_lines_tbl(I).STATUS_TEXT
  FROM DUAL;

  EXIT WHEN I =  x_related_lines_tbl.LAST;
  I :=  x_related_lines_tbl.NEXT(I);
 END LOOP;
END IF;

EXCEPTION
WHEN OTHERS THEN 
x_return_status:='FAILED';
x_return_status_text := x_return_status || ':' || SQLERRM;

END Wm_Price_Request_Api;

END wm_priceRequest_handler_pkg;
/
