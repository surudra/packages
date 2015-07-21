CREATE SEQUENCE OrderDetailsID_SEQ INCREMENT BY 1 MINVALUE 1
/

CREATE TABLE OrderDetails (
 OrderDetailsID INT NOT NULL,
 OrderID INT,
 ProductID INT,
 Quantity INT,
 PRIMARY KEY (OrderDetailsID)
)
/
/
CREATE OR REPLACE TRIGGER NEXT_OrderDetailsID
BEFORE INSERT OR UPDATE OF OrderDetailsID ON OrderDetails
FOR EACH ROW
BEGIN
  SELECT OrderDetailsID_SEQ.NEXTVAL
    INTO :new.OrderDetailsID
    FROM dual ;
End ;
/
;