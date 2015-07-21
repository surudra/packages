REM  Release 10.7SC
REM
WHENEVER SQLERROR EXIT FAILURE ROLLBACK

CREATE OR REPLACE PACKAGE WM_INO_TRANSACTION AS

PROCEDURE WM_GET_REMIT_ADDRESS  
		       (CUSTOMER_TRX_ID 	IN 	NUMBER,
			REMIT_TO_ADDRESS1 	OUT 	VARCHAR2,
			REMIT_TO_ADDRESS2 	OUT 	VARCHAR2,
			REMIT_TO_ADDRESS3 	OUT 	VARCHAR2,
			REMIT_TO_ADDRESS4 	OUT 	VARCHAR2,
			REMIT_TO_CITY		OUT	VARCHAR2,
			REMIT_TO_COUNTY		OUT	VARCHAR2,
			REMIT_TO_STATE		OUT	VARCHAR2,
			REMIT_TO_PROVINCE	OUT	VARCHAR2,
			REMIT_TO_COUNTRY	OUT	VARCHAR2,
			REMIT_TO_CODE_INT       OUT VARCHAR2,
			REMIT_TO_POSTAL_CODE	OUT	VARCHAR2);

  PROCEDURE WM_GET_PAYMENT	       
		       (CUSTOMER_TRX_ID		IN	NUMBER,
			INSTALLMENT_NUMBER	IN	NUMBER,
			MULTIPLE_INSTALLMENTS_FLAG OUT	VARCHAR2,
			MAXIMUM_INSTALLMENT_NUMBER OUT	NUMBER,
			AMOUNT_TAX_DUE	 	OUT 	NUMBER,
			AMOUNT_CHARGES_DUE	OUT 	NUMBER,
			AMOUNT_FREIGHT_DUE 	OUT 	NUMBER,
			AMOUNT_LINE_ITEMS_DUE	OUT 	NUMBER,
			TOTAL_AMOUNT_DUE	OUT 	NUMBER);

  PROCEDURE WM_GET_TERM_DISCOUNT  
		      (DOCUMENT_TYPE		IN	VARCHAR2,
			TERM_ID			IN	NUMBER,
			TERM_SEQUENCE_NUMBER    IN      NUMBER,
			DISCOUNT_PERCENT1       OUT	NUMBER,
			DISCOUNT_DAYS1          OUT     NUMBER,
			DISCOUNT_DATE1          OUT     DATE,
			DISCOUNT_DAY_OF_MONTH1  OUT     NUMBER,
			DISCOUNT_MONTHS_FORWARD1 OUT    NUMBER,
			DISCOUNT_PERCENT2       OUT	NUMBER,
			DISCOUNT_DAYS2          OUT     NUMBER,
			DISCOUNT_DATE2          OUT     DATE,
			DISCOUNT_DAY_OF_MONTH2  OUT     NUMBER,
			DISCOUNT_MONTHS_FORWARD2 OUT    NUMBER,
			DISCOUNT_PERCENT3       OUT	NUMBER,
			DISCOUNT_DAYS3          OUT     NUMBER,
			DISCOUNT_DATE3          OUT     DATE,
			DISCOUNT_DAY_OF_MONTH3  OUT     NUMBER,
			DISCOUNT_MONTHS_FORWARD3 OUT    NUMBER);

PROCEDURE WM_UPDATE_INO_AR(
	document_type			IN	VARCHAR2,
	transaction_id			IN	NUMBER,
	installment_number		IN	NUMBER,
	multiple_installments_flag 	IN	VARCHAR2,
	maximum_installment_number 	IN	NUMBER);
END;

/
CREATE OR REPLACE PACKAGE BODY WM_INO_TRANSACTION AS

L_REMIT_TO_ADDRESS_ID   NUMBER;
L_ORG_ID   NUMBER;

PROCEDURE WM_GET_REMIT_ADDRESS ( 
	customer_trx_id 	IN 	NUMBER,
	remit_to_address1 	OUT 	VARCHAR2,
	remit_to_address2 	OUT 	VARCHAR2,
	remit_to_address3 	OUT 	VARCHAR2,
	remit_to_address4 	OUT 	VARCHAR2,
	remit_to_city		OUT	VARCHAR2,
	remit_to_county		OUT	VARCHAR2,
	remit_to_state		OUT	VARCHAR2,
	remit_to_province	OUT	VARCHAR2,
	remit_to_country	OUT	VARCHAR2,
	remit_to_code_int       OUT 	VARCHAR2,
	remit_to_postal_code	OUT	VARCHAR2)
