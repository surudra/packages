       IDENTIFICATION DIVISION.

       PROGRAM-ID. TRADERBL.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01 WRITEQ-WORDS.
          03 TIME-TRACE                PIC X(08).
          03 PROGRAM-TRACE             PIC X(11) VALUE ' TRADERBL: '.
          03 COMMENT-FIELD             PIC X(50).

      * Work field used for blank stripping

       01 WORK-FIELD                   PIC X(50).

      * For Debug tracing (avoids blank stripping etc)

       01 DEBUG-WORDS                  PIC X(67).
       01 MESSAGE-AREAS.
          03 USER-TRACE-MSG.
             05 FILLER  PIC X(25) VALUE 'USER #UUUUUUUUUUUUUU COMP'.
             05 FILLER  PIC X(25) VALUE 'ANY #CCCCCCCCCCCCCCCCCCC '.
          03 COMPANY-NOT-FOUND-MSG.
             05 FILLER  PIC X(25) VALUE 'COMPANY #CCCCCCCCCCCCCCCC'.
             05 FILLER  PIC X(25) VALUE 'CCC NOT FOUND            '.
          03 REQUEST-NOT-FOUND-MSG.
             05 FILLER  PIC X(25) VALUE 'REQUEST CODE OF #RRRRRRRR'.
             05 FILLER  PIC X(25) VALUE 'RRRRRR INVALID           '.
          03 SUB-FUNCTION-NOT-FOUND-MSG.
             05 FILLER  PIC X(25) VALUE 'FUNCTION BUY/SELL CALLED '.
             05 FILLER  PIC X(25) VALUE 'WITH AN INVALID SUBCODE  '.
          03 OVERFLOW-MSG.
             05 FILLER  PIC X(25) VALUE 'OVERFLOW WHEN CALCULATING'.
             05 FILLER  PIC X(25) VALUE ' SHARE VALUE             '.
          03 TOO-MANY-SHARES-MSG.
             05 FILLER  PIC X(25) VALUE 'CUSTOMER TRIED TO SELL MO'.
             05 FILLER  PIC X(25) VALUE 'RE SHARES THAN HE OWNS   '.
          03 NO-SHARES-MSG.
             05 FILLER  PIC X(25) VALUE 'CUSTOMER HAS NO SHARES TO'.
             05 FILLER  PIC X(25) VALUE ' SELL IN SELECTED COMPANY'.
          03 VALIDATE-MSG.
             05 FILLER  PIC X(25) VALUE 'VALIDATING COMPANY #CCCCC'.
             05 FILLER  PIC X(25) VALUE 'CCCCCCCCCCCCCC           '.
          03 TOO-MANY-MSG.
             05 FILLER  PIC X(25) VALUE 'TOO MANY SHARES REQUESTED'.
             05 FILLER  PIC X(25) VALUE ', MAX OWNERSHIP IS 9999  '.

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

       01 CUSTOMER-IO-BUFFER.
          03 KEYREC.
             05 CUSTOMER               PIC X(60).
             05 KEYREC-DOT             PIC X(01).
             05 COMPANY                PIC X(20).
          03 CONVERT1.
             05 NO-SHARES              PIC X(04).
          03 CONVERT2 REDEFINES CONVERT1.
             05 DEC-NO-SHARES          PIC 9(04).
          03 BUY-FROM                  PIC X(08).
          03 BUY-FROM-NO               PIC X(04).
          03 BUY-TO                    PIC X(08).
          03 BUY-TO-NO                 PIC X(04).
          03 SELL-FROM                 PIC X(08).
          03 SELL-FROM-NO              PIC X(04).
          03 SELL-TO                   PIC X(08).
          03 SELL-TO-NO                PIC X(04).
          03 ALARM-PERCENT             PIC X(03).
       01 COMPANY-IO-BUFFER.
          03 COMPANY                   PIC X(20).
          03 SHARE-VALUE.
             05 SHARE-VALUE-INT-PART   PIC X(05).
             05 FILLER                 PIC X(01).
             05 SHARE-VALUE-DEC-PART   PIC X(02).
          03 VALUE-1                   PIC X(08).
          03 VALUE-2                   PIC X(08).
          03 VALUE-3                   PIC X(08).
          03 VALUE-4                   PIC X(08).
          03 VALUE-5                   PIC X(08).
          03 VALUE-6                   PIC X(08).
          03 VALUE-7                   PIC X(08).
          03 COMMISSION-BUY            PIC X(03).
          03 COMMISSION-SELL           PIC X(03).

       01 CMDRESP                      PIC 9(08) COMP.

       01 MISCEL-VARS.

      * Index fields

          03 INDEX-FIELDS.
             05 I                      PIC 99.
             05 J                      PIC 99.
             05 K                      PIC 99.

      * Work fields

          03 SHR-FLD.
             05 SHARES-OVERFLOW        PIC 9.
             05 SHARES-NORMAL          PIC 9(04).
          03 SHR-FLD-DEC REDEFINES SHR-FLD.
             05 SHARES-WORK1           PIC 9(5).

      * To true/false values

          03 TRUEFALSE.
             05 MOVE-DONE              PIC 9.
             05 BOOLEAN-TRUE           PIC 9 VALUE 1.
             05 BOOLEAN-FALSE          PIC 9 VALUE 0.

      * Constants for error codes and function calls

          03 CONSTANTS.
             05 RETURN-VALUES.
                07 CLEAN-RETURN        PIC X(02) VALUE '00'.
                07 UNKNOWN-REQUEST     PIC X(02) VALUE '01'.
                07 UNKNOWN-SUBTYPE     PIC X(02) VALUE '01'.
                07 BAD-CUST-READ       PIC X(02) VALUE '02'.
                07 BAD-CUST-WRITE      PIC X(02) VALUE '02'.
                07 BAD-CUST-REWRITE    PIC X(02) VALUE '02'.
                07 BAD-COMP-READ       PIC X(02) VALUE '03'.
                07 OVERFLOW-RC         PIC X(02) VALUE '04'.
                07 COMPANY-NOT-FOUND   PIC X(02) VALUE '05'.
                07 INVALID-SALE        PIC X(02) VALUE '06'.
                07 INVALID-BUY         PIC X(02) VALUE '06'.
                07 PGM-LOGIC-ERROR     PIC X(02) VALUE '98'.
                07 CUSTOMER-NOT-FOUND  PIC X(02) VALUE '99'.
             05 REQUEST-TYPES.
                07 GET-COMPANY-REQ     PIC X(15)
                       value 'Get_Company    '.
                07 SHARE-VALUE-REQ     PIC X(15)
                       value 'Share_Value    '.
                07 BUY-SELL-REQ        PIC X(15)
                       value 'Buy_Sell       '.
             05 SUBTYPES.
                07 SUBTYPE-UPDATE      PIC X(01) VALUE '0'.
                07 SUBTYPE-BUY         PIC X(01) VALUE '1'.
                07 SUBTYPE-SELL        PIC X(01) VALUE '2'.
             05 MISC.
                07 OVERFLOW-VALUE      PIC X(12) VALUE 'XXXXXXXXX.XX'.

      * TIMESTAMP FIELDS

          03 TIME-FIELDS.
             05 ABSTIME-FIELD          PIC S9(15) COMP-3.
             05 TIME-FIELD.
                07 TIME-HOURS          PIC X(02).
                07 FILLER              PIC X(01).
                07 TIME-MINUTES        PIC X(02).
                07 FILLER              PIC X(01).
                07 TIME-SECONDS        PIC X(02).

      * FIELDS FOR CONVERTING THE TYPE OF THE FIELDS

          03 CONVERSION-FIELDS.
             05 CHAR-VALUE.
                07 CHAR-INT-PART       PIC X(09).
                07 FILLER              PIC X VALUE '.'.
                07 CHAR-DEC-PART       PIC X(02).
             05 NUM-VALUE REDEFINES CHAR-VALUE.
                07 NUM-INT-PART        PIC 9(09).
                07 GUB92               PIC X.
                07 NUM-DEC-PART        PIC 9(02).
             05 DEC-VALUE.
                07 DECIMAL-SHARE-VALUE PIC 9(11)V99.
             05 WORKING-DECIMAL-VALUE REDEFINES DEC-VALUE.
                07 WORKING-OVERFLOW    PIC 9(02).
                07 WORKING-INT-PART    PIC 9(09).
                07 WORKING-DEC-PART    PIC 9(02).
             05 WORKING-CHAR-VALUE REDEFINES WORKING-DECIMAL-VALUE.
                07 WCHAR-OVERFLOW      PIC X(02).
                07 WCHAR-INT-PART      PIC X(09).
                07 WCHAR-DEC-PART      PIC X(02).

      * Calculations for the TRCERROR routine

       01 TRCERROR-WORK-AREAS.
          03 TRCERROR-MSG.
             05 FILLER                 PIC X(20)
                   VALUE '#DFHRESP#### RETURN '.
             05 FILLER                 PIC X(20)
                   VALUE 'FROM CICS #CICSCALL#'.
          03 TRCERROR-VARIABLES.
             05 CICS-DFHRESP-VALUE     PIC X(12).
             05 CICS-FUNCTION          PIC X(10) VALUE '          '.

       LINKAGE SECTION.

       01 DFHCOMMAREA                  PIC X(372).

       PROCEDURE DIVISION.

       MAINLINE SECTION.

           MOVE 'Entry'                     TO COMMENT-FIELD.
           PERFORM WRITEQ-TS.

           MOVE DFHCOMMAREA                 TO COMMAREA-BUFFER

           MOVE USER-TRACE-MSG              TO COMMENT-FIELD.
           PERFORM WRITEQ-TS.

           EVALUATE REQUEST-TYPE
              WHEN GET-COMPANY-REQ
                   PERFORM GET-COMPANY
              WHEN SHARE-VALUE-REQ
                   PERFORM GET-SHARE-VALUE
              WHEN BUY-SELL-REQ
                   PERFORM BUY-SELL
              WHEN OTHER
                   MOVE UNKNOWN-REQUEST     TO RETURN-VALUE
                   MOVE REQUEST-NOT-FOUND-MSG
                                            TO COMMENT-FIELD
                   PERFORM WRITEQ-TS
           END-EVALUATE.

           MOVE 'Exit'                      TO COMMENT-FIELD.
           PERFORM WRITEQ-TS.

           MOVE COMMAREA-BUFFER             TO DFHCOMMAREA.

           EXEC CICS RETURN
                     END-EXEC.

       MAINLINE-EXIT.

           EXIT.
      /
      *****************************************************************
      * GET ALL THE COMPANY NAMES FROM THE 'COMPFILE'                 *
      *   9/01 CHANGED COMPFILE & CUSTFILE TO TRADCOMP & TRADCUST     *
      *****************************************************************

       GET-COMPANY SECTION.

           MOVE SPACES                      TO COMPANY-NAME.

           EXEC CICS STARTBR FILE('TRADCOMP')
                             RIDFLD(COMPANY-NAME)
                             RESP(CMDRESP)
                             GTEQ
                             END-EXEC.

           PERFORM VARYING COMPANY-NAME-IDX FROM 1 BY 1
               UNTIL CMDRESP = DFHRESP(ENDFILE) OR
                     COMPANY-NAME-IDX > 4

               EXEC CICS READNEXT FILE('TRADCOMP')
                                  RIDFLD(COMPANY-NAME)
                                  INTO(COMPANY-IO-BUFFER)
                                  RESP(CMDRESP)
                                  END-EXEC

               MOVE COMPANY-NAME            TO
                        COMPANY-NAME-TAB (COMPANY-NAME-IDX)
           END-PERFORM.

           EXEC CICS ENDBR FILE('TRADCOMP')
                           RESP(CMDRESP)
                           END-EXEC.

       GET-COMPANY-EXIT.

           EXIT.
      /
      *****************************************************************
       BUY-SELL SECTION.
           EVALUATE UPDATE-BUY-SELL
             WHEN SUBTYPE-UPDATE
               PERFORM VALIDATE-COMPANY-EXISTS
               IF RETURN-VALUE = CLEAN-RETURN
                  PERFORM BUY-SELL-UPDATE-FUNCTION
               END-IF
             WHEN SUBTYPE-BUY
               PERFORM VALIDATE-COMPANY-EXISTS
               IF RETURN-VALUE = CLEAN-RETURN
                  PERFORM BUY-SELL-BUY-FUNCTION
               END-IF
             WHEN SUBTYPE-SELL
               PERFORM VALIDATE-COMPANY-EXISTS
               IF RETURN-VALUE = CLEAN-RETURN
                  PERFORM BUY-SELL-SELL-FUNCTION
               END-IF
             WHEN OTHER
               MOVE UNKNOWN-SUBTYPE TO RETURN-VALUE
               MOVE SUB-FUNCTION-NOT-FOUND-MSG TO COMMENT-FIELD
               PERFORM WRITEQ-TS
           END-EVALUATE
           .
       BUY-SELL-EXIT.
           EXIT.
      *****************************************************************
       BUY-SELL-UPDATE-FUNCTION SECTION.
           MOVE 'Entry for UPDATE' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
           PERFORM READ-CUSTFILE-FOR-UPDATE
           EVALUATE RETURN-VALUE
             WHEN CLEAN-RETURN
                  PERFORM UPDATE-BUY-SELL-FIELDS
                  PERFORM REWRITE-CUSTFILE
             WHEN CUSTOMER-NOT-FOUND
                  MOVE CLEAN-RETURN TO RETURN-VALUE
                  PERFORM BUILD-NEW-CUSTOMER
                  PERFORM UPDATE-BUY-SELL-FIELDS
                  PERFORM WRITE-CUSTFILE
             WHEN OTHER
                  MOVE BAD-CUST-READ TO RETURN-VALUE
           END-EVALUATE
           .
       BUY-SELL-UPDATE-FUNCTION-EXIT.
           EXIT.
      *****************************************************************
       UPDATE-BUY-SELL-FIELDS SECTION.
      * Move the values from the buy/sell commarea into the commarea for
      * the rewrite regardless of whether they are blank or not
      * NOTE: DO NOT ADD ANY CICS CALLS TO THIS SECTION AS THE EIBRESP
      *       CODE IS CHECKED ON RETURN!
           MOVE BUY-SELL1 TO BUY-FROM-NO
           MOVE BUY-SELL-PRICE1 TO BUY-FROM
           MOVE BUY-SELL2 TO BUY-TO-NO
           MOVE BUY-SELL-PRICE2 TO BUY-TO
           MOVE BUY-SELL3 TO SELL-FROM-NO
           MOVE BUY-SELL-PRICE3 TO SELL-FROM
           MOVE BUY-SELL4 TO SELL-TO-NO
           MOVE BUY-SELL-PRICE4 TO SELL-TO
           MOVE ALARM-CHANGE TO ALARM-PERCENT
           .
       UPDATE-BUY-SELL-FIELDS-EXIT.
           EXIT.
      *****************************************************************
       BUY-SELL-BUY-FUNCTION SECTION.
      * Check we have a record for this customer.company
      *   If we have we will do an EXEC CICS REWRITE
      *   If we havn't we will do an EXEC CICS WRITE
      * Apply the effect of the buy and issue the WRITE/REWRITE
      * Calcuate new number of shares and UPDATE CUSTFILE
           MOVE 'Entry for BUY' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
      * Check whether we have any shares yet
           PERFORM READ-CUSTFILE-FOR-UPDATE
           EVALUATE RETURN-VALUE
             WHEN CLEAN-RETURN
                  PERFORM CALCULATE-SHARES-BOUGHT
                  IF RETURN-VALUE = CLEAN-RETURN
                  THEN
                    PERFORM UPDATE-BUY-SELL-FIELDS
                    PERFORM REWRITE-CUSTFILE
      * @test 2 lines
      *             PERFORM CALCULATE-SHARE-VALUE
                    PERFORM BUILD-RESP-COMMAREA
                  END-IF
             WHEN CUSTOMER-NOT-FOUND
                  MOVE CLEAN-RETURN TO RETURN-VALUE
                  PERFORM BUILD-NEW-CUSTOMER
                  PERFORM CALCULATE-SHARES-BOUGHT
                  IF RETURN-VALUE = CLEAN-RETURN
                  THEN
                    PERFORM UPDATE-BUY-SELL-FIELDS
                    PERFORM WRITE-CUSTFILE
      * @test 2 lines
      *             PERFORM CALCULATE-SHARE-VALUE
                    PERFORM BUILD-RESP-COMMAREA
                  END-IF
             WHEN OTHER
                  MOVE BAD-CUST-READ TO RETURN-VALUE
           END-EVALUATE
           .
       BUY-SELL-BUY-FUNCTION-EXIT.
           EXIT.
      *****************************************************************
       CALCULATE-SHARES-BOUGHT SECTION.
      * Move new number of shares into i/p Commarea and
      * customer file write commarea for update
           ADD NO-OF-SHARES-DEC TO DEC-NO-SHARES GIVING SHARES-WORK1
           EVALUATE SHARES-OVERFLOW
             WHEN 0
               MOVE SHARES-NORMAL TO NO-OF-SHARES-DEC
               MOVE SHARES-NORMAL TO DEC-NO-SHARES
               PERFORM UPDATE-BUY-SELL-FIELDS
             WHEN OTHER
               MOVE INVALID-BUY TO RETURN-VALUE
               MOVE TOO-MANY-MSG TO COMMENT-FIELD
               PERFORM WRITEQ-TS
           END-EVALUATE
           .
       CALCULATE-SHARES-BOUGHT-EXIT.
           EXIT.
      *****************************************************************
       CALCULATE-SHARES-SOLD SECTION.
      * Move new number of shares into i/p Commarea and
      * customer file write commarea for update
           SUBTRACT NO-OF-SHARES-DEC FROM DEC-NO-SHARES
           GIVING DEC-NO-SHARES
           MOVE DEC-NO-SHARES TO NO-OF-SHARES-DEC
           .
       CALCULATE-SHARES-SOLD-EXIT.
           EXIT.
      *****************************************************************
       BUY-SELL-SELL-FUNCTION SECTION.
      * Check we have a record for this customer.company, if not EXIT
      * Check that we can meet the sell request, if not EXIT
      * Calcuate new number of shares and UPDATE CUSTFILE
      * Calculate new share TOTAL SHARE VALUE
           MOVE 'Entry for SELL' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
      * Check whether we have any shares to sell
           PERFORM READ-CUSTFILE-FOR-UPDATE
           EVALUATE RETURN-VALUE
             WHEN CLEAN-RETURN
                  IF NO-OF-SHARES-DEC IS GREATER THAN DEC-NO-SHARES
                  THEN
                    MOVE INVALID-SALE TO RETURN-VALUE
                    MOVE TOO-MANY-SHARES-MSG TO COMMENT-FIELD
                    PERFORM WRITEQ-TS
                  ELSE
                    PERFORM CALCULATE-SHARES-SOLD
                    PERFORM UPDATE-BUY-SELL-FIELDS
                    PERFORM REWRITE-CUSTFILE
      * @test 2 lines
      *             PERFORM CALCULATE-SHARE-VALUE
                    PERFORM BUILD-RESP-COMMAREA
                  END-IF
             WHEN CUSTOMER-NOT-FOUND
                  MOVE INVALID-SALE TO RETURN-VALUE
                  MOVE NO-SHARES-MSG TO COMMENT-FIELD
                  PERFORM WRITEQ-TS
             WHEN OTHER
                  MOVE BAD-CUST-READ TO RETURN-VALUE
           END-EVALUATE
           .
       BUY-SELL-SELL-FUNCTION-EXIT.
           EXIT.
      *****************************************************************
       VALIDATE-COMPANY-EXISTS SECTION.
           MOVE VALIDATE-MSG TO COMMENT-FIELD
           PERFORM WRITEQ-TS
           PERFORM READ-COMPFILE
           .
       VALIDATE-COMPANY-EXISTS-EXIT.
           EXIT.
      *****************************************************************
       GET-SHARE-VALUE SECTION.
           MOVE 'Entry to GET-SHARE-VALUE' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
           PERFORM READ-CUSTFILE
           EVALUATE RETURN-VALUE
             WHEN CLEAN-RETURN
                  CONTINUE
             WHEN CUSTOMER-NOT-FOUND
                  MOVE CLEAN-RETURN TO RETURN-VALUE
                  PERFORM SET-DUMMY-CUST-RECORD
             WHEN OTHER
                  CONTINUE
           END-EVALUATE
           IF RETURN-VALUE IS EQUAL TO CLEAN-RETURN
              PERFORM READ-COMPFILE
           IF RETURN-VALUE IS EQUAL TO CLEAN-RETURN
              PERFORM BUILD-RESP-COMMAREA
           .
       GET-SHARE-VALUE-EXIT.
           EXIT.
      *****************************************************************
       READ-CUSTFILE SECTION.
           MOVE 'READING RECORD FROM CUSTOMER FILE' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
      * Build record key
           MOVE USERID TO CUSTOMER OF CUSTOMER-IO-BUFFER
           MOVE '.' TO KEYREC-DOT
           MOVE COMPANY-NAME TO COMPANY OF CUSTOMER-IO-BUFFER
           EXEC CICS READ
                     FILE('TRADCUST')
                     INTO(CUSTOMER-IO-BUFFER)
                     LENGTH(LENGTH OF CUSTOMER-IO-BUFFER)
                     RIDFLD(KEYREC)
                     NOHANDLE
                     END-EXEC
           MOVE 'READ' TO CICS-FUNCTION
           PERFORM TRACE-CICS-ERROR
           EVALUATE EIBRESP
              WHEN DFHRESP(NORMAL)
                   MOVE CLEAN-RETURN TO RETURN-VALUE
              WHEN DFHRESP(NOTFND)
                   PERFORM WRITEQ-TS
                   MOVE CUSTOMER-NOT-FOUND TO RETURN-VALUE
              WHEN OTHER
                   MOVE BAD-CUST-READ TO RETURN-VALUE
                   PERFORM WRITEQ-TS
           END-EVALUATE
           .
       READ-CUSTFILE-EXIT.
           EXIT.
      *****************************************************************
       READ-CUSTFILE-FOR-UPDATE SECTION.
           MOVE 'READ FOR UPDATE OF RECORD FROM CUSTOMER FILE'
                 TO COMMENT-FIELD
           PERFORM WRITEQ-TS
      * Build record key
           MOVE USERID TO CUSTOMER OF CUSTOMER-IO-BUFFER
           MOVE '.' TO KEYREC-DOT
           MOVE COMPANY-NAME TO COMPANY OF CUSTOMER-IO-BUFFER
           EXEC CICS READ
                     FILE('TRADCUST')
                     INTO(CUSTOMER-IO-BUFFER)
                     LENGTH(LENGTH OF CUSTOMER-IO-BUFFER)
                     RIDFLD(KEYREC)
                     UPDATE
                     NOHANDLE
                     END-EXEC
           MOVE 'READ' TO CICS-FUNCTION
           PERFORM TRACE-CICS-ERROR
      * Do not use any CICS calls till after the ecaluate EIBRESP!
           EVALUATE EIBRESP
              WHEN DFHRESP(NORMAL)
                   MOVE CLEAN-RETURN TO RETURN-VALUE
              WHEN DFHRESP(NOTFND)
                   PERFORM WRITEQ-TS
                   MOVE CUSTOMER-NOT-FOUND TO RETURN-VALUE
              WHEN OTHER
                   PERFORM DEBUG-CEBR
                   MOVE BAD-CUST-READ TO RETURN-VALUE
                   PERFORM WRITEQ-TS
           END-EVALUATE
           .
       READ-CUSTFILE-FOR-UPDATE-EXIT.
           EXIT.
      *****************************************************************
       WRITE-CUSTFILE SECTION.
           MOVE 'ADDING NEW RECORD TO CUSTOMER FILE' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
      * Build record key
           MOVE USERID TO CUSTOMER OF CUSTOMER-IO-BUFFER
           MOVE '.' TO KEYREC-DOT
           MOVE COMPANY-NAME TO COMPANY OF CUSTOMER-IO-BUFFER
           EXEC CICS WRITE
                     FILE('TRADCUST')
                     FROM(CUSTOMER-IO-BUFFER)
                     LENGTH(LENGTH OF CUSTOMER-IO-BUFFER)
                     RIDFLD(KEYREC)
                     NOHANDLE
                     END-EXEC
           MOVE 'WRITE' TO CICS-FUNCTION
           PERFORM TRACE-CICS-ERROR
           EVALUATE EIBRESP
             WHEN DFHRESP(NORMAL)
                  CONTINUE
             WHEN OTHER
                  PERFORM WRITEQ-TS
                  MOVE BAD-CUST-WRITE TO RETURN-VALUE
           END-EVALUATE
           .
       WRITE-CUSTFILE-EXIT.
           EXIT.
      *****************************************************************
       REWRITE-CUSTFILE SECTION.
      * Update an existing record in the CUSTFILE
           MOVE 'UPDATING RECORD IN CUSTOMER FILE' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
           EXEC CICS REWRITE
                     FILE('TRADCUST')
                     FROM(CUSTOMER-IO-BUFFER)
                     LENGTH(LENGTH OF CUSTOMER-IO-BUFFER)
                     NOHANDLE
                     END-EXEC
           MOVE 'REWRITE' TO CICS-FUNCTION
           PERFORM TRACE-CICS-ERROR
           EVALUATE EIBRESP
             WHEN DFHRESP(NORMAL)
                  CONTINUE
             WHEN OTHER
                  PERFORM WRITEQ-TS
                  MOVE BAD-CUST-REWRITE TO RETURN-VALUE
           END-EVALUATE
           .
       WRITE-CUSTFILE-EXIT.
           EXIT.
      *****************************************************************
       READ-COMPFILE SECTION.
           MOVE 'READING RECORD FROM COMPANY FILE' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
           EXEC CICS READ
                     FILE('TRADCOMP')
                     INTO(COMPANY-IO-BUFFER)
                     LENGTH(LENGTH OF COMPANY-IO-BUFFER)
                     RIDFLD(COMPANY-NAME OF COMMAREA-BUFFER)
                     NOHANDLE
                     END-EXEC
           MOVE 'READ' TO CICS-FUNCTION
           PERFORM TRACE-CICS-ERROR
           EVALUATE EIBRESP
              WHEN DFHRESP(NORMAL)
                   MOVE CLEAN-RETURN TO RETURN-VALUE
              WHEN DFHRESP(NOTFND)
                   MOVE COMPANY-NOT-FOUND TO RETURN-VALUE
                   MOVE COMPANY-NOT-FOUND-MSG TO COMMENT-FIELD
                   PERFORM WRITEQ-TS
              WHEN OTHER
                   MOVE BAD-COMP-READ TO RETURN-VALUE
                   PERFORM WRITEQ-TS
           END-EVALUATE
           .
       READ-COMPFILE-EXIT.
           EXIT.
      *****************************************************************
       BUILD-NEW-CUSTOMER SECTION.
      * We are creating a new customer in the customer file.  Since the
      * read failed we create a blank record
           MOVE USERID TO CUSTOMER
           MOVE '.' TO KEYREC-DOT
           MOVE COMPANY-NAME TO COMPANY OF CUSTOMER-IO-BUFFER
           MOVE '0000' TO NO-SHARES
           MOVE '00000.00' TO BUY-FROM
           MOVE '0000' TO BUY-FROM-NO
           MOVE '00000.00' TO BUY-TO
           MOVE '0000' TO BUY-TO-NO
           MOVE '00000.00' TO SELL-FROM
           MOVE '0000' TO SELL-FROM-NO
           MOVE '00000.00' TO SELL-TO
           MOVE '0000' TO SELL-TO-NO
           MOVE '000' TO ALARM-PERCENT
           .
       BUILD-NEW-CUSTOMER-EXIT.
           EXIT.
      *****************************************************************
       SET-DUMMY-CUST-RECORD SECTION.
      * We are trying to return a quote but the user does not exist for
      * this company but we still need to return meaningful values
           MOVE ' ' TO CUSTOMER
           MOVE ' ' TO COMPANY OF CUSTOMER-IO-BUFFER
           MOVE '0000' TO NO-SHARES
           MOVE '        ' TO BUY-FROM
           MOVE '        ' TO BUY-TO
           MOVE '        ' TO SELL-FROM
           MOVE '        ' TO SELL-TO
           .
       SET-DUMMY-CUST-RECORD-EXIT.
           EXIT.
      *****************************************************************
       BUILD-RESP-COMMAREA SECTION.
           MOVE 'BUILDING RETURN COMMAREA' TO COMMENT-FIELD
           PERFORM WRITEQ-TS
      * Calculate the value of the shares today
           PERFORM CALCULATE-SHARE-VALUE
      * Return no of shares and unit value today
           MOVE SHARE-VALUE OF COMPANY-IO-BUFFER TO
                UNIT-SHARE-PRICE OF COMMAREA-BUFFER
           MOVE NO-SHARES OF CUSTOMER-IO-BUFFER TO
                NO-OF-SHARES OF COMMAREA-BUFFER
      * Return old unit share prices
           MOVE VALUE-1 TO UNIT-VALUE-1-DAYS
           MOVE VALUE-2 TO UNIT-VALUE-2-DAYS
           MOVE VALUE-3 TO UNIT-VALUE-3-DAYS
           MOVE VALUE-4 TO UNIT-VALUE-4-DAYS
           MOVE VALUE-5 TO UNIT-VALUE-5-DAYS
           MOVE VALUE-6 TO UNIT-VALUE-6-DAYS
           MOVE VALUE-7 TO UNIT-VALUE-7-DAYS
      * Return commision figures
           MOVE COMMISSION-SELL OF COMPANY-IO-BUFFER TO
                COMMISSION-COST-SELL OF COMMAREA-BUFFER
           MOVE COMMISSION-BUY OF COMPANY-IO-BUFFER TO
                 COMMISSION-COST-BUY OF COMMAREA-BUFFER
      * Fill in buy/sell numbers
           MOVE BUY-FROM-NO TO BUY-SELL1
           MOVE BUY-FROM TO BUY-SELL-PRICE1
           MOVE BUY-TO-NO TO BUY-SELL2
           MOVE BUY-TO TO BUY-SELL-PRICE2
           MOVE SELL-FROM-NO TO BUY-SELL3
           MOVE SELL-FROM TO BUY-SELL-PRICE3
           MOVE SELL-TO-NO TO BUY-SELL4
           MOVE SELL-TO TO BUY-SELL-PRICE4
      * Fill in alarm value
           MOVE ALARM-PERCENT TO ALARM-CHANGE
           .
       BUILD-RESP-COMMAREA-EXIT.
           EXIT.
      *****************************************************************
       CALCULATE-SHARE-VALUE SECTION.
      * Calculate value of shares today
      * The following works on AIX but not on NT...it should do!
      *    COMPUTE FP-NO-SHARES = FUNCTION NUMVAL (NO-SHARES)
      *    COMPUTE FP-SHARE-VALUE = FUNCTION NUMVAL (SHARE-VALUE)
      * Sum is DECIMAL-SHARE-VALUE = SHARE-VALUE * NO-SHARES
           MOVE 0 TO WORKING-OVERFLOW
           MOVE SHARE-VALUE-INT-PART TO WORKING-INT-PART
           MOVE SHARE-VALUE-DEC-PART TO WORKING-DEC-PART
           MULTIPLY DECIMAL-SHARE-VALUE BY DEC-NO-SHARES
             GIVING DECIMAL-SHARE-VALUE
           EVALUATE WORKING-OVERFLOW
             WHEN 0
               MOVE WORKING-INT-PART TO NUM-INT-PART
               MOVE WORKING-DEC-PART TO NUM-DEC-PART
               MOVE CHAR-VALUE TO TOTAL-SHARE-VALUE
             WHEN OTHER
               MOVE OVERFLOW-VALUE TO TOTAL-SHARE-VALUE
               MOVE OVERFLOW-RC TO RETURN-VALUE
               MOVE OVERFLOW-MSG TO COMMENT-FIELD
               PERFORM WRITEQ-TS
           END-EVALUATE
           .
       CALCULATE-SHARE-VALUE-EXIT.
           EXIT.
      *****************************************************************
       TIMESTAMP-ROUTINE SECTION.
      * Get the ABSTIME format time and pull out a human readable
      * timestamp from it.
           EXEC CICS ASKTIME ABSTIME(ABSTIME-FIELD) END-EXEC
           EXEC CICS FORMATTIME
                 ABSTIME(ABSTIME-FIELD)
                 TIME(TIME-FIELD)
                 TIMESEP(':')
                 END-EXEC
           MOVE TIME-FIELD TO TIME-TRACE
           .
       TIMESTAMP-ROUTINE-EXIT.
           EXIT.
      *****************************************************************
       REPLACE-FIELDS SECTION.

           INSPECT COMMENT-FIELD REPLACING
             ALL  '#CCCCCCCCCCCCCCCCCCC' BY COMPANY-NAME
           INSPECT COMMENT-FIELD REPLACING
             ALL  '#RRRRRRRRRRRRRR' BY REQUEST-TYPE
           INSPECT COMMENT-FIELD REPLACING
             ALL  '#UUUUUUUUUUUUUU' BY USERID ( 1:15 )
           INSPECT COMMENT-FIELD REPLACING
             ALL  '#R' BY RETURN-VALUE
           .
       REPLACE-FIELDS-EXIT.
           EXIT.
      *****************************************************************
       REMOVE-SPACES SECTION.
      * Strip blanks from COMMENT-FIELD
           PERFORM TEST BEFORE VARYING I FROM 1 BY 1 UNTIL I = 50
             IF COMMENT-FIELD ( I:1 ) = ' ' AND
                COMMENT-FIELD ( I + 1:1 ) = ' '
             THEN
               ADD 1 TO I GIVING K
               MOVE BOOLEAN-FALSE TO MOVE-DONE
               PERFORM TEST BEFORE VARYING J FROM K BY 1 UNTIL J = 50
                 IF COMMENT-FIELD ( J:1 ) NOT = ' ' AND
                    MOVE-DONE = BOOLEAN-FALSE
                 THEN
                   MOVE SPACES TO WORK-FIELD
                   MOVE COMMENT-FIELD ( 1:I )
                        TO WORK-FIELD ( 1:I )
                   MOVE COMMENT-FIELD ( J:51 - J )
                        TO WORK-FIELD ( I + 1:51 - J )
                   MOVE WORK-FIELD TO COMMENT-FIELD
                   MOVE BOOLEAN-TRUE TO MOVE-DONE
                 END-IF
               END-PERFORM
             END-IF
           END-PERFORM
           .
       REMOVE-SPACES-EXIT.
           EXIT.
      *****************************************************************
       WRITEQ-TS SECTION.
      * This section added to write to the CEBR0000 TS Queue at
      * various points in the program so that you can prove the
      * program is being used.
      * To use:  MOVE 'text' TO COMMENT-FIELD  (max of 50 chars)
      *    PERFORM TIMESTAMP-ROUTINE
      *    PERFORM REPLACE-FIELDS
      *    PERFORM REMOVE-SPACES
      *    EXEC CICS WRITEQ TS
      *          QUEUE('CEBR0000')
      *          FROM(WRITEQ-WORDS)
      *          LENGTH(LENGTH OF WRITEQ-WORDS)
      *          END-EXEC.
       WRITEQ-TS-EXIT.
           EXIT.
      *****************************************************************
       DEBUG-CEBR SECTION.
      * This section added to write debug messages without any formatting
      * being done on them.
      * To use:  MOVE 'text' TO DEBUG-WORDS  (max of 69 chars)
           EXEC CICS WRITEQ TS
                 QUEUE('CEBR0000')
                 FROM(DEBUG-WORDS)
                 LENGTH(LENGTH OF DEBUG-WORDS)
                 END-EXEC.
       DEBUG-CEBR-EXIT.
           EXIT.
      *****************************************************************
      * INCLUDE COPIED ROUTINES
      * PERFORM TRACE-CICS-ERROR examines EIBRESP and puts out a trace
      * message to the CEBR0000 log if the CICS response is not NORMAL
      *COPY TRCERROR.
       TRACE-CICS-ERROR SECTION.
           EVALUATE EIBRESP
             WHEN DFHRESP(NORMAL)
                  CONTINUE
             WHEN DFHRESP(ERROR)
                  MOVE 'ERROR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(RDATT)
                  MOVE 'RDATT' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(WRBRK)
                  MOVE 'WRBRK' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(EOF)
                  MOVE 'EOF' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(EODS)
                  MOVE 'EODS' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(EOC)
                  MOVE 'EOC' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INBFMH)
                  MOVE 'INBFMH' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ENDINPT)
                  MOVE 'ENDINPT' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NONVAL)
                  MOVE 'NONVAL' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOSTART)
                  MOVE 'NOSTART' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(TERMIDERR)
                  MOVE 'TERMIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(DSIDERR)
                  MOVE 'DSIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(FILENOTFOUND)
                  MOVE 'FILENOTFOUND' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOTFND)
                  MOVE 'NOTFND' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(DUPREC)
                  MOVE 'DUPREC' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVREQ)
                  MOVE 'INVREQ' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(IOERR)
                  MOVE 'IOERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOSPACE)
                  MOVE 'NOSPACE' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOTOPEN)
                  MOVE 'NOTOPEN' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ENDFILE)
                  MOVE 'ENDFILE' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ILLOGIC)
                  MOVE 'ILLOGIC' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(LENGERR)
                  MOVE 'LENGERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(QZERO)
                  MOVE 'QZERO' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SIGNAL)
                  MOVE 'SIGNAL' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(QBUSY)
                  MOVE 'QBUSY' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ITEMERR)
                  MOVE 'ITEMERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(PGMIDERR)
                  MOVE 'PGMIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(TRANSIDERR)
                  MOVE 'TRANSIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ENDDATA)
                  MOVE 'ENDDATA' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVTSREQ)
                  MOVE 'INVTSREQ' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(EXPIRED)
                  MOVE 'EXPIRED' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(RETPAGE)
                  MOVE 'RETPAGE' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(RTEFAIL)
                  MOVE 'RTEFAIL' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(RTESOME)
                  MOVE 'RTESOME' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(TSIOERR)
                  MOVE 'TSIOERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(MAPFAIL)
                  MOVE 'MAPFAIL' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVERRTERM)
                  MOVE 'INVERRTERM' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVMPSZ)
                  MOVE 'INVMPSZ' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(IGREQID)
                  MOVE 'IGREQID' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(OVERFLOW)
                  MOVE 'OVERFLOW' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVLDC)
                  MOVE 'INVLDC' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOSTG)
                  MOVE 'NOSTG' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(JIDERR)
                  MOVE 'JIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(QIDERR)
                  MOVE 'QIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOJBUFSP)
                  MOVE 'NOJBUFSP' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(DSSTAT)
                  MOVE 'DSSTAT' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SELNERR)
                  MOVE 'SELNERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(FUNCERR)
                  MOVE 'FUNCERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(UNEXPIN)
                  MOVE 'UNEXPIN' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOPASSBKRD)
                  MOVE 'NOPASSBKRD' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOPASSBKWR)
                  MOVE 'NOPASSBKWR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SYSIDERR)
                  MOVE 'SYSIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ISCINVREQ)
                  MOVE 'ISCINVREQ' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ENQBUSY)
                  MOVE 'ENQBUSY' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ENVDEFERR)
                  MOVE 'ENVDEFERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(IGREQCD)
                  MOVE 'IGREQCD' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SESSIONERR)
                  MOVE 'SESSIONERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SYSBUSY)
                  MOVE 'SYSBUSY' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SESSBUSY)
                  MOVE 'SESSBUSY' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOTALLOC)
                  MOVE 'NOTALLOC' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(CBIDERR)
                  MOVE 'CBIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVEXITREQ)
                  MOVE 'INVEXITREQ' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVPARTNSET)
                  MOVE 'INVPARTNSET' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(INVPARTN)
                  MOVE 'INVPARTN' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(PARTNFAIL)
                  MOVE 'PARTNFAIL' TO CICS-DFHRESP-VALUE
      * For some reason USERIDERR will not pass through CICSTRAN
      *      WHEN DFHRESP(USERIDERR)
      *           MOVE 'USERIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOTAUTH)
                  MOVE 'NOTAUTH' TO CICS-DFHRESP-VALUE
      * For some reason VOLIDERR will not pass through CICSTRAN
      *      WHEN DFHRESP(VOLIDERR)
      *           MOVE 'VOLIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SUPPRESSED)
                  MOVE 'SUPPRESSED' TO CICS-DFHRESP-VALUE
      *      WHEN DFHRESP(WRONGSTAT)
      *           MOVE 'WRONGSTAT' TO CICS-DFHRESP-VALUE
      *      WHEN DFHRESP(NAMEERROR)
      *           MOVE 'NAMEERROR' TO CICS-DFHRESP-VALUE
      *      WHEN DFHRESP(CCERROR)
      *           MOVE 'CCERROR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NOSPOOL)
                  MOVE 'NOSPOOL' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(TERMERR)
                  MOVE 'TERMERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ROLLEDBACK)
                  MOVE 'ROLLEDBACK' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(END)
                  MOVE 'END' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(DISABLED)
                  MOVE 'DISABLED' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(ALLOCERR)
                  MOVE 'ALLOCERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(STRELERR)
                  MOVE 'STRELERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(OPENERR)
                  MOVE 'OPENERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SPOLBUSY)
                  MOVE 'SPOLBUSY' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(SPOLERR)
                  MOVE 'SPOLERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(NODEIDERR)
                  MOVE 'NODEIDERR' TO CICS-DFHRESP-VALUE
             WHEN DFHRESP(TASKIDERR)
                  MOVE 'TASKIDERR' TO CICS-DFHRESP-VALUE
             WHEN OTHER
                  MOVE 'UNKNOWN' TO CICS-DFHRESP-VALUE
           END-EVALUATE
           EVALUATE EIBRESP
             WHEN DFHRESP(NORMAL)
                  CONTINUE
             WHEN OTHER
                  MOVE TRCERROR-MSG TO COMMENT-FIELD
                  INSPECT COMMENT-FIELD REPLACING
                    ALL '#DFHRESP####' BY CICS-DFHRESP-VALUE
                  INSPECT COMMENT-FIELD REPLACING
                    ALL '#CICSCALL#' BY CICS-FUNCTION
           END-EVALUATE
           MOVE '          ' TO CICS-FUNCTION.
       TRACE-CICS-ERROR-EXIT.
           EXIT.
á
