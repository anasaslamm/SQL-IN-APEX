-- Make all the Constrainst when table in empty if you added data and then try to add Constrainst it will cause error for not finding the null value

-- To make foreign key by sql query

ALTER TABLE ORDERS
ADD CONSTRAINT CUSTOMERS_CON FOREIGN KEY (CUSTOMER_ID)
REFERENCES CUSTOMER (CUSTOMER_ID);

--
ORA-02298: cannot validate (WKSP_1WEEK.CUSTOMER_CON) - parent keys not found
-- if your having this error means you have rows in your ORDERS table where the CUSTOMER_ID does not exist in the CUSTOMER table

this means you have incorrect data so need to run this to set data 
----
UPDATE ORDERS
SET CUSTOMER_ID = (SELECT CUSTOMER_ID FROM CUSTOMER WHERE ROWNUM = 1) -- Replace with a valid ID
WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM CUSTOMER);
--- Or delete the rows:

DELETE FROM ORDERS
WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM CUSTOMER);

--After adding the foreign key:
--Test inserting/updating rows in ORDERS to ensure only valid CUSTOMER_ID values are accepted.