IS
  DUMMY NUMBER;

BEGIN

SELECT  REMIT_TO_ADDRESS_ID, ORG_ID INTO l_remit_to_address_id, l_org_id
  FROM  RA_CUSTOMER_TRX_ALL 
 WHERE  CUSTOMER_TRX_ID = wm_get_remit_address.customer_trx_id;

IF l_remit_to_address_id IS NULL THEN

  DECLARE

  CURSOR remit_cur IS
  SELECT RT.ADDRESS_ID
    FROM RA_CUSTOMER_TRX_ALL RCT,RA_ADDRESSES_ALL A,RA_REMIT_TOS_ALL RT
   WHERE RCT.CUSTOMER_TRX_ID = wm_get_remit_address.customer_trx_id
     AND RCT.BILL_TO_ADDRESS_ID = A.ADDRESS_ID
     AND RCT.ORG_ID = l_org_id
     AND RCT.ORG_ID = RT.ORG_ID
     AND RCT.ORG_ID = A.ORG_ID 
     AND RT.STATUS = 'A'
     AND NVL(A.STATUS,'A') = 'A'
     AND RT.COUNTRY = A.COUNTRY
     AND ( A.STATE = NVL(RT.STATE, A.STATE )
          OR    (   A.STATE IS NULL
	         AND RT.STATE IS NULL
	        )
  	  OR    (   A.STATE IS NULL
	         AND A.POSTAL_CODE <= NVL(RT.POSTAL_CODE_HIGH, A.POSTAL_CODE)
                 AND A.POSTAL_CODE >= NVL(RT.POSTAL_CODE_LOW,  A.POSTAL_CODE)
   	         AND (   POSTAL_CODE_LOW IS NOT NULL
	              OR POSTAL_CODE_HIGH IS NOT NULL
	             )
	        )
	 )
     AND ( (    A.POSTAL_CODE <= NVL(RT.POSTAL_CODE_HIGH, A.POSTAL_CODE)
            AND A.POSTAL_CODE >= NVL(RT.POSTAL_CODE_LOW, A.POSTAL_CODE)
	   )
	   OR (    A.POSTAL_CODE IS NULL
	       AND RT.POSTAL_CODE_LOW  IS NULL
	       AND RT.POSTAL_CODE_HIGH IS NULL
	      )
	 )
   ORDER BY RT.STATE, RT.POSTAL_CODE_LOW, RT.POSTAL_CODE_HIGH;

  BEGIN
  -- We only want the first record from the select since the 
  -- order by puts the records in a special order
  OPEN remit_cur;
  FETCH remit_cur INTO l_remit_to_address_id;
  IF remit_cur%NOTFOUND THEN
    l_remit_to_address_id := NULL;
  END IF;
  CLOSE remit_cur;

  END;

END IF;

IF l_remit_to_address_id IS NULL THEN

  SELECT MIN(ADDRESS_ID) INTO l_remit_to_address_id
    FROM RA_REMIT_TOS_ALL 
   WHERE STATUS='A'
     AND STATE   = 'DEFAULT'
     AND COUNTRY = 'DEFAULT'
     AND ORG_ID = l_org_id;

END IF;

SELECT  RA.ADDRESS1, RA.ADDRESS2, RA.ADDRESS3, RA.ADDRESS4,
	RA.CITY, RA.COUNTY, RA.STATE, RA.PROVINCE, RA.COUNTRY, RA.POSTAL_CODE,
	RA.ORIG_SYSTEM_REFERENCE
  INTO  remit_to_address1, remit_to_address2, remit_to_address3, 
	remit_to_address4, remit_to_city, remit_to_county, remit_to_state,
	remit_to_province, remit_to_country, remit_to_postal_code,
	remit_to_code_int
  FROM  RA_ADDRESSES_ALL RA
 WHERE  ADDRESS_ID = l_remit_to_address_id
 AND    ORG_ID = l_org_id;

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm||'. '||
    'ERROR: WM_INO_TRANSACTION.WM_GET_REMIT_ADDRESS '||
    'CUSTOMER_TRX_ID = '||wm_get_remit_address.customer_trx_id||
    ' ADDRESS_ID = '||l_remit_to_address_id);
    app_exception.raise_exception;

END WM_GET_REMIT_ADDRESS;

PROCEDURE WM_GET_PAYMENT ( 
	customer_trx_id 	    	      IN 	NUMBER,
	installment_number		IN	NUMBER,
	multiple_installments_flag	OUT	VARCHAR2,
	maximum_installment_number	OUT	NUMBER,
	amount_tax_due	 		OUT 	NUMBER,
	amount_charges_due		OUT 	NUMBER,
	amount_freight_due 		OUT 	NUMBER,
	amount_line_items_due		OUT 	NUMBER,
	total_amount_due		      OUT 	NUMBER)

