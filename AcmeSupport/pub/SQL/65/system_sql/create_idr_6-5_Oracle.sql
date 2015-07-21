--******************************************************************************************
-- 	CREATE TABLE WM_IDR_MSG_HST
--******************************************************************************************

CREATE TABLE WM_IDR_MSG_HST 
(
	TRIGGERNAME         CHAR(28)  NOT NULL,
   	UUID 	            VARCHAR2(96)  NOT NULL,
	P_STATE             CHAR(1)       NOT NULL,
	EXP_TIME	    	DECIMAL(19,0) NOT NULL
)
STORAGE ( MAXEXTENTS UNLIMITED);

--******************************************************************************************
-- Add unique index on the Primary key
--******************************************************************************************

CREATE UNIQUE INDEX IDR_MSG_HST_IDX ON WM_IDR_MSG_HST (TRIGGERNAME,UUID,P_STATE);

--******************************************************************************************
-- Add a non unique index on the expiration time
--******************************************************************************************

CREATE INDEX IDR_EXP_IDX ON WM_IDR_MSG_HST (EXP_TIME);

ALTER TABLE  WM_IDR_MSG_HST 
ADD CONSTRAINT PK_WM_IDR_MSG_HST PRIMARY KEY (TRIGGERNAME, UUID, P_STATE);


