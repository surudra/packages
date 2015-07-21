       01 COMMAREA-BUFFER.
          03 REQUEST-TYPE              PIC X(15).
          03 RETURN-VALUE              PIC X(02).
          03 USERID                    PIC X(60).
          03 USER-PASSWORD             PIC X(10).
          03 COMPANY-NAME              PIC X(20).
          03 CORRELID                  PIC X(32).
          03 UNIT-SHARE-VALUES.
             05 UNIT-SHARE-PRICE       PIC X(08).
             05 UNIT-VALUE-7-DAYS      PIC X(08).
             05 UNIT-VALUE-6-DAYS      PIC X(08).
             05 UNIT-VALUE-5-DAYS      PIC X(08).
             05 UNIT-VALUE-4-DAYS      PIC X(08).
             05 UNIT-VALUE-3-DAYS      PIC X(08).
             05 UNIT-VALUE-2-DAYS      PIC X(08).
             05 UNIT-VALUE-1-DAYS      PIC X(08).
          03 COMMISSION-COST-SELL      PIC X(03).
          03 COMMISSION-COST-BUY       PIC X(03).
          03 SHARES.
             05 NO-OF-SHARES           PIC X(04).
          03 SHARES-CONVERT REDEFINES SHARES.
             05 NO-OF-SHARES-DEC       PIC 9(04).
          03 TOTAL-SHARE-VALUE         PIC X(12).
          03 BUY-SELL1                 PIC X(04).
          03 BUY-SELL-PRICE1           PIC X(08).
          03 BUY-SELL2                 PIC X(04).
          03 BUY-SELL-PRICE2           PIC X(08).
          03 BUY-SELL3                 PIC X(04).
          03 BUY-SELL-PRICE3           PIC X(08).
          03 BUY-SELL4                 PIC X(04).
          03 BUY-SELL-PRICE4           PIC X(08).
          03 ALARM-CHANGE              PIC X(03).
          03 UPDATE-BUY-SELL           PIC X(01).
          03 FILLER                    PIC X(15).
          03 COMPANY-NAME-BUFFER.
             05  COMPANY-NAME-TAB OCCURS 4 TIMES
                    INDEXED BY COMPANY-NAME-IDX
                                           PIC X(20).