IS
l_term_id NUMBER;
l_payment_schedule_exists VARCHAR2(1);
l_term_base_amount NUMBER;
l_term_relative_amount NUMBER;
l_minimum_installment_number NUMBER;
l_amount_tax_due NUMBER;
l_amount_charges_due NUMBER;
l_amount_freight_due NUMBER;
l_amount_line_items_due NUMBER;
l_first_installment_code VARCHAR2(30);
l_type VARCHAR2(30);
l_currency_precision NUMBER;

-- This procedure gets the amount due/credited for a paricular installment
-- of an Invoice or Credit Memo (or any of the related documents)

BEGIN

  -- This select statement is used to determine whether this transaction
  -- has a payment_schedule.  If it does we can get all of the information
  -- we need directly from the payment_schedule, else we need to derive it
  -- from the payment term.
  SELECT RCT.TERM_ID, FC.PRECISION, RCTT.ACCOUNTING_AFFECT_FLAG, 
	   RCTT.TYPE, RT.FIRST_INSTALLMENT_CODE,
    	DECODE(RCTT.TYPE,
	      'CM',
	      'N',
	      'OACM',
	      'N',
	      DECODE(COUNT(*),
		     0,
		     'N',
		     1,
		     'N',
		     'Y')),
	MAX(RTL.SEQUENCE_NUM),
	MIN(RTL.SEQUENCE_NUM)
    INTO l_term_id, l_currency_precision, l_payment_schedule_exists, l_type,
	   l_first_installment_code, multiple_installments_flag, 
	   maximum_installment_number, l_minimum_installment_number
    FROM RA_CUSTOMER_TRX_ALL RCT, RA_CUST_TRX_TYPES_ALL RCTT, RA_TERMS_LINES RTL,
	   RA_TERMS RT, FND_CURRENCIES FC
   WHERE RCT.CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
     AND RCT.INVOICE_CURRENCY_CODE = FC.CURRENCY_CODE
     AND RCT.CUST_TRX_TYPE_ID = RCTT.CUST_TRX_TYPE_ID
     AND RCT.TERM_ID = RT.TERM_ID (+)
     AND RT.TERM_ID = RTL.TERM_ID (+)
     AND RCT.ORG_ID = RCTT.ORG_ID
     GROUP BY RCT.TERM_ID, FC.PRECISION, RCTT.ACCOUNTING_AFFECT_FLAG, 
	   RCTT.TYPE, RT.FIRST_INSTALLMENT_CODE;

  SELECT NVL(MIN(RTL.RELATIVE_AMOUNT),1), NVL(MIN(RT.BASE_AMOUNT),1)
    INTO  l_term_relative_amount, l_term_base_amount
    FROM  RA_TERMS RT, RA_TERMS_LINES RTL
    WHERE RT.TERM_ID = l_term_id
      AND RT.TERM_ID = RTL.TERM_ID
      AND RTL.SEQUENCE_NUM = wm_get_payment.installment_number;

  IF l_payment_schedule_exists = 'Y' THEN

    SELECT NVL(TAX_ORIGINAL,0),
	NVL(FREIGHT_ORIGINAL,0),
	NVL(AMOUNT_LINE_ITEMS_ORIGINAL,0),
	NVL(AMOUNT_DUE_ORIGINAL,0)
      INTO amount_tax_due, amount_freight_due,
	     amount_line_items_due, total_amount_due
      FROM AR_PAYMENT_SCHEDULES_ALL
     WHERE CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id 
       AND DECODE(l_type,
	     'CM',wm_get_payment.installment_number,
	     'OACM',wm_get_payment.installment_number,
	     NVL(TERMS_SEQUENCE_NUMBER, wm_get_payment.installment_number)) 
	   = wm_get_payment.installment_number;

    SELECT NVL(SUM((NVL(RCTL.QUANTITY_INVOICED, RCTL.QUANTITY_CREDITED) * 
	            RCTL.UNIT_SELLING_PRICE)
                   * l_term_relative_amount / l_term_base_amount),0)
      INTO amount_charges_due
      FROM   RA_CUSTOMER_TRX_LINES_ALL RCTL
     WHERE  RCTL.CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
       AND    RCTL.LINE_TYPE = 'CHARGES';

  ELSE

    -- There isn't any payment_schedule, so we need to get the information by
    -- summing up the tax, freight and lines and then applying the payment
    -- term, currency precision and if tax/freight are prorated

    SELECT ROUND(SUM(EXTENDED_AMOUNT * l_term_relative_amount / 
		     l_term_base_amount),l_currency_precision)
    INTO   l_amount_line_items_due
    FROM   RA_CUSTOMER_TRX_LINES_ALL
    WHERE  CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
    AND    LINE_TYPE NOT IN ('TAX','FREIGHT','CHARGES');

    SELECT ROUND(SUM(EXTENDED_AMOUNT * l_term_relative_amount / 
		     l_term_base_amount),l_currency_precision)
    INTO   l_amount_charges_due
    FROM   RA_CUSTOMER_TRX_LINES_ALL
    WHERE  CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
    AND    LINE_TYPE = 'CHARGES';

    -- Check to see if the tax/freight are prorated across installments
    -- or if they are simply included on the first installment.

    IF l_first_installment_code = 'INCLUDE' THEN

      IF l_minimum_installment_number = wm_get_payment.installment_number THEN

        SELECT SUM(EXTENDED_AMOUNT)
        INTO   l_amount_tax_due
        FROM   RA_CUSTOMER_TRX_LINES_ALL
        WHERE  CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
        AND    LINE_TYPE = 'TAX';

        SELECT SUM(EXTENDED_AMOUNT)
        INTO   l_amount_freight_due
        FROM   RA_CUSTOMER_TRX_LINES_ALL
        WHERE  CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
        AND    LINE_TYPE = 'FREIGHT';

      ELSE
        l_amount_tax_due := 0;
        l_amount_freight_due := 0;
      END IF;

    ELSE

      SELECT ROUND(SUM(EXTENDED_AMOUNT * l_term_relative_amount / 
		       l_term_base_amount),l_currency_precision)
        INTO l_amount_tax_due
        FROM  RA_CUSTOMER_TRX_LINES_ALL
       WHERE  CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
         AND  LINE_TYPE = 'TAX';

      SELECT ROUND(SUM(EXTENDED_AMOUNT * l_term_relative_amount / 
		       l_term_base_amount),l_currency_precision)
      INTO   l_amount_freight_due
      FROM   RA_CUSTOMER_TRX_LINES_ALL
      WHERE  CUSTOMER_TRX_ID = wm_get_payment.customer_trx_id
      AND	   LINE_TYPE = 'FREIGHT';

    END IF;

    -- Total up the values and assign them to the out parameters.
    total_amount_due := l_amount_tax_due + l_amount_freight_due 
	                + l_amount_charges_due + l_amount_line_items_due;
    amount_tax_due := NVL(l_amount_tax_due,0);
    amount_charges_due := NVL(l_amount_charges_due,0);
    amount_freight_due := NVL(l_amount_freight_due,0);
    amount_line_items_due := NVL(l_amount_line_items_due,0);

  END IF;


