WHENEVER SQLERROR EXIT FAILURE ROLLBACK

CREATE OR REPLACE PACKAGE WM_ASNO_TRANSACTION AS
PROCEDURE WM_ASNO_UPDATE(
			nHeader_id IN NUMBER
			);
END;
/
CREATE OR REPLACE PACKAGE BODY WM_ASNO_TRANSACTION AS
PROCEDURE WM_ASNO_UPDATE(nHeader_id IN NUMBER)
IS
BEGIN 
		update SO_PICKING_HEADERS_ALL
                set ship_notice_sent_date = SYSDATE,
                    ship_notice_sent_flag = 'Y',
                    last_update_date      = SYSDATE
                where picking_header_id = nHeader_id;
END WM_ASNO_UPDATE;
END;
/