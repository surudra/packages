CREATE TABLE WMSTG_LAST_RUN (
  LAST_EXTRACT_EPOCH                NUMBER(19)      ,
  LAST_HOURAGG_DATE_RID             NUMBER(8)       ,
  LAST_HOURAGG_HOUR24               NUMBER(2)       ,
  LAST_DAYAGG_DATE_RID              NUMBER(8)       
);

CREATE TABLE WMSTG_DRIVER (
  BATCH_BEGIN                       NUMBER(19)      ,
  BATCH_END                         NUMBER(19)      ,
  COPY_RUNTIME_DATA                 NUMBER(1)       ,
  STAGE_METADATA                    NUMBER(1)       ,
  UPDATE_INST_ACCUM                 NUMBER(1)       ,
  UPDATE_STEP_ACCUM                 NUMBER(1)       
);

CREATE TABLE WMSTG_ID (
  ID_TYPE                           NUMBER(2)       ,
  ID_TYPE_DESC                      VARCHAR2(16)    ,
  ID                                NUMBER(8)       ,
  ID_LOCK                           NUMBER(1)       
);

CREATE TABLE WMSTG_MODEL_XREF (
  MODEL_RID                         NUMBER(4)       NOT NULL,
  PROCESS_KEY                       VARCHAR2(64)    NOT NULL,
  DEPL_EPOCH                        NUMBER(19)      
);

ALTER TABLE WMSTG_MODEL_XREF ADD (
  CONSTRAINT PKMODELXREF PRIMARY KEY (MODEL_RID)
);

CREATE TABLE WMSTG_STEP_XREF (
  STEP_RID                          NUMBER(6)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  PROCESS_KEY                       VARCHAR2(64)    ,
  STEP_ID                           VARCHAR2(128)   NOT NULL
);

ALTER TABLE WMSTG_STEP_XREF ADD (
  CONSTRAINT PKSTEPXREF PRIMARY KEY (STEP_RID)
);

CREATE TABLE WMSTG_USER_XREF (
  USER_RID                          NUMBER(6)       NOT NULL,
  USER_NAME                         VARCHAR2(128)   NOT NULL
);

ALTER TABLE WMSTG_USER_XREF ADD (
  CONSTRAINT PKUSERXREF PRIMARY KEY (USER_RID)
);

CREATE TABLE WMSTG_ROLE_XREF (
  ROLE_RID                          NUMBER(4)       NOT NULL,
  ROLE_NAME                         VARCHAR2(128)   NOT NULL
);

ALTER TABLE WMSTG_ROLE_XREF ADD (
  CONSTRAINT PKROLEXREF PRIMARY KEY (ROLE_RID)
);

CREATE TABLE WMSTG_FAIL_TYPE_XREF (
  FAIL_TYPE_RID                     NUMBER(2)       NOT NULL,
  FAIL_TYPE_STAT                    NUMBER(8)       NOT NULL
);

ALTER TABLE WMSTG_FAIL_TYPE_XREF ADD (
  CONSTRAINT PKFAILTYPEXREF PRIMARY KEY (FAIL_TYPE_RID)
);

CREATE TABLE WMSTG_PROCESS (
  ROOTCONTEXTID                     CHAR(32)        ,
  PARENTCONTEXTID                   CHAR(32)        ,
  CONTEXTID                         CHAR(32)        ,
  EXTERNALID                        VARCHAR2(512)   ,
  INSTANCEID                        CHAR(32)        ,
  INSTANCEITERATION                 NUMBER(3)       ,
  PARENTSTEPID                      VARCHAR2(128)   ,
  PARENTINSTANCEID                  CHAR(32)        ,
  PARENTINSTANCEITERATION           NUMBER(3)       ,
  STATUS                            NUMBER(8)       ,
  PROCESSKEY                        VARCHAR2(64)    ,
  AUDITTIMESTAMP                    NUMBER(19)      
);

