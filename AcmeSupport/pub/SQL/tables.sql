CREATE TABLE ORDER_HEADER (
   ORDER_ID NVARCHAR (20) NOT NULL ,
   TRANSACTION_ID NVARCHAR (30) NOT NULL ,
   ORDER_DATE NVARCHAR (40) NOT NULL ,
   TOTAL_COST NVARCHAR (20) NOT NULL ,
   IS_VALID NVARCHAR (10) NOT NULL ,
   SENDER_ID NVARCHAR (20) NOT NULL ,
   RECEIVER_ID NVARCHAR (20) NOT NULL
)

CREATE TABLE SRC_ORDER_PRODUCTS (
	PRODUCT_NO NVARCHAR (20) NOT NULL ,
	PRODUCT_NAME NVARCHAR (50) NULL ,
	PRODUCT_DESCRIPTION NVARCHAR (255) NULL,
	UNIT_PRICE NVARCHAR (9) NULL ,
	PRIMARY KEY (PRODUCT_NO)
) 

CREATE TABLE SRC_CUSTOMERS (
	CUSTOMER_NO NVARCHAR (20) NULL ,
	CUSTOMER_NAME NVARCHAR (40) NULL 
)

CREATE TABLE ORDER_HEADER_BUFFER (
   ORDER_ID NVARCHAR (20) NULL ,
   TRANSACTION_ID NVARCHAR (30) NULL ,
   ORDER_DATE NVARCHAR (40) NULL ,
   TOTAL_COST NVARCHAR (20) NULL ,
   IS_VALID NVARCHAR (10) NULL ,
   SENDER_ID NVARCHAR (20) NULL ,
   RECEIVER_ID NVARCHAR (20) NULL
)

CREATE TABLE ORDER_DETAILS (
   ORDER_ID NVARCHAR (20) NOT NULL ,
   TRANSACTION_ID NVARCHAR (30) NOT NULL ,
   SKU NVARCHAR (40) NOT NULL ,
   QUANTITY NVARCHAR (20) NOT NULL
)

INSERT INTO SRC_CUSTOMERS VALUES ('1', 'Montana-Jerky');
INSERT INTO SRC_CUSTOMERS VALUES ('100', 'Maine Lobster Co');