EXCEPTION
  WHEN OTHERS THEN
    
    dbms_output.put_line( sqlerrm||'. '||
       'ERROR: WM_INO_TRANSACTION.WM_GET_PAYMENT '||
       'CUSTOMER_TRX_ID  = '||wm_get_payment.customer_trx_id||
       ' INSTALLMENT_NUMBER  = '||wm_get_payment.installment_number);
    app_exception.raise_exception;
END WM_GET_PAYMENT;

PROCEDURE WM_GET_TERM_DISCOUNT (
	document_type		 IN	 VARCHAR2,
	term_id			 IN	 NUMBER,
	term_sequence_number     IN      NUMBER,
	discount_percent1        OUT	 NUMBER,
	discount_days1           OUT     NUMBER,
	discount_date1           OUT     DATE,
	discount_day_of_month1   OUT     NUMBER,
	discount_months_forward1 OUT     NUMBER,
	discount_percent2        OUT	 NUMBER,
	discount_days2           OUT     NUMBER,
	discount_date2           OUT     DATE,
	discount_day_of_month2   OUT     NUMBER,
	discount_months_forward2 OUT     NUMBER,
	discount_percent3        OUT	 NUMBER,
	discount_days3           OUT     NUMBER,
	discount_date3           OUT     DATE,
	discount_day_of_month3   OUT     NUMBER,
	discount_months_forward3 OUT     NUMBER)
IS
CURSOR discount IS SELECT DISCOUNT_PERCENT, 
				DISCOUNT_DAYS,
				DISCOUNT_DATE,
				DISCOUNT_DAY_OF_MONTH,
				DISCOUNT_MONTHS_FORWARD
		    FROM 	RA_TERMS_LINES_DISCOUNTS
		   WHERE	TERM_ID = wm_get_term_discount.term_id
		     AND	SEQUENCE_NUM = 
			wm_get_term_discount.term_sequence_number;
