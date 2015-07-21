--********************************************************************
--
-- Create script for Trading Networks 6.1 Oracle
--
--********************************************************************
ALTER SESSION SET NLS_LENGTH_SEMANTICS='BYTE';

CREATE TABLE Partner (
	ParentPartnerID		CHAR(24) NULL,
	PartnerID			CHAR(24) NOT NULL,
	CorporationName		VARCHAR2(255) NOT NULL,
	OrgUnitName			VARCHAR2(255) NULL,
	Deleted				SMALLINT NOT NULL,
	Status				VARCHAR2(12) NOT NULL,
	Type				CHAR(12) NOT NULL,
	Self				SMALLINT NOT NULL,
	TNVersion			VARCHAR2(20) NULL,
	B2BcomMember		SMALLINT DEFAULT 0 NULL,
	PreferredLocale		VARCHAR2(16) NULL       
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_Ptnr_CorpName_OrgUnitName ON Partner
(
       CorporationName                ASC,
       OrgUnitName                    ASC
);


ALTER TABLE Partner
       ADD  ( CONSTRAINT pk_Ptnr_PtnrId PRIMARY KEY (PartnerID) ) ;


--********************************************************************

CREATE TABLE BizDocAttributeDef (
	AttributeName        VARCHAR2(255) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      AttributeDescription VARCHAR2(1024) NULL,
      AttributeType        VARCHAR2(20) NOT NULL,
      Deleted              SMALLINT NOT NULL,
      Persist              SMALLINT,
      LastModified         TIMESTAMP(3) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE BizDocAttributeDef
      ADD  ( CONSTRAINT pk_BizDocAttDef_AttId PRIMARY KEY (AttributeID) ) ;

--********************************************************************

CREATE TABLE BizDocTypeDef (
      TypeName             VARCHAR2(128) NOT NULL,
      TypeID               CHAR(24) NOT NULL,
      TypeDescription      VARCHAR2(255) NULL,
      TypeData             BLOB NOT NULL,
      Deleted              SMALLINT NOT NULL,
      LastModified         TIMESTAMP(3) NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
   LOB(TypeData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

ALTER TABLE BizDocTypeDef
       ADD  ( CONSTRAINT pk_BizDocTypeDef_TypeId PRIMARY KEY (TypeID) ) ;

--********************************************************************

CREATE TABLE BinaryType (
      Type                 SMALLINT NOT NULL,
      Description          VARCHAR2(255) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;


ALTER TABLE BinaryType
      ADD  ( CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE ContactType (
      Type                 SMALLINT NOT NULL,
      Description          VARCHAR2(128) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE ContactType
       ADD  ( CONSTRAINT pk_ContType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE BizDoc (
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

CREATE INDEX idx_BizDoc_DocTypeId ON BizDoc
(
      DocTypeID            ASC
);

CREATE INDEX idx_BizDoc_SenderId ON BizDoc
(
      SenderID             ASC
);

CREATE INDEX idx_BizDoc_ReceiverId ON BizDoc
(
      ReceiverID           ASC
);


ALTER TABLE BizDoc
      ADD  ( CONSTRAINT pk_BizDoc_DocId PRIMARY KEY (DocID) ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_ReceiverId_Ptnr FOREIGN KEY (ReceiverID)
                             REFERENCES Partner ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_SenderId_Ptnr FOREIGN KEY (SenderID)
                             REFERENCES Partner ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_DocTyId_BizDocTypDef FOREIGN KEY (DocTypeID)
                             REFERENCES BizDocTypeDef ) ;

--********************************************************************

CREATE TABLE BizDocAttribute (
      DocID                CHAR(24) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      StringValue          VARCHAR2(512) NULL,
      NumberValue          FLOAT NULL,
      DateValue            TIMESTAMP(3) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_BizDocAtt_AttId ON BizDocAttribute
(
      AttributeID          ASC
);

ALTER TABLE BizDocAttribute
      ADD  ( CONSTRAINT pk_BizDocAtt_DocId_AttId PRIMARY KEY (DocID, AttributeID) ) ;


ALTER TABLE BizDocAttribute
       ADD  ( CONSTRAINT fk_BizDocAtt_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;


ALTER TABLE BizDocAttribute
       ADD  ( CONSTRAINT fk_BizDocAtt_AttId_BizDocAtDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ) ;

--********************************************************************

CREATE TABLE BizDocArrayAttribute (
      DocID                CHAR(24) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      SeqNumber		   INTEGER NOT NULL,
      StringValue          VARCHAR2(512) NULL,
      NumberValue          FLOAT NULL,
      DateValue            TIMESTAMP(3) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_BDArrAtt_AttId ON BizDocArrayAttribute
(
      AttributeID          ASC
);

ALTER TABLE BizDocArrayAttribute
      ADD CONSTRAINT pk_BDArrAtt_DocId_AttId PRIMARY KEY (DocID, AttributeID, SeqNumber) ;

ALTER TABLE BizDocArrayAttribute
       ADD CONSTRAINT fk_BDArrAtt_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ;

ALTER TABLE BizDocArrayAttribute
       ADD CONSTRAINT fk_BDArrAtt_AttId_BizDocAtDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ;

--********************************************************************

CREATE TABLE BizDocContent (
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

ALTER TABLE BizDocContent
       ADD CONSTRAINT pk_BizDocCont_DocId_PartName PRIMARY KEY (DocID,PartName) ;

ALTER TABLE BizDocContent
       ADD  ( CONSTRAINT fk_BizDocCont_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE BizDocRelationship (
       DocID                CHAR(24) NOT NULL,
       RelatedDocID         CHAR(24) NOT NULL,
       Relationship         VARCHAR2(255) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


CREATE INDEX idx_BizDocRel_RelatedDocId ON BizDocRelationship
(
      RelatedDocID                   ASC
);

ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT pk_BizDocRel_DocId_RelatDocId PRIMARY KEY (DocID, RelatedDocID) ) ;


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT fk_BizDocRel_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT fk_BizDocRel_RelatDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE BizDocTypeAttribute (
      AttributeID          CHAR(24) NOT NULL,
      TypeID               CHAR(24) NOT NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_BizDocTypeAtt_TypeId ON BizDocTypeAttribute
(
      TypeID                         ASC
);

ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT pk_BizDocTypeAtt_AttId_TypeId PRIMARY KEY (AttributeID, TypeID) ) ;


ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT fk_BDocTypAtt_TypId_BDocTypDef FOREIGN KEY (TypeID)
                             REFERENCES BizDocTypeDef ) ;


ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT fk_BDocTypAtt_AttId_BDocAttDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ) ;

--********************************************************************

CREATE TABLE Contact (
      ContactID            CHAR(24) NOT NULL,
      PartnerID            CHAR(24) NOT NULL,
      Surname              VARCHAR2(255) NULL,
      GivenName            VARCHAR2(255) NULL,
      SequenceNumber       SMALLINT NOT NULL,
      RoleDescription		VARCHAR2(128) NULL,
      Type                 SMALLINT NOT NULL,
      EmailAddress         VARCHAR2(255) NULL,
      TelNumber            VARCHAR2(60) NULL,
      TelExtension         VARCHAR2(60) NULL,
      FaxNumber            VARCHAR2(60) NULL,
      PagerNumber          VARCHAR2(60) NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_Cont_PtnrId ON Contact
(
       PartnerID                      ASC
);

ALTER TABLE Contact
       ADD  ( CONSTRAINT pk_Cont_ContId PRIMARY KEY ( ContactID) ) ;

ALTER TABLE Contact
       ADD  ( CONSTRAINT fk_Cont_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

ALTER TABLE Contact
  ADD CONSTRAINT fk_Contact_Type_ContType
      FOREIGN KEY(Type) REFERENCES ContactType ;

--*******************************************************************

CREATE TABLE Address (
      AddressID            CHAR(24) NOT NULL,
      PartnerID            CHAR(24) NULL,
      ContactID            CHAR(24) NULL,
      AddressLine1         VARCHAR2(255) NULL,
      AddressLine2         VARCHAR2(255) NULL,
      AddressLine3         VARCHAR2(255) NULL,
      City                 VARCHAR2(255) NULL,
      State_Province       VARCHAR2(128) NULL,
      Zip_PostalCode       VARCHAR2(128) NULL,
      Country              VARCHAR2(60) NULL,
      SequenceNumber       SMALLINT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_Address_ContId ON Address
(
      ContactID            ASC
);

CREATE INDEX idx_Address_PtnrId ON Address
(
      PartnerID            ASC
);

ALTER TABLE Address
      ADD  ( CONSTRAINT pk_Address_AddressId PRIMARY KEY (AddressID) ) ;

ALTER TABLE Address
       ADD  ( CONSTRAINT fk_Address_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

ALTER TABLE Address
       ADD CONSTRAINT fk_Address_ContId_Cont FOREIGN KEY (ContactID)
                            REFERENCES Contact
;

--********************************************************************

CREATE TABLE DeliveryService (
      ServiceName          VARCHAR2(128) NOT NULL,
      B2BInterface         VARCHAR2(512) NOT NULL,
      B2BService           VARCHAR2(512) NOT NULL,
      RemoteLocation       VARCHAR2(128) NULL,
      RemoteUser           VARCHAR2(32) NULL,
      RemotePassword       VARCHAR2(32) NULL,
      Scheduled            INTEGER
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


ALTER TABLE DeliveryService
       ADD  ( CONSTRAINT pk_DeliServ_ServName PRIMARY KEY (ServiceName) ) ;

--********************************************************************

CREATE TABLE DeliveryJob (
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

CREATE INDEX idx_DeliJob_ServName ON DeliveryJob
(
       ServiceName                    ASC
);

CREATE INDEX idx_DeliJob_DocId ON DeliveryJob
(
       DocID                          ASC
);

CREATE INDEX idx_DeliJob_ServerId ON DeliveryJob
(
       ServerID                       ASC
);

CREATE INDEX idx_DeliJob_QueName ON DeliveryJob
(
       QueueName                      ASC
);

ALTER TABLE DeliveryJob
       ADD  ( CONSTRAINT pk_DeliJob_JobId PRIMARY KEY (JobID) ) ;

ALTER TABLE DeliveryJob
       ADD  ( CONSTRAINT fk_DeliJob_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE Destination (
       DestinationID        CHAR(24) NOT NULL,
       PartnerID            CHAR(24) NOT NULL,
       Protocol             VARCHAR2(64) NOT NULL,
       Host                 VARCHAR2(64) NULL,
       PrimaryAddr          INTEGER NOT NULL,
       Port                 VARCHAR2(6) NULL,
       Location             VARCHAR2(255) NULL,
       UserName             VARCHAR2(24) NULL,
       Password             VARCHAR2(24) NULL,
       CustomData	    BLOB NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(CustomData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

CREATE INDEX idx_Dest_PtnrId ON Destination
(
       PartnerID                      ASC
);

CREATE INDEX idx_Dest_PtnrId_Protocol ON Destination
(
       PartnerID,
       Protocol
);

ALTER TABLE Destination
       ADD CONSTRAINT pk_Dest_DestinationId PRIMARY KEY (DestinationID) ;

ALTER TABLE Destination
       ADD  ( CONSTRAINT fk_Dest_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE IDType (
       Type                 INTEGER NOT NULL,
       Description          VARCHAR2(255) NOT NULL
)
   STORAGE ( MAXEXTENTS UNLIMITED )
;


ALTER TABLE IDType
       ADD  ( CONSTRAINT pk_IdType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE PartnerBinary (
       PartnerID            CHAR(24) NOT NULL,
       Type                 VARCHAR2(20) NOT NULL,
       Value                BLOB NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(Value) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

CREATE INDEX idx_PtnrBin_PtnrId ON PartnerBinary
(
       PartnerID                      ASC
);


ALTER TABLE PartnerBinary
       ADD  ( CONSTRAINT pk_PtnrBin_PtnrId_Type PRIMARY KEY (PartnerID, Type) ) ;

ALTER TABLE PartnerBinary
       ADD  ( CONSTRAINT fk_PtnrBin_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE PartnerID (
       PartnerIDID          CHAR(24) NOT NULL,
       InternalID           CHAR(24) NOT NULL,
       ExternalID           VARCHAR2(128) NOT NULL,
       IDType               INTEGER NOT NULL,
       SequenceNumber       SMALLINT NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_PtnrIdTbl_InternalId ON PartnerID
(
       InternalID                     ASC
);

CREATE INDEX idx_PtnrIdTbl_IDType ON PartnerID
(
       IDType                         ASC
);

ALTER TABLE PartnerID
       ADD CONSTRAINT pk_PtnrIdTbl_PtnrIdId PRIMARY KEY (PartnerIDID) ;

ALTER TABLE PartnerID
       ADD  ( CONSTRAINT fk_PtnrIdTbl_InternalId_Ptnr FOREIGN KEY (InternalID)
                             REFERENCES Partner) ;


--*******************************************************************

CREATE TABLE FieldGroup (
       ID           smallint     NOT NULL,
       Description  varchar2(128) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE FieldGroup
       ADD CONSTRAINT pk_GroupID_ID PRIMARY KEY (ID) ;

--********************************************************************

CREATE TABLE ProfileField (
       ProfileFieldID       CHAR(24) NOT NULL,
       Name                 CHAR(32) NULL,
       Required             SMALLINT NOT NULL,
       Registration         SMALLINT NOT NULL,
       ValidValues          VARCHAR2(4000) NULL,
       DefaultValue         VARCHAR2(128) NULL,
       ProfileTbl           VARCHAR2(20) NULL,
       DataType             VARCHAR2(10) NULL,
       ProfileCol           VARCHAR2(20) NULL,
       Deleted              SMALLINT NOT NULL,
       GroupID              SMALLINT NOT NULL,
       Description          VARCHAR2(1024) NULL,
       MaxLength            NUMBER NULL,
       Display              SMALLINT NOT NULL
);

CREATE INDEX idx_ProfFld_ProfTbl_ProfCol ON ProfileField
(
       ProfileTbl                     ASC,
       ProfileCol                     ASC
);

CREATE INDEX idx_ProfFld_Name ON ProfileField
(
       Name                           ASC
);

CREATE INDEX idx_ProfFld_GroupId ON ProfileField
(
       GroupID                        ASC
);


ALTER TABLE ProfileField
       ADD  ( CONSTRAINT pk_ProfFld_ProfFldId PRIMARY KEY (ProfileFieldID) ) ;

ALTER TABLE ProfileField
	ADD CONSTRAINT fk_ProfileFld_GrpID_FieldGrp FOREIGN KEY (GroupID)
			   REFERENCES FieldGroup ;

--********************************************************************

CREATE TABLE PartnerProfileField (
       ProfileFieldID       CHAR(24) NOT NULL,
       ValueBinary          BLOB NULL,
       PartnerID            CHAR(24) NOT NULL,
       ValueString          VARCHAR2(4000) NULL,
	 ProfileFieldName	    CHAR(32) NULL
);

CREATE INDEX idx_PtnrProFld_ProFldId ON PartnerProfileField
(
       ProfileFieldID                 ASC
);

CREATE INDEX idx_PtnrProFld_PtnrId ON PartnerProfileField
(
       PartnerID                      ASC
);


ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT pk_PtnrProFld_PtnrId_ProFldId PRIMARY KEY (PartnerID, ProfileFieldID) ) ;


ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT fk_PtnrProFld_ProFldId_ProFld FOREIGN KEY (ProfileFieldID)
                             REFERENCES ProfileField ) ;

ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT fk_PtnrProFld_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE ProcessingRule (
	RuleID			CHAR(24) NOT NULL,
	RuleIndex			NUMBER NOT NULL,
	RuleDescription		VARCHAR2(255) NULL,
	RuleName			VARCHAR2(128) NOT NULL,
	RuleData			BLOB NULL,
	LastModified		TIMESTAMP(3) NULL,
	Disabled			SMALLINT NOT NULL,
	LastChangeID		CHAR(24) NULL,
	LastChangeUser		VARCHAR2(255) NULL,
	LastChangeSession		VARCHAR2(255) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(RuleData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

ALTER TABLE ProcessingRule
	ADD CONSTRAINT pk_ProcessingRule_RuleID PRIMARY KEY (RuleID);

--********************************************************************

CREATE TABLE ProcessingRuleModification (
	LastChangeID		CHAR(24) NOT NULL,
	LastChangeUser		VARCHAR2(255) NULL,
	LastChangeSession		VARCHAR2(255) NULL
);

ALTER TABLE ProcessingRuleModification
	ADD CONSTRAINT pk_ProcessingRuleMod_ChangeID PRIMARY KEY (LastChangeID);

--********************************************************************

CREATE TABLE Remote (
       PartnerID            CHAR(24) NOT NULL,
       Certificate          VARCHAR2(255) NULL,
       CACertificate        VARCHAR2(255) NULL,
       RemoteStatus         VARCHAR2(12) NULL,
       PrivateKey           VARCHAR2(255) NULL,
       PreferredProtocol    VARCHAR2(64) NULL,
       PollingFrequency     FLOAT NULL,
       DeliveryMaxRetries   SMALLINT NULL,
       DeliveryRetryWait    INTEGER NULL,
       PollingProtocol      VARCHAR2(64) NULL,
       RetryFactor	    INTEGER NULL,
       DeliveryQueue    VARCHAR2(254) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE Remote
       ADD  ( CONSTRAINT pk_Remote_PtnrId PRIMARY KEY (PartnerID) ) ;

ALTER TABLE Remote
       ADD  ( CONSTRAINT fk_Remote_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE ActivityLog(
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

CREATE INDEX idx_ActLog_RelatedDocId ON ActivityLog
(
       RelatedDocID
);

CREATE INDEX idx_ActLog_RelatedPtnrId ON ActivityLog
(
       RelatedPartnerID
);

ALTER TABLE ActivityLog
       ADD CONSTRAINT pk_ActivityLog PRIMARY KEY (ActivityLogID);
       
ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedPtnrId_Ptnr FOREIGN KEY (RelatedPartnerID)
                             REFERENCES Partner;

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc;

--********************************************************************

CREATE TABLE DeliveryQueue (
	QueueName            VARCHAR2(254) NOT NULL,
	QueueType            VARCHAR2(12) NOT NULL,
	QueueState           VARCHAR2(12) NOT NULL,
	Schedule             BLOB NOT NULL
);

CREATE INDEX idx_DeliQueue_QueueType ON DeliveryQueue
(
  QueueType
);

ALTER TABLE DeliveryQueue
       ADD CONSTRAINT pk_DeliQueue_QueueName PRIMARY KEY (QueueName);

--********************************************************************

CREATE TABLE CertificateData
(
	CertID					CHAR(24) NOT NULL,
	OwnerID					CHAR(24) NOT NULL,
	PartnerID				CHAR(24) NULL,
	Usage					VARCHAR2(20) NOT NULL,
	CertificateData			BLOB NOT NULL,
	ExpirationDate			TIMESTAMP(3) NOT NULL
);

CREATE INDEX Idx_CertData_Ownr ON CertificateData( OwnerID );

CREATE INDEX Idx_CertData_Ptnr ON CertificateData( PartnerID );

ALTER TABLE CertificateData ADD CONSTRAINT pk_CertData_CertID
	PRIMARY KEY ( CertID );

ALTER TABLE CertificateData ADD CONSTRAINT fk_CertData_OwnrID_Ptnr
	FOREIGN KEY ( OwnerID ) REFERENCES Partner( PartnerID );

ALTER TABLE CertificateData ADD CONSTRAINT fk_CertData_PtnrID_Ptnr
	FOREIGN KEY ( PartnerID ) REFERENCES Partner( PartnerID );

--********************************************************************

CREATE TABLE ProfileGroup (
		GroupID			CHAR(24) NOT NULL,
		GroupName			VARCHAR2(200) NULL
);

ALTER TABLE ProfileGroup
		ADD CONSTRAINT pk_PGroup_GroupID PRIMARY KEY (GroupID);

--********************************************************************

CREATE TABLE PartnerProfileGroup(
		PartnerID			CHAR(24) NOT NULL,
		GroupID			CHAR(24) NOT NULL
);

CREATE INDEX idx_PtnrPGrp_PtnID on PartnerProfileGroup
(
		PartnerID			ASC
);

CREATE INDEX idx_PtnrPGrp_GrpID on PartnerProfileGroup
(
		GroupID				ASC
);

ALTER TABLE PartnerProfileGroup
		ADD CONSTRAINT pk_PPGrp_PID_GrpID 
				PRIMARY KEY (PartnerID, GroupID);

ALTER TABLE PartnerProfileGroup
		ADD CONSTRAINT fk_PPGrp_PID_Ptnr 
				FOREIGN KEY (PartnerID) REFERENCES Partner ;

ALTER TABLE PartnerProfileGroup
		ADD CONSTRAINT fk_PPGrp_GpID_PGrp
				FOREIGN KEY (GroupID) REFERENCES ProfileGroup;

--********************************************************************

CREATE TABLE TPA (
       TpaID            char(24) NOT NULL,
       Description      varchar(1024) NULL,
       SenderID         char(24) NULL,
       ReceiverID       char(24) NULL,
       AgreementID      varchar(254) NOT NULL,
       TimeCreated      timestamp(3) NULL,
       LastModified     timestamp(3) NULL,
       ControlNumber    int NULL,
       Status           varchar(20) NULL,
       ExportService    varchar(254) NULL,
       InitService      varchar(254) NULL,
       DataSchema       varchar(254) NULL,
       DataStatus       varchar(24) NULL,
       TpaData          BLOB NULL,
       Version          varchar(20) NULL
);

CREATE INDEX idx_TPA_SenderId ON TPA
(
       SenderID
);

CREATE INDEX idx_TPA_ReceiverId ON TPA
(
       ReceiverID
);

CREATE INDEX idx_TPA_AgreementId ON TPA
(
       AgreementID
);

ALTER TABLE TPA
       ADD CONSTRAINT pk_TPA_TpaId PRIMARY KEY (TpaID);

--********************************************************************

CREATE TABLE TPALock (
       LockID            char(24) NOT NULL,
       Description      varchar(1024) NULL,
       TimeExpired      timestamp(3) NULL
);

ALTER TABLE TPALock
       ADD CONSTRAINT pk_TPALock_LockId PRIMARY KEY (LockID);

--********************************************************************

CREATE TABLE TNStatistics (
	ServerID             varchar(255) NOT NULL,
	StatisticsType       varchar(64) NOT NULL,
	StatisticsData       blob 
);

--********************************************************************

CREATE TABLE BizDocUniqueKeys (
		DocID           char(24) NOT NULL,
		UniqueKey       varchar2(254) NOT NULL
);

ALTER TABLE BizDocUniqueKeys
	ADD CONSTRAINT pk_BDUniq_UniqKey PRIMARY KEY (UniqueKey) ;

--********************************************************************

CREATE TABLE TNModelVersion (
       MajorVersion         NUMBER NOT NULL,
       MinorVersion         NUMBER NOT NULL
);

ALTER TABLE TNModelVersion
       ADD  ( CONSTRAINT pk_TNModelVer_MajVer_MinorVer PRIMARY KEY (MajorVersion, MinorVersion) ) ;

--********************************************************************

CREATE TABLE EDITracking (
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

CREATE INDEX idx_EDITracking_SenderID ON EDITracking
(
       SenderID
);

CREATE INDEX idx_EDITracking_ReceiverID ON EDITracking
(
       ReceiverID
);

CREATE INDEX idx_EDITracking_GroupID ON EDITracking
(
       GroupID
);

CREATE INDEX idx_EDITracking_DocTimestamp ON EDITracking
(
       DocTimestamp
);

CREATE INDEX idx_EDITracking_FAStatus ON EDITracking
(
       FAStatus
);

ALTER TABLE EDITracking
       ADD CONSTRAINT pk_EDITracking_DocID PRIMARY KEY (DocID) ;

--********************************************************************

CREATE TABLE EDIEnvelope (
       SenderID             varchar2(35) NOT NULL,
       SenderQual           varchar2(25) NOT NULL,
       ReceiverID           varchar2(35) NOT NULL,
       ReceiverQual         varchar2(25) NOT NULL,
       EnvelopeID           char(24) NOT NULL
);

CREATE UNIQUE INDEX idx_EDIEnvelope ON EDIEnvelope
(
	SenderID, SenderQual, ReceiverID, ReceiverQual
);

ALTER TABLE EDIEnvelope
       ADD CONSTRAINT pk_EDIEnvelope PRIMARY KEY (EnvelopeID)
;

--********************************************************************

CREATE TABLE EDIEnvelopeInfo (
       EnvelopeID           char(24)NOT NULL,
       ProductionMode       integer NOT NULL,
       InbndInfo            blob,       
       OutbndInfo           blob     
);

ALTER TABLE EDIEnvelopeInfo
       ADD CONSTRAINT pk_EDIEnvelopeInfo PRIMARY KEY (EnvelopeID, ProductionMode) ;

ALTER TABLE EDIEnvelopeInfo
       ADD CONSTRAINT fk_EDIEnvInfo_EnvId_EDIEnv FOREIGN KEY (EnvelopeID)
	                        REFERENCES EDIEnvelope ;

--********************************************************************

CREATE TABLE EDIGroup (
       GroupSenderID        varchar2(35) NOT NULL,
       GroupSenderQual      varchar2(25) NOT NULL,
       GroupReceiverID      varchar2(35) NOT NULL,
       GroupReceiverQual    varchar2(25) NOT NULL,
       GroupID              char(24) NOT NULL,
       EnvelopeID           char(24) NOT NULL
);

ALTER TABLE EDIGroup 
       ADD CONSTRAINT pk_EDIGroup PRIMARY KEY (GroupSenderID, GroupSenderQual, GroupReceiverID, GroupReceiverQual)
;

ALTER TABLE EDIGroup 
       ADD CONSTRAINT fk_EDIGroup_EnvId_EDIEnvelope FOREIGN KEY (EnvelopeID)
	                        REFERENCES EDIEnvelope ;

--********************************************************************

CREATE TABLE EDIControlNumber (
       EDICtrlID            integer NOT NULL,	
       SenderID             varchar2(35) NOT NULL,
       SenderQual           varchar2(25) NOT NULL,
       ReceiverID           varchar2(35) NOT NULL,
       ReceiverQual         varchar2(25) NOT NULL,
       Standard             varchar2(30) NOT NULL,
       ProductionMode       integer NOT NULL,
       Version              varchar2(10) NOT NULL,
       GroupType            varchar2(10) NOT NULL,
       ControlNumber        decimal(30,0) NOT NULL,
       ControlNumberCap     decimal(30,0) NOT NULL,
       ControlNumberMin     decimal(30,0) NOT NULL,
       ControlNumberInc     integer NOT NULL,
       ControlNumberWindow  integer NOT NULL
);

CREATE INDEX idx_EDIControlNumber_EDICtrlID ON EDIControlNumber
(
       EDICtrlID
);

ALTER TABLE EDIControlNumber
       ADD CONSTRAINT pk_EDIControlNum 
       PRIMARY KEY (SenderID, SenderQual, ReceiverID, ReceiverQual,
			  Standard, ProductionMode, Version, GroupType) ;

--********************************************************************

CREATE TABLE EDIStatus (
	EDICtrlID			integer NOT NULL,
	TNDocID			char(24) NOT NULL,
	ControlNumber		decimal(30,0) NOT NULL,
	Reason			integer NOT NULL,
	LockTimeStamp		timestamp(3),
	TimeStamp			timestamp(3) NOT NULL
);

CREATE INDEX idx_EDIStatus_EDICtrlID ON EDIStatus
(
       EDICtrlID 
);

ALTER TABLE EDIStatus 
       ADD CONSTRAINT pk_EDIStatus_TNDocID PRIMARY KEY (TNDocID) 
;

--********************************************************************

COMMIT ;

--********************************************************************