CREATE TABLE WMSTG_PROCESS_STEP (
  ROOTCONTEXTID                     CHAR(32)        ,
  PARENTCONTEXTID                   CHAR(32)        ,
  CONTEXTID                         CHAR(32)        ,
  EXTERNALID                        VARCHAR2(512)   ,
  INSTANCEID                        CHAR(32)        ,
  INSTANCEITERATION                 NUMBER(3)       ,
  PROCESSKEY                        VARCHAR2(64)    ,
  STEPID                            VARCHAR2(128)   ,
  STEPITERATION                     NUMBER(3)       ,
  USERNAME                          VARCHAR2(128)   ,
  ROLENAME                          VARCHAR2(128)   ,
  STATUS                            NUMBER(8)       ,
  SYSTEM                            NUMBER(1)       ,
  SERVERID                          VARCHAR2(1040)  ,
  AUDITTIMESTAMP                    NUMBER(19)      
);

CREATE TABLE WMSTG_PROCESS_CONTROL (
  ROOTCONTEXTID                     CHAR(32)        ,
  PARENTCONTEXTID                   CHAR(32)        ,
  CONTEXTID                         CHAR(32)        ,
  INSTANCEID                        CHAR(32)        ,
  INSTANCEITERATION                 NUMBER(3)       ,
  PROCESSKEY                        VARCHAR2(64)    ,
  STEPID                            VARCHAR2(128)   ,
  STEPITERATION                     NUMBER(3)       ,
  PARENTINSTANCEID                  CHAR(32)        ,
  PARENTINSTANCEITERATION           NUMBER(3)       ,
  ACTION                            NUMBER(2)       ,
  USERNAME                          VARCHAR2(128)   ,
  SERVERID                          VARCHAR2(1040)  ,
  AUDITTIMESTAMP                    NUMBER(19)      ,
  DATE_RID                          NUMBER(8)       ,
  TIME_RID                          NUMBER(4)       
);

CREATE TABLE WMSTG_PROCESS_DEFINITION (
  PROCESSKEY                        VARCHAR2(64)    ,
  TYPE                              NUMBER(2)       ,
  PROCESSLABEL                      VARCHAR2(1024)  ,
  PROCESSPATH                       VARCHAR2(1024)  ,
  DESCRIPTION                       VARCHAR2(1024)  ,
  CREATEDBY                         VARCHAR2(64)    ,
  DEPLOYMENTTIME                    NUMBER(19)      
);

CREATE TABLE WMSTG_STEP_DEFINITION (
  PROCESSKEY                        VARCHAR2(64)    ,
  STEPID                            VARCHAR2(128)   ,
  STEPLABEL                         VARCHAR2(1024)  ,
  TYPE                              NUMBER(2)       ,
  DESCRIPTION                       VARCHAR2(1024)  ,
  SERVER                            VARCHAR2(128)   ,
  COMPONENT                         VARCHAR2(1024)  
);

COMMIT;


INSERT INTO WMSTG_LAST_RUN (LAST_EXTRACT_EPOCH) VALUES (1041408000000);


INSERT INTO WMSTG_ID (ID_TYPE, ID_TYPE_DESC, ID, ID_LOCK) VALUES (1, 'MODEL', 1, 1);
INSERT INTO WMSTG_ID (ID_TYPE, ID_TYPE_DESC, ID, ID_LOCK) VALUES (2, 'STEP', 1, 1);
INSERT INTO WMSTG_ID (ID_TYPE, ID_TYPE_DESC, ID, ID_LOCK) VALUES (3, 'USER', 1, 1);
INSERT INTO WMSTG_ID (ID_TYPE, ID_TYPE_DESC, ID, ID_LOCK) VALUES (4, 'ROLE', 1, 1);


INSERT INTO WMSTG_USER_XREF ( USER_RID, USER_NAME ) VALUES (0, 'Not specified'); 

INSERT INTO WMSTG_ROLE_XREF ( ROLE_RID, ROLE_NAME ) VALUES (0, 'Not specified'); 

INSERT INTO WMSTG_FAIL_TYPE_XREF ( FAIL_TYPE_RID, FAIL_TYPE_STAT) VALUES (0, 0); 
INSERT INTO WMSTG_FAIL_TYPE_XREF ( FAIL_TYPE_RID, FAIL_TYPE_STAT) VALUES (1, 4); 
INSERT INTO WMSTG_FAIL_TYPE_XREF ( FAIL_TYPE_RID, FAIL_TYPE_STAT) VALUES (2, 64); 
INSERT INTO WMSTG_FAIL_TYPE_XREF ( FAIL_TYPE_RID, FAIL_TYPE_STAT) VALUES (3, 512); 

COMMIT;
