        IDENTIFICATION DIVISION.
        PROGRAM-ID. TRADERPL.

        ENVIRONMENT DIVISION.

      *****************************************************************
      * THIS PROGRAM PROVIDES THE BMS PRESENTATION LOGIC FOR THE      *
      * TRADER APPLICATION. IT LINKS TO TRADERBL FOR BUSINESS LOGIC.  *
      * IT SUPPORTS THE CICS 3270 TERMINAL TRANSACTION INTERFACE.     *
      *****************************************************************

        DATA DIVISION.
        WORKING-STORAGE SECTION.

        01  TASK-DATA.
            03 DATA1                      PIC S9(8) COMP.
            03 COMPANY-NAME-DATA          PIC X(20) VALUE SPACES.
            03 CUSTOMER-NAME-DATA         PIC X(60) VALUE SPACES.
            03 COMPANY-NAME-COMM-TABLE.
                05  COMPANY-NAME-COMM-ENTRY OCCURS 4 TIMES
                                          PIC X(20).

        01  MESSAGE-TO-SEND               PIC X(20) VALUE SPACES.
        01  START-KEY                     PIC X(20) VALUE SPACES.
        01  COMPANY-NAME                  PIC X(20) VALUE SPACES.

        01 NUMBER-SHARES                  PIC X(4) VALUE ZERO.
        01 PROG-ID                        PIC X(8) VALUE 'TRADERBL'.
        01 CUSTOMER-NAME                  PIC X(60) VALUE SPACES.
        01 SHARE-VALUES.
           03 SHARE-NOW                   PIC X(8) VALUE SPACES.
           03 SHARE-7                     PIC X(8) VALUE SPACES.
           03 SHARE-6                     PIC X(8) VALUE SPACES.
           03 SHARE-5                     PIC X(8) VALUE SPACES.
           03 SHARE-4                     PIC X(8) VALUE SPACES.
           03 SHARE-3                     PIC X(8) VALUE SPACES.
           03 SHARE-2                     PIC X(8) VALUE SPACES.
           03 SHARE-1                     PIC X(8) VALUE SPACES.
           03 COMM-SELL                   PIC X(3) VALUE SPACES.
           03 COMM-BUY                    PIC X(3) VALUE SPACES.
           03 TOTAL-OWNED                 PIC X(4) VALUE SPACES.
           03 TOTAL-VALUE                 PIC X(12) VALUE SPACES.

        01 CUSTOMER-IO-BUFFER.
            03 KEYREC.
               05 CUSTOMER                PIC X(60) VALUE SPACES.
               05 KEYREC-DOT              PIC X(1) VALUE SPACES.
               05 COMPANY                 PIC X(20) VALUE SPACES.
            03 CONVERT1.
               05 NO-SHARES               PIC X(4) VALUE SPACES.
            03 CONVERT2 REDEFINES CONVERT1.
               05 DEC-NO-SHARES           PIC 9(4).
            03 BUY-FROM                   PIC X(8) VALUE SPACES.
            03 BUY-FROM-NO                PIC X(4) VALUE SPACES.
            03 BUY-TO                     PIC X(8) VALUE SPACES.
            03 BUY-TO-NO                  PIC X(4) VALUE SPACES.
            03 SELL-FROM                  PIC X(8) VALUE SPACES.
            03 SELL-FROM-NO               PIC X(4) VALUE SPACES.
            03 SELL-TO                    PIC X(8) VALUE SPACES.
            03 SELL-TO-NO                 PIC X(4) VALUE SPACES.
            03 ALARM-PERCENT              PIC X(3) VALUE SPACES.

        01 COMPANY-IO-BUFFER.
            03 COMPANY                    PIC X(20) VALUE SPACES.
            03 SHARE-VALUE.
               05 SHARE-VALUE-INT-PART    PIC X(5) VALUE SPACES.
               05 FILLER                  PIC X(1) VALUE SPACES.
               05 SHARE-VALUE-DEC-PART    PIC X(2) VALUE SPACES.
            03 VALUE-1                    PIC X(8) VALUE SPACES.
            03 VALUE-2                    PIC X(8) VALUE SPACES.
            03 VALUE-3                    PIC X(8) VALUE SPACES.
            03 VALUE-4                    PIC X(8) VALUE SPACES.
            03 VALUE-5                    PIC X(8) VALUE SPACES.
            03 VALUE-6                    PIC X(8) VALUE SPACES.
            03 VALUE-7                    PIC X(8) VALUE SPACES.
            03 COMMISSION-BUY             PIC X(3) VALUE SPACES.
            03 COMMISSION-SELL            PIC X(3) VALUE SPACES.

        01 GET-COMP-BUFFER.
            03 GET-COMP-REQUEST-TYPE      PIC X(15) VALUE SPACES.
            03 FILLER                     PIC X(277) VALUE SPACES.
            03 COMPANY-NAME-BUFFER.
                05  COMPANY-NAME-TAB OCCURS 4 TIMES
                      INDEXED BY COMPANY-NAME-IDX
                                             PIC X(20).

        01 QUOTE-RETURN-BUFFER.
            03 QUOTE-REQUEST-TYPE         PIC X(15) VALUE SPACES.
            03 QUOTE-RTN-CODE             PIC X(2) VALUE SPACES.
            03 QUOTE-AUTHOR               PIC X(60) VALUE SPACES.
            03 QUOTE-PASSWORD             PIC X(10) VALUE SPACES.
            03 QUOTE-COMPANY-NAME         PIC X(20) VALUE SPACES.
            03 QUOTE-CORR-ID              PIC X(32) VALUE SPACES.
            03 QUOTE-SHARE-NOW            PIC X(8) VALUE SPACES.
            03 QUOTE-SHARE-7              PIC X(8) VALUE SPACES.
            03 QUOTE-SHARE-6              PIC X(8) VALUE SPACES.
            03 QUOTE-SHARE-5              PIC X(8) VALUE SPACES.
            03 QUOTE-SHARE-4              PIC X(8) VALUE SPACES.
            03 QUOTE-SHARE-3              PIC X(8) VALUE SPACES.
            03 QUOTE-SHARE-2              PIC X(8) VALUE SPACES.
            03 QUOTE-SHARE-1              PIC X(8) VALUE SPACES.
            03 QUOTE-COMM-SELL            PIC X(3) VALUE SPACES.
            03 QUOTE-COMM-BUY             PIC X(3) VALUE SPACES.
            03 QUOTE-SHARES-HELD          PIC X(4) VALUE SPACES.
            03 QUOTE-SHARES-VALUE         PIC X(12) VALUE SPACES.
            03 QUOTE-BUY-SELL-1           PIC X(4) VALUE SPACES.
            03 QUOTE-BUY-SELL-PRICE-1     PIC X(8) VALUE SPACES.
            03 QUOTE-BUY-SELL-2           PIC X(4) VALUE SPACES.
            03 QUOTE-BUY-SELL-PRICE-2     PIC X(8) VALUE SPACES.
            03 QUOTE-BUY-SELL-3           PIC X(4) VALUE SPACES.
            03 QUOTE-BUY-SELL-PRICE-3     PIC X(8) VALUE SPACES.
            03 QUOTE-BUY-SELL-4           PIC X(4) VALUE SPACES.
            03 QUOTE-BUY-SELL-PRICE-4     PIC X(8) VALUE SPACES.
            03 QUOTE-ALARM                PIC X(3) VALUE SPACES.

        01 QUOTE-OUT-BUFFER.
            03 OUT-REQUEST-TYPE           PIC X(15) VALUE SPACES.
            03 OUT-RTN-CODE               PIC X(2) VALUE SPACES.
            03 OUT-AUTHOR                 PIC X(60) VALUE SPACES.
            03 OUT-PASSWORD               PIC X(10) VALUE SPACES.
            03 OUT-COMPANY-NAME           PIC X(20) VALUE SPACES.
            03 OUT-CORR-ID                PIC X(32) VALUE SPACES.
            03 FILLER                     PIC X(233) VALUE SPACES.

        01 TRADE-OUT-BUFFER.
            03 TRADE-REQUEST-TYPE         PIC X(15) VALUE SPACES.
            03 TRADE-RTN-CODE             PIC X(2) VALUE SPACES.
            03 TRADE-AUTHOR               PIC X(60) VALUE SPACES.
            03 TRADE-PASSWORD             PIC X(10) VALUE SPACES.
            03 TRADE-COMPANY-NAME         PIC X(20) VALUE SPACES.
            03 TRADE-CORR-ID              PIC X(32) VALUE SPACES.
            03 TRADE-FILLER               PIC X(70) VALUE SPACES.
            03 TRADE-AMOUNT               PIC X(4) VALUE SPACES.
            03 TRADE-FILL                 PIC X(12) VALUE SPACES.
            03 TRADE-BUY-SELL-1           PIC X(4) VALUE SPACES.
            03 TRADE-BUY-SELL-PRICE-1     PIC X(8) VALUE SPACES.
            03 TRADE-BUY-SELL-2           PIC X(4) VALUE SPACES.
            03 TRADE-BUY-SELL-PRICE-2     PIC X(8) VALUE SPACES.
            03 TRADE-BUY-SELL-3           PIC X(4) VALUE SPACES.
            03 TRADE-BUY-SELL-PRICE-3     PIC X(8) VALUE SPACES.
            03 TRADE-BUY-SELL-4           PIC X(4) VALUE SPACES.
            03 TRADE-BUY-SELL-PRICE-4     PIC X(8) VALUE SPACES.
            03 TRADE-ALARM                PIC X(3) VALUE SPACES.
            03 TRADE-BUY-SELL-OPTION      PIC X(1) VALUE SPACES.
            03 FILLER                     PIC X(95) VALUE SPACES.

        COPY NEWTRSET.
        COPY DFHAID.

        LINKAGE SECTION.

        01  DFHCOMMAREA                   PIC X(168).

        PROCEDURE DIVISION.

      ***********************************************************
      * Main Program loop starts here....                       *
      ***********************************************************

        MAIN-PROCESS SECTION.

      ***********************************************************
      * FIRST TIME PROCESSING                                   *
      ***********************************************************

            IF EIBCALEN = 0

               MOVE LOW-VALUES TO T001O
               MOVE LOW-VALUES TO T002O
               MOVE LOW-VALUES TO T003O
               MOVE LOW-VALUES TO T004O
               MOVE LOW-VALUES TO T005O
               MOVE LOW-VALUES TO T006O
               MOVE SPACES TO  COMPANY-NAME-COMM-TABLE
               MOVE 'Get_Company   ' TO GET-COMP-REQUEST-TYPE

               EXEC CICS LINK PROGRAM(PROG-ID)
                              COMMAREA(GET-COMP-BUFFER)
                              LENGTH(LENGTH OF GET-COMP-BUFFER)
                              END-EXEC

               MOVE 1 TO DATA1

               PERFORM VARYING COMPANY-NAME-IDX
                   FROM 1 BY 1
                   UNTIL COMPANY-NAME-IDX > 4

                   MOVE COMPANY-NAME-TAB (COMPANY-NAME-IDX)
                                         TO
                        COMPANY-NAME-COMM-ENTRY (COMPANY-NAME-IDX)
               END-PERFORM

               EXEC CICS SEND MAP('T001')
                              MAPSET('NEWTRAD')
                              FREEKB
                              ERASE
                              END-EXEC

               EXEC CICS RETURN TRANSID('TRAD')
                                COMMAREA (TASK-DATA)
                                LENGTH(168)
                                END-EXEC

            END-IF.

      ***********************************************************
      * END OF FIRST TIME PROCESSING                            *
      ***********************************************************

            MOVE DFHCOMMAREA TO TASK-DATA.

            IF DATA1 = 1
               ADD 1 TO DATA1
               MOVE LOW-VALUES TO T001I
               EXEC CICS RECEIVE MAP('T001')
                           MAPSET('NEWTRAD')
                           NOHANDLE
                           END-EXEC
               MOVE ' ' TO MESS1O
               EVALUATE EIBAID
                   WHEN DFHPF3   PERFORM EXIT-TRANSACTION
                   WHEN DFHPF12  PERFORM EXIT-TRANSACTION
                   WHEN DFHCLEAR CONTINUE
                   WHEN DFHENTER
                       IF ((USER1L NOT = 0) AND (PASS1L NOT = 0))
                           MOVE USER1I TO CUSTOMER-NAME
                           MOVE CUSTOMER-NAME TO CUSTOMER-NAME-DATA
                           MOVE LOW-VALUES TO T002O
                           MOVE LOW-VALUES TO OPTIONO
                           MOVE COMPANY-NAME-COMM-ENTRY (1)
                                               TO COMP1O
                           MOVE COMPANY-NAME-COMM-ENTRY (2)
                                               TO COMP2O
                           MOVE COMPANY-NAME-COMM-ENTRY (3)
                                               TO COMP3O
                           MOVE COMPANY-NAME-COMM-ENTRY (4)
                                               TO COMP4O
      *                    EXEC CICS SEND CONTROL ERASE END-EXEC
                           EXEC CICS SEND MAP('T002')
                               MAPSET('NEWTRAD')
                               FREEKB ERASE END-EXEC
                       ELSE
                           SUBTRACT 1 FROM DATA1
                       MOVE 'Please enter a User Name and Password'
                          TO MESS1O
      *                    EXEC CICS SEND CONTROL ERASE END-EXEC
                           MOVE LOW-VALUES TO USER1O
                           MOVE LOW-VALUES TO PASS1O
                           EXEC CICS SEND MAP('T001')
                                  MAPSET('NEWTRAD')
                                  FREEKB ERASE END-EXEC
                       END-IF
                   WHEN OTHER
                       SUBTRACT 1 FROM DATA1
                       MOVE 'Invalid function key' TO MESS1O
      *                    EXEC CICS SEND CONTROL ERASE END-EXEC
                           MOVE LOW-VALUES TO USER1O
                           MOVE LOW-VALUES TO PASS1O
                           EXEC CICS SEND MAP('T001')
                                  MAPSET('NEWTRAD')
                                  FREEKB ERASE END-EXEC

               END-EVALUATE
               EXEC CICS RETURN TRANSID ('TRAD')
               COMMAREA (TASK-DATA) LENGTH (168) END-EXEC.

           IF DATA1 = 2
               MOVE 3 TO DATA1
               PERFORM GET-COMPANY-SELECTION
               EXEC CICS RETURN TRANSID ('TRAD')
               COMMAREA (TASK-DATA) LENGTH (168) END-EXEC.
           IF DATA1 = 3
               MOVE 4 TO DATA1
               PERFORM GET-OPTIONS
               EXEC CICS RETURN TRANSID ('TRAD')
               COMMAREA (TASK-DATA) LENGTH (168) END-EXEC.
           IF DATA1 = 4
               EXEC CICS RECEIVE MAP('T004')
                   MAPSET('NEWTRAD')
                   NOHANDLE
               END-EXEC

               MOVE ' ' TO MESS4O
               EVALUATE EIBAID
                   WHEN DFHENTER
                       SUBTRACT 1 FROM DATA1
                       MOVE LOW-VALUES TO OPT2O
      *                EXEC CICS SEND CONTROL ERASE END-EXEC
                       EXEC CICS SEND MAP('T003')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
                   WHEN DFHPF3
                       SUBTRACT 1 FROM DATA1
                       MOVE LOW-VALUES TO OPT2O
      *                EXEC CICS SEND CONTROL ERASE END-EXEC
                       EXEC CICS SEND MAP('T003')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
                   WHEN DFHPF12  PERFORM EXIT-TRANSACTION
                   WHEN DFHCLEAR CONTINUE
                   WHEN OTHER
                       SUBTRACT 1 FROM DATA1
                       MOVE LOW-VALUES TO OPT2O
      *                EXEC CICS SEND CONTROL ERASE END-EXEC
                       EXEC CICS SEND MAP('T003')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
               END-EVALUATE
               EXEC CICS RETURN TRANSID ('TRAD')
               COMMAREA (TASK-DATA) LENGTH (168) END-EXEC.

           IF DATA1 = 5
               MOVE LOW-VALUES TO T005I
               EXEC CICS RECEIVE MAP('T005')
                   MAPSET('NEWTRAD')
                   NOHANDLE
               END-EXEC
               PERFORM GET-AMOUNT-TO-BUY
               EXEC CICS RETURN TRANSID ('TRAD')
               COMMAREA (TASK-DATA) LENGTH (168) END-EXEC.

           IF DATA1 = 6
               MOVE LOW-VALUES TO T006I
               EXEC CICS RECEIVE MAP('T006')
                     MAPSET('NEWTRAD')
                     NOHANDLE
               END-EXEC
               PERFORM GET-AMOUNT-TO-SELL
               EXEC CICS RETURN TRANSID ('TRAD')
               COMMAREA (TASK-DATA) LENGTH (168) END-EXEC.

         MAIN-PROCESS-EXIT.
            EXEC CICS RETURN END-EXEC.
            EXIT.
      ***********************************************************
      * Main Program loop ENDS here....                         *
      ***********************************************************

      ***********************************************************
      *  GET-COMPANY-SELECTION STARTS HERE ...                  *
      ***********************************************************

        GET-COMPANY-SELECTION SECTION.
           MOVE LOW-VALUES TO T002I
           EXEC CICS RECEIVE MAP('T002')
                     MAPSET('NEWTRAD')
                     NOHANDLE
                     END-EXEC.

           MOVE ' ' TO MESS2O.
           EVALUATE EIBAID
               WHEN DFHENTER
                    IF OPTIONL = 0
                        MOVE 2 TO DATA1
                        MOVE 'You must select a company' TO MESS2O
                        MOVE ZEROES TO OPTIONO
                        MOVE COMPANY-NAME-COMM-ENTRY (1)
                                            TO COMP1O
                        MOVE COMPANY-NAME-COMM-ENTRY (2)
                                            TO COMP2O
                        MOVE COMPANY-NAME-COMM-ENTRY (3)
                                            TO COMP3O
                        MOVE COMPANY-NAME-COMM-ENTRY (4)
                                            TO COMP4O
      *                 EXEC CICS SEND CONTROL ERASE END-EXEC
                        EXEC CICS SEND MAP('T002')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
                    ELSE
                        MOVE ' ' TO MESS3O
                        EVALUATE OPTIONI
                           WHEN '1'
                               MOVE COMPANY-NAME-COMM-ENTRY (1)
                                        TO COMPANY-NAME
                               MOVE COMPANY-NAME TO COMPANY-NAME-DATA
                               MOVE LOW-VALUES TO OPT2O
      *                        EXEC CICS SEND CONTROL ERASE END-EXEC
                               EXEC CICS SEND MAP('T003')
                                   MAPSET('NEWTRAD')
                                   FREEKB ERASE END-EXEC
                           WHEN '2'
                               MOVE COMPANY-NAME-COMM-ENTRY (2)
                                        TO COMPANY-NAME
                               MOVE COMPANY-NAME TO COMPANY-NAME-DATA
      *                        EXEC CICS SEND CONTROL ERASE END-EXEC
                               EXEC CICS SEND MAP('T003')
                                   MAPSET('NEWTRAD')
                                   FREEKB ERASE END-EXEC
                           WHEN '3'
                               MOVE COMPANY-NAME-COMM-ENTRY (3)
                                        TO COMPANY-NAME
                               MOVE COMPANY-NAME TO COMPANY-NAME-DATA
      *                        EXEC CICS SEND CONTROL ERASE END-EXEC
                               EXEC CICS SEND MAP('T003')
                                   MAPSET('NEWTRAD')
                                   FREEKB ERASE END-EXEC
                           WHEN '4'
                               MOVE COMPANY-NAME-COMM-ENTRY (4)
                                        TO COMPANY-NAME
                               MOVE COMPANY-NAME TO COMPANY-NAME-DATA
      *                        EXEC CICS SEND CONTROL ERASE END-EXEC
                               EXEC CICS SEND MAP('T003')
                                   MAPSET('NEWTRAD')
                                   FREEKB ERASE END-EXEC
                           WHEN OTHER
                              MOVE 2 TO DATA1
                              MOVE 'You must select a company' TO MESS2O
                              MOVE LOW-VALUES TO OPTIONO
                              MOVE COMPANY-NAME-COMM-ENTRY (1)
                                                  TO COMP1O
                              MOVE COMPANY-NAME-COMM-ENTRY (2)
                                                  TO COMP2O
                              MOVE COMPANY-NAME-COMM-ENTRY (3)
                                                  TO COMP3O
                              MOVE COMPANY-NAME-COMM-ENTRY (4)
                                                  TO COMP4O
      *                       EXEC CICS SEND CONTROL ERASE END-EXEC
                              EXEC CICS SEND MAP('T002')
                                 MAPSET('NEWTRAD')
                                 FREEKB ERASE END-EXEC
                        END-EVALUATE
                    END-IF
                WHEN DFHPF3
                    MOVE 1 TO DATA1
      *             EXEC CICS SEND CONTROL ERASE END-EXEC
                    MOVE LOW-VALUES TO USER1O
                    MOVE LOW-VALUES TO PASS1O
                    EXEC CICS SEND MAP('T001')
                          MAPSET('NEWTRAD')
                          FREEKB ERASE END-EXEC
                WHEN DFHPF12  PERFORM EXIT-TRANSACTION
                WHEN DFHCLEAR CONTINUE
                WHEN OTHER
                   MOVE 2 TO DATA1
                   MOVE 'Invalid function key' TO MESS2O
                   MOVE LOW-VALUES TO OPTIONO
                   MOVE COMPANY-NAME-COMM-ENTRY (1)
                                       TO COMP1O
                   MOVE COMPANY-NAME-COMM-ENTRY (2)
                                       TO COMP2O
                   MOVE COMPANY-NAME-COMM-ENTRY (3)
                                       TO COMP3O
                   MOVE COMPANY-NAME-COMM-ENTRY (4)
                                       TO COMP4O
      *            EXEC CICS SEND CONTROL ERASE END-EXEC
                   EXEC CICS SEND MAP('T002')
                      MAPSET('NEWTRAD')
                      FREEKB ERASE END-EXEC

            END-EVALUATE.
        GET-COMPANY-SELECTION-EXIT.
           EXIT.

      ***********************************************************
      *  GET-COMPANY-SELECTION ENDS HERE ...                  *
      ***********************************************************

      ***********************************************************
      * GET-OPTIONS STARTS HERE ...                   *
      ***********************************************************

        GET-OPTIONS SECTION.

           EXEC CICS RECEIVE MAP('T003')
               MAPSET('NEWTRAD')
               NOHANDLE
           END-EXEC.

           MOVE ' ' TO MESS3O.
           EVALUATE EIBAID
               WHEN DFHENTER
                    IF OPT2L = 0
                        MOVE 3 TO DATA1
                        MOVE 'You must select a option' TO MESS3O
      *                 EXEC CICS SEND CONTROL ERASE END-EXEC
                        EXEC CICS SEND MAP('T003')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
                    ELSE
                        EVALUATE OPT2I
                           WHEN '1'
                               PERFORM GET-QUOTE
                           WHEN '2'
                               MOVE 5 TO DATA1
                               MOVE LOW-VALUES TO T005O
                               MOVE COMPANY-NAME-DATA TO COMP51O
                               MOVE CUSTOMER-NAME-DATA TO USER51O
                               MOVE LOW-VALUES TO SHRBUYO
                               EXEC CICS SEND MAP('T005')
                                   MAPSET('NEWTRAD')
                                   FREEKB ERASE END-EXEC
                           WHEN '3'
                               MOVE 6 TO DATA1
                               MOVE LOW-VALUES TO T006O
                               MOVE COMPANY-NAME-DATA TO COMP61O
                               MOVE CUSTOMER-NAME-DATA TO USER61O
                               MOVE LOW-VALUES TO SHRSELLO
                               EXEC CICS SEND MAP('T006')
                                   MAPSET('NEWTRAD')
                                   FREEKB ERASE END-EXEC

                           WHEN OTHER
                             MOVE 3 TO DATA1
                             MOVE 'You must select a option' TO MESS3O
      *                      EXEC CICS SEND CONTROL ERASE END-EXEC
                             EXEC CICS SEND MAP('T003')
                                 MAPSET('NEWTRAD')
                                 FREEKB ERASE END-EXEC
                        END-EVALUATE
                    END-IF
                WHEN DFHPF3
                    MOVE 2 TO DATA1
                    MOVE ' ' TO MESS2O
                    MOVE LOW-VALUES TO OPTIONO
                    MOVE COMPANY-NAME-COMM-ENTRY (1)
                                        TO COMP1O
                    MOVE COMPANY-NAME-COMM-ENTRY (2)
                                        TO COMP2O
                    MOVE COMPANY-NAME-COMM-ENTRY (3)
                                        TO COMP3O
                    MOVE COMPANY-NAME-COMM-ENTRY (4)
                                        TO COMP4O
      *             EXEC CICS SEND CONTROL ERASE END-EXEC
                    EXEC CICS SEND MAP('T002')
                       MAPSET('NEWTRAD')
                       FREEKB ERASE END-EXEC
                WHEN DFHPF12  PERFORM EXIT-TRANSACTION
                WHEN DFHCLEAR CONTINUE
                WHEN OTHER
                    MOVE 3 TO DATA1
                    MOVE 'Invalid function key' TO MESS3O
      *             EXEC CICS SEND CONTROL ERASE END-EXEC
                    EXEC CICS SEND MAP('T003')
                       MAPSET('NEWTRAD')
                       FREEKB ERASE END-EXEC
            END-EVALUATE.

        GET-OPTIONS-EXIT.
           EXIT.

      ***********************************************************
      * GET-OPTIONS ENDS HERE ...                     *
      ***********************************************************

      ***********************************************************
      * GET-QUOTE STARTS HERE ...                               *
      ***********************************************************

        GET-QUOTE SECTION.

           MOVE 'Share_Value    '
                       TO OUT-REQUEST-TYPE OF QUOTE-OUT-BUFFER
           MOVE '00' TO OUT-RTN-CODE OF QUOTE-OUT-BUFFER
           MOVE CUSTOMER-NAME-DATA TO OUT-AUTHOR OF QUOTE-OUT-BUFFER
           MOVE COMPANY-NAME-DATA
                TO OUT-COMPANY-NAME OF QUOTE-OUT-BUFFER

           EXEC CICS LINK PROGRAM(PROG-ID)
               COMMAREA(QUOTE-OUT-BUFFER)
               LENGTH(LENGTH OF QUOTE-OUT-BUFFER)
           END-EXEC.

           MOVE QUOTE-OUT-BUFFER TO QUOTE-RETURN-BUFFER.

           EVALUATE QUOTE-RTN-CODE
                WHEN '00'
                   MOVE 'Request Completed OK' TO MESS4O
                WHEN '01'
                   MOVE 'Request Failed: UNKNOWN REQUEST' TO MESS4O
                WHEN '02'
           MOVE 'Request Failed: BAD CUSTOMER READ/WRITE' TO MESS4O
                WHEN '03'
                   MOVE 'Request Failed: BAD COMPANY READ' TO MESS4O
                WHEN '04'
                   MOVE 'Request Failed: OVERFLOW' TO MESS4O
                WHEN '05'
                   MOVE 'Request Failed: COMPANY NOT FOUND' TO MESS4O
                WHEN '06'
                   MOVE 'Request Failed: INVALID SALE/BUY' TO MESS4O
                WHEN '99'
                   MOVE 'Request Failed: CUSTOMER NOT FOUND' TO MESS4O
                WHEN OTHER
                   MOVE ' ' TO MESS4O
            END-EVALUATE.

            PERFORM SHOW-QUOTE.

        GET-QUOTE-EXIT.
           EXIT.
      ***********************************************************
      * GET-QUOTE ENDS HERE ...                                 *
      ***********************************************************


      ***********************************************************
      * SHOW-QUOTE STARTS HERE ...                              *
      ***********************************************************

        SHOW-QUOTE SECTION.

           IF QUOTE-SHARES-HELD = '0000'
              MOVE 'Information: You hold no shares in this company !'
                   TO MESS4O
           END-IF
           MOVE QUOTE-COMPANY-NAME TO COMP41O
           MOVE QUOTE-AUTHOR TO USER41O
           MOVE QUOTE-SHARE-NOW TO SHRNOWO
           MOVE QUOTE-SHARE-7 TO SHARE7O
           MOVE QUOTE-SHARE-6 TO SHARE6O
           MOVE QUOTE-SHARE-5 TO SHARE5O
           MOVE QUOTE-SHARE-4 TO SHARE4O
           MOVE QUOTE-SHARE-3 TO SHARE3O
           MOVE QUOTE-SHARE-2 TO SHARE2O
           MOVE QUOTE-SHARE-1 TO SHARE1O
           MOVE QUOTE-COMM-SELL TO SELLO
           MOVE QUOTE-COMM-BUY TO BUYO
           MOVE QUOTE-SHARES-HELD TO HELDO
           MOVE QUOTE-SHARES-VALUE TO VALUEO

      *    EXEC CICS SEND CONTROL ERASE END-EXEC.
           EXEC CICS SEND MAP('T004')
               MAPSET('NEWTRAD')
               FREEKB ERASE END-EXEC.

        SHOW-QUOTE-EXIT.
           EXIT.


      ***********************************************************
      * SHOW-QUOTE ENDS HERE ...                                *
      ***********************************************************

      ***********************************************************
      * GET-AMOUNT-TO-BUY STARTS HERE ...                       *
      ***********************************************************

        GET-AMOUNT-TO-BUY SECTION.

           MOVE SPACES TO MESS5O
           EVALUATE EIBAID
                WHEN DFHENTER
                   IF SHRBUYL = 0
                       MOVE 5 TO DATA1
                       MOVE 'You must enter an amount' TO MESS5O
                       MOVE COMPANY-NAME-DATA TO COMP51O
                       MOVE CUSTOMER-NAME-DATA TO USER51O
                       MOVE LOW-VALUES TO SHRBUYO
      *                EXEC CICS SEND CONTROL ERASE END-EXEC
                       EXEC CICS SEND MAP('T005')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
                   ELSE
                       MOVE 3 TO DATA1
                       MOVE SHRBUYI TO NUMBER-SHARES
                       PERFORM SEND-BUY
                   END-IF
                WHEN DFHPF3
                   MOVE 3 TO DATA1
      *            EXEC CICS SEND CONTROL ERASE END-EXEC
                   EXEC CICS SEND MAP('T003')
                       MAPSET('NEWTRAD')
                       FREEKB ERASE END-EXEC
                WHEN DFHPF12  PERFORM EXIT-TRANSACTION
                WHEN DFHCLEAR CONTINUE
                WHEN OTHER
                   MOVE 5 TO DATA1
                   MOVE 'Invalid function key' TO MESS5O
                       MOVE COMPANY-NAME-DATA TO COMP51O
                       MOVE CUSTOMER-NAME-DATA TO USER51O
                       MOVE LOW-VALUES TO SHRBUYO
      *                EXEC CICS SEND CONTROL ERASE END-EXEC
                       EXEC CICS SEND MAP('T005')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
            END-EVALUATE.

        GET-AMOUNT-TO-BUY-EXIT.
           EXIT.

      ***********************************************************
      * GET-AMOUNT-TO-BUY ENDS HERE ...                         *
      ***********************************************************

      ***********************************************************
      * SEND-BUY STARTS HERE ...                   *
      ***********************************************************

         SEND-BUY SECTION.
           MOVE 'Buy_Sell       '
                 TO TRADE-REQUEST-TYPE OF TRADE-OUT-BUFFER
           MOVE '00' TO TRADE-RTN-CODE OF TRADE-OUT-BUFFER
           MOVE CUSTOMER-NAME-DATA TO TRADE-AUTHOR OF TRADE-OUT-BUFFER
           MOVE COMPANY-NAME-DATA
                TO TRADE-COMPANY-NAME OF TRADE-OUT-BUFFER
           MOVE '1' TO TRADE-BUY-SELL-OPTION OF TRADE-OUT-BUFFER
           MOVE NUMBER-SHARES TO TRADE-AMOUNT OF TRADE-OUT-BUFFER

           EXEC CICS LINK PROGRAM(PROG-ID)
               COMMAREA(TRADE-OUT-BUFFER)
               LENGTH(LENGTH OF TRADE-OUT-BUFFER)
               END-EXEC.

           MOVE TRADE-OUT-BUFFER TO QUOTE-RETURN-BUFFER.

           EVALUATE QUOTE-RTN-CODE
                WHEN '00'
                   MOVE 'Request Completed OK' TO MESS3O
                WHEN '01'
                   MOVE 'Request Failed: UNKNOWN REQUEST' TO MESS3O
                WHEN '02'
           MOVE 'Request Failed: BAD CUSTOMER READ/WRITE' TO MESS3O
                WHEN '03'
                   MOVE 'REQUEST FAILED: BAD COMPANY READ' TO MESS3O
                WHEN '04'
                   MOVE 'Request Failed: OVERFLOW' TO MESS3O
                WHEN '05'
                   MOVE 'Request Failed: COMPANY NOT FOUND' TO MESS3O
                WHEN '06'
                   MOVE 'Request Failed: INVALID SALE/BUY' TO MESS3O
                WHEN '99'
                   MOVE 'Request Failed: CUSTOMER NOT FOUND' TO MESS3O
                WHEN OTHER
                   MOVE ' ' TO MESS3O
            END-EVALUATE.

      *     EXEC CICS SEND CONTROL ERASE END-EXEC.
            EXEC CICS SEND MAP('T003')
               MAPSET('NEWTRAD')
               FREEKB ERASE END-EXEC.
         SEND-BUY-EXIT.
           EXIT.
      ***********************************************************
      * SEND-BUY ENDS HERE ...                     *
      ***********************************************************

      ***********************************************************
      * GET-AMOUNT-TO-SELL STARTS HERE ...                      *
      ***********************************************************

        GET-AMOUNT-TO-SELL SECTION.

           MOVE ' ' TO MESS6O
           EVALUATE EIBAID
                WHEN DFHENTER
                   IF SHRSELLL = 0
                       MOVE 6 TO DATA1
                       MOVE 'You must enter an amount' TO MESS6O
                       MOVE COMPANY-NAME-DATA TO COMP61O
                       MOVE CUSTOMER-NAME-DATA TO USER61O
                       MOVE LOW-VALUES TO SHRSELLO
      *                EXEC CICS SEND CONTROL ERASE END-EXEC
                       EXEC CICS SEND MAP('T006')
                            MAPSET('NEWTRAD')
                            FREEKB ERASE END-EXEC
                   ELSE
                       MOVE 3 TO DATA1
                       MOVE SHRSELLI TO NUMBER-SHARES
                       PERFORM SEND-SELL
                   END-IF
                WHEN DFHPF3
                   MOVE 3 TO DATA1
      *            EXEC CICS SEND CONTROL ERASE END-EXEC
                   EXEC CICS SEND MAP('T003')
                       MAPSET('NEWTRAD')
                       FREEKB ERASE END-EXEC
                WHEN DFHPF12  PERFORM EXIT-TRANSACTION
                WHEN DFHCLEAR CONTINUE
                WHEN OTHER
                   MOVE 6 TO DATA1
                   MOVE 'Invalid function key' TO MESS6O
                   MOVE COMPANY-NAME-DATA TO COMP61O
                   MOVE CUSTOMER-NAME-DATA TO USER61O
                   MOVE LOW-VALUES TO SHRBUYO
      *            EXEC CICS SEND CONTROL ERASE END-EXEC
                   EXEC CICS SEND MAP('T005')
                       MAPSET('NEWTRAD')
                       FREEKB ERASE END-EXEC
            END-EVALUATE.

        GET-AMOUNT-TO-SELL-EXIT.
           EXIT.

      ***********************************************************
      * GET-AMOUNT-TO-SELL ENDS HERE ...                        *
      ***********************************************************

      ***********************************************************
      * SEND-SELL STARTS HERE ...                   *
      ***********************************************************

         SEND-SELL SECTION.
           MOVE 'Buy_Sell       '
                 TO TRADE-REQUEST-TYPE OF TRADE-OUT-BUFFER
           MOVE '00' TO TRADE-RTN-CODE OF TRADE-OUT-BUFFER
           MOVE CUSTOMER-NAME-DATA TO TRADE-AUTHOR OF TRADE-OUT-BUFFER
           MOVE COMPANY-NAME-DATA
                TO TRADE-COMPANY-NAME OF TRADE-OUT-BUFFER
           MOVE '2' TO TRADE-BUY-SELL-OPTION OF TRADE-OUT-BUFFER
           MOVE NUMBER-SHARES TO TRADE-AMOUNT OF TRADE-OUT-BUFFER

           EXEC CICS LINK PROGRAM(PROG-ID)
               COMMAREA(TRADE-OUT-BUFFER)
               LENGTH(LENGTH OF TRADE-OUT-BUFFER)
               END-EXEC.

           MOVE TRADE-OUT-BUFFER TO QUOTE-RETURN-BUFFER.

           EVALUATE QUOTE-RTN-CODE
                WHEN '00'
                   MOVE 'Request Completed OK' TO MESS3O
                WHEN '01'
                   MOVE 'Request Failed: UNKNOWN REQUEST' TO MESS3O
                WHEN '02'
           MOVE 'Request Failed: BAD CUSTOMER READ/WRITE' TO MESS3O
                WHEN '03'
                   MOVE 'Request Failed: BAD READ/WRITE' TO MESS3O
                WHEN '04'
                   MOVE 'Request Failed: OVERFLOW' TO MESS3O
                WHEN '05'
                   MOVE 'Request Failed: COMPANY NOT FOUND' TO MESS3O
                WHEN '06'
                   MOVE 'Request Failed: INVALID SALE/BUY' TO MESS3O
                WHEN '99'
                   MOVE 'Request Failed: CUSTOMER NOT FOUND' TO MESS3O
                WHEN OTHER
                   MOVE ' ' TO MESS3O
            END-EVALUATE.

      *     EXEC CICS SEND CONTROL ERASE END-EXEC.
            EXEC CICS SEND MAP('T003')
               MAPSET('NEWTRAD')
               FREEKB ERASE END-EXEC.

         SEND-SELL-EXIT.
           EXIT.
      ***********************************************************
      * SEND-BUY ENDS HERE ...                     *
      ***********************************************************

      ***********************************************************
      * EXIT-TRANSACTION STARTS HERE ...                        *
      ***********************************************************

        EXIT-TRANSACTION SECTION.
      *********************************************************
      * End of this transaction, put out message and die...
      *********************************************************

            MOVE 'Trader: Session Over' to MESSAGE-TO-SEND.
      *     EXEC CICS SEND CONTROL ERASE FREEKB END-EXEC.
            EXEC CICS SEND FROM(MESSAGE-TO-SEND)
                           LENGTH(LENGTH OF MESSAGE-TO-SEND) END-EXEC.
            EXEC CICS RETURN END-EXEC.

        EXIT-TRANSACTION-EXIT.
           EXIT.
