create table WMSERVICE (
  ROOTCONTEXTID         CHAR(32) NOT NULL,
  PARENTCONTEXTID       CHAR(32),
  CONTEXTID             CHAR(32),
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL,
  USERID                VARCHAR2(64),
  RESUBMITTABLE         INTEGER,
  DURATION              INTEGER,
  SERVICENAME           VARCHAR2(128),
  STATUS                INTEGER NOT NULL,
  ERRORMESSAGE          VARCHAR2(512),
  PIPELINE              BLOB,
  PIPELINEFLAG          SMALLINT,
  SYSTEMDATA            BLOB,
  SYSTEMDATAFLAG        SMALLINT,
  SERVERID              VARCHAR2(1040)
  );

create index IDX_SVC_CID on WMSERVICE (
  CONTEXTID
  );

create index IDX_SVC_PCID on WMSERVICE (
  PARENTCONTEXTID
  );

create index IDX_SVC_AUDTM on WMSERVICE (
  AUDITTIMESTAMP DESC
  );

create index IDX_SVC_SVCNM on WMSERVICE (
  SERVICENAME
  );

create table WMSERVICEACTIVITYLOG ( 
  ROOTCONTEXTID         CHAR(32) NOT NULL,
  PARENTCONTEXTID       CHAR(32),
  CONTEXTID             CHAR(32),
  ENTRYTYPE             INTEGER,
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL,
  FULLMESSAGE           VARCHAR2(1024),
  BRIEFMESSAGE          VARCHAR2(240),
  B2BUSER               VARCHAR2(20),
  PROCESSSTEPCONTEXT CHAR(32),
  SERVERID              VARCHAR2(1040)
  );

create index IDX_SVCACTLOG_CID on WMSERVICEACTIVITYLOG (
  CONTEXTID
  );

create table WMSERVICEASSOC ( 
  CONTEXTID             CHAR(32) NOT NULL,
  EXTERNALID            VARCHAR2(512) NOT NULL,
  SERVERID              VARCHAR2(1040)
  );

create index IDX_SVCASSOC_CID on WMSERVICEASSOC (
  CONTEXTID
  );

create table WMSESSION (
  ROOTCONTEXTID         CHAR(32) NOT NULL,
  PARENTCONTEXTID       CHAR(32),
  CONTEXTID             CHAR(32),
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL,
  SERVERID              VARCHAR2(1040),
  SESSIONSTATE          INTEGER,
  USERID                VARCHAR2(64),
  SESSIONNAME           VARCHAR2(128),
  RPCS                  INTEGER,
  AGE                   INTEGER,
  SESSIONID             VARCHAR2(64)
  );

create index IDX_SESS_SVRID on WMSESSION (
  SERVERID
  );

create index IDX_SESS_AUDTM on WMSESSION (
  AUDITTIMESTAMP DESC
  );

create table WMERROR (
  ROOTCONTEXTID         CHAR(32) NOT NULL,
  PARENTCONTEXTID       CHAR(32),
  CONTEXTID             CHAR(32),
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL,
  SERVERID              VARCHAR2(1040),
  ERRORMSG              VARCHAR2(1024),
  ERRSTACKTRACE         VARCHAR2(2000),
  SERVICENAME           VARCHAR2(256) 
  );

create index IDX_ERR_CID on WMERROR (
  CONTEXTID
  );

create index IDX_ERR_SVRID on WMERROR (
  SERVERID
  );

create index IDX_ERR_AUDTM on WMERROR (
  AUDITTIMESTAMP DESC
  );

create table WMTXIN (
  ROOTCONTEXTID         CHAR(32) NOT NULL,
  PARENTCONTEXTID       CHAR(32),
  CONTEXTID             CHAR(32),
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL,
  SERVERID              VARCHAR2(1040),
  TXSTATUS              INTEGER,
  TXMSG                 VARCHAR2(128), 
  TXERRMSG              VARCHAR2(1024) 
  );

create index IDX_TXIN_SVRID on WMTXIN (
  SERVERID
  );

create index IDX_TXIN_AUDTM on WMTXIN (
  AUDITTIMESTAMP DESC
  );

create table WMTXOUT (
  ROOTCONTEXTID         CHAR(32) NOT NULL,
  PARENTCONTEXTID       CHAR(32),
  CONTEXTID             CHAR(32),
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL,
  SERVERID              VARCHAR2(1040),
  TXSTATUS              INTEGER,
  TXMSG                 VARCHAR2(128), 
  TXERRMSG              VARCHAR2(1024) 
  );

create index IDX_TXOUT_SVRID on WMTXOUT (
  SERVERID
  );

create index IDX_TXOUT_AUDTM on WMTXOUT (
  AUDITTIMESTAMP DESC
  );

create table WMSERVICE4X (      
  ACTIVATIONID          VARCHAR2(300) NOT NULL,    
  AUDITID               CHAR(24) NOT NULL,      
  AUDITTYPE             INTEGER NOT NULL,       
  INTEGRATIONNAME       VARCHAR2(512),
  COMPONENTNAME         VARCHAR2(512),
  ADAPTERNAME           VARCHAR2(128),    
  ADAPTERTYPE           VARCHAR2(128),    
  DOCUMENTID            VARCHAR2(128),    
  ENQUEUETIMESTAMP      DATE, 
  SERVERID              VARCHAR2(1040),    
  BRIEFMESSAGE          VARCHAR2(240),   
  FULLMESSAGE           VARCHAR2(1024),    
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL 
  );

create index IDX_SVC4X_ACTID on WMSERVICE4X (
  ACTIVATIONID
  );

create index IDX_SVC4X_INTNAME on WMSERVICE4X (
  INTEGRATIONNAME
  );

create index IDX_SVC4X_AUDTM on WMSERVICE4X (
  AUDITTIMESTAMP DESC
  );

create table WMCUSTOMDATA4X  (     
  AUDITID               CHAR(24)  NOT NULL,  
  FIELDNAME             VARCHAR2(128),
  FIELDVALUE            BLOB,  
  FIELDVALUEFLAG        SMALLINT,
  STRINGVALUE           VARCHAR2(255),
  NUMBERVALUE           FLOAT,  
  DATEVALUE             DATE, 
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL
  );

create index IDX_CUSTDATA4X_AUDID on WMCUSTOMDATA4X (
  AUDITID
  );

create table WMDOCUMENT (     
  DOCUMENTID            VARCHAR2(128)  NOT NULL,    
  DOCUMENTNAME          VARCHAR2(128),    
  STATUS                INTEGER,
  ENQUEUETIMESTAMP      DATE NOT NULL,    
  DOCUMENT              BLOB,    
  SERVERID              VARCHAR2(1040),    
  AUDITTIMESTAMP        DECIMAL(19,0) NOT NULL
  );

create index IDX_DOC_DOCNAME on WMDOCUMENT (
  DOCUMENTNAME
  );

create index IDX_DOC_AUDTM on WMDOCUMENT (
  AUDITTIMESTAMP DESC
  );


COMMIT;