l_counter 		      NUMBER DEFAULT 1;
l_discount_percent            NUMBER;
l_discount_days               NUMBER;
l_discount_date               DATE;
l_discount_day_of_month       NUMBER;
l_discount_months_forward     NUMBER;
BEGIN

  IF wm_get_term_discount.document_type IN ('CM','OACM') THEN

    discount_percent1		:= null;
    discount_days1		:= null;
    discount_date1		:= null;
    discount_day_of_month1 	:= null;
    discount_months_forward1 	:= null;
    discount_percent2		:= null;
    discount_days2		:= null;
    discount_date2		:= null;
    discount_day_of_month2 	:= null;
    discount_months_forward2 	:= null;
    discount_percent3		:= null;
    discount_days3		:= null;
    discount_date3		:= null;
    discount_day_of_month3 	:= null;
    discount_months_forward3 	:= null;

  ELSE

    OPEN DISCOUNT;
  
    LOOP
      FETCH discount into l_discount_percent,       
			l_discount_days,          
			l_discount_date,          
			l_discount_day_of_month,  
			l_discount_months_forward;
      EXIT WHEN discount%NOTFOUND;

      IF l_counter = 1 THEN
      	discount_percent1        := l_discount_percent;
	discount_days1           := l_discount_days;
	discount_date1           := l_discount_date;
	discount_day_of_month1   := l_discount_day_of_month;
	discount_months_forward1 := l_discount_months_forward;
      END IF;
      IF l_counter = 2 THEN
      	discount_percent2        := l_discount_percent;
	discount_days2           := l_discount_days;
	discount_date2           := l_discount_date;
	discount_day_of_month2   := l_discount_day_of_month;
	discount_months_forward2 := l_discount_months_forward;
      END IF;
      IF l_counter = 3 THEN
      	discount_percent3        := l_discount_percent;
	discount_days3           := l_discount_days;
	discount_date3           := l_discount_date;
	discount_day_of_month3   := l_discount_day_of_month;
	discount_months_forward3 := l_discount_months_forward;
      END IF;
   
      l_counter := l_counter + 1;

    END LOOP;

  END IF;
EXCEPTION
  WHEN others THEN
    dbms_output.put_line( SQLERRM);
    app_exception.raise_exception;
END WM_GET_TERM_DISCOUNT;

PROCEDURE WM_UPDATE_INO_AR(
	document_type			IN	VARCHAR2,
	transaction_id			IN	NUMBER,
	installment_number		IN	NUMBER,
	multiple_installments_flag 	IN	VARCHAR2,
	maximum_installment_number 	IN	NUMBER
	)
IS

L_UPDATE_VALUE          VARCHAR2(20);
BEGIN

	-- This is as good as sent using EDI gateway 
	-- so the status should be set to 'ED' as used by Oracle EDI gateway

    L_UPDATE_VALUE := 'ED';

-- Using mult-org table to update to not to have any restriction on IS. 
-- Unique Transaction_id will ensure that it updates only the designated record

  UPDATE RA_CUSTOMER_TRX_ALL
  SET LAST_UPDATE_DATE = SYSDATE,
	PRINTING_PENDING =
		DECODE (document_type,
			'CM', 'N',
			'OACM', 'N',
			DECODE(maximum_installment_number,
			       installment_number, 'N',
	                       NULL, 'N',
	                       1, 'N',
	                       'Y')),
	PRINTING_COUNT = NVL(PRINTING_COUNT,0) + 1,
	PRINTING_LAST_PRINTED = SYSDATE,
	PRINTING_ORIGINAL_DATE =
		DECODE (NVL(PRINTING_COUNT,0),
			0, SYSDATE,
			PRINTING_ORIGINAL_DATE),
	LAST_PRINTED_SEQUENCE_NUM = 
		DECODE	(multiple_installments_flag,
			'N',NULL,
			GREATEST(NVL(LAST_PRINTED_SEQUENCE_NUM,0),
				 installment_number)),
      EDI_PROCESSED_FLAG = 'Y',
      EDI_PROCESSED_STATUS = L_UPDATE_VALUE
  WHERE CUSTOMER_TRX_ID = WM_UPDATE_INO_AR.transaction_id;

EXCEPTION
  when others then
    dbms_output.put_line( SQLERRM);
    app_exception.raise_exception;

END WM_UPDATE_INO_AR;

END;
/