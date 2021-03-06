REM ===========================================================
REM Release 11 - Cash management - Forecasting open Interface 
REM Inbound Transactions
REM Create following table/view and use it for Open Interface
REM Refer :- page 2-39,Forecasting Open Interface
REM Oracle Financials Open Interface manual
REM ===========================================================

DROP TABLE WM_CE_FORECAST_EXT
/
CREATE TABLE WM_CE_FORECAST_EXT
(
TRANSACTION_AMOUNT NUMBER NOT NULL,
FUNCTIONAL_AMOUNT NUMBER NOT NULL,
CURRENCY_CODE VARCHAR2(15) NOT NULL,
FUNCTIONAL_CURRENCY VARCHAR2(15) NOT NULL,
CASH_ACTIVITY_DATE DATE NOT NULL,
CRITERIA1 VARCHAR2(150),
CRITERIA2 VARCHAR2(150),
CRITERIA3 VARCHAR2(150),
CRITERIA4 VARCHAR2(150),
CRITERIA5 VARCHAR2(150),
CRITERIA6 VARCHAR2(150),
CRITERIA7 VARCHAR2(150),
CRITERIA8 VARCHAR2(150),
CRITERIA9 VARCHAR2(150),
CRITERIA10 VARCHAR2(150),
CRITERIA11 VARCHAR2(150),
CRITERIA12 VARCHAR2(150),
CRITERIA13 VARCHAR2(150),
CRITERIA14 VARCHAR2(150),
CRITERIA15 VARCHAR2(150)
)
/