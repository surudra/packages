CREATE TABLE ATC_XREF (
       app_id               VARCHAR2(30) NOT NULL,
       obj_name             VARCHAR2(30) NOT NULL,
       native_id            VARCHAR2(100) NOT NULL,
       canonical_id         VARCHAR2(100) NOT NULL,
       latch_closed         CHAR(1) NOT NULL
) STORAGE (INITIAL 2M  NEXT 2M  MINEXTENTS 1  MAXEXTENTS 100  PCTINCREASE 0);

-- constraints

ALTER TABLE ATC_XREF
       ADD constraint PK_ATC_XREF
       PRIMARY KEY (app_id, obj_name, native_id, canonical_id);

COMMIT;
