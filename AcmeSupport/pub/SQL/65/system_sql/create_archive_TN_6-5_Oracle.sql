--********************************************************************
--
-- Creates archive tables for Trading Networks 6.5 - Oracle
--
--********************************************************************

ALTER SESSION SET NLS_LENGTH_SEMANTICS='BYTE';

CREATE TABLE ARCHIVE_BizDoc (
      DocID                CHAR(24) NOT NULL,
      DocTypeID            CHAR(24) NULL,
      SenderID             CHAR(24) NOT NULL,
      ReceiverID           CHAR(24) NOT NULL,
      NativeID             VARCHAR2(100) NULL,
      DocTimestamp         TIMESTAMP(3) NOT NULL,
      RoutingStatus        VARCHAR2(20) NOT NULL,
      GroupID              VARCHAR2(100) NULL,
      ConversationID       VARCHAR2(300) NULL,
      UserStatus           VARCHAR2(255) NULL,
      ReceiveSvc           VARCHAR2(250) NULL,
      OrigSenderID         VARCHAR2(128) NULL,
      OrigReceiverID       VARCHAR2(128) NULL,
      LastModified         TIMESTAMP(3) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

--********************************************************************

CREATE TABLE ARCHIVE_BizDocAttribute (
      DocID                CHAR(24) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      StringValue          VARCHAR2(512) NULL,
      NumberValue          FLOAT NULL,
      DateValue            TIMESTAMP(3) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

--********************************************************************

CREATE TABLE ARCHIVE_BizDocArrayAttribute (
      DocID                CHAR(24) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      SeqNumber		   INTEGER NOT NULL,
      StringValue          VARCHAR2(512) NULL,
      NumberValue          FLOAT NULL,
      DateValue            TIMESTAMP(3) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

--********************************************************************

CREATE TABLE ARCHIVE_BizDocContent (
      DocID                CHAR(24) NOT NULL,
      PartName		   VARCHAR2(100) NOT NULL,
      MimeType		   VARCHAR2(100),
      ContentLength	   INTEGER NULL,
      Content	           BLOB NULL,
      PartIndex	           INTEGER NULL,
      StorageType       VARCHAR2(100) NULL,
      StorageRef        VARCHAR2(250) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(Content) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

--********************************************************************

CREATE TABLE ARCHIVE_BizDocRelationship (
       DocID                CHAR(24) NOT NULL,
       RelatedDocID         CHAR(24) NOT NULL,
       Relationship         VARCHAR2(255) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

--********************************************************************

CREATE TABLE ARCHIVE_BizDocUniqueKeys (
		DocID           char(24) NOT NULL,
		UniqueKey       varchar2(254) NOT NULL
);

--********************************************************************

CREATE TABLE ARCHIVE_DeliveryJob (
      JobID                CHAR(24) NOT NULL,
      ServerID             VARCHAR2(50) NOT NULL,
      TimeCreated          TIMESTAMP(3) NULL,
      TimeUpdated          TIMESTAMP(3) NULL,
      JobStatus            VARCHAR2(20) NULL,
      TimeToWait           NUMBER NULL,
      Retries              NUMBER NULL,
      RetryLimit           NUMBER NULL,
      TransportStatus      VARCHAR2(60) NULL,
      TransportStatusMessage VARCHAR2(512) NULL,
      TransportTime        NUMBER NULL,
      DocID                CHAR(24) NULL,
      OutputData           BLOB NULL,
      ServiceName          VARCHAR2(128) NULL,
      RetryFactor	   INTEGER NULL,
      TypeData		   BLOB NULL,
      JobType		   VARCHAR2(20) NULL,
      QueueName        VARCHAR2(254) NULL,
      UserName         VARCHAR2(254) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(OutputData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
   LOB(TypeData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

--********************************************************************

CREATE TABLE ARCHIVE_ActivityLog(
       ActivityLogID		char(24) NOT NULL,
       RelatedDocID         char(24),
       EntryTimestamp       timestamp(3) NOT NULL,
       EntryType            int NOT NULL,
       EntryClass           varchar2(20),
       BriefMessage         varchar2(240) NOT NULL,
       RelatedPartnerID     char(24),
       RelatedInstanceID	 varchar2(300),
       RelatedStepID			 varchar2(128),
       B2BUser              varchar2(128),
       FullMessage          varchar2(1024)
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

--********************************************************************

CREATE TABLE ARCHIVE_EDITracking (
       DocID                char(24) NOT NULL,
       DocTypeID            char(24) NOT NULL,
       SenderID             char(24) NOT NULL,
       ReceiverID           char(24) NOT NULL,
       EnvelopeID           varchar2(100),
       GroupID		    varchar2(100),
       TransactionSetID     varchar2(100),
       GroupType 	    varchar2(100),
       GroupVersion	    varchar2(100),
       DocTimestamp         timestamp(3) NOT NULL,
       FATimestamp          timestamp(3),
       FAStatus             integer NOT NULL,
       RelatedDocID	    char(24)
)
  STORAGE( MAXEXTENTS UNLIMITED )
;

--********************************************************************

CREATE TABLE ARCHIVE_WorkTable (
		DocID           char(24) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE ARCHIVE_WorkTable
	ADD CONSTRAINT pk_ARC_WorkTable PRIMARY KEY (DocID);

--********************************************************************

COMMIT ;

