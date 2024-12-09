-- Basic Loop and Curser
DECLARE
    CURSOR C_EMP IS
        SELECT FIRST_NAME FROM EMPLOYEE;
BEGIN
    FOR I IN C_EMP LOOP
        dbms_output.put_line(I.FIRST_NAME);
    END LOOP;
END;
